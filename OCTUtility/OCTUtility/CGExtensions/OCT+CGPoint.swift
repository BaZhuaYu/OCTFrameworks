//
//  CGPointExtension.swift
//  Untold
//
//  Created by yuhan zhang on 11/6/15.
//  Copyright © 2015 octopus. All rights reserved.
//

import UIKit

extension CGPoint {
    public static func randomPointInRect(rect: CGRect) -> CGPoint {
        let x = CGFloat.random(from: rect.origin.x, range: rect.width)
        let y = CGFloat.random(from: rect.origin.y, range: rect.height)
        return CGPoint(x: x, y: y)
    }
    
    
//    func isInView(view: UIView) -> Bool {
//        if let window = UIApplication.sharedApplication().keyWindow {
//            let rect = view.convertRect(view.frame, toView: window)
//            if
//        } else {
//            print("UIApplication.sharedApplication().keyWindow is nil")
//        }
//        return false
//    }
}
