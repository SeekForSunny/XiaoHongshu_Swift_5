//
//  NoteDetailViewController.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/11/3.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController {

    //上级模型数据
    var model:DiscoverModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置内容
        setupUIContent()
    }
    
    //初始化设置
    func setupUIContent(){
        
        //设置背景经验色
        view.backgroundColor = UIColor.randomColor()
    }
    

}
