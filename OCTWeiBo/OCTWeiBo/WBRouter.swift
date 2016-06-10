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
    
    public static var token: String?
    
    
    case UserInfo
    
    
    var path: String {
        switch self {
        case .UserInfo:
            return WBAPI.userURL
        }
    }
    
    var method: Alamofire.Method {
        switch self{
        case .UserInfo:
            return .GET
        }
    }
    
    
    public var URLRequest: NSMutableURLRequest {
        let url = NSURL(string: path)!
        let mutableRequest = NSMutableURLRequest(URL: url)
        mutableRequest.HTTPMethod = method.rawValue
        
        if WBRouter.token != nil {
            mutableRequest.setValue(WBRouter.token!, forHTTPHeaderField: "token")
        }
        
        switch self {
        default:
            return mutableRequest
        }
        
    }
    
    
    
}