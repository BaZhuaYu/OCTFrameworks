//
//  ONRouter.swift
//  OCTNeoKit
//
//  Created by yuhan zhang on 4/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation
//import Alamofire

public enum ONRouter {

    
    static var Token = ("Authorization", "Basic bmVvNGo6amlzdWFuamkxMTE=")
    
    static var CypherURL = "http://120.25.98.248:7474/db/data/cypher"
    
    static let BaseURL = "http://120.25.98.248:7474/db/data"
    
    
    static func getUserProperitiesURL(id: String) -> String {
        return "\(BaseURL)/node/\(id)/properties"
    }
    
    
    static func getUserProperityURL(id: String, properity: String) -> String {
        return getUserProperitiesURL(id) + "/\(properity)"
    }
    
    
    static func getUserRelationships(id: String, relationships: String) -> String {
        return "\(BaseURL)/node/\(id)/relationships/all/\(relationships)"
    }
    
    
    
}





