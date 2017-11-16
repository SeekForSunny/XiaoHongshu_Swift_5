//
//  F_RelatedNoteCell.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/11/12.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import TTTAttributedLabel


fileprivate let USER_ICON_WH = 25*APP_SCALE
class F_RelatedNoteCell: UICollectionViewCell {
    
   static let kF_RelatedNoteCell_ID = "kF_RelatedNoteCell_ID"
    
    //图片
    fileprivate lazy var picView:UIImageView = {
        let picView = UIImageView()
        return picView
    }()
    
    //标题
    fileprivate lazy var titleLabel:TTTAttributedLabel = {
        let titleLabel = TTTAttributedLabel(frame:CGRect.zero)
        return titleLabel
    }()
    
    //描述
    fileprivate lazy var descLabel:TTTAttributedLabel = {
        let descLabel = TTTAttributedLabel(frame:CGRect.zero)
        return descLabel
    }()
    
    //头像
    fileprivate lazy var iconView:UIImageView = {
        let iconView = UIImageView()
        return iconView
    }()
    
    //昵称
    fileprivate lazy var nameLabel:UILabel = {
        let nameLabel = UILabel()
        return nameLabel
    }()
    
    //点赞
    fileprivate lazy var praiseBtn:UIButton = {
        let praiseBtn = UIButton()
        
        return praiseBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUIContent(){
        
        backgroundColor = BACK_GROUND_COLOR
        
        addSubview(picView)
        addSubview(titleLabel)
        addSubview(descLabel)
        addSubview(iconView)
        addSubview(nameLabel)
        addSubview(praiseBtn)
        
        layer.cornerRadius = 5*APP_SCALE
        layer.shadowColor = UIColor.randomColor().cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
    }
    
    //MARK:数据源方法
    func fillter(model:F_RelatedNoteModel){
        
        //描述图片
        let height = CGFloat(model.images_list?.first?.height ?? 1)
        let width = CGFloat(model.images_list?.first?.width ?? 1)
        let rate = CGFloat(width/height)
        let itemWith = self.frame.size.width
        let picH =  itemWith / rate
        picView.snp.remakeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.width.equalTo(itemWith)
            make.height.equalTo(picH)
        }
        if let url = model.images_list?.first?.url {
            picView.sd_setImage(with: URL(string:url), completed: nil)
            picView.clipsToBounds = true
            picView.contentMode = UIViewContentMode.scaleAspectFill
        }

        //标题
        var textH:CGFloat = 0
        if let title = model.title {
            titleLabel.text = title
            titleLabel.font = SYSTEM_FONT_14
            textH = titleLabel.textH(text: title, font: BOLD_SYSTEM_FONT_13, width: itemWith - 2*SM_MRAGIN_10, numberOfLine: 2)
            titleLabel.snp.remakeConstraints { (make) in
                make.top.equalTo(picView.snp.bottom).offset(SM_MRAGIN_5)
                make.left.equalTo(self).offset(SM_MRAGIN_10)
                make.right.equalTo(self).offset(-SM_MRAGIN_10)
                make.height.equalTo(textH)
            }
        }
        
       //描述
        if let desc = model.desc {
            descLabel.text = desc
            descLabel.font = SYSTEM_FONT_14
            let descH = descLabel.textH(text: desc, font: SYSTEM_FONT_13, width: itemWith - 2*SM_MRAGIN_10, numberOfLine: 3)
            descLabel.snp.remakeConstraints { (make) in
                make.top.equalTo(picView.snp.bottom).offset(SM_MRAGIN_5 + textH + SM_MRAGIN_5)
                make.left.equalTo(self).offset(SM_MRAGIN_10)
                make.right.equalTo(self).offset(-SM_MRAGIN_10)
                make.height.equalTo(descH)
            }
        }

        
        //头像
        iconView.snp.remakeConstraints { (make) in
            make.left.equalTo(descLabel)
            make.top.equalTo(descLabel.snp.bottom).offset(SM_MRAGIN_5)
            make.width.height.equalTo(USER_ICON_WH)
        }
        if let url = model.user?.images{
            iconView.sd_setImage(with: URL(string:url), completed: nil)
            iconView.clipsToBounds = true
            iconView.layer.cornerRadius = USER_ICON_WH * 0.5
        }
        
        //昵称
        nameLabel.snp.remakeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(SM_MRAGIN_5)
            make.centerY.equalTo(iconView)
        }
        if let name = model.user?.nickname{
            nameLabel.text = name
            nameLabel.font = SYSTEM_FONT_12
        }
        
        //点赞
        
    }
    
    //获取cell高度
    class func cellHeight(model:F_RelatedNoteModel,itemWidth:CGFloat) ->CGFloat{
        var cellH:CGFloat = 0
        
        //描述图片
        let height = CGFloat(model.images_list?.first?.height ?? 1)
        let width = CGFloat(model.images_list?.first?.width ?? 1)
        let rate = CGFloat(width/height)
        let picH = itemWidth / rate
        cellH += picH
        
        //标题
        if let title = model.title {
            let textH = Utils.textH(text: title, font: BOLD_SYSTEM_FONT_13, width: itemWidth - 2*SM_MRAGIN_10,numberOfLine: 2)
            cellH += SM_MRAGIN_5 + textH
        }
        
        //描述
        if let desc = model.desc {
            let descH = Utils.textH(text: desc, font: SYSTEM_FONT_13, width: itemWidth - 2*SM_MRAGIN_10,numberOfLine: 3)
            cellH += SM_MRAGIN_5 + descH
        }
        
        //头像
        cellH += SM_MRAGIN_5 + USER_ICON_WH
        
        return cellH + SM_MRAGIN_5
    }
    
    
}
