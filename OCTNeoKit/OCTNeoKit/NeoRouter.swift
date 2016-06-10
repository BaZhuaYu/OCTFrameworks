//
//  NeoRouter.swift
//  OCTNeoKit
//
//  Created by yuhan zhang on 5/13/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation
import Alamofire


protocol NeoRouter {
    
    static var Token: String { get }
    
    static var CypherURL: String { get }
    
    static var BaseURL: String { get }
    
    
    var GET: URLRequestConvertible { get }
    var POST: URLRequestConvertible { get }
    var PUT: URLRequestConvertible { get }
    var DELETE: URLRequestConvertible { get }
    
}