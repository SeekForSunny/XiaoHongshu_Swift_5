//
//  AS_FocusUserCellNode.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/11/19.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import AsyncDisplayKit

fileprivate let MORE_BUTTON_WH =  25*APP_SCALE

class AS_FollowCellNode: ASCellNode {
    
    private lazy var sourceTextNode = ASTextNode()
    private lazy var moreButtonNode = ASButtonNode()
    private lazy var itemNodeArr = [ASDisplayNode]()
    private lazy var bottomSeparator = ASDisplayNode()
    private let cellType:FocusCellType
    private let model:FocusModel
    
    init(model:FocusModel,cellType:FocusCellType) {
        self.cellType = cellType
        self.model = model
        super.init()
        setupChildNodes()
    }
    
    func setupChildNodes(){
        setupSourceNode()
        setupMoreButtonNode()
        setupItemList()
        setupBottomSeparator()
    }
    
    func setupSourceNode(){
        let name = model.users?.first?.name ?? ""
        var source = name + " 关注了用户"
        if cellType == .friendFollowVendor { //关注了商家
            source = name + " 关注了商家"
        }
        let attributedText = NSMutableAttributedString(string: source, attributes: [NSFontAttributeName:SYSTEM_FONT_15,NSForegroundColorAttributeName:LIGHT_TEXT_COLOR])
        attributedText.addAttributes([NSFontAttributeName:BOLD_SYSTEM_FONT_15,NSForegroundColorAttributeName:UIColor.darkText], range: NSRange(location: 0, length: name.characters.count));
        sourceTextNode.attributedText = attributedText
        addSubnode(sourceTextNode)
    }
    
    func setupMoreButtonNode(){
        moreButtonNode.setImage(UIImage(named:"icon_menu_grey_25_25x25_"), for: UIControlState.normal)
        moreButtonNode.imageNode.contentMode = .scaleAspectFill
        moreButtonNode.style.preferredSize = CGSize(width: MORE_BUTTON_WH, height: MORE_BUTTON_WH)
        self.addSubnode(moreButtonNode)
    }
    
    func setupItemList(){
        
        if cellType == .friendFollowUser {
            guard let user_list = model.user_list else {return}
            for model in user_list {
                let perItemNode = AS_FollowPercellNode(uModel:model,vModel:nil,itemType:.user)
                self.addSubnode(perItemNode)
                itemNodeArr.append(perItemNode)
            }
        }else{
            guard let vendor_list = model.vendor_list else {return}
            for model in vendor_list {
                let perItemNode = AS_FollowPercellNode(uModel:nil,vModel:model,itemType:.vendor)
                self.addSubnode(perItemNode)
                itemNodeArr.append(perItemNode)
            }
        }
        
    }
    
    //底部分割线
    func setupBottomSeparator(){
        bottomSeparator.backgroundColor = BACK_GROUND_COLOR
        bottomSeparator.style.preferredSize = CGSize(width: SCREEN_WIDTH, height: SM_MRAGIN_10)
        addSubnode(bottomSeparator)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let sourceMoreSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.spaceBetween, alignItems: ASStackLayoutAlignItems.center, children: [sourceTextNode,moreButtonNode])
        let insets = UIEdgeInsets(top: SM_MRAGIN_10, left: SM_MRAGIN_15, bottom: SM_MRAGIN_10, right: SM_MRAGIN_15)
        let sourceMoreInsetSpec = ASInsetLayoutSpec(insets:insets , child: sourceMoreSpec)
        
        let itemNodeArrSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: SM_MRAGIN_10, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: itemNodeArr )
        
        let itemArrBottomSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: SM_MRAGIN_10, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [itemNodeArrSpec,bottomSeparator])
        
        return ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.stretch, children: [sourceMoreInsetSpec,itemArrBottomSpec])
    }
    
    override func layout() {
        super.layout()
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor.white
        
    }
    
}
