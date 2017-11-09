//
//  DiscoverModel.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/10/27.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import ObjectMapper

class DiscoverModel: Mappable {
    
    var comments:Int?// 1,
    var cursor_score:String?// "1509089662.9900",
    var desc: String?//"",
    var enabled:Bool?// true,
    var fav_count:Int?// 0,
    var geo: String?//"",
    var id: String?//"59f09b2e91c72c65fff11636",
    var images_list: [D_ImagesListModel]?//,
    var infavs:Bool?// false,
    var inlikes:Bool?// false,
    var is_goods_note: Bool?//false,
    var level: Int?//4,
    var likes:Int?// 130,
    var model_type:String?// "note",
    var name: String?//"Hip Hop 全身燃脂健身舞",
    var newest_comments: [AnyObject]?//,
    var recommend: D_RecommendModel?//,
    var relatedgoods_list: [AnyObject]?//,
    var share_link: String?//"http://www.xiaohongshu.com/discovery/item/59f09b2e91c72c65fff11636",
    var show_more: Bool?//false,
    var time: String?//"2017-10-25 22:09",
    var title: String?//"Hip Hop 全身燃脂健身舞",
    var type: String?//"video",
    var user: D_UserModel?//,
    var video_id: String?//"59f09b2e91c72c65fff11637",
    var video_info: D_VideoInfoModel?
    var cellH: CGFloat = 0
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        comments <- map["comments"]
        cursor_score <- map["cursor_score"]
        desc <- map["desc"]
        enabled <- map["enabled"]
        fav_count <- map["fav_count"]
        geo <- map["geo"]
        id  <- map["id"]
        images_list <- map["images_list"]
        infavs <- map["infavs"]
        inlikes <- map["inlikes"]
        is_goods_note <- map["is_goods_note"]
        level <- map["level"]
        likes <- map["likes"]
        model_type <- map["model_type"]
        name <- map["name"]
        newest_comments <- map["newest_comments"]
        recommend <- map["recommend"]
        relatedgoods_list <- map["relatedgoods_list"]
        share_link <- map["share_link"]
        show_more <- map["show_more"]
        time <- map["time"]
        title <- map["title"]
        type <- map["type"]
        user <- map["user"]
        video_id <- map["video_id"]
        video_info <- map["video_info"]
        cellH <- map["cellH"]
    }
}

class D_VideoInfoModel: Mappable {
    
    var gif_url: String?// "http://sg.xiaohongshu.com/lq3XVhW0X8qyX4JTNHMltCUhWk4U_gif_w320?sign=71a544437cce266d0900a25574bb1c8e&t=59f33fba",
    var height:Int? //360,
    var id: String?// "59f09b2e91c72c65fff11637",
    var played_count:Int?//  2106,
    var url:String?//  "http://v.xiaohongshu.com/lq3XVhW0X8qyX4JTNHMltCUhWk4U_compress_L1?sign=41d6bce8b5ab555945d4216d3711f58e&t=59f432ff",
    var width:Int?//  640
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        gif_url <- map["gif_url"]
        height <- map["height"]
        id <- map["id"]
        played_count <- map["played_count"]
        url <- map["url"]
        width <- map["width"]
        
    }
}

class D_RecommendModel: Mappable {
    
    var desc: String? //"",
    var icon: String? //"",
    var target_id: String? //"",
    var target_name: String? //"",
    var track_id: String? //"tf_common_tag.540349abb4c4d61f4dbbec42@59f2e17f3031682a68a93d70",
    var type: String? //"tag"
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        desc <- map["desc"]
        icon <- map["icon"]
        target_id <- map["target_id"]
        target_name <- map["target_name"]
        track_id <- map["track_id"]
        type <- map["type"]
    }
}

class D_ImagesListModel: Mappable {
    
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

class D_UserModel: Mappable {
    
    var followed:Bool?// false,
    var images: String?//"https://img.xiaohongshu.com/avatar/59aebd34b46c5d56df367176.jpg@80w_80h_90q_1e_1c_1x.jpg",
    var nickname: String?//"土逗有点闲",
    var red_official_verified: Bool?//false,
    var userid:String?// "58c5491582ec3910cd32a630"
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        followed <- map["followed"]
        images <- map["images"]
        nickname <- map["nickname"]
        red_official_verified <- map["red_official_verified"]
        userid <- map["userid"]
    }
}
