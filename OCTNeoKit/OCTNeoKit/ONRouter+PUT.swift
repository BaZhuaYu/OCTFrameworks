//
//  ONRouter+PUT.swift
//  OCTNeoKit
//
//  Created by yuhan zhang on 4/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation
import Alamofire


public extension ONRouter {

    enum PUT: URLRequestConvertible {
        
        case Properties(id: String, properties: [String: AnyObject])
        case Property(id: String, property: (String, AnyObject))
        
        var path: String {
            switch self {
            case .Properties:
                return ONRouter.CypherURL
            case let .Property(id, property):
                return ONRouter.getUserProperityURL(id, properity: property.0)
            }
        }
        
        
        
        var method: Alamofire.Method {
            switch self {
            case .Properties:
                return .POST
            default:
                return .PUT
            }
        }
        
        
        var cypher: [String: AnyObject] {
            let query: String
            let params: [String: AnyObject]
            
            
            switch self {
            case let .Properties(key, props):
//                var str2 = props.map() {
//                    "u.\($0.0) = \(neoView($0.1)), "
//                    }.reduce("") {
//                        return $0 + $1
//                }
//                str2.removeLastCharacter(2)
//                
//                query = "START u = NODE(\(key)) SET \(str2)"
//                params = [:]
                
                query = "START u = NODE(\(key) SET u += { props }"
                params = ["props": props]
            default:
                query = ""
                params = [:]
            }
            
            return ["query": query, "params": params]
        }
        
        
        public var URLRequest: NSMutableURLRequest {
            let url = NSURL(string: path)!
            let mutableRequest = NSMutableURLRequest(URL: url)
            mutableRequest.HTTPMethod = method.rawValue
            mutableRequest.setValue(ONRouter.Token.1, forHTTPHeaderField: ONRouter.Token.0)
            
            
            switch self {
            case .Properties:
                return Alamofire.ParameterEncoding.JSON.encode(mutableRequest, parameters: cypher).0
            case .Property(_, (_, let value)):
                mutableRequest.HTTPBody = "\"\(value)\"".dataUsingEncoding(NSUTF8StringEncoding)
                return mutableRequest
            }
        }
        
    }
    
}