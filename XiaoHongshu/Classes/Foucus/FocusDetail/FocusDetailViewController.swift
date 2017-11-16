//
//  FocusDetailViewController.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/11/9.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import TTTAttributedLabel
import ObjectMapper
import SwiftyJSON
class FocusDetailViewController: UIViewController {
    
    //上一级传递数据
    var note_id:String!
    var images_list:[ImageModel]!
    
    //当前笔记详情Model
    var curModel:F_NoteDetailModel?
    
    //滚动容器
    fileprivate lazy var scrollView:UIScrollView = {
        let scrollView =  UIScrollView()
        return scrollView
    }()
    
    //评论内容
    fileprivate var commentInfo:F_CommentModel?
    //评论内容数组
    fileprivate lazy var commentArr:[F_Comments] = [F_Comments]()
    
    //bannerView
    fileprivate lazy var bannerView:F_BannerView = {
        let bannerView = F_BannerView()
        return bannerView
    }()
    fileprivate var bannerVH:CGFloat = 0
    
    //descView
    fileprivate  lazy var descView:F_NoteDescView = {
        let descView = F_NoteDescView()
        self.scrollView.addSubview(descView)
        return descView
    }()
    fileprivate  var descVH:CGFloat = 0
    
    //commentView
    fileprivate lazy var commentView:F_CommentView = {
        let commentView = F_CommentView()
        return commentView
    }()
    fileprivate var commentVH:CGFloat = 0
    
    //relatedView
    fileprivate lazy var relatedView:F_RelatedNoteView = {
        let relatedView = F_RelatedNoteView()
        return relatedView
    }()
    fileprivate var relatedVH:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置内容View
        setupUIContentView()
        
        //加载笔记详情
        loadNoteDetailInfo()
        
    }
    
}

//MARK: - 加载笔记详情
extension FocusDetailViewController{
    
    func loadNoteDetailInfo() {
        
        SMProvider.request(MoyaAPI.NoteDetail(note_id)) {[weak self] result in
            switch result {
            case let .success(response):
                
                let json = JSON(data: response.data)
                if let data = json["data"].dictionaryObject {
                    let model = Mapper<F_NoteDetailModel>().map(JSON: data)
                    self?.curModel = model
                    self?.setupNoteDescView()
                }
                
            case let .failure(error):
                print(error)
                break
            }
        }
    }
}


//MARK: - 设置内容View
extension FocusDetailViewController {
    
    func setupUIContentView() {
        
        //添加scrollView
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        scrollView.backgroundColor = BACK_GROUND_COLOR
        
        
        //设置顶部bannerView
        setupBannerView()
        
        //        //设置笔记描述View
        //        setupNoteDescView()
        
        //        //设置笔记评论
        //        setupCommmentView()
        
        //        //设置相关笔记
        //        setupRelatedNoteView()
        
        //计算滚动Size
        setScrollContentSize()
    }
    
    //计算滚动Size
    func setScrollContentSize(){
        
        let scrollH = bannerVH + descVH + commentVH + relatedVH
        scrollView.contentSize = CGSize(width: 0, height: scrollH)
        
    }
    
}

//MARK: - 顶部bannerView相关
extension FocusDetailViewController{
    
    func setupBannerView(){
        
        scrollView.addSubview(bannerView)
        let bannerH = bannerView.fillterWith(images_list: images_list) {[weak self] bannerH in
            self?.updateBannerView(height:bannerH)
        }
        bannerVH = bannerH
        bannerView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left)
            make.top.equalTo(self.scrollView.snp.top)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(bannerH)
        }
        
    }
    
    //更新bannerView
    func updateBannerView(height:CGFloat){
        
        UIView.animate(withDuration: 0.5, animations: {
            self.bannerView.snp.updateConstraints { (make) in
                make.height.equalTo(height)
            }
            self.scrollView.layoutIfNeeded()
            
        })
        
        bannerVH = height
        self.setScrollContentSize()
    }
    
}


//MARK: - 笔记描述相关
extension FocusDetailViewController{
    
    //设置笔记描述View
    func setupNoteDescView(){
        let descViewH =  descView.fillter(model: self.curModel!)
        descView.snp.makeConstraints { (make) in
            make.top.equalTo(bannerView.snp.bottom).offset(SM_MRAGIN_10)
            make.left.equalTo(self.scrollView)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(descViewH)
        }
        descView.backgroundColor = UIColor.white
        
        descVH = descViewH + SM_MRAGIN_10
        self.setScrollContentSize()
        
        //设置笔记评论
        setupCommmentView()
        
    }
    
}


//MARK: - 笔记评论相关
extension FocusDetailViewController{
    
    //设置笔记评论
    func setupCommmentView(){
        
        scrollView.addSubview(commentView)
        
        commentView.snp.makeConstraints { (make) in
            make.top.equalTo(descView.snp.bottom).offset(SM_MRAGIN_10)
            make.left.equalTo(scrollView)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(NOTE_DETAIL_HEADER_VIEW_HEIGHT + NOTE_DETAIL_USER_EDIT_VIEW_HEIGHT + SM_MRAGIN_10)
        }
        
        commentView.fillterWithNoteID(note_id) {[weak self] commentH, isLoadAll in
            if isLoadAll {
                self?.updateCommentView(commentH: commentH)
                //设置相关笔记
                self?.setupRelatedNoteView()
            }else{
                self?.updateCommentView(commentH: commentH + SM_MRAGIN_10)
            }
        }
        
        
        
        
    }
    
    //更新评论View高度约束
    func updateCommentView(commentH:CGFloat) {
        
        commentView.snp.updateConstraints { (make) in
            make.height.equalTo(commentH)
        }
        
        commentVH = SM_MRAGIN_10 + commentH
        self.setScrollContentSize()
        
    }
    
}


//MARK: - 相关笔记
extension FocusDetailViewController{
    
    //设置相关笔记
    func setupRelatedNoteView(){
        scrollView.addSubview(relatedView)
        relatedView.backgroundColor = BACK_GROUND_COLOR
        let relatedViewH:CGFloat = 0
        
        relatedView.fillterWithNoteID(note_id) { contentH in
            self.updateRelatedViewConstraints(contentH)
        }
        relatedView.snp.makeConstraints { (make) in
            make.top.equalTo(commentView.snp.bottom).offset(SM_MRAGIN_10)
            make.left.equalTo(scrollView)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(relatedViewH)
        }
        relatedVH = SM_MRAGIN_10 + relatedViewH
    }
    
    
    
    func updateRelatedViewConstraints(_ contentH:CGFloat) {
        
        relatedView.snp.updateConstraints { (make) in
            make.height.equalTo(contentH)
        }
        
        relatedVH = SM_MRAGIN_10 + contentH
        self.setScrollContentSize()
    }
}

