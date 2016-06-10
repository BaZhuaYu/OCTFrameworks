//
//  UIColorExtension.swift
//  ZhaiClans
//
//  Created by yuhan zhang on 11/13/15.
//  Copyright © 2015 Octopus. All rights reserved.
//

import UIKit

extension UIColor {
    
    public convenience init(r: Int, g: Int, b: Int, a: CGFloat) {
        self.init(red: CGFloat(r)/CGFloat(255), green: CGFloat(g)/CGFloat(255), blue: CGFloat(b)/CGFloat(255), alpha: a)
    }
    
    
    public convenience init(RGB rgbValue: UInt) {
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0))
    }
    
    
    
    public class func steelblue() -> UIColor {
        return UIColor(r: 70, g: 130, b: 180, a: 1)
    }
    
    public class func deepSkyblue() -> UIColor {
        return UIColor(r: 0, g: 191, b: 255, a: 1)
    }
    
    public class func skyblue() -> UIColor {
        return UIColor(r: 135, g: 206, b: 235, a: 1)
    }
    
    
    public class func lightSkyblue() -> UIColor {
        return UIColor(r: 135, g: 206, b: 250, a: 1)
    }
    
    
    
    public class func lightCyan() -> UIColor {
        return UIColor(r: 224, g: 255, b: 255, a: 1)
    }
    
    
    
    //MARK:- System Colors
    
    public class func lightAqua() -> UIColor {
        return UIColor(r: 53, g: 167, b: 250, a: 1)
    }
    
    
    public class func aqua() -> UIColor {
        return UIColor(r: 0, g: 128, b: 255, a: 1)
    }
    
    
    public class func silver() -> UIColor {
        return UIColor(r: 204, g: 204, b: 204, a: 1)
    }
    
    
    public class func mercury() -> UIColor {
        return UIColor(r: 230, g: 230, b: 230, a: 1)
    }
    
    
    public class func lead() -> UIColor {
        return UIColor(r: 25, g: 25, b: 25, a: 1)
    }
    
    
    public class func tungsten() -> UIColor {
        return UIColor(r: 51, g: 51, b: 51, a: 1)
    }
    
    
    public class func turquoise() -> UIColor {
        return UIColor(r: 0, g: 255, b: 255, a: 1)
    }
    
    
    public class func steel() -> UIColor {
        return UIColor(r: 102, g: 102, b: 102, a: 1)
    }
    
    
}














