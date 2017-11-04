//
//  SMSearchView.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/10/21.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit

class SMSearchView: UIView {
    
    let textTF = UITextField()
    
    //占位文字
    var placeholder: String = ""
    {
        didSet{
            self.textTF.placeholder = placeholder
        }
    }
    
    // 字体大小
    var fontSize = 14*APP_SCALE{
        didSet{
            self.textTF.font = UIFont.systemFont(ofSize: fontSize*APP_SCALE)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUIContent(){
        
        //设置背景颜色
        self.backgroundColor = UIColor.white
        
        //设置搜索框
        let searchView = UIView()
        addSubview(searchView)
        let viewH = 30*APP_SCALE
        searchView.layer.cornerRadius = viewH * 0.5
        searchView.clipsToBounds = true
        searchView.backgroundColor = UIColor.init(r: 247, g: 247, b: 247)
        searchView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(SM_MRAGIN_15)
            make.right.equalTo(self.snp.right).offset(-SM_MRAGIN_15)
            make.height.equalTo(viewH)
        }
        
        //搜搜图标
        let icoView =  UIImageView(image: UIImage(named:"icon_search_grey_25_25x25_"))
        searchView.addSubview(icoView)
        let icoWH = 20*APP_SCALE
        icoView.snp.makeConstraints { (make) in
            make.left.equalTo(searchView.snp.left).offset(viewH*0.5)
            make.centerY.equalTo(searchView.snp.centerY)
            make.size.equalTo(CGSize(width: icoWH, height: icoWH))
        }
        
        //文字输入框
        searchView.addSubview(textTF)
        textTF.font = UIFont.systemFont(ofSize: fontSize)
        textTF.tintColor = UIColor.red
        textTF.snp.makeConstraints { (make) in
            make.left.equalTo(icoView.snp.right).offset(SM_MRAGIN_5)
            make.centerY.equalTo(searchView.snp.centerY)
            make.right.equalTo(searchView.snp.right).offset(-viewH*0.5)
            make.height.equalTo(searchView.snp.height)
        }
        
    }
    
    
}
