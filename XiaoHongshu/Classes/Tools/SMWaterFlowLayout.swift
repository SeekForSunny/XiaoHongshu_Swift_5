//
//  SMWaterFlowLayout.swift
//  WaterFlowLayout
//
//  Created by SMART on 2017/9/19.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit

@objc protocol SMWaterFlowLayoutDataSource:class {

    func waterFlowLayout(layout:SMWaterFlowLayout, itemWidth:CGFloat, heightForItemAtIndex index:Int) -> CGFloat;

    func waterFlowLayout(layout:SMWaterFlowLayout, contentHeight:CGFloat);
}

class SMWaterFlowLayout: UICollectionViewFlowLayout {
    
    //列数
    var cols:Int = 2
    //最大高度
    var maxHeight:CGFloat = 0
    //高度数组
    lazy var heights:[CGFloat] = Array(repeating: self.sectionInset.top, count: self.cols)
    //属性数组
    lazy var attributes:[UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    //数据源
    weak var dataSource:SMWaterFlowLayoutDataSource?

    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else {
            return
        }
        
        let count = collectionView.numberOfItems(inSection: 0);
        
        let itemW = (collectionView.bounds.width - sectionInset.left - sectionInset.right - CGFloat(cols-1)*minimumInteritemSpacing)/CGFloat(cols)
        for i in attributes.count..<count {
            
            let indexPath = IndexPath(item: i, section: 0)
            let attr =  UICollectionViewLayoutAttributes(forCellWith: indexPath)
            let itemH = dataSource?.waterFlowLayout(layout: self,itemWidth: itemW, heightForItemAtIndex: i) ?? 0
            let minH = heights.min()!
            let minIndex = heights.index(of: minH)!
            let itemX = sectionInset.left + (itemW+minimumInteritemSpacing)*CGFloat(minIndex)
            let itemY = minH
            attr.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
            attributes.append(attr);
            heights[minIndex] = attr.frame.maxY + minimumLineSpacing
            
        }
        maxHeight = heights.max()!
        
    }
    
}

extension SMWaterFlowLayout{
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
    
}

extension SMWaterFlowLayout{
    override var collectionViewContentSize: CGSize{
        
        dataSource?.waterFlowLayout(layout: self, contentHeight: maxHeight)
        return CGSize(width: UIScreen.main.bounds.size.width, height: maxHeight)
        
    }
}
