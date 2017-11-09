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
class PerFollowUserItem: UIView {
    
    //头像
    fileprivate lazy var iconView:UIImageView = {
        let view = UIImageView()
        self.addSubview(view)
        return view
    }()
    
    //昵称
    fileprivate lazy var nameLabel:UILabel = {
        let view = UILabel()
        self.addSubview(view)
        return view
    }()
    
    //用户相关信息
    fileprivate lazy var infoLabel:UILabel = {
        let view = UILabel()
        self.addSubview(view)
        return view
    }()
    
    //签名
    fileprivate lazy var descLabel:UILabel = {
        let view = UILabel()
        self.addSubview(view)
        return view
    }()
    
    //关注按钮
    fileprivate lazy var focusBtn:UIButton = {
        let view = UIButton()
        self.addSubview(view)
        return view
    }()
    
    //数据源方法
    func fillter(model:F_UserModel){
        
        //头像
        iconView.snp.remakeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(SM_MRAGIN_15)
            make.height.width.equalTo(USER_ICON_WH)
        }
        iconView.layer.cornerRadius = USER_ICON_WH * 0.5
        iconView.clipsToBounds = true
        if let url = model.image {
            iconView.sd_setImage(with: URL(string:url), completed: nil)
        }
        
        //用户相关信息
        let collectedCount = model.collected_count ?? 0
        let likedCount = model.liked_count ?? 0
        let fansCount = model.fans_count ?? 0
        let clcount = collectedCount + likedCount
        var info = "\(clcount)个赞与收藏  \(fansCount)个粉丝"
        if clcount / 10000 > 1 {
            info = "\(clcount / 10000)万个赞与收藏  \(fansCount)个粉丝"
        }
        if fansCount / 10000 > 1 {
            info = "\(clcount)个赞与收藏  \(fansCount/10000)万个粉丝"
        }
        if clcount/10000 > 1 && fansCount/10000 > 1 {
            info = "\(clcount/10000)万个赞与收藏  \(fansCount/10000)万个粉丝"
        }
        infoLabel.text = info
        infoLabel.font = SYSTEM_FONT_13
        infoLabel.textColor = LIGHT_TEXT_COLOR
        infoLabel.snp.remakeConstraints { (make) in
            make.centerY.equalTo(iconView)
            make.left.equalTo(iconView.snp.right).offset(SM_MRAGIN_10)
        }
        
        //昵称
        nameLabel.snp.remakeConstraints { (make) in
            make.bottom.equalTo(infoLabel.snp.top).offset(-SM_MRAGIN_5)
            make.left.equalTo(infoLabel)
        }
        if let name = model.name {
            nameLabel.text = name
            nameLabel.font = BOLD_SYSTEM_FONT_15
            nameLabel.textColor = UIColor.darkGray
        }
        
        
        
        //关注按钮
        focusBtn.snp.remakeConstraints { (make) in
            make.right.equalTo(self).offset(-SM_MRAGIN_15)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width:50*APP_SCALE,height:25*APP_SCALE))
        }
        focusBtn.layer.cornerRadius = 5*APP_SCALE
        focusBtn.layer.borderColor = UIColor.red.cgColor
        focusBtn.layer.borderWidth = 0.5
        focusBtn.setTitle("关注", for: UIControlState.normal)
        focusBtn.setTitleColor(UIColor.red, for: UIControlState.normal)
        focusBtn.titleLabel?.font = SYSTEM_FONT_14
        
        //签名
        descLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(infoLabel.snp.bottom).offset(SM_MRAGIN_5)
            make.left.equalTo(infoLabel)
            make.right.equalTo(focusBtn.snp.left).offset(SM_MRAGIN_5)
        }
        if let desc = model.desc {
            descLabel.text = desc
            descLabel.font = SYSTEM_FONT_12
            descLabel.textColor = LIGHT_TEXT_COLOR
        }
        
    }
}
class FriendFollowUserCell: UITableViewCell {
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
    
    //PerFollowUserItemArr
    fileprivate lazy var userItemArr = [PerFollowUserItem]()
    
    
    static let identifier = "FriendFollowUserCell"
    static func cell(tableView:UITableView)->FriendFollowUserCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = FriendFollowUserCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            cell?.selectionStyle = .none
        }
        return cell as! FriendFollowUserCell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

extension FriendFollowUserCell{
    
    func fillter(model:FocusModel) {
        
        //累计高度
        var cellH:CGFloat = 0
        
        //来源View
        sourceView.snp.remakeConstraints { (make) in
            make.top.equalTo(self)
            make.left.right.equalTo(self)
            make.height.equalTo(FOCUS_CELL_SOURCE_VIEW_HEIGHT)
        }
        //来源View
        cellH += FOCUS_CELL_SOURCE_VIEW_HEIGHT
        
        //来源Label
        sourceLabel.snp.remakeConstraints { (make) in
            make.centerY.equalTo(sourceView)
            make.left.equalTo(sourceView.snp.left).offset(SM_MRAGIN_15)
        }
        if let name = model.users?.first?.name {
            let source = name + " 关注了用户"
            let attributedText = NSMutableAttributedString(string: source, attributes: [NSFontAttributeName:SYSTEM_FONT_15,NSForegroundColorAttributeName:LIGHT_TEXT_COLOR])
            attributedText.addAttributes([NSFontAttributeName:BOLD_SYSTEM_FONT_15,NSForegroundColorAttributeName:UIColor.darkText], range: NSRange(location: 0, length: name.characters.count));
            sourceLabel.attributedText = attributedText
        }
        
        //容器View
        var listViewH:CGFloat = 0
        if let count = model.followed_count {
            listViewH = CGFloat(count)*(PER_LISTVIEW_ITEM_HEIGHT) +  CGFloat(count-1)*SM_MRAGIN_10
            func setupListView(){
                for i in 0..<count {
                    
                    if userItemArr.count < count{
                        let perItem = PerFollowUserItem()
                        perItem.layer.cornerRadius = 5*APP_SCALE
                        perItem.layer.shadowColor = UIColor.randomColor().cgColor
                        perItem.layer.shadowOffset = CGSize.zero
                        perItem.layer.shadowRadius = 3
                        perItem.layer.shadowOpacity = 0.5;
                        userItemArr.append(perItem)
                        listView.addSubview(perItem)
                    }else{
                        userItemArr.removeSubrange(Range(count..<userItemArr.count))
                    }
                    
                    let item = userItemArr[i]
                    if let model = model.user_list?[i] {
                        item.fillter(model: model)
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
        listView.snp.remakeConstraints { (make) in
            make.top.equalTo(sourceView.snp.bottom).offset(SM_MRAGIN_10)
            make.left.equalTo(self.snp.left).offset(SM_MRAGIN_15)
            make.right.equalTo(self.snp.right).offset(-SM_MRAGIN_15)
            make.height.equalTo(listViewH)
        }
        //listView高度
        cellH += SM_MRAGIN_10 + listViewH
        
        
        //底部分割线
        lineView.backgroundColor = BACK_GROUND_COLOR
        lineView.snp.remakeConstraints { (make) in
            make.top.equalTo(listView.snp.bottom).offset(SM_MRAGIN_10)
            make.left.right.equalTo(self)
            make.height.equalTo(SM_MRAGIN_10)
        }
        //底部分割线
        cellH += SM_MRAGIN_10 + SM_MRAGIN_10
        
        model.cellH = cellH
        
    }
    
}
