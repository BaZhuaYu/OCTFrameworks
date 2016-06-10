//
//  UIViewExtension.swift
//  Untold
//
//  Created by yuhan zhang on 10/30/15.
//  Copyright © 2015 octopus. All rights reserved.
//

import UIKit

extension UIView {
    public var centerBounds: CGPoint {
        set{
            let x = newValue.x - self.bounds.width/2
            let y = newValue.y - self.bounds.height/2
            self.bounds.origin = CGPoint(x: x, y: y)
        }
        
        get{
            return CGPoint(x: self.bounds.origin.x + self.bounds.size.width/2,
                           y: self.bounds.origin.y + self.bounds.size.height/2)
        }
    }
    
    public var x: CGFloat {
        set{
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
        }
        get {
            return self.frame.origin.x
        }
    }
    
    public var y: CGFloat {
        set{
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
        get {
            return self.frame.origin.y
        }
    }
    
    public var width: CGFloat{
        set{
            var rect = self.frame
            rect.size.width = newValue
            self.frame = rect
        }
        get {
            return self.bounds.size.width
        }
    }
    
    public var height: CGFloat {
        set{
            var rect = self.frame
            rect.size.height = newValue
            self.frame = rect
        }
        get {
            return self.bounds.size.height
        }
    }
    
    public var bottom: CGFloat {
        set{
            var rect = self.frame
            rect.origin.y = bottom - rect.height
            self.frame = rect
        }
        get {
            return self.y + self.height
        }
    }
    
    
    
    public var right: CGFloat {
        set{
            var rect = self.frame
            rect.origin.x = right - rect.width
            self.frame = rect
        }
        get {
            return self.x + self.width
        }
    }
    
    
    public var size: CGSize {
        set{
            self.frame.size = newValue
        }
        get {
            return self.frame.size
        }
    }

}


//MARK:- UIView Animations


extension UIView {
    public func displayAtBottom(fromView: UIView) {
        guard let superView = self.superview else {
            print("display at bottom: no superview")
            return
        }
        
        self.y = superView.height
        self.hidden = false
        UIView.animateWithDuration(0.3) { () -> Void in
            if fromView.y > superView.height - self.height - 100 {
                let offset = fromView.y - (superView.height - self.height - fromView.height - 50)
                superView.y -= offset
                superView.height += offset + self.height
                self.y = superView.height - self.height*2
            } else {
                self.y = superView.height - self.height
            }
        }
    }
    
    
    
    public func showFromBottom(flag: Bool) {
        if flag {
            if self.y > OCTScreenHeight - self.width/2 { //if self beneath the screen, then play the animation
//                self.y = gScreenHeight
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    self.y = OCTScreenHeight - self.height
                    }, completion: nil)
            }
        } else {
            if self.y < OCTScreenHeight {     //if self above the screen, then play the animation
//                self.y = gScreenHeight - self.height
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.y = OCTScreenHeight
                    }, completion: { (Flag) -> Void in

                    })
            }
        }
    }
    
    
    public func showFromTop(flag: Bool) {
        if flag {
            if self.y < 1 {
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    self.y = self.height
                    }, completion: nil)
            }
        } else {
            if self.y > 0 {
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.y = 0
                    }, completion: nil)
            }
        }
    }
    
}



extension UIView {
    public func getViewController() -> UIViewController? {
        var view: UIView? = self
        
        while(view != nil) {
            view = view?.superview
            guard let controller = view?.nextResponder() else {
                return nil
            }
            
            if controller.isKindOfClass(UIViewController) {
                return controller as? UIViewController
            }
        }
        
        return nil
    }
}











