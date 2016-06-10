//
//  PopView.swift
//  ZhaiClans
//
//  Created by yuhan zhang on 1/21/16.
//  Copyright © 2016 Octopus. All rights reserved.
//

import UIKit

class OCTAlertPopView: UIView {
    
    var imageView: UIImageView!
    
    var label: UILabel!
    
    
    let BackgroundColor = UIColor.blackColor()
    let ForegroundColor = AppForegroundColor
    
    
    
    //MARK:- Life Cycle
    
    
    
    init(_ text: String) {
        let w: CGFloat = (text.characters.count > 15) ? 220 : 160
        let h = 100 as CGFloat
        super.init(frame: CGRect(x: OCTScreenWidth/2 - w/2, y: OCTScreenHeight/2 - 80, width: w, height: h))
        
        self.backgroundColor = BackgroundColor

        self.alpha = 0.7
        
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        configImageView()
        configLabel(text)
    }
    
    
    class func pop(text: String) {
        let view = OCTAlertPopView(text)
        UIApplication.sharedApplication().windows.first?.addSubview(view)
    }
    
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        willEnterAnimation()
        UIView.animateWithDuration(0.2) { [unowned self] () -> Void in
            self.willLeaveAnimation()
        }
    }
    
    
    override func didMoveToSuperview() {
        UIView.animateWithDuration(0.2, delay: 0.6, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.willEnterAnimation()
            }, completion: { (Finished) -> Void in
                self.removeFromSuperview()
        })
    }
    
    
    //MARK:- Config Subviews
    
    
    private func configImageView() {
        let point = CGPoint(x: self.width/2 - 22, y: 10)
        let size = CGSize(width: 44, height: 44)
        
        imageView = UIImageView(frame: CGRect(origin: point, size: size))
        imageView.image = UIImage(named: "alert")
        
        imageView.layer.cornerRadius = imageView.width/2
        imageView.layer.borderColor = UIColor.aqua().CGColor
        imageView.layer.borderWidth = 2
        
        
        self.addSubview(imageView)
    }
    
    
    private func configLabel(text: String?) {
        let point = CGPoint(x: 0, y: imageView.bottom + 10)
        let size = CGSize(width: self.width, height: 30)
        
        label = UILabel(frame: CGRect(origin: point, size: size))
        
        label.backgroundColor = UIColor.clearColor()
        
        label.font = UIFont.systemFontOfSize(13)
        
        label.textColor = ForegroundColor
        
        label.text = text
        
        label.adjustsFontSizeToFitWidth = true
        
        label.textAlignment = .Center
        
        self.addSubview(label)
    }
    
    
    
    //MARK:- Animations
    
    
    
    private func willEnterAnimation() {
        self.alpha = 0
    }
    
    
    private func willLeaveAnimation() {
        self.alpha = 1
    }
    
    
}
