//
//  OCTUtility.swift
//  OCTUtility
//
//  Created by yuhan zhang on 4/28/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation

public extension NSMutableDictionary {
    public func setString(s: String?, forKey key: String) {
        if let temp = s {
            self.setObject(temp, forKey: key)
        }
    }
    
    public func setInt32(i: Int32, forKey key: String) {
        self.setObject(Int(i), forKey: key)
    }
    
    public func setArray(array: [AnyObject]?, forKey key: String) {
        if let a = array {
            if a.count > 0 {
                self.setObject(a, forKey: key)
            }
        }
    }
    
}