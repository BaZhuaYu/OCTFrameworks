//
//  Logger.swift
//  ZhaiClans
//
//  Created by yuhan zhang on 12/1/15.
//  Copyright © 2015 Octopus. All rights reserved.
//

import Foundation

public class Logger {
    
    public static var sharedInstance = Logger()
    
    private init() {}
    
    public static let debugMode = true
    
    public class func info(s: String, function: String = __FUNCTION__) {
        print("✅" + function + "\n" + s)
    }
    
    public class func debug(s: String, filename: String = __FILE__, line: Int = __LINE__, function: String = __FUNCTION__) {
        if Logger.debugMode {
            print("⚠️\((filename as NSString).lastPathComponent): line \(line) \(function):\n --- \(s)")
        }
    }
    
    public class func error(s: String, filename: String = __FILE__, line: Int = __LINE__, function: String = __FUNCTION__) {
        if true {
            print("❌\((filename as NSString).lastPathComponent): line \(line) \(function):\n --- \(s)")
        }
    }
}