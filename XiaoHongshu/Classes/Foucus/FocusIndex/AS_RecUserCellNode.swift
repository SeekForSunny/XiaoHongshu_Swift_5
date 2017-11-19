//
//  AS_RecUserCellNode.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/11/18.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import AsyncDisplayKit

private let  PER_CARD_VIEW_HEIGHT = 260*APP_SCALE
private let PERUSER_CARD_VIEW_WIDTH = 135*APP_SCALE


class AS_RecUserCellNode: ASCellNode ,ASCollectionDelegate,ASCollectionDataSource{
    
    
    private lazy var sourceNode = ASTextNode()
    private lazy var moreButtonNode = ASButtonNode()
    private lazy var bottomSeparator = ASDisplayNode()
    private var model:FocusModel
    
    private lazy var collectionNode:ASCollectionNode = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = SM_MRAGIN_10
        layout.minimumInteritemSpacing = SM_MRAGIN_10
        layout.sectionInset = UIEdgeInsets(top: 0, left: SM_MRAGIN_10, bottom: 0, right: SM_MRAGIN_10)
        layout.itemSize = CGSize(width: PERUSER_CARD_VIEW_WIDTH, height: PER_CARD_VIEW_HEIGHT)
        let collectionNode = ASCollectionNode(collectionViewLayout: layout)
        collectionNode.dataSource = self
        collectionNode.delegate = self
        return collectionNode
    }()
    
    init(model:FocusModel) {
        self.model = model
        super.init()

        setupChildNode()
    }
    
    func setupChildNode(){
        setupSourceNode()
        setupMoreButtonNode()
        setupCollectionNode()
        setupBottomSeparator()
    }
    
    func setupSourceNode(){
        sourceNode.attributedText = NSAttributedString(string: "你可能感兴趣的用户", attributes: [NSFontAttributeName:SYSTEM_FONT_15])
        addSubnode(sourceNode)
    }
    
    func setupMoreButtonNode(){
        moreButtonNode.setTitle("查看更多", with: SYSTEM_FONT_14, with: LIGHT_TEXT_COLOR, for: UIControlState.normal)
        addSubnode(moreButtonNode)
    }
    
    func setupCollectionNode(){
        collectionNode.style.preferredSize = CGSize(width: SCREEN_WIDTH, height: PER_CARD_VIEW_HEIGHT + 2*SM_MRAGIN_5)
        collectionNode.backgroundColor = UIColor.white
        addSubnode(collectionNode)
    }
    
    func setupBottomSeparator(){
        bottomSeparator.backgroundColor = BACK_GROUND_COLOR
        bottomSeparator.style.preferredSize = CGSize(width: SCREEN_WIDTH, height: SM_MRAGIN_10)
        addSubnode(bottomSeparator)
    }
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return model.user_list?.count ?? 0
    }
    
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cellNodeBlock = {[weak self] () -> ASCellNode in
            if let model = self?.model.user_list?[indexPath.row] {
                 let cellNode = AS_RecUserPerCellNode(model: model)
                return cellNode
            }
            return ASCellNode()
        }
        return cellNodeBlock
    }
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let sourceMoreSpec = ASStackLayoutSpec(direction: .horizontal, spacing: SM_MRAGIN_10, justifyContent: .spaceBetween, alignItems: .center, children: [sourceNode,moreButtonNode])
        
        let insets =  UIEdgeInsets(top: SM_MRAGIN_10, left: SM_MRAGIN_15, bottom: 0, right: SM_MRAGIN_15)
        let sourceMoreInsetSpec = ASInsetLayoutSpec(insets: insets, child: sourceMoreSpec)
        
        let collectSeparatorSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [collectionNode,bottomSeparator])
        
        let finalSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: SM_MRAGIN_10, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.stretch, children: [sourceMoreInsetSpec,collectSeparatorSpec])
        return finalSpec
    }
    
    override func layout() {
        super.layout()
        self.backgroundColor = UIColor.white
        self.selectionStyle = .none
    }
    
}
