//
//  NavigationController.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/10/19.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    fileprivate lazy var button:UIButton = {
        let button = UIButton(type: UIButtonType.custom);
        button.setImage(UIImage(named:"navi_back_25x25_"), for: UIControlState.normal);
        if #available(iOS 11.0, *) {
            button.snp.makeConstraints { (make) in
                make.width.height.equalTo(25)
            }
        }else{
            button.frame.size = CGSize(width: 25, height: 25)
        }
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //统一设置外观
        setupAppearance()
    }
    
}


extension NavigationController{
    
    //MARK:统一设置外观
    func setupAppearance() {
        
        //导航栏背景设置
        navigationBar.setBackgroundImage(UIImage.image(color: .white), for: UIBarMetrics.default)
        //设置标题属性
        navigationBar.titleTextAttributes=[NSFontAttributeName:UIFont.boldSystemFont(ofSize: 10*APP_SCALE),NSForegroundColorAttributeName:UIColor.darkGray];
        navigationBar.shadowImage = UIImage();
        
    }
    
    
    //MARK: 统一设置返回按钮
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if childViewControllers.count >= 1{
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button);
        }
        
        super.pushViewController(viewController, animated: animated);
        button.addTarget(self, action: #selector(turnBack), for: UIControlEvents.touchUpInside);
        
    }
    
    //MARK: 返回
    func turnBack() {
        self.popViewController(animated: true);
    }
}
