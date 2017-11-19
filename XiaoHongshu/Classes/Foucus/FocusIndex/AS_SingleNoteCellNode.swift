//
//  AS_SingleNoteCellNode.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/11/17.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import AsyncDisplayKit

//更多按钮宽高
fileprivate let MORE_BUTTON_WH =  25*APP_SCALE

//头像宽高
fileprivate let ICON_VIEW_WH = 30*APP_SCALE

class AS_SingleNoteCellNode: ASCellNode {
    
    //笔记来源
    fileprivate lazy var sourceTextNode = ASTextNode()
    
    //更多按钮
    fileprivate lazy var moreButtonNode = ASButtonNode()
    
    //顶部笔记来源View底部分割线
    fileprivate lazy var lineNode = ASDisplayNode()
    
    //用户头像
    fileprivate lazy var avatarNode = ASNetworkImageNode()
    
    //昵称
    fileprivate lazy var nameTextNode = ASTextNode()
    
    //发布时间
    fileprivate lazy var timeTextNode = ASTextNode()
    
    //关注按钮
    fileprivate lazy var focusBtnNode = ASButtonNode()
    
    //图片
    fileprivate lazy var pictureNode = ASNetworkImageNode()
    
    //标题
    fileprivate lazy var titleTextNode = ASTextNode()
    
    //描述内容
    fileprivate lazy var descTextNode = ASTextNode()
    
    //底部工具条
    fileprivate lazy var toolBar = AS_CellToolBar()
    
    //底部间隔
    fileprivate lazy var bottomSeparator = ASDisplayNode()
    
    var model:FocusModel
    var cellType:FocusCellType
    
    init(model:FocusModel,cellType:FocusCellType) {
        self.model = model
        self.cellType = cellType
        super.init()
        
        //设置子节点
        setupChildNodes()
        
    }
    
}

//MARK: - 设置子节点
extension AS_SingleNoteCellNode{
    
    func setupChildNodes(){
        
        setupSourceTextNode()
        setupMoreBtnNode()
        setupLineNode()
        setupAvatarNode()
        setupNameTextNode()
        setupTimeTextNode()
        setupFocusBtnNode()
        setupPictureNode()
        setupTitleTextNode()
        setupDescTextNode()
        setupToolBar()
        setupBottomSeparator()
        
    }
    
    //笔记来源
    func setupSourceTextNode(){
        //来源
        var suffix = ""
        if cellType == .friendCollect {
            //已关注的人收藏了未关注的人的笔记
            suffix = " 收藏了笔记"
        }else if cellType == .friendLike  {
            //单条: Missgreenberry 赞了笔记
            suffix = " 赞了笔记"
        }
        let name = model.users?.first?.name ?? ""
        let nameAttributesText = NSAttributedString(string: name, attributes: [NSForegroundColorAttributeName : UIColor.darkGray,
                                                                               NSFontAttributeName:UIFont.boldSystemFont(ofSize: 15*APP_SCALE)])
        let suffixattributedText = NSAttributedString(string: suffix, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 15*APP_SCALE),NSForegroundColorAttributeName:LIGHT_TEXT_COLOR])
        let attributedText = NSMutableAttributedString(attributedString: nameAttributesText)
        attributedText.append(suffixattributedText)
        sourceTextNode.attributedText = attributedText
        addSubnode(sourceTextNode)
    }
    
    //更多按钮
    func setupMoreBtnNode(){
        moreButtonNode.setImage(UIImage(named:"icon_menu_grey_25_25x25_"), for: UIControlState.normal)
        moreButtonNode.imageNode.contentMode = .scaleAspectFill
        moreButtonNode.style.preferredSize = CGSize(width: MORE_BUTTON_WH, height: MORE_BUTTON_WH)
        self.addSubnode(moreButtonNode)
    }
    
    //顶部笔记来源分割线
    func setupLineNode(){
        lineNode.backgroundColor = UIColor(white: 0.7, alpha: 0.7)
        lineNode.style.preferredSize = CGSize(width: SCREEN_WIDTH, height: 0.5)
        self.addSubnode(lineNode)
    }
    
    //头像
    func setupAvatarNode(){
        var avatar:String
        if cellType == .friendPost  {
            avatar = model.user?.image ?? ""
        } else {
            avatar = model.note_list?.first?.user?.image ?? ""
        }
        avatarNode.url = URL(string: avatar)
        avatarNode.imageModificationBlock = { image in
            return image.makeCircleImage()
        }
        avatarNode.style.preferredSize = CGSize(width:ICON_VIEW_WH, height: ICON_VIEW_WH)
        addSubnode(avatarNode)
    }
    
    //昵称
    func setupNameTextNode(){
        var name:String
        if cellType == .friendPost { //已关注人的笔记
            //昵称
            name = model.user?.name ?? ""
        } else { //LittleJ 收藏了笔记
            //昵称
            name = model.note_list?.first?.user?.name ?? ""
        }
        let attributes = [NSFontAttributeName:BOLD_SYSTEM_FONT_14]
        nameTextNode.attributedText = NSAttributedString(string: name, attributes: attributes)
        addSubnode(nameTextNode)
    }
    
    //发布时间
    func setupTimeTextNode(){
        //发布时间
        let time = model.note_list?.first?.time ?? 0
        let timeStr = Utils.formatterDate(timeStamp: time)
        let attributes = [NSFontAttributeName:SYSTEM_FONT_11]
        timeTextNode.attributedText = NSAttributedString(string: timeStr, attributes: attributes)
        addSubnode(timeTextNode)
    }
    
    //关注按钮
    func setupFocusBtnNode(){
        focusBtnNode.setTitle("关注", with: BOLD_SYSTEM_FONT_13, with: UIColor.red, for: UIControlState.normal)
        focusBtnNode.style.preferredSize = CGSize(width: 50*APP_SCALE, height: 25*APP_SCALE)
        addSubnode(focusBtnNode)
    }
    
    //图片描述
    func setupPictureNode(){
        let url = model.note_list?.first?.images_list?.first?.url ?? ""
        pictureNode.url = URL(string:url)
        pictureNode.contentMode = .scaleAspectFit
        if let picInfo = model.note_list?.first?.images_list?.first{
            if let height = picInfo.height {
                if let width = picInfo.width {
                    let rate = width/height
                    let picW = SCREEN_WIDTH
                    let picH = picW / rate
                    pictureNode.style.preferredSize = CGSize(width:picW, height:picH)
                }
            }
        }
        addSubnode(pictureNode)
    }
    
    //标题
    func setupTitleTextNode(){
        
        let title =  model.note_list?.first?.title ?? ""
        titleTextNode.isLayerBacked = true
        titleTextNode.maximumNumberOfLines = 2
        titleTextNode.truncationMode = .byTruncatingTail
        let attributes = [NSFontAttributeName :BOLD_SYSTEM_FONT_15 ]
        titleTextNode.attributedText = NSAttributedString(string: title, attributes: attributes)
        addSubnode(titleTextNode)
    }
    
    //文字描述
    func setupDescTextNode(){
        let desc =  model.note_list?.first?.desc ?? ""
        descTextNode.isLayerBacked = true
        let attributes = [NSFontAttributeName:SYSTEM_FONT_15]
        descTextNode.attributedText = NSAttributedString(string: desc, attributes: attributes)
        descTextNode.maximumNumberOfLines = 2
        descTextNode.truncationMode = .byTruncatingTail
        addSubnode(descTextNode)
    }
    
    //底部工具条
    func setupToolBar(){
        toolBar.style.preferredSize = CGSize(width: SCREEN_WIDTH, height: FOCUS_CELL_TOOL_BAR_HEIGHT)
        addSubnode(toolBar)
    }
    
    //底部分割线
    func setupBottomSeparator(){
        bottomSeparator.backgroundColor = BACK_GROUND_COLOR
        bottomSeparator.style.preferredSize = CGSize(width: SCREEN_WIDTH, height: SM_MRAGIN_10)
        addSubnode(bottomSeparator)
    }
    
}


//布局子控件
extension AS_SingleNoteCellNode{
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let nameTimeSpec = ASStackLayoutSpec(direction: .vertical, spacing: SM_MRAGIN_3, justifyContent: .start, alignItems: .start, children: [nameTextNode,timeTextNode])
        
        var userInfoSpec = ASStackLayoutSpec(direction: .horizontal, spacing: SM_MRAGIN_5, justifyContent: .start, alignItems: .center, children: [avatarNode,nameTimeSpec])
        
        if cellType  != .friendPost {
            userInfoSpec = ASStackLayoutSpec(direction: .horizontal, spacing: SM_MRAGIN_5, justifyContent: .spaceBetween, alignItems: .center, children: [userInfoSpec,focusBtnNode])
        }else{
            userInfoSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.spaceBetween, alignItems: ASStackLayoutAlignItems.start, children: [userInfoSpec,moreButtonNode])
        }
        
        let insetTop = cellType == .friendPost ? SM_MRAGIN_10 : 0
        let userInfoInsetSpec =  ASInsetLayoutSpec(insets: UIEdgeInsets(top: insetTop, left: SM_MRAGIN_15, bottom: 0, right: SM_MRAGIN_15), child: userInfoSpec)
        
        let picSpec = ASWrapperLayoutSpec(layoutElement: pictureNode)
        
        let titleDescSpec = ASStackLayoutSpec(direction: .vertical, spacing: SM_MRAGIN_10, justifyContent: .start, alignItems: .start, children:[titleTextNode,descTextNode])
        let titleDesInsetSpec =  ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: SM_MRAGIN_15, bottom: 0, right: SM_MRAGIN_15), child: titleDescSpec)
        
        var verStackSpec:ASStackLayoutSpec
        if cellType == .friendPost { //关注的人的笔记
            
            let toolBarBottomSeparatorSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.start, children: [toolBar,bottomSeparator])
            
            verStackSpec = ASStackLayoutSpec(direction: .vertical, spacing: SM_MRAGIN_10, justifyContent: .start, alignItems: .stretch, children: [userInfoInsetSpec,picSpec,titleDesInsetSpec,toolBarBottomSeparatorSpec])
            
        } else { // 收藏/点赞
            
            let sourceMoreSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.spaceBetween, alignItems: ASStackLayoutAlignItems.center, children: [sourceTextNode,moreButtonNode])
            
            let insets = UIEdgeInsets(top: SM_MRAGIN_10, left: SM_MRAGIN_15, bottom: SM_MRAGIN_10, right: SM_MRAGIN_15)
            let sourceMoreInsetSpec = ASInsetLayoutSpec(insets:insets , child: sourceMoreSpec)
            
            let sourceLineSpce = ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .stretch, children: [sourceMoreInsetSpec,lineNode])
            
            let toolBarBottomSeparatorSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.start, children: [toolBar,bottomSeparator])
            verStackSpec = ASStackLayoutSpec(direction: .vertical, spacing: SM_MRAGIN_10, justifyContent: .start, alignItems: .stretch, children: [sourceLineSpce,userInfoInsetSpec,picSpec,titleDesInsetSpec,toolBarBottomSeparatorSpec])
            
        }
        return verStackSpec
    }
    
    override func layout() {
        super.layout()
        
        self.selectionStyle = .none
        self.backgroundColor = .white
        
        focusBtnNode.borderColor = UIColor.red.cgColor
        focusBtnNode.cornerRadius = 5*APP_SCALE
        focusBtnNode.borderWidth = 0.5
    }
    
}

