//
//  Router.swift
//  OCTWeiBo
//
//  Created by yuhan zhang on 4/22/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation
import Alamofire

public enum WBRouter: URLRequestConvertible {
    
    static var token: String?
    
    
    case UserInfo
    case UID
    
    
    var path: String {
        switch self {
        case .UserInfo:
            return WBAPI.userURL
        case .UID:
            return WBAPI.uidURL
        }
    }
    
    var method: Alamofire.Method {
        switch self{
        case .UserInfo, .UID:
            return .GET
        }
    }
    
    
//    var params: [String: AnyObject] {
//        switch self {
//        case .UID:
//
//        }
//    }
    
    
    public var URLRequest: NSMutableURLRequest {
        let url = NSURL(string: path)!
        let mutableRequest = NSMutableURLRequest(URL: url)
        mutableRequest.HTTPMethod = method.rawValue
        
        if WBRouter.token != nil {
            mutableRequest.setValue(WBRouter.token!, forHTTPHeaderField: "token")
        }
        
        switch self {
        case .UID:
            return Alamofire.ParameterEncoding.URL.encode(mutableRequest, parameters: ["access_token": WBToken!]).0
        default:
            return mutableRequest
        }
        
    }
    
    
    
}