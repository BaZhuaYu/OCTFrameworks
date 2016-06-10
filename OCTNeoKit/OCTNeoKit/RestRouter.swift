//
//  RestRouter.swift
//  OCTNeoKit
//
//  Created by yuhan zhang on 4/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation
import Alamofire

public enum RestRouter: URLRequestConvertible {
    
    private static var Token = "Basic bmVvNGo6amlzdWFuamkxMTE="
    
    
    case UserProperties(id: String)
    case UserProperty(id: String, property: String)
    
    
    var path: String {
        switch self {
        case .UserProperties(let id):
            return RestAPI.getUserProperitiesURL(id)
        case let .UserProperty(id, property):
            return RestAPI.getUserProperityURL(id, properity: property)
        }
    }
    
    var method: Alamofire.Method {
        switch self {
        default:
            return .GET
        }
    }
    
    
    public var URLRequest: NSMutableURLRequest {
        let url = NSURL(string: path)!
        let mutableRequest = NSMutableURLRequest(URL: url)
        mutableRequest.HTTPMethod = method.rawValue
        mutableRequest.setValue(RestRouter.Token, forHTTPHeaderField: "Authorization")
        
        
        return mutableRequest
    }
    
    
}



private class RestAPI {
    
    static let BaseURL = "http://120.25.98.248:7474/db/data"
    
    
    class func getUserProperitiesURL(id: String) -> String {
        return "\(BaseURL)/node/\(id)/properties"
    }
    
    
    class func getUserProperityURL(id: String, properity: String) -> String {
        return getUserProperitiesURL(id) + "/\(properity)"
    }
    
    
}
