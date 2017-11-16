//
//  F_CommentCell.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/11/10.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import TTTAttributedLabel
class F_CommentCell: UITableViewCell {
    
    //重用标识
    fileprivate static let reusableidentifier = "F_CommentCell"
    
    //头像宽高
    private let  ICON_WH = 35*APP_SCALE
    
    //头像
    lazy var iconView:UIImageView = {
        let iconView = UIImageView()
        self.addSubview(iconView)
        return iconView
    }()
    
    //昵称
    lazy var nickLabel:UILabel = {
        let nickLabel = UILabel()
        self.contentView.addSubview(nickLabel)
        nickLabel.font = SYSTEM_FONT_13
        return nickLabel
    }()
    
    //评论内容
    lazy var commentLabel:TTTAttributedLabel = {
        let commentLabel = TTTAttributedLabel(frame:CGRect.zero)
        self.contentView.addSubview(commentLabel)
        commentLabel.font = SYSTEM_FONT_13
        return commentLabel
    }()
    
    //评论时间
    lazy var timeLabel:UILabel = {
        let timeLabel = UILabel()
        self.contentView.addSubview(timeLabel)
        timeLabel.font = SYSTEM_FONT_12
        return timeLabel
    }()
    
    //回复
    lazy var replyBtn:UIButton = {
        let replyBtn = UIButton()
        self.contentView.addSubview(replyBtn)
        return replyBtn
    }()
    
    //点赞
    lazy var praiseBtn:UIButton = {
        let praiseBtn = UIButton()
        self.contentView.addSubview(praiseBtn)
        return praiseBtn
    }()
    
    //子回复内容View
    fileprivate lazy var revertLabel:TTTAttributedLabel = {
        let revertLabel = TTTAttributedLabel(frame:CGRect.zero)
        self.contentView.addSubview(revertLabel)
        return revertLabel
    }()
    
    class func cell(tableView:UITableView)->F_CommentCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: reusableidentifier)
        if cell == nil {
            cell = F_CommentCell(style: UITableViewCellStyle.default, reuseIdentifier: reusableidentifier)
            cell?.selectionStyle = .none
        }
        return cell as! F_CommentCell
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //数据源方法
    func fillterWith(model:F_Comments){
        
        //累计高度
        var cellH:CGFloat = 0
        
        //头像
        if  let image = model.user?.images {
            iconView.sd_setImage(with: URL(string:image), completed: nil)
        }
        iconView.snp.remakeConstraints { (make) in
            make.top.equalTo(self).offset(SM_MRAGIN_10)
            make.left.equalTo(self).offset(SM_MRAGIN_15)
            make.width.height.equalTo(ICON_WH)
        }
        iconView.layer.cornerRadius = ICON_WH * 0.5
        iconView.clipsToBounds = true
        
        //昵称
        if let nickname = model.user?.nickname {
            nickLabel.text = nickname
        }
        nickLabel.sizeToFit()
        nickLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(self).offset(SM_MRAGIN_10)
            make.left.equalTo(iconView.snp.right).offset(SM_MRAGIN_10)
        }
        
        cellH += SM_MRAGIN_10 + nickLabel.bounds.height
        
        //回复内容
        var commmentH :CGFloat = 0
        if let content = model.content {
            let maxWidth = SCREEN_WIDTH - SM_MRAGIN_15 - ICON_WH - SM_MRAGIN_10 - SM_MRAGIN_15
            commmentH = commentLabel.textH(text: content, font: SYSTEM_FONT_14, width: maxWidth)
        }
        commentLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(nickLabel.snp.bottom).offset(SM_MRAGIN_10)
            make.left.equalTo(iconView.snp.right).offset(SM_MRAGIN_10)
            make.right.equalTo(self).offset(-SM_MRAGIN_15)
            make.height.equalTo(commmentH)
        }
        cellH += SM_MRAGIN_10 + commmentH
        
        //回复时间
        if let time = model.priority_sub_comments?.first?.target_comment?.time {
            timeLabel.text = Utils.formatterDate(timeStamp: time)
        }
        timeLabel.sizeToFit()
        timeLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(commentLabel.snp.bottom).offset(SM_MRAGIN_5)
            make.left.equalTo(iconView.snp.right).offset(SM_MRAGIN_10)
            make.height.equalTo(timeLabel.bounds.height)
        }
        cellH += SM_MRAGIN_5 + timeLabel.bounds.height
        
        //回复按钮
        
        //点赞按钮
        
        //子回复
        if let content = model.priority_sub_comments?.first?.content {
            revertLabel.isHidden = false
            let maxWidth = SCREEN_WIDTH - SM_MRAGIN_15 - ICON_WH - SM_MRAGIN_10 - SM_MRAGIN_15 - 2*SM_MRAGIN_15
            var text = (model.priority_sub_comments?.first?.user?.nickname ?? "") + ":" +  content
            if model.user?.userid == model.priority_sub_comments?.first?.user?.userid {
                text = (model.priority_sub_comments?.first?.user?.nickname ?? "") + "(作者):" + content
            }
            
            var revertH = revertLabel.textH(text: text, font: SYSTEM_FONT_12, width: maxWidth,lineSpacing:3)
            revertH = revertH + 2*SM_MRAGIN_10
            revertLabel.snp.remakeConstraints { (make) in
                make.top.equalTo(timeLabel.snp.bottom).offset(SM_MRAGIN_5)
                make.left.equalTo(timeLabel.snp.left)
                make.right.equalTo(self).offset(-SM_MRAGIN_15)
                make.height.equalTo(revertH)
            }
            revertLabel.backgroundColor = BACK_GROUND_COLOR
            revertLabel.textInsets = UIEdgeInsets(top: SM_MRAGIN_5, left: SM_MRAGIN_15, bottom: 0, right: SM_MRAGIN_15)
            revertLabel.layer.cornerRadius = 5*APP_SCALE
            revertLabel.clipsToBounds = true
            
            cellH += SM_MRAGIN_5 + revertH
        }else{
            revertLabel.isHidden = true
        }

        
        
        cellH += SM_MRAGIN_10
        
        model.cellH = cellH
    }
}
