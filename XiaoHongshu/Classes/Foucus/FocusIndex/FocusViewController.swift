
//
//  FocusViewController.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/10/19.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper

class FocusViewController: UITableViewController {
    
    //数据
    fileprivate lazy var contentArr = [FocusModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //网络请求
        loadData()
        
        //初始化设置
        setupUIContent()
        
    }
    
}

//MARK: - 初始化设置
extension FocusViewController{
    
    func setupUIContent()  {
        // 设置背景颜色
        view.backgroundColor = BACK_GROUND_COLOR
        
        //设置分割线样式
        tableView.separatorStyle = .none
        
    }
    
}


//MARK: - 网络请求
extension FocusViewController{
    
    func loadData(){
        SMProvider.request(.Focus) {[weak self] result in
            switch result {
            case let .success(response):
                
                let json = JSON(data: response.data)
                if let dataArr = json["data"].arrayObject as?  [[String: AnyObject]]{
                    self?.contentArr = Mapper<FocusModel>().mapArray(JSONArray: dataArr)
                    self?.tableView.reloadData()
                }
                
            case let .failure(error):
                print(error)
                break
            }
        }
    }
    
}

//TableView 数据源代理方法
extension FocusViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let defaultCell = DefaultTableViewCell.cell(tableView: tableView)
        
        let model = contentArr[indexPath.row]
        
        guard let recommend_reason = model.recommend_reason  else{
            return defaultCell
        }
        if recommend_reason.contains("friend_post") { //已关注人的笔记
            
            let cell = FocusNormalCell.cell(tableView: tableView)
            cell.fillter(model: model)
            return cell
            
        } else if recommend_reason.contains("friend_collect") { //已关注的人收藏了未关注的人的笔记
            
            //LittleJ 收藏了笔记
            if model.note_list?.count == 1 {
                
                let cell = FocusNormalCell.cell(tableView: tableView)
                cell.fillter(model: model)
                return cell
                
            }else{
                let cell = FriendCollectOrLikeCell.cell(tableView: tableView)
                cell.fillter(model: model)
                return cell
            }
            
        } else if recommend_reason.contains("friend_like") {
            
            //已关注的人给未关注的人点赞的笔记
            if model.note_list?.count == 1 {
                //单条: Missgreenberry 赞了笔记
                let cell = FocusNormalCell.cell(tableView: tableView)
                cell.fillter(model: model)
                return cell
            } else{
                //多条: 叫我诺诺 赞了 6篇笔记
                let cell = FriendCollectOrLikeCell.cell(tableView: tableView)
                cell.fillter(model: model)
                return cell
            }
            
        } else if recommend_reason.contains("recommend_user") {
            
            //你可能感兴趣的用户
            let cell = RecommendUserCell.cell(tableView: tableView)
            cell.fillter(model: model)
            return cell
            
        } else  if recommend_reason.contains("friend_follow_user"){
            
            // 叫我诺诺 关注了 2 位用户
            let cell = FriendFollowUserCell.cell(tableView: tableView)
            cell.fillter(model: model)
            return cell
            
        }  else {
            
            return defaultCell
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model = contentArr[indexPath.row]
        return model.cellH
        
    }
    
    
}

