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
            return "/api/sns/v2/followfeed"
        case .Discover(_):
            return "/api/sns/v5/homefeed"
        case .Categories:
            return "/api/sns/v2/homefeed/categories"
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
