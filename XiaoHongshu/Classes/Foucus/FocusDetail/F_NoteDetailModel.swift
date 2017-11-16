//
//  F_NoteDetailModel.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/11/13.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON
class F_NoteDetailModel: Mappable {
    
    var ats: [Any]?//,
    var comments:Int?// 4,
    var cover: ImageModel?//,
    var desc:String?// "昨晚的礼服是我人生第一次没穿内衣就上台的礼服，人生第一次这么光滑的头😂…因为我是这活动的开场舞编舞老师，所以总决赛的晚宴带上了我的小姐妹一起参加～三人终于合体了好久没一起合照🙃虽然基本一周都要见几次🙃～真是为了梳好这个头真是两三天没洗头🙃…#悉尼[地区]##澳大利亚[地区]##周末桃花妆[话题]##连体裤[话题]##小性感[话题]##法国[地区]##迪奥[品牌]# @Viki🍃 @暴躁的胖可丁_",
    var desc_html_id:String?//  "",
    var desc_html_url:String?//  "",
    var enabled:Bool?// true,
    var extra_info_tip_type: Int?//0,
    var fav_count: Int?//3,
    var filter_tags: [Any]?//,
    var geo: String?// "",
    var geo_link:String?//  "",
    var hash_tag: [F_Hash_tag]?//,
    var id: String?// "5a085397bd7ed2070ee54738",
    var illegal_info: [String:Any]?//,
    var images_list: [ImageModel]?//,
    var infavs: Bool?// false,
    var inlikes: Bool?// false,
    var is_goods_note: Bool?// false,
    var level: Int?//4,
    var like_users: [Any]?//,
    var likes: Int?//18,
    var name: String?// "悉尼The star 中澳华人流行歌手大赛晚宴💿📀",
    var poi_dict_info: [String:Any]?//,
    var post_time: TimeInterval?//,
    var relatedgoods_list: [F_Relatedgoods_list]?//,
    var share_count: Int?//0,
    var share_info: F_Share_info?//,
    var share_link: String?// "http://www.xiaohongshu.com/discovery/item/5a085397bd7ed2070ee54738",
    var tags_info_2: String?// "[[[{"type": "center", "angle": 0, "name": "", "position": {"y": 0.2518337408312961, "x": 0.7987117306621756}}, {"type": "brand", "oid": "brand.52d0deb1b4c4d655316b7d21", "angle": 180, "name": "Dior"}, {"type": "good", "angle": 180, "name": "\u53e3\u7ea2"}], [{"type": "center", "angle": 0, "name": "", "position": {"y": 0.8003259859341568, "x": 0.3123993435919574}}, {"type": "brand", "angle": 180, "name": "Zhivago"}, {"type": "good", "angle": 180, "name": "\u8fde\u4f53\u793c\u670d"}]], [[]], [[]], [[]], [[]], [[]], [[]], [[]]]",
    var time: String?// "2017-11-12 21:58",
    var title: String?// "悉尼The star 中澳华人流行歌手大赛晚宴💿📀",
    var type: String?// "normal",
    var user: UserModel?//,
    var video_id:String?//  ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        ats <- map["ats"]
        comments <- map["comments"]
        cover <- map["cover"]
        desc <- map["desc"]
        desc_html_id <- map["desc_html_id"]
        desc_html_url <- map["desc_html_url"]
        enabled <- map["enabled"]
        extra_info_tip_type <- map["extra_info_tip_type"]
        fav_count <- map["fav_count"]
        filter_tags <- map["filter_tags"]
        geo <- map["geo"]
        hash_tag <- map["hash_tag"]
        id <- map["id"]
        illegal_info <- map["illegal_info"]
        images_list <- map["images_list"]
        infavs <- map["infavs"]
        inlikes <- map["inlikes"]
        is_goods_note <- map["is_goods_note"]
        level <- map["level"]
        like_users <- map["like_users"]
        likes <- map["likes"]
        name <- map["name"]
        poi_dict_info <- map["poi_dict_info"]
        post_time <- map["post_time"]
        relatedgoods_list <- map["relatedgoods_list"]
        share_count <- map["share_count"]
        share_info <- map["share_info"]
        share_link <- map["share_link"]
        tags_info_2 <- map["tags_info_2"]
        time <- map["time"]
        title <- map["title"]
        type <- map["type"]
        user <- map["user"]
        video_id <- map["video_id"]
        
    }
    
}

class ImageModel: Mappable {
    
    var height:CGFloat?// 360,
    var original: String?//"http://ci.xiaohongshu.com/d067cb3b-1390-41ad-9b38-5630af651bd5",
    var url: String?//"http://ci.xiaohongshu.com/d067cb3b-1390-41ad-9b38-5630af651bd5@r_640w_640h.webp",
    var width: CGFloat?//640
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        height <- map["height"]
        original <- map["original"]
        url <- map["url"]
        width <- map["width"]
        
    }
}

class F_Hash_tag: Mappable {
    
    var id: String?//"5967550289f60c2461b41110",
    var link: String?//"xhsdiscover://list/huati.5967550289f60c2461b41110",
    var name: String?//"小性感",
    var type: String?//"topic"
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        link <- map["link"]
        name <- map["name"]
        type <- map["type"]
        
    }
}

class F_Relatedgoods_list: Mappable {
    var desc: String?//"Dior迪奥 蓝星水亮唇膏 #688 3.2g",
    var discount_price: Int?//216,
    var id: String?//"57b52eb63283527a3eb63859",
    var image: String?//"https://img.xiaohongshu.com/items/53fb581af7263fe7a9c8848cb8a3b906@_320w_320h_1e_1c_0i_90Q_1x_2o.jpg",
    var link: String?//"https://pages.xiaohongshu.com/goods/57b52eb63283527a3eb63859?xhs_g_s=0002",
    var price: Int?//268,
    var title: String?//"法国·低调自然玫粉色",
    var track_id: String?//"M.j9xlrvmz"
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        desc <- map["desc"]
        discount_price <- map["discount_price"]
        id <- map["id"]
        image <- map["image"]
        link <- map["link"]
        price <- map["price"]
        title <- map["title"]
        track_id <- map["track_id"]
    }
}

class F_Share_info: Mappable {
    var content: String?//"昨晚的礼服是我人生第一次没穿内衣就上台的礼服，人生第一次这么光滑的头😂…因为我是这活动的开场舞编舞老师，所以总决赛的晚宴带上了我的小姐妹一起参加～三人终于合体了好久没一起合照🙃虽然基本一周都要见几次🙃",
    var image: String?//"http://ci.xiaohongshu.com/e0012db4-dcb2-41df-a03f-45ccda97b0b1@r_120w_120h.jpg",
    var link: String?//"http://www.xiaohongshu.com/discovery/item/5a085397bd7ed2070ee54738",
    var  title: String?//"悉尼The star 中澳华人流行歌手大赛晚宴💿📀"
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        content <- map["content"]
        image <- map["image"]
        link <- map["link"]
        title <- map["title"]
    }
}
