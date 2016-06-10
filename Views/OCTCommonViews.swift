//
//  OCTCommonViews.swift
//  ZhaiClans
//
//  Created by yuhan zhang on 2/3/16.
//  Copyright © 2016 Octopus. All rights reserved.
//

import UIKit

class OCTCommonViews {
    class func createBottomBar(forButton button: UIButton, withTitle title: String) -> UIView {
        
        let bottomBar = UIView(frame: CGRect(x: 0, y: OCTScreenHeight - 52, width: OCTScreenWidth, height: 52))
        bottomBar.backgroundColor = AppLightBackgroundColor
        
        button.frame = CGRect(x: 20, y: 8, width: bottomBar.width - 40, height: bottomBar.height - 16)
        button.setTitle(title, forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage.imageWithColor(UIColor.grayColor().colorWithAlphaComponent(0.7), size: button.size), forState: UIControlState.Highlighted)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(14)
        button.setTitleColor(UIColor.lightAqua(), forState: UIControlState.Normal)
        
        button.layer.borderColor = AppForegroundColor.colorWithAlphaComponent(0.3).CGColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        button.clipsToBounds = true
        
        bottomBar.addSubview(button)

        return bottomBar
    }
    
    
    class func createBottomMenu(buttons: [UIButton], withTitles titles: [String]) -> UIView {
        let size = CGSize(width: OCTScreenWidth, height: 44)
        
        let menu = UIView(frame: CGRect(x: 0, y: OCTScreenHeight - size.height, width: size.width, height: size.height))
        menu.backgroundColor = AppBackgroundColor//.colorWithAlphaComponent(0.5)
        
        
        let buttonSize = CGSize(width: size.width/CGFloat(buttons.count), height: size.height)
        
        for i in 0..<buttons.count {
            buttons[i].frame = CGRect(x: CGFloat(i) * buttonSize.width , y: 0, width: buttonSize.width, height: buttonSize.height)
            buttons[i].setTitle(titles[i], forState: UIControlState.Normal)
            
//            buttons[i].setBackgroundImage(UIImage(named: titles[i]), forState: UIControlState.Normal)
            
            buttons[i].setTitleColor(UIColor.lightAqua(), forState: UIControlState.Normal)
            buttons[i].setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
            buttons[i].titleLabel?.font = UIFont.systemFontOfSize(13)
            
            menu.addSubview(buttons[i])
        }
        
//        let line = UIView(frame: CGRect(x: menu.width/2, y: 0, width: 1, height: menu.height))
//        line.backgroundColor = UIColor.lightAqua().colorWithAlphaComponent(0.3)
//        menu.addSubview(line)
        
//        menu.alpha = 0.5
        
//        let line2 = UIView(frame: CGRect(x: 0, y: 0, width: menu.width, height: 1))
//        line2.backgroundColor = UIColor.lightAqua().colorWithAlphaComponent(0.3)
//        menu.addSubview(line2)
        
        return menu
    }
    
    
}















