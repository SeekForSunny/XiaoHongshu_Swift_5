//
//  FocusCellToolBar.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/10/24.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit

class FocusCellToolBar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

extension FocusCellToolBar{
    
    func setupUIContent(){
        
        let titleArr = ["点赞","评论","收藏"]
        let iconArr = ["icon_like_grey_20_20x20_","icon_comment_grey_20_20x20_","icon_collect_grey_20_20x20_"]
        for title in titleArr {
            if let index =  titleArr.index(of: title) {
                
                let button = UIButton()
                addSubview(button)
                let width = SCREEN_WIDTH / CGFloat(titleArr.count)
                button.snp.makeConstraints({ (make) in
                    make.top.equalTo(self).offset(1.0)
                    make.left.equalTo(self.snp.left).offset(width*CGFloat(index))
                    make.width.equalTo(width)
                    make.height.equalTo(FOCUS_CELL_TOOL_BAR_HEIGHT)
                })
                button.setTitle(title, for: UIControlState.normal)
                button.setTitleColor(UIColor.darkText, for: UIControlState.normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 13*APP_SCALE)
                button.setImage(UIImage(named:iconArr[index]), for: UIControlState.normal)
                button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5*APP_SCALE)
            }
        }
        
        //顶部分割线
        let lineView = UIView()
        addSubview(lineView)
        lineView.backgroundColor = UIColor.init(white: 0.7, alpha: 0.7)
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self.snp.left).offset(SM_MRAGIN_15)
            make.right.equalTo(self.snp.right).offset(-SM_MRAGIN_15)
            make.height.equalTo(0.5)
        }
        
    }
    
}
