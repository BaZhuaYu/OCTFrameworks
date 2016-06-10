//
//  WeiBoAPI.swift
//  OCTWeiBo
//
//  Created by yuhan zhang on 4/22/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation

class WBAPI {
    static let baseURL = "https://api.weibo.com/2"
    
    static let userURL = "/\(baseURL)/users/show"
    
    static let uidURL = "/\(baseURL)/account/get_uid"
}