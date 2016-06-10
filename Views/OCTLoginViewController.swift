//
//  LoginViewController.swift
//  ZhaiClans
//
//  Created by yuhan zhang on 12/25/15.
//  Copyright © 2015 Octopus. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class OCTLoginViewController: UIViewController, OCTTopBarViewDelegate {
    
    var container: UIView!
        var accountField: UITextField!
        var passwordField: UITextField!
    
    var forgetPasswordButton: UIButton!
    
    var loginButton: UIButton!
    
    
    weak var delegate: OCTEnrollable?
    
    
    override func viewDidLoad() {

        self.configBackground()
        self.configTopBar()
        self.configContainer()
        self.configForgetPasswordButton()
        self.configLoginButton()
    
    }
    
    
    //MARK:- Config Subviews
    
    
    private func configBackground() {
        self.view.backgroundColor = AppBackgroundColor
    }
    
    
    private func configTopBar() {
        let topBar = OCTTopBarView(style: TopBarStyle.Dark).configTitleLabel("登录").configLeftButton()
        topBar.delegate = self
        self.view.addSubview(topBar)
    }
    
    
    
    let textFieldWidht = OCTScreenWidth - 44
    let textFieldHeight = 32 as CGFloat
    
    private func configContainer() {
        let offset = 4 as CGFloat
        let point = CGPoint(x: offset, y: 64 + offset)
        let size = CGSize(width: OCTScreenWidth - offset * 2 , height: textFieldHeight * 2 + 1)

        self.container = UIView(frame: CGRect(origin: point, size: size))
        self.container.layer.cornerRadius = 3
        self.container.clipsToBounds = true
        container.backgroundColor = AppLightBackgroundColor
        
        self.view.addSubview(container)
        
        self.configTextFields()
    }

    
    private func configTextFields() {
        self.accountField = UITextField()
        self.passwordField = UITextField()
        
        
        let imageSize = CGSize(width: 20, height: 20)
        let imagePoint = CGPoint(x: 8, y: 6)
        
        let accountImage = UIImageView(frame: CGRect(origin: imagePoint, size: imageSize))
        accountImage.image = UIImage(named: "account")
        container.addSubview(accountImage)
        
        
        self.accountField.uniform("请输入手机号").frame = CGRect(x: 36, y: 0, width: textFieldWidht, height: textFieldHeight)
        self.accountField.keyboardAppearance = .Dark
        
        
        
        let line1 = UIView(frame: CGRect(x: 0, y: accountField.bottom, width: container.width, height: 1))
        line1.backgroundColor = AppForegroundColor.colorWithAlphaComponent(0.3)
        
        
        let passwordImage = UIImageView(frame: CGRect(origin: CGPoint(x: imagePoint.x, y: line1.bottom + imagePoint.y), size: imageSize))
        passwordImage.image = UIImage(named: "lock")
        container.addSubview(passwordImage)
        
        self.passwordField.uniform("请输入密码")
            .frame = CGRect(x: 36, y: line1.bottom, width: textFieldWidht, height: textFieldHeight)
        self.passwordField.keyboardAppearance = .Dark
        
        accountField.becomeFirstResponder()
        
        self.container.addSubview(accountField)
        self.container.addSubview(line1)
        self.container.addSubview(passwordField)
//        self.container.addSubview(line2)

    }
    
    
    private func configForgetPasswordButton() {
        let point = CGPoint(x: container.right - 80, y: container.bottom + 12)
        let size = CGSize(width: 80, height: 30)
        
        forgetPasswordButton = UIButton(frame: CGRect(origin: point, size: size))
        forgetPasswordButton.titleLabel?.font = UIFont.systemFontOfSize(11)
        forgetPasswordButton.backgroundColor = UIColor.clearColor()

        forgetPasswordButton.setTitle("忘记密码", forState: UIControlState.Normal)
        forgetPasswordButton.setTitleColor(UIColor.aqua(), forState: UIControlState.Highlighted)
        
        self.view.addSubview(forgetPasswordButton)
    }
    
    
    
    
    private func configLoginButton() {
        let point = CGPoint(x: self.container.x, y: forgetPasswordButton.bottom + 4)
        let size = CGSize(width: container.width, height: textFieldHeight)
        
        self.loginButton = UIButton(frame: CGRect(origin: point, size: size))

        self.loginButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        self.loginButton.setTitle("登 录", forState: UIControlState.Normal)
        self.loginButton.setBackgroundImage(UIImage.imageWithColor(UIColor.lightAqua(), size: size), forState: UIControlState.Normal)
        
        self.loginButton.setBackgroundImage(UIImage.imageWithColor(UIColor.aqua(), size: size),forState: UIControlState.Highlighted)
            
        self.loginButton.layer.cornerRadius = 3
        self.loginButton.clipsToBounds = true
        
        loginButton.addTarget(self, action: "didClickLoginButton:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(self.loginButton)
        
    }
    
    
    //MARK:- Actions
    
    
    func didClickLeftButton(sender: UIButton) {
        if let navi = self.navigationController {
            navi.popViewControllerAnimated(true)
        } else {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    
    func didClickLoginButton(sender: UIButton) {
        do {
            try self.delegate?.checkValidation(account: self.accountField.text, password: self.passwordField.text)
            
            self.delegate?.didClickLoginButton(account: self.accountField.text!, password: self.passwordField.text!) {
                self.navigationController?.pushViewController(self.delegate!.getRootViewController(), animated: false)
            }
            
        } catch _ {
            Logger.debug("error")
            OCTAlertPopView.pop("格式错误")
        }
        
    }
    
    
}


private extension UITextField {
    func uniform(placeHolder: String = "") -> UITextField {
        self.backgroundColor = AppLightBackgroundColor
        self.textColor = AppForegroundColor
        self.font = UIFont.systemFontOfSize(12)
        self.attributedPlaceholder  = NSAttributedString(string: placeHolder, attributes: [NSForegroundColorAttributeName: AppLightForegroundColor.colorWithAlphaComponent(0.7)])
        
        return self
    }
}








