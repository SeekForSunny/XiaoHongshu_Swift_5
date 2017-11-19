//
//  MainViewController.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/10/19.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON
import SDWebImage

class MainViewController: UIViewController {
    // letftItem
    lazy var leftButton: UIButton = {
        
        let leftButton = UIButton()
        let icoWH = CGFloat(25)
        leftButton.imageView?.contentMode = .scaleAspectFit
        leftButton.imageView?.layer.cornerRadius = icoWH*0.5
        leftButton.imageView?.clipsToBounds = true
        leftButton.layer.shadowColor = UIColor.gray.cgColor
        leftButton.layer.shadowOffset = CGSize.zero
        leftButton.layer.shadowRadius = 3
        leftButton.layer.shadowOpacity = 0.5;
        if #available(iOS 11.0, *) {
            leftButton.snp.makeConstraints { (make) in
                make.width.height.equalTo(icoWH)
            }
        } else {
            leftButton.frame.size = CGSize(width: icoWH, height: icoWH)
        }
        
        leftButton.addTarget(self, action: #selector(showLeftMenu), for: UIControlEvents.touchUpInside)
        return leftButton
        
    }()
    
    //导航栏选项卡View
    lazy var optionCardView = UIView()
    //选中按钮
    var selectBtn:UIButton?
    //选项按钮数组
    var optionCardBtns = [UIButton]()
    // 容器ScrollView
    lazy var scrollView = UIScrollView()
    // 指示器
    lazy var indicatorView = UIView()
    // 蒙版View
    lazy var maskView:UIView = {
        let maskView = UIView(frame: UIScreen.main.bounds)
        maskView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        return maskView
    }()
    // 参照点
    var pointX:CGFloat = 0
    
    //选项卡
    let titles = ["关注","发现","购买"]
    
    //左侧菜单栏
    lazy var menuView:UIView = {
        let mineVc = MineViewController()
        self.navigationController?.addChildViewController(mineVc)
        return mineVc.view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //导航栏设置
        setupNavigationBar()
        
        // 设置子控制器
        setupChildsController()
        
        //内容设置
        setupUIContent()
        
        //加载网络请求
        loadData()
        
    }
    
}

//MARK: 网络请求
extension MainViewController{
    
    func loadData(){
        SMProvider.request(.User) {[weak self] result in
            switch result {
            case let .success(response):
                
                let json = JSON(data: response.data)
                if let data = json["data"].dictionary{
                    
                    //用户头像
                    if let avatar = data["imageb"]?.string {
                        self?.leftButton.sd_setImage(with: URL(string:avatar), for: UIControlState.normal, completed: nil)
                    }
                    
                }
                
            case let .failure(error):
                print(error)
                break
            }
        }
    }
    
}


//MARK: - 初始化设置
extension MainViewController{
    
    //MARK: 设置子控制器
    func setupChildsController(){
        
        // 关注
        let focusVc = FocusViewController()
        addChildViewController(focusVc)
        
        //发现
        let discoverVc = DiscoverViewController()
        addChildViewController(discoverVc)
        
        // 购买
        let shoppingVc = ShoppingViewController()
        addChildViewController(shoppingVc)
        
    }
    
    //MARK: 内容设置
    func setupUIContent(){
        
        //设置背景颜色
        view.backgroundColor = BACK_GROUND_COLOR
        
        //设置搜索框
        let searchView = SMSearchView()
        searchView.placeholder = "搜索笔记，商品和用户"
        searchView.fontSize = 14*APP_SCALE
        view.addSubview(searchView)
        searchView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(view)
            make.height.equalTo(CGFloat(40)*APP_SCALE)
        }
        
        //设置内容View
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(searchView.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
        scrollView.backgroundColor = BACK_GROUND_COLOR
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: SCREEN_WIDTH * CGFloat(titles.count), height: 0)
        scrollView.bounces = false
        scrollView.delegate = self
        scrollViewDidEndScrollingAnimation(scrollView)
        
    }
    
    
    //MARK: 导航栏设置
    func setupNavigationBar(){
        
        //设置导航栏左侧按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        //设置导航栏右侧按钮
        let rightButton = UIButton(type: UIButtonType.custom)
        rightButton.setImage(UIImage(named:"icon_post_black_25_24x24_"), for: UIControlState.normal)
        rightButton.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        rightButton.addTarget(self, action:  #selector(publishNote), for: UIControlEvents.touchUpInside)
        
        
        //设置TitleView
        let BAR_HEIGHT = CGFloat(30)
        let CARD_VIEW_WIDTH = CGFloat(180)*APP_SCALE
        navigationItem.titleView = optionCardView
        if #available(iOS 11.0, *) {
            optionCardView.snp.makeConstraints { (make) in
                make.width.equalTo(CARD_VIEW_WIDTH)
                make.height.equalTo(BAR_HEIGHT)
            }
        }else{
            optionCardView.frame.size = CGSize(width: CARD_VIEW_WIDTH, height: BAR_HEIGHT)
        }
        // 设置顶部选项卡
        func setupOptionCard(){
            
            for title in titles {
                
                if let index = titles.index(of: title) {
                    
                    let button = UIButton()
                    
                    let width = CARD_VIEW_WIDTH/CGFloat(titles.count)
                    let height =  BAR_HEIGHT
                    let x = CGFloat(index) * width
                    let y = CGFloat(0)
                    button.frame = CGRect(x: x, y: y, width: width, height: height)
                    
                    button.setTitle(title, for: UIControlState.normal)
                    button.setTitleColor(UIColor.gray, for: UIControlState.normal)
                    button.setTitleColor(UIColor.darkGray, for: UIControlState.selected)
                    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15*APP_SCALE)
                    button.addTarget(self, action: #selector(optionCardBtnClicked), for: UIControlEvents.touchUpInside)
                    
                    optionCardBtns.append(button)
                    optionCardView.addSubview(button)
                }
                
            }
            
        }
        setupOptionCard()
        
        //设置指示器
        func setupIndicator(){
            // 默认选中第一个按钮
            let firstBtn = optionCardBtns.first
            firstBtn?.isSelected = true
            selectBtn = firstBtn
            
            if let selectBtn = selectBtn {
                selectBtn.titleLabel?.sizeToFit()
                optionCardView.addSubview(indicatorView)
                indicatorView.backgroundColor = UIColor.red
                indicatorView.snp.makeConstraints { (make) in
                    make.bottom.equalTo(selectBtn.snp.bottom)
                    make.centerX.equalTo(selectBtn.snp.centerX)
                    make.width.equalTo(selectBtn.titleLabel!.frame.width)
                    make.height.equalTo(2)
                }
            }
            
        }
        setupIndicator()
        
    }
    
}

//MARK: - UIScrollViewDelegate
extension MainViewController:UIScrollViewDelegate{
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
        
        let index = Int(scrollView.contentOffset.x / SCREEN_WIDTH)
        let button = optionCardBtns[index]
        optionCardBtnClicked(sender: button)
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        let index = Int(scrollView.contentOffset.x / SCREEN_WIDTH)
        let willShowVc = self.childViewControllers[index]
        
        if willShowVc.isViewLoaded{
            return
        }
        
        scrollView.addSubview(willShowVc.view)
        willShowVc.view.snp.makeConstraints { (make) in
            make.left.equalTo(scrollView.snp.left).offset(SCREEN_WIDTH*CGFloat(index))
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.width.equalTo(SCREEN_WIDTH)
        }
        
    }
}


//MARK: - 内部控制方法
extension MainViewController{
    
    //MARK:点击选项卡按钮
    func optionCardBtnClicked(sender:UIButton){
        
        if let index = optionCardBtns.index(of: sender) {
            
            let offset = CGPoint(x: SCREEN_WIDTH * CGFloat(index), y: 0)
            scrollView.setContentOffset(offset, animated: true)
            
            //更新指示器
            selectBtn?.isSelected = false
            sender.isSelected = true
            selectBtn = sender
            indicatorView.snp.remakeConstraints({ (make) in
                make.bottom.equalTo(selectBtn!.snp.bottom)
                make.centerX.equalTo(selectBtn!.snp.centerX)
                make.width.equalTo(selectBtn!.titleLabel!.frame.width)
                make.height.equalTo(2)
            })
            UIView.animate(withDuration: 0.5, animations: {
                self.optionCardView.layoutIfNeeded()
            })
            
        }
        
    }
    
    //MARK: 显示左侧菜单栏
    func showLeftMenu(){
        
        let keyWindow = UIApplication.shared.keyWindow
        guard keyWindow != nil  else {  return }
        let tapGes =   UITapGestureRecognizer.init(target: self, action: #selector(disMiss))
        maskView.addGestureRecognizer(tapGes)
        keyWindow!.addSubview(maskView)
        
        menuView.frame = CGRect(x: -SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH*0.65, height: SCREEN_HEIGHT)
        keyWindow!.addSubview(menuView)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.menuView.frame.origin.x = 0
            self.maskView.layoutIfNeeded()
        }, completion: nil)
        
        let panGes = UIPanGestureRecognizer(target:self, action:#selector(touchMove(_:)))
        maskView.addGestureRecognizer(panGes)
        
    }
    
    
    //MARK: 发布笔记内容
    func publishNote(){
        
    }
    
    //移除蒙版View
    func disMiss(){
        
        self.maskView.removeFromSuperview()
        
        UIView.animate(withDuration: 0.5, animations: {
            self.menuView.frame.origin.x = -SCREEN_WIDTH
            self.maskView.layoutIfNeeded()
        }) { (_) in
            
            self.menuView.removeFromSuperview()
        }
        
    }
    
    
    //滑动操作
    func touchMove(_ recognizer:UIPanGestureRecognizer) {
        
       let offsetX = recognizer.translation(in: self.view).x

        if (offsetX > 0) {
            menuView.frame.origin.x = 0;
        }else{
            menuView.frame.origin.x = offsetX;
        }
    
        if recognizer.state == UIGestureRecognizerState.ended  {
            
            if menuView.frame.maxX < menuView.bounds.width * 0.5 {
                disMiss()
            }else{
                UIView.animate(withDuration: 0.25, animations: {
                    self.menuView.frame.origin.x = 0
                })
            }
            
        }
        
    }
    
}
