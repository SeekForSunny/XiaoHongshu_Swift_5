//
//  F_RelatedNoteModel.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/11/11.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import ObjectMapper

class F_RelatedNoteModel: Mappable {
    
    var desc: String?//"",
    var id: String?//"59f09b2e91c72c65fff11636",
    var images_list: [ImagesListModel]?//,
    var inlikes:Bool?// false,
    var likes:Int?// 130,
    var name: String?//"Hip Hop 全身燃脂健身舞",
    var time: String?//"2017-10-25 22:09",
    var title: String?//"Hip Hop 全身燃脂健身舞",
    var type: String?//"video",
    var user: UserModel?//,
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        desc <- map["desc"]
        id  <- map["id"]
        images_list <- map["images_list"]
        inlikes <- map["inlikes"]
        likes <- map["likes"]
        name <- map["name"]
        time <- map["time"]
        title <- map["title"]
        type <- map["type"]
        user <- map["user"]
        
    }
}

class ImagesListModel: Mappable {
    
    var height:Int?// 360,
    var original: String?//"http://ci.xiaohongshu.com/d067cb3b-1390-41ad-9b38-5630af651bd5",
    var url: String?//"http://ci.xiaohongshu.com/d067cb3b-1390-41ad-9b38-5630af651bd5@r_640w_640h.webp",
    var width: Int?//640
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        height <- map["height"]
        original <- map["original"]
        url <- map["url"]
        width <- map["width"]
        
    }
}
