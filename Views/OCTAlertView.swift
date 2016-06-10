//
//  OCTAlertView.swift
//  ZhaiClans
//
//  Created by yuhan zhang on 1/27/16.
//  Copyright © 2016 Octopus. All rights reserved.
//

import UIKit


class OCTAlertView: UIView {
    
    var leftButton: UIButton!
    var rightButton: UIButton!
    
    var title: UILabel!
    
    var imageView: UIImageView!
    
    var handler: (() -> Void)?
    
    init(text: String) {

        let w = OCTScreenWidth * 0.65
        let h = OCTScreenWidth*3/8
        super.init(frame: CGRect(x: OCTScreenWidth/2 - w/2, y: OCTScreenHeight/2 - h/2 - 50, width: w, height: h))
        
        configBackground()
        configImage()
        configTitle(text)
        configButtons()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var bgview: UIView!
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        bgview = UIView(frame: OCTScreen)
        bgview.backgroundColor = AppBackgroundColor
        bgview.alpha = 0.3
        newSuperview?.addSubview(bgview)
    }
    
    
    
    //MARK:- Configurations
    
    
    
    private func configBackground() {
        self.backgroundColor = AppBackgroundColor
        self.layer.cornerRadius = 5
//        self.layer.borderColor = AppLightBackgroundColor.CGColor
//        self.layer.borderWidth = 2
        self.clipsToBounds = true
    }
    
    
    private func configImage() {
        let imageWidth: CGFloat = self.height * 0.4
        
        imageView = UIImageView(frame: CGRect(x: self.width/2 - imageWidth/2, y: 8, width: imageWidth, height: imageWidth))
        imageView.image = UIImage(named: "alert")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.width/2
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.aqua().CGColor
        self.addSubview(imageView)
    }
    
    
    private func configTitle(text: String) {
        title = UILabel(frame: CGRect(x: 8, y: self.height - 72, width: self.width - 16, height: 36))
        title.font = UIFont.systemFontOfSize(13)
        title.textColor = AppStaticForegroundColor
        title.textAlignment = .Center
        title.text = text
        self.addSubview(title)
    }
    
    
    private func configButtons() {
        let buttonSize = CGSize(width: self.width/2, height: 40)
        
        
        func uniform(button: UIButton) {
            button.setTitleColor(AppLightForegroundColor, forState: UIControlState.Highlighted)
            button.setBackgroundImage(UIImage.imageWithColor(UIColor.aqua(), size: buttonSize), forState: UIControlState.Highlighted)
            button.backgroundColor = UIColor.clearColor()
        }
        
        
        leftButton = UIButton(frame: CGRect(x: 0, y: self.height - buttonSize.height,
                                            width: buttonSize.width, height: buttonSize.height))
        rightButton = UIButton(frame: CGRect(x: leftButton.right + 1, y: leftButton.y,
                                            width: buttonSize.width, height: buttonSize.height))
        
        uniform(leftButton)
        uniform(rightButton)
        
        leftButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        rightButton.titleLabel?.font = UIFont.boldSystemFontOfSize(14)
        
        leftButton.setTitle("取消", forState: UIControlState.Normal)
        rightButton.setTitle("确定", forState: UIControlState.Normal)
        
        leftButton.setTitleColor(AppForegroundColor, forState: UIControlState.Normal)
        rightButton.setTitleColor(UIColor.aqua(), forState: UIControlState.Normal)
        
        leftButton.addTarget(self, action: "didClickLeftButton", forControlEvents: UIControlEvents.TouchUpInside)
        rightButton.addTarget(self, action: "didClickRightButton", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(leftButton)
        self.addSubview(rightButton)
        

        let line1 = UIView(frame: CGRect(x: 0, y: leftButton.y - 1, width: self.width, height: 1))
        line1.backgroundColor = AppSeparatorLineColor
        self.addSubview(line1)
        

        let line2 = UIView(frame: CGRect(x: leftButton.right, y: line1.y + 1, width: 1, height: buttonSize.height))
        line2.backgroundColor = AppSeparatorLineColor
        self.addSubview(line2)
    }
    
    
    //MARK:- Public Methods
    
    
    func configRightButton(title: String, handler: (() -> Void)?) -> OCTAlertView {
        rightButton.setTitle(title, forState: UIControlState.Normal)
        self.handler = handler
        
        return self
    }
    
    
    func configImage(named: String) -> OCTAlertView {
        self.imageView.image = UIImage(named: named)
        
        return self
    }
    
    
    
    //MARK:- Actions
    
    
    
    func didClickLeftButton() {
        bgview.removeFromSuperview()
        self.removeFromSuperview()
    }
    
    func didClickRightButton() {
        self.didClickLeftButton()
        self.handler?()
    }
    
    
}













