//
//  ONRouter+POST.swift
//  OCTNeoKit
//
//  Created by yuhan zhang on 4/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation
import Alamofire


public extension ONRouter {
    
    enum POST: URLRequestConvertible {
        
        case CreateUser
        case CreateUserWithParams(props: [String: AnyObject])
        
        case Login(props: [String: AnyObject])
        
        
//        case UpdateUserProperties(id: String, props: [String: AnyObject])
        
        
        var path: String {
            return ONRouter.CypherURL
        }
        
        
        var cypher: [String: AnyObject] {
            let query: String
            let params: [String: AnyObject]
            
            
            switch self {
            case .CreateUser:
                query = "CREATE (n: User) RETURN n"
                params = [:]
            case let .CreateUserWithParams(props):
                query = "CREATE (n: User { props } ) RETURN n"
                params = ["props": props]
            case let .Login(props):
                query = "MATCH (n: User) WHERE n.account = {account} AND n.password = {password} RETURN n"
                let a = props["account"] as! String
                let p = props["password"] as! String
                params = ["account": a, "password": p]
//            case let .UpdateUserProperties(key, props):
//                var str2 = props.map() {
//                    "u.\($0.0) = \(neoView($0.1)), "
//                    }.reduce("") {
//                        return $0 + $1
//                }
//                str2.removeLastCharacter(2)
//                
//                query = "START u = NODE(\(key)) SET \(str2)"
//                params = [:]
            }
            
            return ["query": query, "params": params]
        }
        
        
        public var URLRequest: NSMutableURLRequest {
            let url = NSURL(string: path)!
            let mutableRequest = NSMutableURLRequest(URL: url)
            mutableRequest.HTTPMethod = Alamofire.Method.POST.rawValue
            mutableRequest.setValue(ONRouter.Token.1, forHTTPHeaderField: ONRouter.Token.0)
            
            
            return Alamofire.ParameterEncoding.JSON.encode(mutableRequest, parameters: cypher).0
        }
    }
    
}


func neoView(obj: AnyObject) -> String {
    if obj is String {
        return "\'\(obj)\'"
    }
    return "\(obj)"
}


extension String {
    mutating func removeLastCharacter(count: Int = 1) {
        self = self.substringToIndex(self.endIndex.advancedBy(-count))
    }
}






