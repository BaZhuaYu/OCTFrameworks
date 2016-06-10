//
//  OCTPushNotificationCenter.swift
//  ZhaiClans
//
//  Created by yuhan zhang on 3/16/16.
//  Copyright © 2016 Octopus. All rights reserved.
//

import UIKit

protocol PushNotificationRespondable {
    func didReceivePushNotification(userInfo: [NSObject: AnyObject])
}


class OCTPushNotificationCenter: NSObject {
    
    static var sharedInstance = OCTPushNotificationCenter()
    
    private override init() { }
    
    
    var observers = [(String, PushNotificationRespondable)]()
    
    
    func addNotificationObserver(obj: PushNotificationRespondable, forName name: String) {
        self.observers.append((name, obj))
    }
    
    
    func removeNotificationObserver(name name: String) {
        self.observers = self.observers.filter() { $0.0 == name }
    }
    
    
    func didReceivePushNotification(userInfo: [NSObject: AnyObject]) {
        for observer in self.observers {
            observer.1.didReceivePushNotification(userInfo)
        }
    }
}
