//
//  FocusModel.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/10/22.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import ObjectMapper

class FocusModel: Mappable {
    var cursor: String?
    var note_list:[F_NoteModel]?
    var recommend_reason:String?
    var track_id:String?
    var user:UserModel?
    var users:[UserModel]?
    var user_list:[UserModel]?
    var followed_count:Int?
    var friends_count:Int?
    var notes_count:Int?
    var vendor_list:[F_VendorModel]?
    var cellH:CGFloat = 0
    var vendor: [F_VendorModel]?
    var product_list:[F_ProductModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        cursor <- map["cursor"]
        note_list <- map["note_list"]
        vendor_list <- map["vendor_list"]
        recommend_reason <- map["recommend_reason"]
        track_id <- map["track_id"]
        user <- map["user"]
        users <- map["users"]
        user_list <- map["user_list"]
        friends_count <- map["friends_count"]
        notes_count <- map["notes_count"]
        followed_count <- map["followed_count"]
        
    }
}


class F_ProductModel: Mappable {
    
    var buyable:Bool?// true,
    var category_id: String?//"52ce1c02b4c4d649b58b8936",
    var desc:String?// "desitin 婴儿护臀膏 2oz/57g 紫色 加强型 ×2",
    var discount_price:Int?// 112,
    var feature:String?// "红屁股第二天必好",
    var height: Int?//320,
    var id:String?// "59f0624ac9d75948b9561a07",
    var image:String?// "https://img.xiaohongshu.com/items/12aff1eec72df931c7a54e18b4884c94@_320w_320h_1e_1c_0i_90Q_1x_2o.jpg",
    var ipq:Int?// 2,
    var link:String?// "http://www.xiaohongshu.com/goods/59f0624ac9d75948b9561a07?xhs_g_s=0089",
    var member_price: AnyObject? //null,
    var new_arriving: Bool?//true,
    var price:String?// "",
    var seller_id:String?// "53df5710b4c4d6383ae8e9a6",
    var skucode: String?//"074300000701",
    var spv_id:String?// "59f0602ec9d759488e04bedc",
    var stock_shortage:String?// "",
    var stock_status: Int?//1,
    var tax_included: Bool?//true,
    var time: Int?//1508935525,
    var title:String?// "美国·红屁股第二天必好",
    var vendor_icon:String?// "http://img.xiaohongshu.com///////seller/00f3bc34eb4668c0f205d67d70bb2c48",
    var whcode:String?// "C004",
    var width:Int? //320
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        buyable <- map["buyable"]
        category_id <- map["category_id"]
        desc <- map["desc"]
        discount_price <- map["discount_price"]
        feature <- map["feature"]
        height <- map["height"]
        id <- map["id"]
        image <- map["image"]
        ipq <- map["ipq"]
        link <- map["link"]
        member_price <- map["member_price"]
        new_arriving <- map["new_arriving"]
        seller_id <- map["seller_id"]
        skucode <- map["skucode"]
        spv_id <- map["spv_id"]
        stock_shortage <- map["stock_shortage"]
        stock_status <- map["stock_status"]
        tax_included <- map["tax_included"]
        time <- map["time"]
        title <- map["title"]
        vendor_icon <- map["vendor_icon"]
        whcode <- map["whcode"]
        width <- map["width"]
        
    }
}





class F_VendorModel: Mappable {
    
    var desc: String?// "use旨在放弃浮华，从自我转向本质，回归简单。以简约、实用为设计精髓，用精致的剪裁，明快的色彩，优良的质感为女性打造看似简约但不平凡的气质。",
    var fans_count: Int?//0,
    var followed: Bool?//,
    var icon:String?// "http://img.xiaohongshu.com//seller/58b1862516738b822903ad7702321c3a",
    var id:String?// "599aac78c095a537ff799a11",
    var link:String?// "http://www.xiaohongshu.com/vendor/599aac78c095a537ff799a11?xhs_g_s=1001&naviHidden=yes",
    var new_items_count: Int?//0,
    var products_count: Int?//748,
    var share_link: String?//"http://www.xiaohongshu.com/vendor/599aac78c095a537ff799a11?xhs_g_s=1001&naviHidden=yes",
    var time: Int?//1508809022,
    var title: String?//"USE官方品牌店"
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        desc <- map["desc"]
        fans_count <- map["fans_count"]
        followed <- map["followed"]
        icon <- map["icon"]
        id <- map["id"]
        new_items_count <- map["new_items_count"]
        products_count <- map["products_count"]
        share_link <- map["share_link"]
        time <- map["time"]
        title <- map["title"]
    }
}

//笔记详情
class F_NoteModel: Mappable {
    
    var collected: Bool?
    var collected_count: Int?
    var comments_count: Int?
    var desc: String? //"#周末探店#W酒店 周末朋友小聚",
    var id: String? //"59eca406c8e55d3b05c7e5ec",
    var images_list: [ImageModel]?
    var is_goods_note:Bool?
    var liked: Bool?
    var liked_count: Int?
    var liked_users: [[String:Any]]?
    var poi: [String:AnyObject]?
    var price: Int?
    var share_info:[String:AnyObject]?
    var shared_count: Int?
    var time: TimeInterval?
    var title: String? //"打卡网红酒店 W酒店🌃",
    var type: String? //"normal",
    var video: [String:AnyObject]?
    var viewed_count: Int?
    var user: UserModel?
    var titleH:CGFloat?//标题高度
    var descH:CGFloat?//描述内容高度
    var descAttrText:NSAttributedString? // 富文本信息
    var titleAttrText:NSAttributedString? // 富文本信息
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        collected <- map["collected"]
        collected_count <- map["collected_count"]
        comments_count <- map["comments_count"]
        desc <- map["desc"]
        id <- map["id"]
        images_list <- map["images_list"]
        is_goods_note <- map["is_goods_note"]
        liked <- map["liked"]
        liked_count <- map["liked_count"]
        poi <- map["poi"]
        liked_users <- map["liked_users"]
        price <- map["price"]
        share_info <- map["share_info"]
        shared_count <- map["shared_count"]
        time <- map["time"]
        title <- map["title"]
        type <- map["type"]
        video <- map["video"]
        viewed_count <- map["viewed_count"]
        user <- map["user"]
        descH <- map["descH"]
        titleH <- map["titleH"]
        titleAttrText <- map["titleAttrText"]
        descAttrText <- map["descAttrText"]
        
    }
}

//用户模型
class UserModel: Mappable {
    
    var desc: String? // "院长小朋友 等13位好友也关注了",
    var userid:String? //  "5594a6665894464be38ce6ed",
    var followed: Bool?
    var image:String? // "https://img.xiaohongshu.com/avatar/57a1c183e9521a72780dbdc9.jpg@120w_120h_92q_1e_1c_1x.jpg",
    var index:Int? // 0,
    var name: String? //"美妆薯",
    var red_official_verified: Bool? // true,
    var track_id: String? // "2ndv_j92tkatm"
    var boards_count: Int?//0,
    var collected_count: Int?//3680,
    var fans_count: Int?//432,
    var liked_count: Int?//1947,
    var notes_count: Int?//11,
    var share_link: Int?//"xhsdiscover://user/597f412f82ec39713bfd686c"
    var level:[String:Any]?
    var images:String?
    var nickname:String?
    var descH: CGFloat?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        descH <- map["descH"]
        desc <- map["desc"]
        userid <- map["userid"]
        followed <- map["followed"]
        image <- map["image"]
        images <- map["images"]
        index <- map["index"]
        name <- map["name"]
        nickname <- map["nickname"]
        red_official_verified <- map["red_official_verified"]
        track_id <- map["track_id"]
        boards_count <- map["boards_count"]
        collected_count <- map["collected_count"]
        fans_count <- map["fans_count"]
        liked_count <- map["liked_count"]
        notes_count <- map["notes_count"]
        share_link <- map["share_link"]
        level <- map["level"]
        
    }
    
}
