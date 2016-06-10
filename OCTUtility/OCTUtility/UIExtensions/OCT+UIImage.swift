//
//  UIImageExtension.swift
//  ZhaiClans
//
//  Created by yuhan zhang on 1/21/16.
//  Copyright © 2016 Octopus. All rights reserved.
//

import UIKit

extension UIImage {
    public class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        
        let rect = CGRect(origin: CGPointZero, size: size)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
        
    }
    
}
