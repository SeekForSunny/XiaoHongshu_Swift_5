//
//  F_CommentModel.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/11/10.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit
import ObjectMapper

class F_CommentModel:  Mappable{
    
    var comment_count:Int?// 22,
    var comment_count_l1:Int?// 19,
    var comments: [F_Comments]?//,
    var user_id: String? //"567df0941c07df02d42bf6f8"
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        comment_count <- map["comment_count"]
        comment_count_l1 <- map["comment_count_l1"]
        comments <- map["comments"]
        user_id <- map["comments"]
        
    }
    
}


class F_Comments: Mappable {
    
    var at_users: [Any]?//,
    var content:String?// "淘宝名是什么",
    var friend_liked_msg:String?// "",
    var hash_tags: [ Any]?//,
    var id: String?//"5a0413a326c62421157683ac",
    var like_count: Int?//0,
    var liked:Bool?// false,
    var note_id: String?//"5a03312f0546a40359efda5c",
    var priority_sub_comment_user:String?// "",
    var priority_sub_comments: [F_Sub_comments]?//,
    var score:Int?// 4,
    var status:Int?// 0,
    var sub_comment_count: Int?//1,
    var sub_comments: [F_Sub_comments]?//,
    var time: Int?//1510216560,
    var user: UserModel?
    var cellH:CGFloat = 0
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        at_users <- map["at_users"]
        content <- map["content"]
        friend_liked_msg <- map["friend_liked_msg"]
        hash_tags <- map["hash_tags"]
        id <- map["id"]
        like_count <- map["like_count"]
        liked <- map["liked"]
        note_id <- map["note_id"]
        priority_sub_comment_user <- map["priority_sub_comment_user"]
        priority_sub_comments <- map["priority_sub_comments"]
        score <- map["score"]
        status <- map["status"]
        sub_comment_count <- map["at_users"]
        sub_comments <- map["sub_comments"]
        time <- map["time"]
        user <- map["user"]
        cellH <- map["cellH"]
        
    }
}

class F_Sub_comments: Mappable {
    
    var at_users: [Any]?//,
    var content: String?//"还在申请中…",
    var friend_liked_msg:String?// "",
    var hash_tags: [Any]?//,
    var id: String?//"5a041494304b146d16fbd2fa",
    var like_count:Int?// 0,
    var liked: Bool?//false,
    var note_id: String?//"5a03312f0546a40359efda5c",
    var status: Int?// 0,
    var target_comment: F_Target_comment?//,
    var time: TimeInterval?// 1510216800,
    var user: UserModel?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        at_users <- map["at_users"]
        content <- map["content"]
        friend_liked_msg <- map["friend_liked_msg"]
        hash_tags <- map["hash_tags"]
        id <- map["id"]
        like_count <- map["like_count"]
        liked <- map["liked"]
        note_id <- map["note_id"]
        status <- map["status"]
        target_comment <- map["target_comment"]
        time <- map["time"]
        user <- map["user"]
        
    }
}

class F_Target_comment: Mappable {
    var content:String?// "",
    var id: String?//"5a03bf2e6e889333b776deec",
    var like_count: Int?//0,
    var note_id:String?// "5a03312f0546a40359efda5c",
    var status:Int?// 0,
    var time: TimeInterval?//1510194960,
    var user: UserModel?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        content <- map["at_users"]
        id <- map["at_users"]
        like_count <- map["at_users"]
        note_id <- map["at_users"]
        status <- map["at_users"]
        time <- map["time"]
        user <- map["at_users"]
        
    }
}


