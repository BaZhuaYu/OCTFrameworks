//
//  OCTWeiBo.swift
//  OCTWeiBo
//
//  Created by yuhan zhang on 4/22/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation



public class OCTWeiBo: NSObject {
//    
//    public static let WBAppKey = "492900438"
//    public static let WBAppSecret = "087e5e676fa30968aca22671dc6e9a36"
//    public static let WBRedirectURI = "https://www.weibo.com"
//    
//    
//    public static var WBToken: String?
//    public static var WBUserID: String?
//    public static var WBRefreshToken: String?
//    
//    
    
    public class func login() {
        let temp = WBAuthorizeRequest.request() as! WBAuthorizeRequest
        temp.redirectURI = "https://www.weibo.com"
        temp.scope = "all"
        WeiboSDK.sendRequest(temp)
    }
}