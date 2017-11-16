//
//  MoyaAPI.swift
//  XiaoHongshu
//
//  Created by SMART on 2017/10/22.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import Foundation
import Moya

//初始化请求的Provider
let SMProvider = MoyaProvider<MoyaAPI>()

//下面定义请求的endpoints

enum MoyaAPI{
    
    case User  //获取用户信息
    case Focus  //关注
    case Discover([String:Any])  //发现
    case Categories //发现标签栏
    case NoteDetail(String) // 笔记详情
    case NoteComment(String) //笔记详情 - 评论
    case NoteRelated(String) //笔记详情 - 相关笔记
    
}

extension MoyaAPI: TargetType {
    
    //请求头
    var headers: [String: String]? {
        return nil
    }
    
    //服务器地址
    var baseURL: URL {
        return URL(string: "https://www.xiaohongshu.com")!
    }
    
    //单个请求的具体路径
    var path:String{
        
        switch self {
        case .User:
            return "/api/sns/v3/user/me"
        case .Focus:
//            https://www.xiaohongshu.com/api/sns/v2/followfeed?cursor_score=1510757047115000&deviceId=B9B75D10-C165-4F63-A7B0-3C98B65850F3&lang=zh&num=20&platform=iOS&sid=session.1192865895539576508&sign=5692d272c2c43ede354005e54898bec9&size=l&t=1510814782
            return "/api/sns/v2/followfeed"
        case .Discover(_):
            return "/api/sns/v5/homefeed"
        case .Categories:
            return "/api/sns/v2/homefeed/categories"
            
        case .NoteDetail(let note_id):
            //https://www.xiaohongshu.com/api/sns/v8/note/5a0905dc05b06277aced5b3f?deviceId=B9B75D10-C165-4F63-A7B0-3C98B65850F3&lang=zh&oid=5a0905dc05b06277aced5b3f&platform=iOS&sid=session.1192865895539576508&sign=26dd0bf6895dd6e54a777e2805c37e92&size=l&t=1510556722
            return "/api/sns/v8/note/" + note_id
        case .NoteComment(let note_id):
            //https://www.xiaohongshu.com/api/sns/v5/note/5a03312f0546a40359efda5c/comment/list?deviceId=B9B75D10-C165-4F63-A7B0-3C98B65850F3&lang=zh&num=3&oid=5a03312f0546a40359efda5c&platform=iOS&show_priority_sub_comments=1&sid=session.1192865895539576508&sign=78db9b8504de8d8a91f5c0e924374167&t=1510303158
            return "/api/sns/v5/note/" + note_id + "/comment/list"  //"/api/sns/v5/note/5a03312f0546a40359efda5c/comment/list"
        case .NoteRelated(let note_id):
            //https://www.xiaohongshu.com/api/sns/v2/note/5a03312f0546a40359efda5c/related?deviceId=B9B75D10-C165-4F63-A7B0-3C98B65850F3&discovery_id=5a03312f0546a40359efda5c&lang=zh&page=1&platform=iOS&sid=session.1192865895539576508&sign=d8ad5479fbeba2137c02a320a7a21bf7&t=1510303158&tag_oid=
            
            return "/api/sns/v2/note/"+note_id+"/related" // "/api/sns/v2/note/5a03312f0546a40359efda5c/related"
        }
    }
    
    //请求类型
    var method: Moya.Method{
        switch self {
        case .User:
            return .get
        case .Focus:
            return .get
        case .Discover(_):
            return .get
        case .Categories:
            return .get
        case .NoteDetail(_):
            return .get
        case .NoteComment(_):
            return .get
        case .NoteRelated(_):
            return .get
        default:
            return .get
        }
    }
    
    //请求任务事件（附带参数）
    var task: Task {
        
        var params: [String: Any] = [:]
        params["deviceId"] = "B9B75D10-C165-4F63-A7B0-3C98B65850F3"
        params["lang"] = "zh"
        params["platform"] = "iOS"
        params["sid"] = GLOBAL_SID
        
        switch self {
        case .User:
            
            //sign=24635472b285ed0cbb53b9352dd7b580
            //t=1508575412
            
            params["sign"] = "24635472b285ed0cbb53b9352dd7b580"
            params["t"] = 1508575412
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .Focus:
        
            
            //sign=ab1c0a4eea2aef71b1908580bd2bdd3e
            //t=1508575831
            //num=20
            //size=l
            params["sign"] = "ab1c0a4eea2aef71b1908580bd2bdd3e"
            params["t"] = 1508575831
            params["num"] = 20
            params["size"] = "l"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        case .Discover(let parameters ):
            
            
            //num=20
            //oid=homefeed_recommend
            //page=1
            //sign=93ccfb693d56a600856390a552dc8028
            //size=l
            //t=1508575888
            //value=simple
            
            params["oid"] = parameters["oid"]//"homefeed_recommend"
            params["page"] = 1
            params["num"] = 20
            params["sign"] = "93ccfb693d56a600856390a552dc8028"
            params["size"] = "l"
            params["t"] = 1508575888
            params["value"] = "simple"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        case .Categories:
            //            deviceId=B9B75D10-C165-4F63-A7B0-3C98B65850F3
            //            lang=zh
            //            platform=iOS
            //            sid=session.1192865895539576508
            
            params["sign"] = "c8abea0d7eea0ffa153cc5e0c684d12f"
            params["t"] = 1509320402
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        case .NoteDetail(_):
            //            deviceId=B9B75D10-C165-4F63-A7B0-3C98B65850F3
            //            lang=zh
            //            platform=iOS
            //            sid=session.1192865895539576508
            
            //            oid=5a0905dc05b06277aced5b3f
            //            sign=26dd0bf6895dd6e54a777e2805c37e92
            //            size=l
            //            t=1510556722
            
            params["oid"] = "5a0905dc05b06277aced5b3f"
            params["sign"] = "26dd0bf6895dd6e54a777e2805c37e92"
            params["t"] = 1510556722
            params["size"] = "l"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .NoteComment(_):
            //deviceId=B9B75D10-C165-4F63-A7B0-3C98B65850F3
            //lang=zh
            //platform=iOS
            //sid=session.1192865895539576508
            
            //num=3
            //oid=5a03312f0546a40359efda5c
            //show_priority_sub_comments=1
            //sign=78db9b8504de8d8a91f5c0e924374167
            //t=1510303158
            
            params["sign"] = "78db9b8504de8d8a91f5c0e924374167"
            params["t"] = 1510303158
            params["show_priority_sub_comments"] = 1
            params["num"] = 3
            params["oid"] = "5a03312f0546a40359efda5c"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .NoteRelated(_):
            
            //         deviceId=B9B75D10-C165-4F63-A7B0-3C98B65850F3
            //         lang=zh
            //         platform=iOS
            //         sid=session.1192865895539576508
            
            //         page=1
            //         discovery_id=5a03312f0546a40359efda5c
            //         sign=d8ad5479fbeba2137c02a320a7a21bf7
            //         t=1510303158
            //         tag_oid=
            
            params["discovery_id"] = "5a03312f0546a40359efda5c"
            params["page"] = 1
            params["sign"] = "d8ad5479fbeba2137c02a320a7a21bf7"
            params["t"] = 1510303158
            params["tag_oid"] = ""
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
        
    }
    
    //是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    
    //单元测试模拟数据，只会在单元测试文件中有作用
    var sampleData: Data {
        switch self {
        case .User:
            return "Create post successfully".data(using: String.Encoding.utf8)!
        default:
            return "Create post successfully".data(using: String.Encoding.utf8)!
        }
    }
    
}
