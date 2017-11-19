//
//  AS_RecPerUserCellNode.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/11/18.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import AsyncDisplayKit
private let USER_ICON_VIEW_WH = 70*APP_SCALE
class AS_RecUserPerCellNode: ASCellNode {
    
    private lazy var avatarNode = ASNetworkImageNode()
    private lazy var nameTextNode = ASTextNode()
    private lazy var sourceTextNode = ASTextNode()
    private lazy var focusButtonNode = ASButtonNode()
    private lazy var hiddenButtonNode = ASButtonNode()
    
    private var model:UserModel
    init(model:UserModel) {
        self.model = model
        super.init()
        
        setupChildNotes()
        
    }
    
    func setupChildNotes(){
        
        setupAvatarNode()
        setupNameTextNode()
        setupSourceTextNode()
        setupFocusButtonNode()
        setupHiddenButtonNode()
        
    }
    
    func setupAvatarNode() {
        let url = model.image ?? ""
        avatarNode.url = URL(string: url)
        avatarNode.style.preferredSize = CGSize(width: USER_ICON_VIEW_WH, height: USER_ICON_VIEW_WH)
        avatarNode.imageModificationBlock = { imge in
            return imge.makeCircleImage()
        }
        addSubnode(avatarNode)
    }
    
    func setupNameTextNode(){
        let name = model.name ?? ""
        nameTextNode.attributedText = NSAttributedString(string: name, attributes: [NSFontAttributeName: BOLD_SYSTEM_FONT_13])
        nameTextNode.maximumNumberOfLines = 1
        nameTextNode.truncationMode = .byTruncatingTail
        addSubnode(nameTextNode)
    }
    
    func setupSourceTextNode(){
        let desc = model.desc ?? ""
        sourceTextNode.attributedText = NSAttributedString(string: desc, attributes: [NSFontAttributeName: SYSTEM_FONT_12])
        sourceTextNode.maximumNumberOfLines = 0
        addSubnode(sourceTextNode)
    }
    
    func setupFocusButtonNode(){
        focusButtonNode.setTitle("关注", with: SYSTEM_FONT_13, with: UIColor.red, for: UIControlState.normal)
        focusButtonNode.style.preferredSize = CGSize(width: 100*APP_SCALE, height: 25*APP_SCALE)
        addSubnode(focusButtonNode)
    }
    
    func setupHiddenButtonNode(){
        hiddenButtonNode.setTitle("隐藏", with: SYSTEM_FONT_12, with: LIGHT_TEXT_COLOR, for: UIControlState.normal)
        addSubnode(hiddenButtonNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let verStackSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: SM_MRAGIN_10, justifyContent: ASStackLayoutJustifyContent.spaceBetween, alignItems: ASStackLayoutAlignItems.center, children: [avatarNode,nameTextNode,sourceTextNode,focusButtonNode,hiddenButtonNode])
        
        let insets = UIEdgeInsets(top: SM_MRAGIN_20, left: SM_MRAGIN_20, bottom: SM_MRAGIN_10, right: SM_MRAGIN_15)
        let finalSpec =  ASInsetLayoutSpec(insets: insets, child: verStackSpec)
        return finalSpec
        
    }
    
    override func layout() {
        super.layout()
        
        self.backgroundColor = .white
        self.selectionStyle = .none
        
        self.cornerRadius = 5*APP_SCALE
        self.borderColor = UIColor.cyan.cgColor
        self.borderWidth = 0.5
        
        focusButtonNode.borderColor = UIColor.red.cgColor
        focusButtonNode.borderWidth = 0.5
        focusButtonNode.cornerRadius = 5*APP_SCALE
        
    }
    
}
