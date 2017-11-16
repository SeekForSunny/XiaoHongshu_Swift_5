//
//  F_NoteDescView.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/11/10.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class F_NoteDescView: UIView {

    private let ICONWH = 40*APP_SCALE
    
    //用户头像
    lazy var iconView:UIImageView = {
        let iconView = UIImageView()
        self.addSubview(iconView)
        return iconView
    }()
    
    //用户昵称
    lazy var nickLabel:UILabel = {
        let nickLabel = UILabel()
        nickLabel.font = SYSTEM_FONT_13
        self.addSubview(nickLabel)
        return nickLabel
    }()
    
    //关注按钮
    lazy var focusBtn:UIButton = {
        let focusBtn = UIButton()
        focusBtn.titleLabel?.font = SYSTEM_FONT_13
        self.addSubview(focusBtn)
        return focusBtn
    }()
    
    //分割线
    lazy var lineView:UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor(white: 0.7, alpha: 0.7)
        self.addSubview(lineView)
        return lineView
    }()
    
    //标题
    lazy var titleLabel: TTTAttributedLabel = {
        let nickLabel = TTTAttributedLabel(frame:CGRect.zero)
        self.addSubview(nickLabel)
        return nickLabel
    }()
    
    //内容
    lazy var descLabel: TTTAttributedLabel = {
        let descLabel = TTTAttributedLabel(frame:CGRect.zero)
        descLabel.lineSpacing = 3*APP_SCALE
        self.addSubview(descLabel)
        return descLabel
    }()
    
    //发布时间
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = SYSTEM_FONT_13
        timeLabel.textColor = LIGHT_TEXT_COLOR
        self.addSubview(timeLabel)
        return timeLabel
    }()
    
    //点赞次数
    lazy var lickedCountLabel: UILabel = {
        let lickedCountLabel = UILabel()
        lickedCountLabel.font = SYSTEM_FONT_13
        lickedCountLabel.textColor = LIGHT_TEXT_COLOR
        self.addSubview(lickedCountLabel)
        return lickedCountLabel
    }()
    
    //收藏次数
    lazy var collectedCountLabel: UILabel = {
        let collectedCountLabel = UILabel()
        collectedCountLabel.font = SYSTEM_FONT_13
        collectedCountLabel.textColor = LIGHT_TEXT_COLOR
        self.addSubview(collectedCountLabel)
        return collectedCountLabel
    }()
    
    func fillter(model:F_NoteDetailModel)->CGFloat{
        
        //累计高度
        var viewH:CGFloat = 0
        
       let user = model.user
        
        //头像
        if let image = user?.images {
            iconView.sd_setImage(with: URL(string:image), completed: nil)
        }
        iconView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(SM_MRAGIN_10)
            make.top.equalTo(self).offset(SM_MRAGIN_15)
            make.height.width.equalTo(ICONWH)
        }
        iconView.layer.cornerRadius = ICONWH * 0.5
        iconView.clipsToBounds = true
        viewH += SM_MRAGIN_10 + ICONWH
        
        
        //昵称
        if let name = user?.nickname {
            nickLabel.text = name
        }
        nickLabel.snp.makeConstraints({ (make) in
            make.centerY.equalTo(iconView)
            make.left.equalTo(iconView.snp.right).offset(SM_MRAGIN_10)
        })
        
        //关注按钮
        focusBtn.setTitle("关注", for: UIControlState.normal)
        focusBtn.setTitleColor(.red, for: UIControlState.normal)
        focusBtn.layer.cornerRadius = 5*APP_SCALE
        focusBtn.layer.borderColor = UIColor.red.cgColor
        focusBtn.layer.borderWidth = 0.5
        focusBtn.snp.makeConstraints({ (make) in
            make.centerY.equalTo(iconView)
            make.right.equalTo(self).offset(-SM_MRAGIN_15)
            make.size.equalTo(CGSize(width:60*APP_SCALE,height:25*APP_SCALE))
        })
        
        
        //分割线
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.bottom).offset(SM_MRAGIN_5)
            make.left.equalTo(self).offset(SM_MRAGIN_15)
            make.right.equalTo(self).offset(-SM_MRAGIN_15)
            make.height.equalTo(0.5)
        }
        viewH += SM_MRAGIN_5 + 0.5
        
        //标题
        var titleH:CGFloat = 0
        if let title = model.title {//note_list?.first?
            let maxWidth = SCREEN_WIDTH - 2 * SM_MRAGIN_15
            titleH = titleLabel.textH(text: title, font: BOLD_SYSTEM_FONT_14, width: maxWidth, numberOfLine: 0, textColor: UIColor.darkGray)
            titleLabel.snp.makeConstraints({ (make) in
                make.top.equalTo(lineView.snp.bottom).offset(SM_MRAGIN_10)
                make.left.equalTo(self).offset(SM_MRAGIN_15)
                make.right.equalTo(self).offset(-SM_MRAGIN_15)
                make.height.equalTo(titleH)
            })
            viewH += SM_MRAGIN_10 + titleH
        }
        
        //内容
        if let desc = model.desc {//note_list?.first?.
            
            let maxWidth = SCREEN_WIDTH - 2 * SM_MRAGIN_15
            let textH = descLabel.textH(text: desc, font: SYSTEM_FONT_14, width: maxWidth, numberOfLine: 0, textColor: UIColor.darkGray,paragraphSpacing: 15)
            descLabel.snp.makeConstraints({ (make) in
                make.top.equalTo(lineView.snp.bottom).offset(SM_MRAGIN_10 + titleH + SM_MRAGIN_10)
                make.left.equalTo(self).offset(SM_MRAGIN_15)
                make.right.equalTo(self).offset(-SM_MRAGIN_15)
                make.height.equalTo(textH)
            })
            viewH += SM_MRAGIN_10 + textH
        }
        
        //发布时间
        timeLabel.text = Utils.formatterDate(timeStamp: model.post_time ?? 0)
        timeLabel.sizeToFit()
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(descLabel.snp.bottom).offset(SM_MRAGIN_10)
            make.left.equalTo(self).offset(SM_MRAGIN_15)
            make.height.equalTo(timeLabel.bounds.height)
        }
        viewH += SM_MRAGIN_10 + timeLabel.bounds.height
        
        //点赞次数
        guard let likedCount = model.likes else {
            return viewH + SM_MRAGIN_10
        }
        
        //收藏次数
        guard let collectedCount = model.fav_count else{
            return viewH + SM_MRAGIN_10
        }
        
        if likedCount != 0 && collectedCount != 0{
            
            lickedCountLabel.text = "\(likedCount)次赞"
            lickedCountLabel.snp.makeConstraints({ (make) in
                make.right.equalTo(self).offset(-SM_MRAGIN_15)
                make.centerY.equalTo(timeLabel)
            })
            
            collectedCountLabel.text = "\(collectedCount)次收藏"
            collectedCountLabel.snp.makeConstraints({ (make) in
                make.right.equalTo(lickedCountLabel.snp.left).offset(-SM_MRAGIN_15)
                make.centerY.equalTo(timeLabel)
            })
            
        } else if likedCount == 0{ //暂无点赞
            collectedCountLabel.text = "\(collectedCount)次收藏"
            collectedCountLabel.snp.makeConstraints({ (make) in
                make.right.equalTo(self).offset(-SM_MRAGIN_15)
                make.centerY.equalTo(timeLabel)
            })
        }else{ //暂无收藏
            lickedCountLabel.text = "\(likedCount)次赞"
            lickedCountLabel.snp.makeConstraints({ (make) in
                make.right.equalTo(self).offset(-SM_MRAGIN_15)
                make.centerY.equalTo(timeLabel)
            })
        }
        
        return viewH + SM_MRAGIN_10
        
    }

}
