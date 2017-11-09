//
//  DiscoverViewController.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/10/19.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper

fileprivate let DISCOVER_COLLECTION_CELL_ID = "DISCOVER_COLLECTION_CELL_ID"
fileprivate let TITLE_VIEW_HEIGHT = 44*APP_SCALE
class DiscoverViewController: UIViewController {
    
    //CollectionView
    fileprivate lazy var collectionView:UICollectionView = {
        let layout = SMWaterFlowLayout()
        layout.dataSource = self
        layout.sectionInset = UIEdgeInsets(top: 0, left: SM_MRAGIN_10, bottom: SM_MRAGIN_10, right: SM_MRAGIN_10)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = BACK_GROUND_COLOR
        collectionView.register(DiscoverCell.self, forCellWithReuseIdentifier: DISCOVER_COLLECTION_CELL_ID)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    //标签数据字典
    fileprivate lazy var contentMap = [String:[DiscoverModel]]()
    
    //单个标签对应的模型数组
    fileprivate lazy var contentArr = [DiscoverModel]()
    
    //标题栏
    fileprivate lazy var titleView:UIScrollView = {
        let titleView = UIScrollView()
        self.view.addSubview(titleView)
        return titleView
    }()
    
    //标题按钮数组
    fileprivate lazy var titleBtnArr = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //加载顶部标题栏
        loadCategoriesData()
        
        //加载网络请求
        loadData()
        
        //布局UI
        setupUIContent()
        
    }
    
}


//MARK: - 布局UI
extension DiscoverViewController{
    
    //MARK:设置标题栏
    func setupTitleView()  {
        titleView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.left.right.equalTo(self.view)
            make.height.equalTo(TITLE_VIEW_HEIGHT)
        }
    }
    
    //数据填充
    func fillter(titleArr:[[String:String]]){
        titleBtnArr.removeAll()
        var offsetX:CGFloat = 0
        let btnH = 20*APP_SCALE
        for index in 0..<titleArr.count {
            let title = titleArr[index]["name"]
            let btn = UIButton()
            titleView.addSubview(btn)
            btn.setTitle(title, for: UIControlState.normal)
            btn.titleLabel?.font = SYSTEM_FONT_14
            btn.sizeToFit()
            btn.backgroundColor = UIColor.white
            btn.layer.cornerRadius = btnH * 0.5
            btn.layer.borderWidth = 0.5
            btn.layer.borderColor = UIColor.randomColor().cgColor
            btn.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
            btn.snp.makeConstraints({ (make) in
                make.left.equalTo(titleView.snp.left).offset(SM_MRAGIN_15 + offsetX)
                make.width.equalTo(btn.frame.size.width + SM_MRAGIN_20)
                make.height.equalTo(btnH)
                make.centerY.equalTo(titleView.snp.centerY)
            })
            offsetX += (btn.frame.size.width + SM_MRAGIN_20) + SM_MRAGIN_15
        }
        offsetX +=  SM_MRAGIN_15
        titleView.contentSize = CGSize(width: offsetX, height: 0)
        
    }
    
    func setupUIContent()  {
        setupTitleView()
        
        //设置collectionView
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleView.snp.bottom)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        
    }
    
}

//MARK: - 网络请求
extension DiscoverViewController{
    
    func loadCategoriesData() -> () {
        
        SMProvider.request(.Categories) {[weak self] result in
            switch result {
            case let .success(response):
                let json = JSON(data: response.data)
                if let titleArr = json["data"].arrayObject as? [[String:String]] {
                    print(titleArr)
                    self?.fillter(titleArr: titleArr)
                }
            case let .failure(error):
                print(error)
                break
            }
        }
    }
    
    func loadData(){
        let category = ["oid":"homefeed_recommend"]
        SMProvider.request(.Discover(category as [String : AnyObject])) {[weak self]  result in
            switch result {
            case let .success(response):
                
                let json = JSON(data: response.data)
                if let dataArr = json["data"].arrayObject as? [[String:AnyObject]] {
                    self?.contentArr = Mapper<DiscoverModel>().mapArray(JSONArray: dataArr)
                    self?.collectionView.reloadData()
                }
                
            case let .failure(error):
                print(error)
                break
            }
        }
    }
    
}

extension DiscoverViewController:UICollectionViewDataSource,UICollectionViewDelegate,SMWaterFlowLayoutDataSource{
    
    func waterFlowLayout(layout: SMWaterFlowLayout,itemWidth:CGFloat,  heightForItemAtIndex index: Int) -> CGFloat {
        var cellH:CGFloat = 0
        let model = contentArr[index]
        if model.cellH != 0{ return model.cellH }
        cellH = DiscoverCell.cellHeight(model: model, itemWidth:itemWidth)
        
        return cellH
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DISCOVER_COLLECTION_CELL_ID, for: indexPath) as! DiscoverCell
        cell.backgroundColor = UIColor.white
        let model = contentArr[indexPath.row]
        cell.fillter(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVc =  NoteDetailViewController()
        
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
}


