//
//  AS_CellToolBar.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/11/18.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class AS_CellToolBar: ASDisplayNode {
    
    private lazy var separatorLine = ASDisplayNode()
    private lazy var praiseButtonNode = ASButtonNode()
    private lazy var replyButtonNode = ASButtonNode()
    private lazy var collectButtonNode = ASButtonNode()
    
    
    override init() {
        super.init()
        setupChildNotes()
    }
    
    func setupChildNotes(){
        
        setupSeparatorLine()
        setupPraiseButtonNode()
        setupReplyButtonNode()
        setupCollectButtonNode()
        
    }
    
    func setupSeparatorLine(){
        separatorLine.backgroundColor = UIColor(white: 0.7, alpha: 0.7)
        separatorLine.style.preferredSize = CGSize(width: SCREEN_WIDTH, height: 0.5)
        addSubnode(separatorLine)
    }
    
    func setupPraiseButtonNode(){
        praiseButtonNode.imageNode.image = UIImage(named: "icon_like_grey_20_20x20_")
        praiseButtonNode.setTitle("点赞", with: SYSTEM_FONT_14, with: UIColor.darkGray, for: UIControlState.normal)
        praiseButtonNode.style.preferredSize = CGSize(width: SCREEN_WIDTH/3, height: FOCUS_CELL_TOOL_BAR_HEIGHT)
        addSubnode(praiseButtonNode)
    }
    
    func setupReplyButtonNode(){
        replyButtonNode.imageNode.image = UIImage(named: "icon_comment_grey_20_20x20_")
        replyButtonNode.setTitle("评论", with: SYSTEM_FONT_14, with: UIColor.darkGray, for: UIControlState.normal)
        replyButtonNode.style.preferredSize = CGSize(width: SCREEN_WIDTH/3, height: FOCUS_CELL_TOOL_BAR_HEIGHT)
        addSubnode(replyButtonNode)
    }
    
    func setupCollectButtonNode(){
        collectButtonNode.imageNode.image = UIImage(named: "icon_collect_grey_20_20x20_")
        collectButtonNode.setTitle("收藏", with: SYSTEM_FONT_14, with: UIColor.darkGray, for: UIControlState.normal)
        collectButtonNode.style.preferredSize = CGSize(width: SCREEN_WIDTH/3, height: FOCUS_CELL_TOOL_BAR_HEIGHT)
        addSubnode(collectButtonNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    
        let buttonSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.start, children: [praiseButtonNode,replyButtonNode,collectButtonNode])
        
        return ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [separatorLine,buttonSpec])
    }
    
    
}
