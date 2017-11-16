//
//  RecommendUserCell.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/10/23.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
fileprivate let  SCROLL_VIEW_HEIGHT = 260*APP_SCALE
fileprivate let USER_ICON_VIEW_WH = 70*APP_SCALE
fileprivate let PERUSER_CARD_VIEW_W = 135*APP_SCALE

//MARK: - PerRecUserItem
class PerRecUserItem: UICollectionViewCell {
    
    static let identifier = "PerRecUserItem"
    //头像
    
    fileprivate lazy var iconView:UIImageView = {
        let iconView = UIImageView()
        self.addSubview(iconView)
        iconView.layer.cornerRadius = USER_ICON_VIEW_WH * 0.5
        iconView.clipsToBounds = true
        return iconView
    }()
    
    //昵称
    fileprivate lazy var nameLabel:UILabel = {
        let nameLabel = UILabel()
        self.addSubview(nameLabel)
        nameLabel.textAlignment = .center
        nameLabel.font = BOLD_SYSTEM_FONT_13
        nameLabel.textColor = UIColor.darkGray
        return nameLabel
    }()
    
    //推荐说明
    fileprivate lazy var infoLabel:UILabel = {
        let infoLabel = UILabel()
        self.addSubview(infoLabel)
        infoLabel.numberOfLines = 2
        infoLabel.textAlignment = .center
        infoLabel.font = SYSTEM_FONT_12
        infoLabel.textColor = LIGHT_TEXT_COLOR
        return infoLabel
    }()
    
    //关注按钮
    fileprivate lazy var focusBtn:UIButton = {
        let focusBtn = UIButton()
        self.addSubview(focusBtn)
        focusBtn.layer.borderColor  = UIColor.red.cgColor
        focusBtn.layer.borderWidth = 1.0
        focusBtn.layer.cornerRadius = 5*APP_SCALE
        focusBtn.setTitle("关注", for: UIControlState.normal)
        focusBtn.setTitleColor(UIColor.red, for: UIControlState.normal)
        focusBtn.titleLabel?.font = SYSTEM_FONT_13
        return focusBtn
    }()
    
    //隐藏按钮
    fileprivate lazy var hiddenBtn:UIButton = {
        let hiddenBtn = UIButton()
        self.addSubview(hiddenBtn)
        hiddenBtn.setTitle("隐藏", for: UIControlState.normal)
        hiddenBtn.setTitleColor(LIGHT_TEXT_COLOR, for: UIControlState.normal)
        hiddenBtn.titleLabel?.font = SYSTEM_FONT_12
        return hiddenBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUIContent() {
        
        //头像
        iconView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self.snp.top).offset(SM_MRAGIN_15)
            make.width.height.equalTo(USER_ICON_VIEW_WH)
            
        }
        //昵称
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconView)
            make.top.equalTo(iconView.snp.bottom).offset(SM_MRAGIN_10)
            make.left.equalTo(self).offset(SM_MRAGIN_15)
            make.right.equalTo(self).offset(-SM_MRAGIN_15)
            
        }
        //推荐说明
        infoLabel.snp.makeConstraints { (make) in
            //            make.centerX.equalTo(iconView)
            make.height.equalTo(0)
            make.top.equalTo(nameLabel.snp.bottom).offset(SM_MRAGIN_10)
            make.left.equalTo(self).offset(SM_MRAGIN_15)
            make.right.equalTo(self).offset(-SM_MRAGIN_15)
        }
        //关注按钮
        focusBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconView)
            make.bottom.equalTo(hiddenBtn.snp.top).offset(-SM_MRAGIN_10)
            make.size.equalTo(CGSize(width:100*APP_SCALE, height:25*APP_SCALE))
        }
        
        //隐藏按钮
        hiddenBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconView)
            make.bottom.equalTo(self.snp.bottom).offset(-SM_MRAGIN_10)
            make.size.equalTo(CGSize(width:100*APP_SCALE, height:25*APP_SCALE))
        }
        
    }
    
    
    func fillter(model:UserModel){
        
        //头像
        if let url = model.image  {
            iconView.sd_setImage(with: URL(string:url), completed: nil)
        }
        
        //昵称
        if let name = model.name {
            nameLabel.text = name
        }
        
        //推荐说明
        var infoH:CGFloat = 0
        if let info = model.desc {
            infoLabel.text = info
            
            if let descH = model.descH {
                infoH = descH
            }else{
                infoLabel.sizeToFit()
                infoH = infoLabel.bounds.height
            }
            
        }
        infoLabel.snp.updateConstraints { (make) in
            make.height.equalTo(infoH)
        }
    }
}


//MARK: - 初始化设置
class RecommendUserCell: UITableViewCell{
    
    //来源View
    fileprivate lazy var sourceView:UIView = {
        let sourceView = UIView()
        self.contentView.addSubview(sourceView)
        return sourceView
    }()
    
    //来源标签
    fileprivate lazy var sourceLabel:UILabel = {
        let sourceLabel = UILabel()
        self.sourceView.addSubview(sourceLabel)
        return sourceLabel
    }()
    
    //查看更多
    fileprivate lazy var moreBtn:UIButton = {
        let moreBtn = UIButton()
        self.sourceView.addSubview(moreBtn)
        return moreBtn
    }()
    
    //内容滚动容器
    fileprivate lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: PERUSER_CARD_VIEW_W, height: SCROLL_VIEW_HEIGHT-2*SM_MRAGIN_5)
        layout.sectionInset = UIEdgeInsets(top: SM_MRAGIN_5, left: SM_MRAGIN_10, bottom: SM_MRAGIN_5, right: 0)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:layout )
        collectionView.register(PerRecUserItem.self, forCellWithReuseIdentifier: PerRecUserItem.identifier)
        self.contentView.addSubview(collectionView)
        layout.scrollDirection = .horizontal
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    //底部分割线
    fileprivate lazy var lineView:UIView = {
        let lineView = UIView()
        self.contentView.addSubview(lineView)
        return lineView
    }()
    
    
    //数据模型
    fileprivate var model:FocusModel?
    
    static let identifier = "RecommendUserCell"
    static func cell(tableView:UITableView)->RecommendUserCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = RecommendUserCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            cell?.selectionStyle = .none
        }
        return cell as! RecommendUserCell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        setupUIContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUIContent(){
        
        //数据来源View
        sourceView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(FOCUS_CELL_SOURCE_VIEW_HEIGHT)
        }
        
        //数据来源
        sourceLabel.text = "你可能感兴趣的用户"
        sourceLabel.textColor = UIColor.darkGray
        sourceLabel.font = SYSTEM_FONT_15
        sourceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.sourceView.snp.left).offset(SM_MRAGIN_15)
            make.top.equalTo(self.sourceView.snp.top).offset(SM_MRAGIN_15)
        }
        
        //查看更多
        moreBtn.setTitle("查看更多", for: UIControlState.normal)
        moreBtn.titleLabel?.font = SYSTEM_FONT_13
        moreBtn.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
        moreBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.sourceView.snp.right).offset(-SM_MRAGIN_15)
            make.centerY.equalTo(self.sourceView.snp.centerY)
            make.size.equalTo(CGSize(width: 70*APP_SCALE, height: 35*APP_SCALE))
        }
        
        //容器View
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(sourceView.snp.bottom).offset(SM_MRAGIN_5)
            make.left.right.equalTo(self)
            make.height.equalTo(SCROLL_VIEW_HEIGHT)
        }
        
        //分割线
        lineView.backgroundColor = BACK_GROUND_COLOR
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom).offset(SM_MRAGIN_5)
            make.left.right.equalTo(self)
            make.height.equalTo(10*APP_SCALE)
        }
        
    }
    
}


//MARK: - 填充数据
extension RecommendUserCell{
    
    //数据源方法
    func fillter(model:FocusModel){
        
        self.model = model
        self.collectionView.reloadData()
        
        //cell高度
        var cellH:CGFloat = 0
        if model.cellH != 0 {  return }
        //数据来源View
        cellH += FOCUS_CELL_SOURCE_VIEW_HEIGHT
        //内容滚动View
        cellH += SM_MRAGIN_5 + SCROLL_VIEW_HEIGHT
        //分割线
        cellH += SM_MRAGIN_5 + 10*APP_SCALE
        model.cellH = cellH
        
    }
    
}

//MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension RecommendUserCell:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return model?.user_list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: PerRecUserItem.identifier, for: indexPath) as! PerRecUserItem
        item.layer.cornerRadius = 5*APP_SCALE
        item.backgroundColor = UIColor.white
        item.layer.shadowColor = UIColor.cyan.cgColor
        item.layer.shadowOffset = CGSize.zero
        item.layer.shadowRadius = 3
        item.layer.shadowOpacity = 0.5;
        if let model = model?.user_list?[indexPath.row] {
            item.fillter(model: model)
        }
        return item
    }
    
}


