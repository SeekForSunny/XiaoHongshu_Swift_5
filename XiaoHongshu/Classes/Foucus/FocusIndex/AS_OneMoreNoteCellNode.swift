//
//  AS_OneMoreNoteCellNode.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/11/19.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import AsyncDisplayKit

private let PER_CARD_VIEW_HEIGHT = 260*APP_SCALE
private let PERUSER_CARD_VIEW_WIDTH = 135*APP_SCALE
fileprivate let MORE_BUTTON_WH =  25*APP_SCALE

class AS_OneMoreNoteCellNode: ASCellNode ,ASCollectionDelegate,ASCollectionDataSource{
    
    private lazy var sourceNode = ASTextNode()
    private lazy var moreButtonNode = ASButtonNode()
    private lazy var bottomSeparator = ASDisplayNode()
    private var model:FocusModel
    private let cellType:FocusCellType
    
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
    
    init(model:FocusModel,cellType:FocusCellType) {
        self.model = model
        self.cellType = cellType
        super.init()
        
        self.backgroundColor = UIColor.white
        self.selectionStyle = .none
        
        setupChildNode()
    }
    
    func setupChildNode(){
        
        setupSourceNode()
        setupMoreButtonNode()
        setupCollectionNode()
        setupBottomSeparator()
    }
    
    func setupSourceNode(){  //数据来源标签
        var suffix = ""
        if cellType == .friendCollect {
            suffix = " 收藏了"
        } else if cellType == .friendLike{
            suffix = " 赞了"
        }
        let name = model.users?.first?.name ?? ""
        let count = model.notes_count ?? 0
        suffix += "\(count)" + " 篇笔记"
        
        let nameAttributeText = NSAttributedString(string: name, attributes: [NSForegroundColorAttributeName : UIColor.darkGray,
                                                                              NSFontAttributeName:UIFont.boldSystemFont(ofSize: 15*APP_SCALE)])
        let suffixAttributeText = NSAttributedString(string: suffix, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 15*APP_SCALE),NSForegroundColorAttributeName:LIGHT_TEXT_COLOR])
        let attributedText = NSMutableAttributedString(attributedString: nameAttributeText)
        attributedText.append(suffixAttributeText)
        sourceNode.attributedText = attributedText
        addSubnode(sourceNode)
    }
    
    func setupMoreButtonNode(){
        moreButtonNode.setImage(UIImage(named:"icon_menu_grey_25_25x25_"), for: UIControlState.normal)
        moreButtonNode.imageNode.contentMode = .scaleAspectFill
        moreButtonNode.style.preferredSize = CGSize(width: MORE_BUTTON_WH, height: MORE_BUTTON_WH)
        self.addSubnode(moreButtonNode)
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
        return model.note_list?.count ?? 0
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cellNodeBlock = {[weak self] () -> ASCellNode in
            if let model = self?.model.note_list?[indexPath.row] {
                let cellNode = AS_OneMoreNotePerCellNode(model: model)
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
        self.selectionStyle = .none
    }
    
}
