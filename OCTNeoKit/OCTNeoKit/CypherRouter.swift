//
//  CypherRouter.swift
//  OCTNeoKit
//
//  Created by yuhan zhang on 4/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation
import Alamofire


public enum CypherRouter: URLRequestConvertible {
    
    static var Token = "Basic bmVvNGo6amlzdWFuamkxMTE="
    
    static let CypherURL = "http://120.25.98.248:7474/db/data/cypher"
    
    
    case CreateUser
    case CreateUserWithParams(props: [String: AnyObject])
    
    case Login(props: [String: AnyObject])
    
    
    var method: Alamofire.Method {
        switch self {
        default:
            return .POST
        }
    }
    
    
    var path: String {
        return CypherRouter.CypherURL
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
        }
        
        return ["query": query, "params": params]
    }
    
    
    public var URLRequest: NSMutableURLRequest {
        let url = NSURL(string: path)!
        let mutableRequest = NSMutableURLRequest(URL: url)
        mutableRequest.HTTPMethod = method.rawValue
        
        mutableRequest.setValue(CypherRouter.Token, forHTTPHeaderField: "Authorization")
        
        
        return Alamofire.ParameterEncoding.JSON.encode(mutableRequest, parameters: cypher).0
    }
    
}

