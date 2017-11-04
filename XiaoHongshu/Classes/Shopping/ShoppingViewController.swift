//
//  ShoppingViewController.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/10/19.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit

class ShoppingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUIContent()
    }
    
    
}


extension ShoppingViewController{
    
    func setupUIContent()  {
        // 设置背景颜色
        view.backgroundColor = UIColor.randomColor()
    }
    
}
