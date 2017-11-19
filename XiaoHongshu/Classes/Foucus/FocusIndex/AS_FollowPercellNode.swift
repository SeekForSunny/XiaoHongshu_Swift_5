//
//  AS_FollowPercellNode.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/11/19.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import AsyncDisplayKit

private let USER_ICON_WH = 70*APP_SCALE
enum FollowItemType {
    case user
    case vendor
}

class AS_FollowPercellNode: ASDisplayNode {
    
    private lazy var avatarNode = ASNetworkImageNode()
    private lazy var nameTextNode = ASTextNode()
    private lazy var infoTextNode = ASTextNode()
    private lazy var descTextNode = ASTextNode()
    private lazy var focusButtonNode = ASButtonNode()
    private let uModel:UserModel?
    private let vModel:F_VendorModel?
    private let itemType:FollowItemType
    
    init(uModel:UserModel?,vModel:F_VendorModel?,itemType:FollowItemType) {
        self.uModel = uModel
        self.vModel = vModel
        self.itemType = itemType
        super.init()
        setupChildNodes()
    }
    
    func setupChildNodes(){
        
        setupAvatarNode()
        setupNameTextNode()
        setupInfoTextNode()
        setupDescTextNode()
        setupFocusButtonNode()
        
    }
    
    func setupAvatarNode(){
        //头像
        var url:String
        if itemType == .user {
            url = uModel?.image ?? ""
        } else {
            url = vModel?.icon ?? ""
        }
        avatarNode.url = URL(string:url)
        avatarNode.imageModificationBlock = { image in
            return image.makeCircleImage()
        }
        avatarNode.style.preferredSize = CGSize(width: USER_ICON_WH, height: USER_ICON_WH)
        addSubnode(avatarNode)
    }
    
    func setupNameTextNode(){
        //昵称
        var name:String
        if itemType == .vendor{
            name = vModel?.title ?? ""
        }else{
            name = uModel?.name ?? ""
        }
        nameTextNode.attributedText =  NSAttributedString(string: name, attributes: [NSFontAttributeName:BOLD_SYSTEM_FONT_14])
        addSubnode(nameTextNode)
    }
    
    func setupInfoTextNode(){
        //用户相关信息
        var info:String
        if itemType == .vendor {
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
        infoTextNode.attributedText = NSAttributedString(string: info, attributes: [NSFontAttributeName : SYSTEM_FONT_12])
        addSubnode(infoTextNode)
    }
    
    func setupDescTextNode(){
        //描述
        var desc:String
        if itemType == .vendor {
            desc = vModel?.desc ?? ""
        }else{
            desc = uModel?.desc ?? ""
        }
        descTextNode.attributedText = NSAttributedString(string: desc, attributes: [NSFontAttributeName:SYSTEM_FONT_12])
        descTextNode.maximumNumberOfLines = 1
        descTextNode.truncationMode = .byTruncatingTail
        addSubnode(descTextNode)
    }
    
    func setupFocusButtonNode(){
        focusButtonNode.setTitle("关注", with: SYSTEM_FONT_13, with: UIColor.red, for: UIControlState.normal)
        focusButtonNode.style.preferredSize = CGSize(width: 50*APP_SCALE, height: 25*APP_SCALE)
        addSubnode(focusButtonNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        descTextNode.style.width = ASDimensionMake(170*APP_SCALE)
        
        let vStackSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: SM_MRAGIN_10, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.start, children: [nameTextNode,infoTextNode,descTextNode])
        
        let hStackSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: SM_MRAGIN_15, justifyContent: ASStackLayoutJustifyContent.spaceBetween, alignItems: ASStackLayoutAlignItems.center, children: [avatarNode,vStackSpec,focusButtonNode])
        
        let insets = UIEdgeInsets(top: SM_MRAGIN_10, left: SM_MRAGIN_15, bottom: SM_MRAGIN_10, right: SM_MRAGIN_15)
        let insetSpec = ASInsetLayoutSpec(insets: insets, child: hStackSpec)
        
        return insetSpec
    }
    
    override func layout() {
        super.layout()
        
        focusButtonNode.borderColor = UIColor.red.cgColor
        focusButtonNode.borderWidth = 0.5
        focusButtonNode.cornerRadius = 5*APP_SCALE
        
        self.cornerRadius = 5*APP_SCALE
        self.borderWidth = 0.5
        self.borderColor = UIColor.cyan.cgColor
        
    }
}
