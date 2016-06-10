//
//  ONRouter+GET.swift
//  OCTNeoKit
//
//  Created by yuhan zhang on 4/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation
import Alamofire



public extension ONRouter {
    
    public enum GET: URLRequestConvertible {
        
        case Properties(id: String)
        case Property(id: String, property: String)
        
        case Relationships(id: String, relationships: String)
        
        
        var path: String {
            switch self {
            case .Properties(let id):
                return ONRouter.getUserProperitiesURL(id)
            case let .Property(id, property):
                return ONRouter.getUserProperityURL(id, properity: property)
            case let .Relationships(id, relationships):
                return ONRouter.getUserRelationships(id, relationships: relationships)
            }
        }
        
        
        public var URLRequest: NSMutableURLRequest {
            let url = NSURL(string: path)!
            let mutableRequest = NSMutableURLRequest(URL: url)
            mutableRequest.HTTPMethod = Alamofire.Method.GET.rawValue
            mutableRequest.setValue(ONRouter.Token.1, forHTTPHeaderField: ONRouter.Token.0)
            
            
            return mutableRequest
        }
        
        
    }
    
    
}






