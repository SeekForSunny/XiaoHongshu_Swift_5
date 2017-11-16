//
//  F_CommentView.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/11/11.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON

fileprivate let USER_ICON_VIEW_WH = 35*APP_SCALE
class F_CommentView: UIView {
    
    //评论内容
    fileprivate var commentInfo:F_CommentModel?
    
    //评论内容数组
    fileprivate lazy var commentArr:[F_Comments] = [F_Comments]()
    
    //指示器View
    fileprivate lazy var  indicatorView:UIView = {
        let indicatorView = UIView()
        self.headerView.addSubview(indicatorView)
        indicatorView.backgroundColor = .red
        return indicatorView
    }()
    
    //分组标题
    fileprivate lazy var headerView:UIView = UIView()
    
    //标题Label
    fileprivate lazy var titleLabel:UILabel = {
        let titleLabel = UILabel()
        self.headerView.addSubview(titleLabel)
        titleLabel.font = SYSTEM_FONT_15
        titleLabel.text = "笔记评论"
        return titleLabel
    }()
    
    //分割线
    fileprivate lazy var lineView:UIView = {
        let lineView = UIView()
        self.headerView.addSubview(lineView)
        lineView.backgroundColor = UIColor(white: 0.7, alpha: 0.7)
        return lineView
    }()
    
    //用户编辑留言View
    fileprivate lazy var editView:UIView = UIView()
    
    //用户头像
    fileprivate lazy var iconView:UIImageView = {
        let iconView = UIImageView()
        self.editView.addSubview(iconView)
        return iconView
    }()
    
    //用户留言输入框
    fileprivate lazy var inputTF:UITextField = {
        let inputTF = UITextField()
        self.editView.addSubview(inputTF)
        return inputTF
    }()
    
    //commentView
    fileprivate lazy var commentView:UITableView = {
        let commentView = UITableView()
        commentView.delegate = self
        commentView.dataSource = self
        return commentView
    }()
    fileprivate var commentVH:CGFloat = 0
    
    //高度改变回调bolck
    public typealias Completion = (_ commentH: CGFloat, _ isLoadAll:Bool) -> Void
    
    var handleblock:Completion?
    
    //笔记id
   fileprivate var note_id:String!
    
    //设置笔记评论
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUIContent()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUIContent(){
        
        addSubview(headerView)
        headerView.backgroundColor = UIColor.white
        headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(NOTE_DETAIL_HEADER_VIEW_HEIGHT)
        }
        
        //指示器View
        indicatorView.snp.makeConstraints { (make) in
            make.left.equalTo(headerView).offset(SM_MRAGIN_10)
            make.centerY.equalTo(headerView)
            make.size.equalTo(CGSize(width: 2*APP_SCALE, height: NOTE_DETAIL_HEADER_VIEW_HEIGHT*0.3))
        }
        
        //分组标题
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(headerView)
            make.left.equalTo(indicatorView.snp.right).offset(SM_MRAGIN_5)
        }
        
        //分割线
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(headerView).offset(SM_MRAGIN_10)
            make.bottom.right.equalTo(headerView)
            make.height.equalTo(0.5)
        }
        
        //用户编辑留言View
        addSubview(editView)
        editView.backgroundColor = .white
        editView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(NOTE_DETAIL_USER_EDIT_VIEW_HEIGHT)
        }
        
        //用户头像
        iconView.snp.makeConstraints { (make) in
            make.centerY.equalTo(editView)
            make.left.equalTo(editView).offset(SM_MRAGIN_15)
            make.height.width.equalTo(USER_ICON_VIEW_WH)
        }
        iconView.layer.cornerRadius = USER_ICON_VIEW_WH * 0.5
        iconView.clipsToBounds = true
        iconView.backgroundColor = UIColor.randomColor()
        
        //留言框
        inputTF.snp.makeConstraints { (make) in
            make.centerY.equalTo(editView)
            make.left.equalTo(iconView.snp.right).offset(SM_MRAGIN_15)
            make.right.equalTo(editView).offset(-SM_MRAGIN_15)
            make.height.equalTo(30*APP_SCALE)
        }
        inputTF.backgroundColor = BACK_GROUND_COLOR
        inputTF.placeholder = "  想勾搭,先评论"
        inputTF.font = SYSTEM_FONT_14
        inputTF.layer.cornerRadius = 3*APP_SCALE
        
        //评论View
        self.addSubview(commentView)
        commentView.bounces = false
        commentView.isScrollEnabled = false
        commentView.separatorStyle = .none
        commentView.snp.makeConstraints { (make) in
            make.top.equalTo(editView.snp.bottom)
            make.left.right.bottom.equalTo(self)
        }
        
    }
    
}

extension F_CommentView:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  F_CommentCell.cell(tableView: tableView)
        let model = commentArr[indexPath.row]
        cell.fillterWith(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70*APP_SCALE
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = commentArr[indexPath.row]
        self.updateCommentView(count:indexPath.row)
        return  model.cellH
    }
    
    //更新评论View高度约束
    func updateCommentView(count:Int) {

        commentVH = 0
        if commentArr.count > 0 {
            for i in 0...count {
                let model = commentArr[i]
                commentVH += model.cellH
            }
        }

        let isLoadAll = count < commentArr.count - 1 ? false : true
        if let block = self.handleblock {
            block(NOTE_DETAIL_HEADER_VIEW_HEIGHT + NOTE_DETAIL_USER_EDIT_VIEW_HEIGHT + commentVH ,isLoadAll)
        }
        
    }
}

extension F_CommentView{
    
    //加载评论内容
    func loadComment(){
        
        SMProvider.request(.NoteComment(note_id)) {[weak self] result in
            switch result {
            case let .success(response):
                
                let json = JSON(data: response.data)
                if let data = json["data"].dictionaryObject {
                    self?.commentInfo = Mapper<F_CommentModel>().map(JSONObject: data)
                    if let comments = self?.commentInfo?.comments {
                        self?.commentArr = comments
                        if self?.commentArr.count == 0 {
                            self?.updateCommentView(count: 0)
                            return
                        }
                        self?.commentView.reloadData()
                    }
                }
                
            case let .failure(error):
                print(error)
                break
            }
        }
        
    }
    
    func fillterWithNoteID(_ note_id:String,handleblock:@escaping Completion){
        self.handleblock = handleblock

        self.note_id = note_id
        
        //加载评论信息
        loadComment()
        
    }
    
}
