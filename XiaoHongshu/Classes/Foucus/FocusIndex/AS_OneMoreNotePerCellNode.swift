//
//  AS_OneMoreNotePerCellNode.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/11/19.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import AsyncDisplayKit

private let AVATAR_ICON_WH = 20*APP_SCALE
private let PERUSER_CARD_VIEW_WIDTH = 135*APP_SCALE

class AS_OneMoreNotePerCellNode: ASCellNode {
    
    private lazy var pictureNode = ASNetworkImageNode()
    private lazy var titleTextNode = ASTextNode()
    private lazy var avatarNode = ASNetworkImageNode()
    private lazy var nameTextNode = ASTextNode()
    private lazy var separatorLine = ASDisplayNode()
    private lazy var praiseButtonNode = ASButtonNode()
    private lazy var collectButtonNode = ASButtonNode()
    private var model:F_NoteModel
    
    init(model:F_NoteModel) {
        self.model = model
        super.init()
        setupChildNotes()
    }
    
    func setupChildNotes(){
        setupPictureNode()
        setupTitleTextNode()
        setupAvatarNode()
        setupNameTextNode()
        setupSeparatorLinde()
        setupPraiseButtonNode()
        setupCollectButtonNode()
    }
    
    func setupPictureNode(){//描述图片
        let url = model.images_list?.first?.url ?? ""
        pictureNode.url = URL(string:url)
        pictureNode.contentMode = .scaleAspectFill
        addSubnode(pictureNode)
    }
    
    func setupTitleTextNode(){
        let title = model.title ?? ""
        if title.characters.count > 0 {
            titleTextNode.attributedText = NSAttributedString(string: title, attributes: [NSFontAttributeName: BOLD_SYSTEM_FONT_14])
        }else{
            let desc = model.desc ?? ""
            titleTextNode.attributedText = NSAttributedString(string: desc, attributes: [NSFontAttributeName: SYSTEM_FONT_14,NSForegroundColorAttributeName:LIGHT_TEXT_COLOR])
        }
        titleTextNode.maximumNumberOfLines = 2
        titleTextNode.truncationMode = .byTruncatingTail
        addSubnode(titleTextNode)
    }
    
    func setupAvatarNode(){
        let url = model.user?.image ?? ""
        avatarNode.url = URL(string:url)
        avatarNode.imageModificationBlock = { image in
            return image.makeCircleImage()
        }
        avatarNode.style.preferredSize = CGSize(width: AVATAR_ICON_WH, height: AVATAR_ICON_WH)
        addSubnode(avatarNode)
    }
    
    func setupNameTextNode(){
        let name = model.user?.name ?? ""
        nameTextNode.attributedText = NSAttributedString(string: name, attributes: [NSFontAttributeName:SYSTEM_FONT_11])
        nameTextNode.maximumNumberOfLines = 1
        addSubnode(nameTextNode)
    }
    
    func setupSeparatorLinde(){
        separatorLine.backgroundColor = UIColor(white: 0.7, alpha: 0.7)
        addSubnode(separatorLine)
    }
    
    func setupPraiseButtonNode(){
        let count = model.liked_count ?? 0
        let text = (count != 0) ? "\(count)" : "点赞"
        praiseButtonNode.setTitle(text, with: SYSTEM_FONT_11, with: UIColor.darkGray, for: UIControlState.normal)
        praiseButtonNode.setImage(UIImage(named: "icon_like_grey_20_20x20_"), for: UIControlState.normal)
        addSubnode(praiseButtonNode)
    }
    
    func setupCollectButtonNode(){
        let count = model.collected_count ?? 0
        let text = (count != 0) ? "\(count)" : "收藏"
        collectButtonNode.setTitle(text, with: SYSTEM_FONT_11, with: UIColor.darkGray, for: UIControlState.normal)
        collectButtonNode.setImage(UIImage(named: "icon_collect_grey_20_20x20_"), for: UIControlState.normal)
        addSubnode(collectButtonNode)
    }
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        pictureNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: constrainedSize.max.width)
        separatorLine.style.preferredSize = CGSize(width: constrainedSize.max.width - 2*SM_MRAGIN_10, height: 0.5)
        nameTextNode.style.width = ASDimensionMake(constrainedSize.max.width - AVATAR_ICON_WH - SM_MRAGIN_5 - 2*SM_MRAGIN_10)
        
        let avatarNameSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: SM_MRAGIN_5, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [avatarNode,nameTextNode])
        
        let praiseCollectSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.spaceBetween, alignItems: ASStackLayoutAlignItems.center, children: [praiseButtonNode,collectButtonNode])
        
        let bottomSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: SM_MRAGIN_10, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.stretch, children: [titleTextNode,avatarNameSpec,separatorLine,praiseCollectSpec])
        let insets = UIEdgeInsets(top: 0, left: SM_MRAGIN_10, bottom: SM_MRAGIN_5, right: SM_MRAGIN_10)
        let bottomInsetSpec = ASInsetLayoutSpec(insets: insets, child: bottomSpec)
        
        let finalSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: SM_MRAGIN_10, justifyContent: ASStackLayoutJustifyContent.spaceBetween, alignItems: ASStackLayoutAlignItems.start, children: [pictureNode,bottomInsetSpec])
        
        return finalSpec
    }
    
    override func layout() {
        super.layout()
        
        self.backgroundColor = UIColor.white
        self.cornerRadius = 5*APP_SCALE
        self.borderWidth = 0.5
        self.borderColor = UIColor.cyan.cgColor
    
    }
}
