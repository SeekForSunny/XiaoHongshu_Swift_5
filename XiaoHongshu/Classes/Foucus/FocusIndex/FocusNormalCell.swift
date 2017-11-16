//
//  FocusViewCell.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/10/23.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import SDWebImage
import TTTAttributedLabel

class FocusNormalCell: UITableViewCell {
    
    //更多按钮宽高
    static let MORE_BTN_WH =  25*APP_SCALE
    
    //头像宽高
    static  let ICON_VIEW_WH = 30*APP_SCALE
    
    //顶部笔记来源View
    fileprivate lazy var sourceView:UIView = {
        let sourceView = UIView()
        self.contentView.addSubview(sourceView)
        return sourceView
    }()
    
    //笔记来源
    fileprivate lazy var sourceLabel:TTTAttributedLabel = {
        let sourceLabel = TTTAttributedLabel(frame: CGRect.zero)
        self.sourceView.addSubview(sourceLabel)
        return sourceLabel
    }()
    
    //顶部笔记来源View底部分割线
    fileprivate lazy var sourceLineView:UIView = {
        let sourceLineView = UIView()
        sourceLineView.backgroundColor = UIColor.init(white: 0.7, alpha: 0.7)
        self.sourceView.addSubview(sourceLineView)
        return sourceLineView;
    }()
    
    
    //关注按钮
    fileprivate lazy var focusBtn:UIButton = {
        let focusBtn = UIButton()
        self.contentView.addSubview(focusBtn)
        focusBtn.setTitle("关注", for: UIControlState.normal)
        focusBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14*APP_SCALE)
        focusBtn.setTitleColor(UIColor.red, for: UIControlState.normal)
        focusBtn.layer.borderWidth = 0.5
        focusBtn.layer.cornerRadius = 5*APP_SCALE
        focusBtn.layer.borderColor = UIColor.red.cgColor
        focusBtn.clipsToBounds = true
        return focusBtn
    }()
    
    //更多按钮
    fileprivate lazy var moreBtn:UIButton = {
        let moreBtn = UIButton()
        self.contentView.addSubview(moreBtn)
        moreBtn.setImage(UIImage(named:"icon_menu_grey_25_25x25_"), for: UIControlState.normal)
        moreBtn.imageView?.contentMode = .scaleAspectFill
        return moreBtn
    }()
    
    //用户头像
    fileprivate lazy var iconView:UIImageView = {
        let iconView = UIImageView()
        self.contentView.addSubview(iconView)
        iconView.layer.cornerRadius = FocusNormalCell.ICON_VIEW_WH*0.5
        iconView.clipsToBounds = true
        return iconView
    }()
    
    //昵称
    fileprivate lazy var nameLabel:TTTAttributedLabel = {
        let nameLabel = TTTAttributedLabel(frame:CGRect.zero)
        self.contentView.addSubview(nameLabel)
        return nameLabel
    }()
    
    //图片
    fileprivate lazy var picView:UIImageView = {
        let picView = UIImageView()
        self.contentView.addSubview(picView)
        return picView
    }()
    
    //发布时间
    fileprivate lazy var timeLabel:UILabel = {
        let timeLabel = UILabel()
        self.contentView.addSubview(timeLabel)
        return timeLabel
    }()
    
    //标题
    fileprivate lazy var titleLabel:TTTAttributedLabel = {
        let titleLabel = TTTAttributedLabel(frame:CGRect.zero)
        self.contentView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.darkGray
        titleLabel.numberOfLines = 2
        return titleLabel
    }()
    
    //内容
    fileprivate lazy var descLabel:TTTAttributedLabel = {
        let descLabel = TTTAttributedLabel(frame:CGRect.zero)
        self.contentView.addSubview(descLabel)
        descLabel.textColor = LIGHT_TEXT_COLOR
        descLabel.numberOfLines = 2
        return descLabel
    }()
    
    //底部工具条
    fileprivate lazy var toolBar:FocusCellToolBar = {
        let bottomBar = FocusCellToolBar()
        self.contentView.addSubview(bottomBar)
        return bottomBar
    }()
    
    //底部分割线
    fileprivate lazy var lineView :UIView = {
        let lineView = UIView()
        lineView.backgroundColor = BACK_GROUND_COLOR
        self.contentView.addSubview(lineView)
        return lineView
    }()
    
    var model:FocusModel?
    
    
    static let identifier = "FocusNormalCell"
    static func cell(tableView:UITableView)->FocusNormalCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = FocusNormalCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            cell?.selectionStyle = .none
            cell?.backgroundColor = FOCUS_CELL_BACKGROUND_COLOR
        }
        return cell as! FocusNormalCell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        setupUIContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func  setupUIContent() {
        
        //笔记来源View
        sourceView.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top)
            make.left.right.equalTo(self)
            make.height.equalTo(FOCUS_CELL_SOURCE_VIEW_HEIGHT)
        })
        
        //来源
        sourceLabel.snp.makeConstraints({ (make) in
            make.centerY.equalTo(sourceView.snp.centerY)
            make.left.equalTo(sourceView.snp.left).offset(SM_MRAGIN_15)
        })
        
        //顶部笔记来源View底部分割线
        sourceLineView.snp.makeConstraints({ (make) in
            make.bottom.equalTo(sourceView.snp.bottom)
            make.left.right.equalTo(sourceView)
            make.height.equalTo(0.3)
            
        })
        
        //头像
        iconView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(SM_MRAGIN_10)
            make.left.equalTo(self.snp.left).offset(SM_MRAGIN_15)
            make.height.width.equalTo(FocusNormalCell.ICON_VIEW_WH)
        }
        
        //昵称
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15*APP_SCALE)
        nameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(iconView.snp.centerY)
            make.left.equalTo(iconView.snp.right).offset(SM_MRAGIN_10)
        }
        
        //更多按钮
        moreBtn.snp.makeConstraints({ (make) in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-SM_MRAGIN_15)
            make.size.equalTo(CGSize(width: FocusNormalCell.ICON_VIEW_WH, height: FocusNormalCell.ICON_VIEW_WH))
        })
        
        
        //关注按钮
        focusBtn.snp.makeConstraints({ (make) in
            make.centerY.equalTo(iconView.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-SM_MRAGIN_15)
            make.size.equalTo(CGSize(width: 50*APP_SCALE, height: 25*APP_SCALE))
        })
        
        //发布时间标签
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(iconView.snp.centerY)
        }
        
        //描述图片
        picView.snp.makeConstraints({ (make) in
            make.top.equalTo(iconView.snp.bottom).offset(SM_MRAGIN_10)
            make.left.equalTo(self.snp.left)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(0)
            
        })
        picView.contentMode = .scaleAspectFill
        picView.clipsToBounds = true
        
        
        //标题Label
        titleLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(picView.snp.bottom).offset(SM_MRAGIN_10)
            make.left.equalTo(self).offset(SM_MRAGIN_15)
            make.right.equalTo(self.snp.right).offset(-SM_MRAGIN_15)
            make.height.equalTo(0)
        })
        
        //内容描述Label
        descLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(picView.snp.bottom).offset(SM_MRAGIN_10 + 0 + SM_MRAGIN_10)
            make.left.equalTo(self.snp.left).offset(SM_MRAGIN_15)
            make.right.equalTo(self.snp.right).offset(-SM_MRAGIN_15)
            make.height.equalTo(0)
        })
        
        //底部工具条
        toolBar.snp.makeConstraints { (make) in
            make.top.equalTo(picView.snp.bottom).offset(SM_MRAGIN_10 + 0 + SM_MRAGIN_10 + SM_MRAGIN_10)
            make.left.right.equalTo(self)
            make.height.equalTo(FOCUS_CELL_TOOL_BAR_HEIGHT)
        }
        
        //底部分割线
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(toolBar.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(SM_MRAGIN_10)
        }
        
    }
    
    
}

extension FocusNormalCell{
    
    func fillter(model:FocusModel) {
        
        self.model = model
        
        guard let recommend_reason = model.recommend_reason else {
            return
        }
        
        //cell累计高度
        var cellH:CGFloat = 0
        
        if recommend_reason.contains("friend_post") { //已关注人的笔记
            
            sourceView.isHidden = true
            focusBtn.isHidden = true
            
            //头像
            iconView.snp.updateConstraints { (make) in
                make.top.equalTo(self.snp.top).offset(SM_MRAGIN_10)
            }
            if let avatar = model.user?.image {
                iconView.sd_setImage(with: URL(string:avatar), completed: nil)
            }
            
            //更多按钮
            moreBtn.snp.remakeConstraints({ (make) in
                make.centerY.equalTo(nameLabel.snp.centerY)
                make.right.equalTo(self.snp.right).offset(-SM_MRAGIN_15)
                make.size.equalTo(CGSize(width: FocusNormalCell.ICON_VIEW_WH, height: FocusNormalCell.ICON_VIEW_WH))
            })
            
            //昵称
            nameLabel.text = model.user?.name
            
            //头像高度
            cellH += SM_MRAGIN_10 + FocusNormalCell.ICON_VIEW_WH
            
            
        } else {
            
            //LittleJ 收藏了笔记
            sourceView.isHidden = false
            focusBtn.isHidden = false
            
            //来源
            var suffix = ""
            if recommend_reason.contains("friend_collect") {
                //已关注的人收藏了未关注的人的笔记
                suffix = " 收藏了笔记"
            } else if recommend_reason.contains("friend_like") {
                //单条: Missgreenberry 赞了笔记
                suffix = " 赞了笔记"
            }
            let name = model.users?.first?.name ?? ""
            let source = name + suffix
            let attributedText = NSMutableAttributedString(string: source)
            attributedText.addAttributes([NSForegroundColorAttributeName : UIColor.darkGray,
                                          NSFontAttributeName:UIFont.boldSystemFont(ofSize: 15*APP_SCALE)],
                                         range: NSRange(location: 0, length: name.characters.count))
            attributedText.addAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 15*APP_SCALE),NSForegroundColorAttributeName:LIGHT_TEXT_COLOR],
                                         range: NSRange(location: name.characters.count, length: source.characters.count - name.characters.count))
            sourceLabel.attributedText = attributedText
            
            
            //更多按钮
            moreBtn.snp.remakeConstraints({ (make) in
                make.centerY.equalTo(self.sourceView)
                make.right.equalTo(self.snp.right).offset(-SM_MRAGIN_15)
                make.size.equalTo(CGSize(width: FocusNormalCell.ICON_VIEW_WH, height: FocusNormalCell.ICON_VIEW_WH))
            })
            
            //头像
            iconView.snp.updateConstraints { (make) in
                make.top.equalTo(self.snp.top).offset(FOCUS_CELL_SOURCE_VIEW_HEIGHT + SM_MRAGIN_10)
            }
            if let avatar = model.note_list?.first?.user?.image {
                iconView.sd_setImage(with: URL(string:avatar), completed: nil)
            }
            
            //昵称
            nameLabel.text = model.note_list?.first?.user?.name
            
            //来源View高度
            cellH +=  FOCUS_CELL_SOURCE_VIEW_HEIGHT
            
            //头像高度
            cellH += SM_MRAGIN_10 + FocusNormalCell.ICON_VIEW_WH
        }
        
        
        //发布时间
        if let time = model.note_list?.first?.time {
            timeLabel.text =  Utils.formatterDate(timeStamp: time)
        }
        timeLabel.font = UIFont.systemFont(ofSize: 12*APP_SCALE)
        timeLabel.textColor = UIColor.init(r: 170, g: 170, b: 170)
        
        //图片
        if let picInfo = model.note_list?.first?.images_list?.first{
            
            if let pic = picInfo.url {
                picView.sd_setImage(with: URL(string: pic), completed: nil)
                if let height = picInfo.height {
                    if let width = picInfo.width {
                        let rate = width/height
                        let picH = SCREEN_WIDTH / rate
                        picView.snp.updateConstraints({ (make) in
                            make.height.equalTo(picH)
                        })
                        //图片高度
                        cellH += SM_MRAGIN_10 + picH
                    }
                    
                }
            }
            
        }
        
        //标题
        var titleH:CGFloat = 0
        if let title = model.note_list?.first?.title {
            if let textH = model.note_list?.first?.titleH {
                titleH =  textH
                titleLabel.attributedText = model.note_list?.first?.titleAttrText
            }else{
                titleH = titleLabel.textH(text: title, font: BOLD_SYSTEM_FONT_15, width: SCREEN_WIDTH - 2*SM_MRAGIN_15, numberOfLine: 2)
                model.note_list?.first?.titleH = titleH
            }
            if let attrText = titleLabel.attributedText {
                let attributedText =  NSMutableAttributedString(attributedString: attrText)
                attributedText.addAttributes([NSForegroundColorAttributeName:UIColor.darkGray,NSFontAttributeName:BOLD_SYSTEM_FONT_15], range: NSRange(location: 0, length: attributedText.length))
                titleLabel.attributedText = attributedText
            }
        }
        titleLabel.snp.updateConstraints({ (make) in
            make.height.equalTo(titleH)
        })
        //标题高度
        cellH += SM_MRAGIN_10 + titleH
        
        //描述内容
        var contentH:CGFloat = 0
        if let desc = model.note_list?.first?.desc {
            if let descH = model.note_list?.first?.descH {
                contentH =  descH
                descLabel.attributedText = model.note_list?.first?.descAttrText
            }else{
                contentH = descLabel.textH(text: desc, font: SYSTEM_FONT_15, width: SCREEN_WIDTH - 2*SM_MRAGIN_15, numberOfLine: 2)
                model.note_list?.first?.descH = contentH
            }
            if let attrText = descLabel.attributedText {
                let attributedText =  NSMutableAttributedString(attributedString: attrText )
                attributedText.addAttributes([NSForegroundColorAttributeName:LIGHT_TEXT_COLOR], range: NSRange(location: 0, length: attributedText.length))
                descLabel.attributedText = attributedText
            }
            
        }
        descLabel.snp.updateConstraints({ (make) in
            make.top.equalTo(picView.snp.bottom).offset(SM_MRAGIN_10 + titleH + SM_MRAGIN_10)
            make.height.equalTo(contentH)
        })
        
        //内容高度
        cellH += SM_MRAGIN_10 + contentH
        
        
        //底部工具条
        toolBar.snp.updateConstraints { (make) in
            make.top.equalTo(picView.snp.bottom).offset(SM_MRAGIN_10 + titleH + SM_MRAGIN_10 + contentH + SM_MRAGIN_10)
        }
        
        cellH += SM_MRAGIN_10 + FOCUS_CELL_TOOL_BAR_HEIGHT
        
        //底部分割线
        cellH += SM_MRAGIN_10
        
        model.cellH = cellH
        
    }
    
}

