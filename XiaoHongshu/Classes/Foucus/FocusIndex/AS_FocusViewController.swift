//
//  AS_FocusViewController.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/11/17.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import SwiftyJSON
import ObjectMapper

class AS_FocusViewController: ASViewController<ASDisplayNode> ,ASTableDelegate,ASTableDataSource {
    
    fileprivate lazy var tableNode:ASTableNode = ASTableNode(style: UITableViewStyle.plain)
    
    fileprivate lazy var contentArr = [FocusModel]()
    
    init() {
        super.init(node: ASDisplayNode())
        
        //设置tableNode
        setupTableNode()
        
        //加载网络数据
        loadData()
        
    }
    
    func setupTableNode(){
        
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.backgroundColor = BACK_GROUND_COLOR
        self.node.addSubnode(tableNode)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableNode.view.separatorStyle = .none
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        //设置尺寸
        tableNode.frame = self.node.bounds
    }
    
}

extension AS_FocusViewController {
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return contentArr.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        let cellNodeBlock = {[weak self] () -> ASCellNode in
            
            let defaultCellNode = ASCellNode()
            
            guard let model = self?.contentArr[indexPath.row] else { return defaultCellNode }
            
            guard let recommend_reason = model.recommend_reason else { return defaultCellNode }
            
            if recommend_reason.contains("friend_post") { //已关注人的笔记
                let cellNode = AS_SingleNoteCellNode(model:model, cellType:.friendPost)
                return cellNode
            } else if recommend_reason.contains("friend_collect") { //已关注的人收藏了笔记
                if model.note_list?.count == 1 {
                    let cellNode = AS_SingleNoteCellNode(model:model, cellType:.friendCollect)
                    return cellNode
                }else{
                    return AS_OneMoreNoteCellNode(model: model, cellType: FocusCellType.friendCollect)
                }
            } else if recommend_reason.contains("friend_like") {
                if model.note_list?.count == 1 {
                    //单条: Missgreenberry 赞了笔记
                    let cellNode = AS_SingleNoteCellNode(model:model, cellType:.friendLike)
                    return cellNode
                } else{
                    //多条: 叫我诺诺 赞了 6篇笔记
                    return AS_OneMoreNoteCellNode(model: model, cellType: FocusCellType.friendLike)
                }
            } else if recommend_reason.contains("recommend_user") {
                //推荐用户
                return AS_RecUserCellNode(model: model)
            } else if recommend_reason.contains("friend_follow_user"){
                //关注用户
                return AS_FollowCellNode(model: model, cellType: FocusCellType.friendFollowUser)
            } else if recommend_reason.contains("friend_follow_vendor"){
                //关注商家
                return AS_FollowCellNode(model: model, cellType: FocusCellType.friendFollowVendor)
            }else{ //其他
                return defaultCellNode
            }
        }
        return cellNodeBlock
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        
        let detailVc = FocusDetailViewController()
        let model = contentArr[indexPath.row]
        detailVc.note_id = model.note_list?.first?.id
        detailVc.images_list = model.note_list?.first?.images_list
        navigationController?.pushViewController(detailVc, animated: true)
        
    }
    
}

//MARK: - 加载网络
extension AS_FocusViewController {
    
    func loadData(){
        SMProvider.request(.Focus) {[weak self] result in
            switch result {
            case let .success(response):
                
                let json = JSON(data: response.data)
                guard let dataArr = json["data"].arrayObject as?  [[String: AnyObject]] else { return }
                self?.contentArr = Mapper<FocusModel>().mapArray(JSONArray: dataArr)
                self?.tableNode.reloadData()
                
            case let .failure(error):
                print(error)
                break
            }
        }
    }
    
}
