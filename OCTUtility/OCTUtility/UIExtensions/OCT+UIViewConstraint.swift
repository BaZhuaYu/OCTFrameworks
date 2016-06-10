//
//  UIViewConstraintExtension.swift
//  ZhaiClans
//
//  Created by yuhan zhang on 11/11/15.
//  Copyright © 2015 Octopus. All rights reserved.
//

import UIKit

extension UIView {
    public func centerXTo(view: UIView) {
        guard let _ = self.superview else {
            print("view: \(self.classForCoder) is not added into superview")
            return
        }
        
        if view.subviews.contains(self) {
            self.centerXToSuper(view)
        } else {
            self.centerXToSibling(view)
        }
    }
    
    public func centerYTo(view: UIView) {
        guard let _ = self.superview else {
            print("view: \(self.classForCoder) is not added into superview")
            return
        }
        
        if view.subviews.contains(self) {
            self.centerYToSuper(view)
        } else {
            self.centerYToSibling(view)
        }
    }
    
    public func centerTo(view: UIView) {
        guard let _ = self.superview else {
            print("view: \(self.classForCoder) is not added into superview")
            return
        }
        
        self.centerYTo(view)
        self.centerXTo(view)
    }
    
    
    
    
    
    private func centerXToSuper(view: UIView) {
        self.center.x = view.width/2
    }
    
    private func centerYToSuper(view: UIView) {
        self.center.y = view.height/2
    }
    
    private func centerToSuper(view: UIView) {
        self.centerXToSuper(view)
        self.centerToSuper(view)
    }
    
    private func centerYToSibling(view: UIView) {
        self.center.y = view.center.y
    }
    
    private func centerXToSibling(view: UIView) {
        self.center.x = view.center.x
    }
    
    private func centerToSibling(view: UIView) {
        self.centerYToSibling(view)
        self.centerXToSibling(view)
    }
}
