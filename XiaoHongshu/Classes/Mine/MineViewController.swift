//
//  MineViewController.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/10/20.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit

class MineViewController: UITableViewController {
    
    //TableHeader高度
    let headerH = 135*APP_SCALE
    //标题数组
    let titleArr:[String] = ["我的关注","我的收藏","消息","购物车","订单","薯券","心愿单","黑卡会员","设置"]
    //图片数组
    let icoArr:[String] = ["XYPHMenuFollow_20x20_","icon_hambugercollect_grey_20_20x20_","XYPHMenuMessage_20x20_","XYPHMenuShoppingCart_20x20_","XYPHMenuOrder_20x20_","XYPHMenuCoupon_20x20_","XYPHMenuWishList_20x20_","icon_blackcard_grey_20_20x20_","XYPHMenuSetting_20x20_"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化设置
        setupUIContent()
    }
    
}

//MARK:  - 初始化设置
extension MineViewController{
    
    func setupUIContent(){
        //背景颜色
        view.backgroundColor = UIColor.white
        
        //分割线样式
        tableView.separatorStyle = .none
        
        //设置头部View
        setupTableHeaderView()
    }
    
}

//MARK: - 设置头部View
extension MineViewController{
    
    func setupTableHeaderView(){
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        headerView.frame.size.height = headerH
        tableView.tableHeaderView = headerView
        tableView.bounces = false
        
        //头像
        let icoView = UIImageView()
        let icoWH = 65*APP_SCALE
        headerView.addSubview(icoView)
        icoView.snp.makeConstraints { (make) in
            make.left.equalTo(headerView.snp.left).offset(SM_MRAGIN_30)
            make.top.equalTo(headerView.snp.top).offset(20*APP_SCALE)
            make.size.equalTo(CGSize(width: icoWH, height: icoWH))
        }
        icoView.layer.cornerRadius = icoWH*0.5
        icoView.layer.shadowColor = UIColor.gray.cgColor
        icoView.layer.shadowOffset = CGSize.zero
        icoView.image = UIImage.createCircleImage(name: "usericon")
        icoView.layer.shadowRadius = 3
        icoView.layer.shadowOpacity = 0.5;
        
        //用户昵称信息
        let infoView = UIView()
        headerView.addSubview(infoView)
        infoView.snp.makeConstraints { (make) in
            make.top.equalTo(icoView.snp.bottom)
            make.left.right.bottom.equalTo(headerView)
        }

        //昵称标签
        let nameLabel = UILabel()
        infoView.addSubview(nameLabel)
        nameLabel.text = "宁静致远"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15*APP_SCALE)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(icoView.snp.left)
            make.top.bottom.equalTo(infoView)
            make.width.equalTo(150*APP_SCALE)
        }

        //右侧箭头
        let arrowView =  UIImageView(image: UIImage(named:""))
        arrowView.contentMode = .scaleAspectFill
        let arrowWH = 20*APP_SCALE
        infoView.addSubview(arrowView)
        arrowView.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.right).offset(SM_MRAGIN_30)
            make.centerY.equalTo(infoView.snp.centerY)
            make.size.equalTo(CGSize(width: arrowWH, height: arrowWH))
        }
    }

}

//MARK: - 数据源代理方法
extension MineViewController{
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 3 : (section == 1 ? 5:1)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MineTableViewCell.cell(tableView: tableView)
        let section = indexPath.section
        var titles = [String]()
        var icos = [String]()
        if section == 0 {
            titles = (titleArr as NSArray).subarray(with: NSRange(location: 0, length: 3)) as! [String]
            icos = (icoArr as NSArray).subarray(with: NSRange(location: 0, length: 3)) as! [String]
        } else if section == 1 {
            titles = (titleArr as NSArray).subarray(with: NSRange(location: 3, length: 5)) as! [String]
            icos = (icoArr as NSArray).subarray(with: NSRange(location: 3, length: 5)) as! [String]
        } else {
           titles = (titleArr as NSArray).subarray(with: NSRange(location: 8, length: 1)) as! [String]
            icos = (icoArr as NSArray).subarray(with: NSRange(location: 8, length: 1)) as! [String]
        }
        cell.fillter(title: titles[indexPath.row], ico: icos[indexPath.row], showLine: (titles.count-1 == indexPath.row && section != 2 ? true : false) )
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (SCREEN_HEIGHT - headerH - 70*APP_SCALE)/CGFloat(9)
    }
    
}

