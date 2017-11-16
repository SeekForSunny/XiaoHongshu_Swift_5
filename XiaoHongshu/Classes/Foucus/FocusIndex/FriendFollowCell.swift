//
//  FocusViewCell.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/10/22.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import SDWebImage
fileprivate let PER_LISTVIEW_ITEM_HEIGHT = 90*APP_SCALE
fileprivate let USER_ICON_WH = 70*APP_SCALE
class PerFollowItem: UIView {
    
    //头像
    fileprivate lazy var iconView:UIImageView = {
        let iconView = UIImageView()
        self.addSubview(iconView)
        iconView.contentMode = .scaleAspectFit
        iconView.layer.cornerRadius = USER_ICON_WH * 0.5
        iconView.clipsToBounds = true
        return iconView
    }()
    
    //昵称
    fileprivate lazy var nameLabel:UILabel = {
        let nameLabel = UILabel()
        self.addSubview(nameLabel)
        nameLabel.font = BOLD_SYSTEM_FONT_15
        nameLabel.textColor = UIColor.darkGray
        return nameLabel
    }()
    
    //用户相关信息
    fileprivate lazy var infoLabel:UILabel = {
        let infoLabel = UILabel()
        self.addSubview(infoLabel)
        infoLabel.font = SYSTEM_FONT_13
        infoLabel.textColor = LIGHT_TEXT_COLOR
        return infoLabel
    }()
    
    //签名
    fileprivate lazy var descLabel:UILabel = {
        let descLabel = UILabel()
        self.addSubview(descLabel)
        descLabel.font = SYSTEM_FONT_12
        descLabel.textColor = LIGHT_TEXT_COLOR
        return descLabel
    }()
    
    //关注按钮
    fileprivate lazy var focusBtn:UIButton = {
        let focusBtn = UIButton()
        self.addSubview(focusBtn)
        focusBtn.layer.cornerRadius = 5*APP_SCALE
        focusBtn.layer.borderColor = UIColor.red.cgColor
        focusBtn.layer.borderWidth = 0.5
        focusBtn.setTitle("关注", for: UIControlState.normal)
        focusBtn.setTitleColor(UIColor.red, for: UIControlState.normal)
        focusBtn.titleLabel?.font = SYSTEM_FONT_14
        return focusBtn
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
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(SM_MRAGIN_15)
            make.height.width.equalTo(USER_ICON_WH)
        }
        
        //描述Label
        infoLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconView)
            make.left.equalTo(iconView.snp.right).offset(SM_MRAGIN_10)
        }
        //昵称
        nameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(infoLabel.snp.top).offset(-SM_MRAGIN_5)
            make.left.equalTo(infoLabel)
        }
        
        //关注按钮
        focusBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-SM_MRAGIN_15)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width:50*APP_SCALE,height:25*APP_SCALE))
        }
        
        //签名
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(infoLabel.snp.bottom).offset(SM_MRAGIN_5)
            make.left.equalTo(infoLabel)
            make.right.equalTo(focusBtn.snp.left).offset(SM_MRAGIN_5)
        }
        
        
    }
    
    //数据源方法
    func fillter(uModel:UserModel?,vModel:F_VendorModel?,reason:String){
        
        //头像
        if reason.contains("friend_follow_vendor"){
            if let url = vModel?.icon {
                iconView.sd_setImage(with: URL(string:url), completed: nil)
            }
        }else{
            if let url = uModel?.image {
                iconView.sd_setImage(with: URL(string:url), completed: nil)
            }
        }
        
        
        //用户相关信息
        var info:String?
        if reason.contains("friend_follow_vendor"){
            let products_count = vModel?.products_count ?? 0
            info = "\(products_count)件商品"
        }else{
            let collectedCount = uModel?.collected_count ?? 0
            let likedCount = uModel?.liked_count ?? 0
            let fansCount = uModel?.fans_count ?? 0
            let clcount = collectedCount + likedCount
            info = "\(clcount)个赞与收藏  \(fansCount)个粉丝"
            if clcount / 10000 > 1 {
                info = "\(clcount / 10000)万个赞与收藏  \(fansCount)个粉丝"
            }
            if fansCount / 10000 > 1 {
                info = "\(clcount)个赞与收藏  \(fansCount/10000)万个粉丝"
            }
            if clcount/10000 > 1 && fansCount/10000 > 1 {
                info = "\(clcount/10000)万个赞与收藏  \(fansCount/10000)万个粉丝"
            }
        }
        infoLabel.text = info
        
        
        //昵称
        if reason.contains("friend_follow_vendor"){
            if let title = vModel?.title {
                nameLabel.text = title
            }
        }else{
            if let name = uModel?.name {
                nameLabel.text = name
            }
        }
        
        //描述
        if reason.contains("friend_follow_vendor"){
            if let desc = vModel?.desc {
                descLabel.text = desc
            }
        }else{
            if let desc = uModel?.desc {
                descLabel.text = desc
            }
        }
        
    }
}
class FriendFollowCell: UITableViewCell {
    
    //来源View
    fileprivate lazy var sourceView:UIView = {
        let view = UIView()
        self.addSubview(view)
        return view
    }()
    
    //来源标签
    fileprivate lazy var sourceLabel:UILabel = {
        let view = UILabel()
        self.sourceView.addSubview(view)
        return view
    }()
    
    //更多按钮
    fileprivate lazy var moreBtn:UIButton = {
        let view = UIButton()
        self.sourceView.addSubview(view)
        return view
    }()
    
    //关注用户容器View
    fileprivate lazy var listView:UIView = {
        let view = UIView()
        self.addSubview(view)
        return view
    }()
    
    //底部分割线
    fileprivate lazy var lineView:UIView = {
        let lineView = UIView()
        self.addSubview(lineView)
        return lineView
    }()
    
    //itemArr
    fileprivate lazy var itemArr = [PerFollowItem]()
    
    var model:FocusModel?
    
    static let identifier = "FriendFollowCell"
    static func cell(tableView:UITableView)->FriendFollowCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = FriendFollowCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            cell?.selectionStyle = .none
        }
        return cell as! FriendFollowCell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        setupUIContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUIContent(){
        
        //来源View
        sourceView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.right.equalTo(self)
            make.height.equalTo(FOCUS_CELL_SOURCE_VIEW_HEIGHT)
            
        }
        
        //来源Label
        sourceLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(sourceView)
            make.left.equalTo(sourceView.snp.left).offset(SM_MRAGIN_15)
            
        }
        
        listView.snp.makeConstraints { (make) in
            make.top.equalTo(sourceView.snp.bottom).offset(SM_MRAGIN_10)
            make.left.equalTo(self.snp.left).offset(SM_MRAGIN_15)
            make.right.equalTo(self.snp.right).offset(-SM_MRAGIN_15)
            make.height.equalTo(0)
        }
        
        //底部分割线
        lineView.backgroundColor = BACK_GROUND_COLOR
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(listView.snp.bottom).offset(SM_MRAGIN_10)
            make.left.right.equalTo(self)
            make.height.equalTo(SM_MRAGIN_10)
        }
        
    }
    
}

extension FriendFollowCell{
    
    func fillter(model:FocusModel) {
        
        self.model = model
        
        guard let recommend_reason =  model.recommend_reason else {
            return
        }
        
        //累计高度
        var cellH:CGFloat = 0
        
        if let name = model.users?.first?.name {
            var source = name + " 关注了用户"
            if recommend_reason.contains("friend_follow_vendor") { //关注了商家
                source = name + " 关注了商家"
            }
            let attributedText = NSMutableAttributedString(string: source, attributes: [NSFontAttributeName:SYSTEM_FONT_15,NSForegroundColorAttributeName:LIGHT_TEXT_COLOR])
            attributedText.addAttributes([NSFontAttributeName:BOLD_SYSTEM_FONT_15,NSForegroundColorAttributeName:UIColor.darkText], range: NSRange(location: 0, length: name.characters.count));
            sourceLabel.attributedText = attributedText
        }
        
        //容器View
        var listViewH:CGFloat = 0
        if let count = model.followed_count {
            listViewH = CGFloat(count)*(PER_LISTVIEW_ITEM_HEIGHT) +  CGFloat(count-1)*SM_MRAGIN_10
            func setupListView(){
                
                for (index,subview) in listView.subviews.enumerated() {
                    subview.isHidden = index >= count ? true : false
                }
                
                for i in 0..<count {
                    
                    if itemArr.count < count{
                        let perItem = PerFollowItem()
                        perItem.layer.cornerRadius = 5*APP_SCALE
                        perItem.layer.shadowColor = UIColor.randomColor().cgColor
                        perItem.layer.shadowOffset = CGSize.zero
                        perItem.layer.shadowRadius = 3
                        perItem.layer.shadowOpacity = 0.5;
                        itemArr.append(perItem)
                        listView.addSubview(perItem)
                    }
                    
                    let item = itemArr[i]
                    if recommend_reason.contains("friend_follow_vendor"){
                        if let model = model.vendor_list?[i] {
                            item.fillter(uModel: nil, vModel:model,reason:recommend_reason)
                        }
                    }else {
                        if let model = model.user_list?[i] {
                            item.fillter(uModel: model, vModel:nil,reason:recommend_reason)
                        }
                    }
                    
                    item.backgroundColor = UIColor.white
                    item.snp.remakeConstraints({ (make) in
                        make.left.right.equalTo(listView)
                        make.height.equalTo(PER_LISTVIEW_ITEM_HEIGHT)
                        make.top.equalTo(CGFloat(i)*PER_LISTVIEW_ITEM_HEIGHT + CGFloat(i-1)*SM_MRAGIN_10)
                    })
                    
                }
                
            }
            
            setupListView()
            
        }
        
        listView.snp.updateConstraints { (make) in
            make.height.equalTo(listViewH)
        }
        
        if model.cellH != 0{ return }
        
        //来源View
        cellH += FOCUS_CELL_SOURCE_VIEW_HEIGHT
        //listView高度
        cellH += SM_MRAGIN_10 + listViewH
        //底部分割线
        cellH += SM_MRAGIN_10 + SM_MRAGIN_10
        
        model.cellH = cellH
        
    }
    
}

