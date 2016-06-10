//
//  TopBarView.swift
//  ZhaiClans
//
//  Created by yuhan zhang on 1/20/16.
//  Copyright © 2016 Octopus. All rights reserved.
//

import UIKit

enum TopBarStyle {
    case Dark
    case Light
}


protocol OCTTopBarViewDelegate: NSObjectProtocol {
    func didClickTopBarLeftButton()
    func didClickTopBarRightButton()
}


extension OCTTopBarViewDelegate where Self: UIViewController {
    func didClickTopBarLeftButton() {
        if let navi = self.navigationController {
            navi.popViewControllerAnimated(true)
        } else {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    func didClickTopBarRightButton() {
        return
    }
}


class OCTTopBarView: UIView {
    
    var titleLabel: UILabel?
    var leftButton: UIButton?
    var rightButton: UIButton?
    
    weak var delegate: OCTTopBarViewDelegate?
    
    let style: TopBarStyle!
    
    init(style: TopBarStyle) {
        self.style = style
        super.init(frame: CGRect(x: 0, y: 0, width: OCTScreenWidth, height: 64))
        
        configBackground()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configBackground() {
        self.backgroundColor = AppBackgroundColor//.colorWithAlphaComponent(0.5)
    }
    
    
    let offset = 16 as CGFloat
    
    func configTitleLabel(title: String) -> OCTTopBarView {
        self.titleLabel = UILabel(frame: CGRect(x: OCTScreenWidth/2 - 50, y: 27, width: 100, height: 30))
        self.titleLabel?.font = UIFont.systemFontOfSize(14)
        self.titleLabel?.textAlignment = .Center
        self.titleLabel?.textColor = UIColor.whiteColor()
        self.titleLabel?.text = title
        
        self.addSubview(self.titleLabel!)
        return self
    }
    
    
    func configLeftButton(imageName: String = "backward") -> OCTTopBarView {
        self.leftButton = UIButton(frame: CGRect(x: 0, y: 20, width: 44, height: 44))
        self.leftButton?.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        self.addSubview(self.leftButton!)
        
        leftButton?.addTarget(self, action: "didClickLeftButton", forControlEvents: UIControlEvents.TouchUpInside)
        
        return self
    }
    
    func configRightButton(imageName: String = "check") -> OCTTopBarView {
        self.rightButton = UIButton(frame: CGRect(x: self.width - 44, y: 20, width: 44, height: 44))
//        rightButton?.titleLabel?.text = imageName
//        rightButton?.titleLabel?.textColor = AppStaticForegroundColor
//        rightButton?.titleLabel?.font = UIFont.systemFontOfSize(14)
        self.rightButton?.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        self.addSubview(self.rightButton!)
        
        rightButton?.addTarget(self, action: "didClickRightButton", forControlEvents: UIControlEvents.TouchUpInside)
        
        return self
    }
    
    
    
    
    //mark:- Actions
    
    
    
    func didClickLeftButton() {
        self.delegate?.didClickTopBarLeftButton()
    }
    
    
    func didClickRightButton() {
        self.delegate?.didClickTopBarRightButton()
    }
    
    
}



