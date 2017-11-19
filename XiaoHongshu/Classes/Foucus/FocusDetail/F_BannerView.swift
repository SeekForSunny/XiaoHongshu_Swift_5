//
//  F_BannerView.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/11/10.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit

class F_BannerView: UIView {
    
    //bannerView
    fileprivate lazy var bannerView:UIScrollView = {
        let scrollView = UIScrollView()
        self.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    // model
    var images_list:[ImageModel]?
    
    //高度改变回调bolck
    public typealias Completion = (_ bannerH: CGFloat) -> Void
    
    var completion:Completion?
    
    func fillterWith(images_list:[ImageModel],completion:@escaping Completion)->CGFloat {
        
        self.images_list = images_list
        self.completion = completion
        
        bannerView.backgroundColor = BACK_GROUND_COLOR
        
        //        guard let images_list = model.note_list?.first?.images_list else{return 0}
        guard let height = images_list.first?.height else {return 0}
        guard let width = images_list.first?.width else {return 0}
        let rate = width/height
        let bannerViewH = SCREEN_WIDTH / rate
        bannerView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        bannerView.contentSize = CGSize(width: CGFloat(images_list.count)*SCREEN_WIDTH, height: 0)
        for (index,item) in  images_list.enumerated() {
            
            let iView = UIImageView()
            iView.contentMode = .scaleAspectFill
            iView.clipsToBounds = true
            bannerView.addSubview(iView)
            
            if let url = item.url {
                iView.sd_setImage(with: URL(string:url))
            }
            iView.snp.makeConstraints({ (make) in
                make.left.equalTo(bannerView.snp.left).offset(CGFloat(index)*SCREEN_WIDTH)
                make.top.equalTo(bannerView)
                make.width.equalTo(SCREEN_WIDTH)
                make.height.equalTo(bannerView.snp.height)
            })
            
        }
        
        return bannerViewH
    }
    
}

extension F_BannerView:UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        let index =  Int(scrollView.contentOffset.x/SCREEN_WIDTH)
        guard let height = images_list?[index].height else {return}
        guard let width =  images_list?[index].width  else {return}
        let rate = width / height
        let itemH = SCREEN_WIDTH / rate
        
        if let block = self.completion  {
            block(itemH)
        }
        
    }
    
    
}
