//
//  FriendLikeTableCell.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/10/23.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//  关注的好友收藏了或赞了超过一条的笔记

import UIKit
import TTTAttributedLabel

//滚动容器高度
fileprivate let SCROLL_VIEW_HEIGHT = 260*APP_SCALE

//单个卡片的宽度
fileprivate let PERCARED_VIEW_WIDTH = 135*APP_SCALE

//滚动容器内部单个卡片View
class PerNoteItem: UICollectionViewCell {
    
    static let identifier = "PerNoteItem"
    //描述图片
    fileprivate lazy var picView:UIImageView = {
        let picView = UIImageView()
        self.addSubview(picView)
        return picView
    }()
    
    //标题
    fileprivate lazy var titleLable:TTTAttributedLabel = {
        let titleLable = TTTAttributedLabel(frame:CGRect.zero)
        self.addSubview(titleLable)
        return titleLable
    }()
    
    //头像
    fileprivate lazy var iconView:UIImageView = {
        let iconView = UIImageView()
        self.addSubview(iconView)
        return iconView
    }()
    
    //昵称
    fileprivate lazy var nameLabel:UILabel = {
        let nameLable = UILabel()
        self.addSubview(nameLable)
        return nameLable
    }()
    
    //分割线
    fileprivate lazy var lineView:UIView = {
        let lineView = UIView()
        self.addSubview(lineView)
        return lineView
    }()
    
    //点赞按钮
    fileprivate lazy var praiseBtn:UIButton = {
        let praiseBtn = UIButton()
        self.addSubview(praiseBtn)
        return praiseBtn
    }()
    
    //收藏按钮
    fileprivate lazy var collectBtn:UIButton = {
        let collectBtn = UIButton()
        self.addSubview(collectBtn)
        return collectBtn
    }()
    
    func fillter(model:F_NoteModel){
        
        //描述图片
        if let map =  model.images_list?.first {
            if let url = map["url"] as? String {
                picView.sd_setImage(with: URL(string:url), completed: nil)
                picView.contentMode = .scaleAspectFill
                picView.clipsToBounds = true
                picView.snp.makeConstraints({ (make) in
                    make.top.equalTo(self)
                    make.left.right.equalTo(self)
                    make.height.equalTo(self.snp.width)
                })
            }
        }
        
        //标题
        var textH:CGFloat = 0
        if let title = model.title {
            textH = titleLable.textH(text: title, font: UIFont.boldSystemFont(ofSize: 14*APP_SCALE), width: PERCARED_VIEW_WIDTH - 2*SM_MRAGIN_5, numberOfLine: 2)
            titleLable.snp.remakeConstraints({ (make) in
                make.top.equalTo(picView.snp.bottom).offset(SM_MRAGIN_5)
                make.left.equalTo(self.snp.left).offset(SM_MRAGIN_5)
                make.right.equalTo(self.snp.right).offset(-SM_MRAGIN_5)
                make.height.equalTo(textH)
            })
        }
        
        //头像
        if let url = model.user?.image {
            let viewWH = 30*APP_SCALE
            iconView.sd_setImage(with: URL(string:url), completed: nil)
            iconView.layer.cornerRadius = viewWH * 0.5
            iconView.clipsToBounds = true
            iconView.snp.remakeConstraints({ (make) in
                make.top.equalTo(picView.snp.bottom).offset(SM_MRAGIN_5 + textH + SM_MRAGIN_5)
                make.left.equalTo(self.snp.left).offset(SM_MRAGIN_5)
                make.height.width.equalTo(viewWH)
            })
        }
        
        //昵称
        if let name = model.user?.name {
            nameLabel.text = name
            nameLabel.font = UIFont.systemFont(ofSize: 12*APP_SCALE)
            nameLabel.snp.remakeConstraints({ (make) in
                make.centerY.equalTo(iconView.snp.centerY)
                make.left.equalTo(iconView.snp.right).offset(SM_MRAGIN_5)
                make.right.equalTo(self.snp.right).offset(-SM_MRAGIN_5)
            })
        }
        
        //分割线
        lineView.snp.makeConstraints { (make) in
            make.bottom.equalTo(praiseBtn.snp.top).offset(-SM_MRAGIN_5)
            make.left.equalTo(self.snp.left).offset(SM_MRAGIN_5)
            make.right.equalTo(self.snp.right).offset(-SM_MRAGIN_5)
            make.height.equalTo(0.5)
        }
        lineView.backgroundColor = UIColor(white: 0.7, alpha: 0.7)
        
        //点赞
        praiseBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom).offset(-SM_MRAGIN_5)
            make.left.equalTo(self.snp.left).offset(SM_MRAGIN_5)
            make.width.equalTo(self.snp.width).multipliedBy(0.5)
            make.height.equalTo(20*APP_SCALE)
        }
        praiseBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13*APP_SCALE)
        praiseBtn.setTitleColor(LIGHT_TEXT_COLOR, for: UIControlState.normal)
        if let likedCount = model.liked_count {
            if likedCount > 0 {
                praiseBtn.setTitle( "\(likedCount)", for: UIControlState.normal)
                praiseBtn.setImage(UIImage(named:"icon_like_grey_20_20x20_"), for: UIControlState.normal)
            }else {
                praiseBtn.setTitle("赞", for: UIControlState.normal)
                praiseBtn.setImage(UIImage(named:"icon_like_grey_20_20x20_"), for: UIControlState.normal)
            }
        }
        
        //收藏
        collectBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.praiseBtn.snp.bottom)
            make.right.equalTo(self.snp.right).offset(-SM_MRAGIN_5)
            make.size.equalTo(self.praiseBtn)
        }
        collectBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13*APP_SCALE)
        collectBtn.setTitleColor(LIGHT_TEXT_COLOR, for: UIControlState.normal)
        if let collectCount = model.collected_count {
            if collectCount > 0 {
                collectBtn.setTitle( "\(collectCount)", for: UIControlState.normal)
                collectBtn.setImage(UIImage(named:"icon_collect_grey_20_20x20_"), for: UIControlState.normal)
            }else {
                collectBtn.setTitle("赞", for: UIControlState.normal)
                collectBtn.setImage(UIImage(named:"icon_collect_grey_20_20x20_"), for: UIControlState.normal)
            }
        }
    }
    
    
}




class FriendCollectOrLikeCell: UITableViewCell {
    
    
    //笔记来源View
    lazy var sourceView : UIView = {
        let sourceView = UIView()
        self.addSubview(sourceView)
        return sourceView
    }()
    
    //来源标签
    lazy var sourceLable:UILabel = {
        let sourceLable = UILabel()
        self.sourceView.addSubview(sourceLable)
        return sourceLable
    }()
    
    //更多按钮
    lazy var moreBtn:UIButton = {
        let moreBtn = UIButton()
        self.sourceView.addSubview(moreBtn)
        moreBtn.setImage(UIImage(named:"icon_menu_grey_25_25x25_"), for: UIControlState.normal)
        moreBtn.imageView?.contentMode = .scaleAspectFill
        return moreBtn
    }()
    
    //内容滚动容器
    fileprivate lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: PERCARED_VIEW_WIDTH, height: SCROLL_VIEW_HEIGHT-2*SM_MRAGIN_5)
        layout.sectionInset = UIEdgeInsets(top: SM_MRAGIN_5, left: SM_MRAGIN_10, bottom: SM_MRAGIN_5, right: 0)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:layout )
        collectionView.register(PerNoteItem.self, forCellWithReuseIdentifier: PerNoteItem.identifier)
        self.addSubview(collectionView)
        layout.scrollDirection = .horizontal
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    //显示更多
    lazy var showMoreBtn:UIButton = {
        let showMoreBtn = UIButton()
        self.sourceView.addSubview(showMoreBtn)
        showMoreBtn.layer.cornerRadius = 5*APP_SCALE
        showMoreBtn.layer.shadowColor = UIColor.randomColor().cgColor
        showMoreBtn.layer.shadowOffset = CGSize.zero
        showMoreBtn.layer.shadowRadius = 3
        showMoreBtn.layer.shadowOpacity = 0.5;
        return showMoreBtn
    }()
    
    //底部分割线
    lazy var lineView:UIView = {
        let lineView = UIView()
        self.addSubview(lineView)
        lineView.backgroundColor = BACK_GROUND_COLOR
        return lineView
    }()
    
    //数据模型
    fileprivate var model:FocusModel?
    
    static let identifier = "FriendCollectOrLikeCell"
    static func cell(tableView:UITableView)->FriendCollectOrLikeCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = FriendCollectOrLikeCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            cell?.selectionStyle = .none
        }
        return cell as! FriendCollectOrLikeCell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

//MARK: - 数据源方法

extension FriendCollectOrLikeCell{
    
    //MARK: 数据填充
    func fillter(model:FocusModel){
        
        self.model = model
        collectionView.reloadData()
        
        guard let recommend_reason = model.recommend_reason else {
            return
        }
        
        //顶部笔记来源View
        sourceView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.left.right.equalTo(self)
            make.height.equalTo(FOCUS_CELL_SOURCE_VIEW_HEIGHT)
        }
        
        //数据来源标签
        var suffix = ""
        if recommend_reason.contains("friend_collect") {
            //已关注的人收藏了未关注的人的笔记
            suffix = " 收藏了"
        } else if recommend_reason.contains("friend_like") {
            suffix = " 赞了"
        }
        
        if let name = model.users?.first?.name {
            if let count = model.notes_count {
                
                let source = name + suffix + "\(count)" + " 篇笔记"
                let attributedText = NSMutableAttributedString(string: source)
                attributedText.addAttributes([NSForegroundColorAttributeName : UIColor.darkGray,
                                              NSFontAttributeName:UIFont.boldSystemFont(ofSize: 15*APP_SCALE)],
                                             range: NSRange(location: 0, length: name.characters.count))
                attributedText.addAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 15*APP_SCALE),NSForegroundColorAttributeName:LIGHT_TEXT_COLOR],
                                             range: NSRange(location: name.characters.count, length: source.characters.count - name.characters.count))
                sourceLable.attributedText = attributedText
                
                sourceLable.snp.remakeConstraints({ (make) in
                    make.centerY.equalTo(sourceView.snp.centerY)
                    make.left.equalTo(sourceView.snp.left).offset(SM_MRAGIN_15)
                })
                
            }
            
        }
        
        //更多按钮
        moreBtn.snp.remakeConstraints { (make) in
            make.right.equalTo(sourceView.snp.right).offset(-SM_MRAGIN_15)
            make.centerY.equalTo(sourceView.snp.centerY)
            make.width.height.equalTo(25*APP_SCALE)
        }
        
        
        //容器View
        collectionView.snp.remakeConstraints { (make) in
            make.top.equalTo(sourceView.snp.bottom).offset(SM_MRAGIN_5)
            make.left.right.equalTo(self)
            make.height.equalTo(SCROLL_VIEW_HEIGHT)
        }
        
        
        //底部分割线
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom).offset(SM_MRAGIN_15)
            make.left.right.equalTo(self)
            make.height.equalTo(SM_MRAGIN_10)
        }
        
    }
    
    
    
    //MARK: 计算高度
    class func getHeight(model:FocusModel)->CGFloat{
        
        var cellH:CGFloat = 0
        
        //顶部来源View
        cellH += FOCUS_CELL_SOURCE_VIEW_HEIGHT
        
        //滚动容器高度
        cellH += SCROLL_VIEW_HEIGHT
        
        //底部分割线
        cellH += SM_MRAGIN_10 + SM_MRAGIN_15
        
        return cellH
    }
}


//MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension FriendCollectOrLikeCell:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return model?.note_list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: PerNoteItem.identifier, for: indexPath) as! PerNoteItem
        item.layer.cornerRadius = 5*APP_SCALE
        item.backgroundColor = UIColor.white
        item.layer.shadowColor = UIColor.randomColor().cgColor
        item.layer.shadowOffset = CGSize.zero
        item.layer.shadowRadius = 3
        item.layer.shadowOpacity = 0.5;
        if let model = model?.note_list?[indexPath.row] {
            item.fillter(model: model)
        }
        return item
    }
    
}

