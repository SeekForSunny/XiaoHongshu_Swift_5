//
//  NoteDetailViewController.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/11/3.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置内容
        setupUIContent()
    }
    
    func setupUIContent(){
        view.backgroundColor = UIColor.randomColor()
    }

}
