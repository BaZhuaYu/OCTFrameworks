//
//  EnterViewController.swift
//  ZhaiClans
//
//  Created by yuhan zhang on 1/19/16.
//  Copyright © 2016 Octopus. All rights reserved.
//

import UIKit

class OCTEnrollViewController: UIViewController {
    
    var loginButton: UIButton!
    var signupButton: UIButton!

    var enroll: OCTEnrollable!
    
    
    //MARK:- Life Cycle
    
    
    
    override func viewDidLoad() {

        configBackground()
        configLogo()
        configSignupButton()
        configLoginButton()

        self.enroll = EnrollModel.sharedInstance
        
    }
    
    
    
    //MARK:- Configutations
    
    
    private func configBackground() {
        let image = UIImage(named: "back002.jpg")
        let imageView = UIImageView(image: image)
        imageView.alpha = 0.7
        imageView.frame = CGRect(x: 0, y: 0, width: OCTScreenWidth, height: OCTScreenHeight)
        
        self.view.addSubview(imageView)
    }
    
    private func configLogo() {
//        let label = UILabel(frame: CGRect(x: OCTScreenWidth/2 - 50, y: 100, width: 100, height: 56))
//        label.textAlignment = .Center
//        label.font = UIFont.systemFontOfSize(18)
//        label.textColor = UIColor.mercury()
//        label.text = "八 爪 鱼"
        
        
//        let imageView = UIImageView(image: UIImage(named: "logo"))
//        imageView.frame.origin = CGPoint(x: OCTScreenWidth/2 - 50, y: 100)
//        
//        self.view.addSubview(imageView)
    }
    
    

    let buttonSize = CGSize(width: (OCTScreenWidth - 32)/2, height: 40)

    
    private func configSignupButton() {
        self.signupButton = UIButton(frame: CGRect(origin: CGPoint(x: 12, y: OCTScreenHeight - 48),
            size: buttonSize))
        self.signupButton.setTitle("注册", forState: UIControlState.Normal)
        self.signupButton.addTarget(self, action: "didClickSignup", forControlEvents: UIControlEvents.TouchUpInside)
        

        signupButton.setBackgroundImage(UIImage.imageWithColor(UIColor.whiteColor(), size: buttonSize), forState: UIControlState.Normal)
        signupButton.setTitleColor(UIColor.lightAqua(), forState: UIControlState.Normal)

        
        signupButton.setBackgroundImage(UIImage.imageWithColor(AppLightForegroundColor, size: buttonSize), forState: UIControlState.Highlighted)
        signupButton.setTitleColor(UIColor.lightAqua(), forState: UIControlState.Highlighted)
        
        
        signupButton.uniform()
        self.view.addSubview(self.signupButton)
    }
    
    
    private func configLoginButton() {
        self.loginButton = UIButton(frame: CGRect(origin: CGPoint(x: self.signupButton.right + 8, y: self.signupButton.y), size: buttonSize))
        
        loginButton.setBackgroundImage(UIImage.imageWithColor(UIColor.lightAqua(), size: buttonSize), forState: UIControlState.Normal)
        loginButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)

        loginButton.setBackgroundImage(UIImage.imageWithColor(UIColor.lightAqua().colorWithAlphaComponent(0.7), size: buttonSize), forState: UIControlState.Highlighted)
        loginButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        
        loginButton.setTitle("登录", forState: UIControlState.Normal)
        self.loginButton.addTarget(self, action: "didClickLogin", forControlEvents: UIControlEvents.TouchUpInside)
        
        loginButton.uniform()
        self.view.addSubview(self.loginButton)
    }
    

    
    
    //MARK:- Actions
    
    
    func didClickLogin() {
        let loginVC = OCTLoginViewController()
        loginVC.delegate = self.enroll
        
        if let navi = self.navigationController {
            navi.pushViewController(loginVC, animated: true)
        } else {
            self.presentViewController(loginVC, animated: true, completion: nil)
        }
    }
    
    
    
    func didClickSignup() {
        let signupVC = OCTSignupViewController()
        signupVC.delegate = self.enroll

        if let navi = self.navigationController {
            navi.pushViewController(signupVC, animated: true)
        } else {
            self.presentViewController(signupVC, animated: true, completion: nil)
        }
    }
    
}


//MARK:- Extensions


private extension UIButton {
    func uniform() -> UIButton {
//        self.setTitleColor(AppForegroundColor, forState: UIControlState.Normal)

        self.titleLabel?.font = UIFont.systemFontOfSize(13)
//        self.backgroundColor = UIColor.lightAqua()
        
//        self.setTitleColor(UIColor.aqua(), forState: UIControlState.Highlighted)
//        self.setBackgroundImage(UIImage.imageWithColor(AppForegroundColor, size: self.size), forState: UIControlState.Highlighted)

//        let image = UIImage.imageWithColor(self.backgroundColor!.colorWithAlphaComponent(0.3), size: self.size)
        
//        self.setBackgroundImage(image, forState: UIControlState.Highlighted)
        
        
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        return self
    }
}






