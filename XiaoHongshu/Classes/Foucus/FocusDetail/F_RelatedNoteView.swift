//
//  F_RelatedNoteView.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/11/11.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON

class F_RelatedNoteView: UIView {
    
    //分组标题View
    fileprivate lazy var headerView:UIView = UIView()
    
    //标题Label
    fileprivate lazy var  titleLabel:UILabel = {
        let titleLabel = UILabel()
        self.headerView.addSubview(titleLabel)
        titleLabel.text = "相关笔记"
        titleLabel.font = SYSTEM_FONT_15
        return titleLabel
    }()
    
    //指示器View
    fileprivate lazy var  indicatorView:UIView = {
        let indicatorView = UIView()
        self.headerView.addSubview(indicatorView)
        indicatorView.backgroundColor = .red
        return indicatorView
    }()
    
    
    //collectionView
    fileprivate lazy var collectionView:UICollectionView = {
        let layout = SMWaterFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: SM_MRAGIN_10, left: SM_MRAGIN_10, bottom: SM_MRAGIN_10, right: SM_MRAGIN_10)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(F_RelatedNoteCell.self, forCellWithReuseIdentifier: F_RelatedNoteCell.kF_RelatedNoteCell_ID)
        layout.dataSource = self
        collectionView.backgroundColor = BACK_GROUND_COLOR
        return collectionView
    }()
    
    //relatedNoteArr
    fileprivate lazy var noteArr = [F_RelatedNoteModel]()
    
    public typealias HandleBlock = (_ contentH: CGFloat) -> Void
    
    fileprivate var handleblock:HandleBlock?
    
    fileprivate var note_id:String!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupContent(){
        
        //分组View
        addSubview(headerView)
        headerView.backgroundColor = UIColor.white
        headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(NOTE_DETAIL_HEADER_VIEW_HEIGHT)
        }
        
        //指示器View
        indicatorView.snp.makeConstraints { (make) in
            make.left.equalTo(headerView).offset(SM_MRAGIN_10)
            make.centerY.equalTo(headerView)
            make.size.equalTo(CGSize(width: 2*APP_SCALE, height: NOTE_DETAIL_HEADER_VIEW_HEIGHT*0.3))
        }
        
        //分组标题
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(headerView)
            make.left.equalTo(indicatorView.snp.right).offset(SM_MRAGIN_5)
        }
        
        //collectionView
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(headerView.snp.bottom)
        }
        
    }
    
    func fillterWithNoteID(_ note_id:String,handleblock: @escaping HandleBlock) {
        
        self.handleblock = handleblock
        self.note_id = note_id
        
        //加载相关笔记
        loadRelatedNotes()
    }
    
    
}

extension F_RelatedNoteView{
    
    //加载评论内容
    func loadRelatedNotes(){
        
        SMProvider.request(.NoteRelated(note_id)) {[weak self] result in
            switch result {
            case let .success(response):
                
                let json = JSON(data: response.data)
                if let dataArr = json["data"].arrayObject as?  [[String: AnyObject]]{
                    self?.noteArr = Mapper<F_RelatedNoteModel>().mapArray(JSONArray: dataArr)
                    self?.collectionView.reloadData()
                }
                
            case let .failure(error):
                print(error)
                break
            }
        }
        
    }
    
}

extension F_RelatedNoteView:UICollectionViewDataSource,UICollectionViewDelegate,SMWaterFlowLayoutDataSource{
    
    func waterFlowLayout(layout: SMWaterFlowLayout, itemWidth: CGFloat, heightForItemAtIndex index: Int) -> CGFloat {
        var cellH:CGFloat = 0
        let model = noteArr[index]
        cellH = F_RelatedNoteCell.cellHeight(model: model, itemWidth:itemWidth)
        return cellH
    }
    
    func waterFlowLayout(layout: SMWaterFlowLayout, contentHeight: CGFloat) {
        let height = noteArr.count == 0 ? 0 : contentHeight + NOTE_DETAIL_HEADER_VIEW_HEIGHT
        self.isHidden = noteArr.count == 0 ? true : false
        self.handleblock?(height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.noteArr.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: F_RelatedNoteCell.kF_RelatedNoteCell_ID, for: indexPath) as! F_RelatedNoteCell
        let model = noteArr[indexPath.row]
        cell.fillter(model: model)
        return cell
    }
    
}


