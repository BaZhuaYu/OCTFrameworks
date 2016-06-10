//
//  Signup.swift
//  ZhaiClans
//
//  Created by yuhan zhang on 1/20/16.
//  Copyright © 2016 Octopus. All rights reserved.
//

import UIKit


class OCTSignupViewController: UIViewController, OCTTopBarViewDelegate {
    
    var accountField: UITextField!
    var passwordField: UITextField!
    var authCodeField: UITextField!
    
    
    var container: UIView!
    
    
    var authButton: UIButton!
    var signupButton: UIButton!
    
    weak var delegate: OCTEnrollable?
    
    override func viewDidLoad() {

        self.configBackground()
        self.configTopBar()
        self.configContainer()
        self.configTextFields()
        self.configSignupButton()

    }    
    
    
    //MARK:- Configutarions
    
    
    private func configBackground() {
        self.view.backgroundColor = AppBackgroundColor
    }
    
    
    private func configTopBar() {
        let topBar = OCTTopBarView(style: TopBarStyle.Dark).configTitleLabel("注册").configLeftButton()
        topBar.delegate = self
        self.view.addSubview(topBar)
    }
    
    
    private func configContainer() {
        let offset = 8 as CGFloat
        self.container = UIView(frame: CGRect(x: offset, y: 64 + offset, width: OCTScreenWidth - 2*offset, height: textFieldHeight * 3 + 2))
        
        self.container.backgroundColor = AppLightBackgroundColor
        self.container.layer.cornerRadius = 3
        self.container.clipsToBounds = true
        self.view.addSubview(container)
    }
    
    
    let textFieldWidht = OCTScreenWidth - 44
    let textFieldHeight = 32 as CGFloat
    
    private func configTextFields() {
        self.accountField = UITextField()
        self.passwordField = UITextField()
        self.authCodeField = UITextField()
        
        
        let imageSize = CGSize(width: 20, height: 20)
        let imagePoint = CGPoint(x: 8, y: 6)
        let imageFrame = CGRect(origin: imagePoint, size: imageSize)
        
        let accountImage = UIImageView(frame: CGRect(origin: imagePoint, size: imageSize))
        accountImage.image = UIImage(named: "account")

        
        
        self.accountField.uniform("请输入手机号").frame = CGRect(x: 36, y: 0, width: textFieldWidht - 120, height: textFieldHeight)

        

        self.authButton = UIButton(frame: CGRect(x: self.accountField.right, y: 0, width: 120, height: self.accountField.height))
        self.authButton.setTitleColor(UIColor.lightAqua(), forState: UIControlState.Normal)
        self.authButton.setTitleColor(AppForegroundColor, forState: UIControlState.Disabled)
        self.authButton.setTitle("获取验证码", forState: UIControlState.Normal)
        self.authButton.titleLabel?.textAlignment = .Center
        self.authButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        self.authButton.backgroundColor = UIColor.clearColor()
        self.authButton.addTarget(self, action: "didClickAuthButton", forControlEvents: UIControlEvents.TouchUpInside)

        
        
        let line1 = UIView(frame: CGRect(x: 0, y: accountField.bottom, width: container.width, height: 1))
        line1.backgroundColor = AppSeparatorLineColor


        let passwordImage = UIImageView(frame: CGRect(origin: CGPoint(x: imagePoint.x, y: line1.bottom + imagePoint.y), size: imageSize))
        passwordImage.image = UIImage(named: "lock")

        self.passwordField.uniform("请输入密码")
                        .frame = CGRect(x: 36, y: line1.bottom, width: textFieldWidht, height: textFieldHeight)

        
        
        let line2 = UIView(frame: CGRect(x: 0, y: passwordField.bottom, width: line1.width, height: 1))
        line2.backgroundColor = AppSeparatorLineColor
        
        
        let authCodeImage = UIImageView(frame: CGRect(origin: CGPoint(x: imagePoint.x, y: line2.bottom + imagePoint.y), size: imageSize))
        authCodeImage.image = UIImage(named: "authcode")

        
        self.authCodeField.uniform("请输入验证码")
                    .frame = CGRect(x: 36, y: line2.bottom, width: self.accountField.width, height: textFieldHeight)

        
        accountField.becomeFirstResponder()


        
        container.addSubview(accountImage)
        container.addSubview(passwordImage)
        container.addSubview(authCodeImage)

        
        self.container.addSubview(accountField)
        self.container.addSubview(line1)
        self.container.addSubview(passwordField)
        self.container.addSubview(line2)
        self.container.addSubview(authCodeField)
        
        self.container.addSubview(self.authButton)
    }
    
    
    private func configSignupButton() {
        let point = CGPoint(x: container.x, y: container.bottom + 12)
        let size = CGSize(width: container.width, height: accountField.height)

        self.signupButton = UIButton(frame: CGRect(origin: point, size: size))
        
        self.signupButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        self.signupButton.setTitle("注 册", forState: UIControlState.Normal)
        self.signupButton.setBackgroundImage(UIImage.imageWithColor(UIColor.lightAqua(), size: size), forState: UIControlState.Normal)
        
        self.signupButton.setBackgroundImage(UIImage.imageWithColor(UIColor.aqua(), size: size),forState: UIControlState.Highlighted)
        
        self.signupButton.layer.cornerRadius = 5
        self.signupButton.clipsToBounds = true
        
        self.signupButton.addTarget(self, action: "didClickSignupButton:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(self.signupButton)
        
    }
    
    
    //MARK:- Actions
    
    var timer: NSTimer?
    var timeCountDown = 30
    
    func didClickAuthButton() {
        guard let phone = self.accountField.text where phone.characters.count == 11
        else {
            OCTAlertPopView.pop("请输入11位电话号码")
            return
        }
        
        
        SMS_SDK.getVerificationCodeBySMSWithPhone(phone, zone: "86") { (SMS_SDKError) -> Void in
            guard SMS_SDKError == nil else {
                Logger.debug("\(SMS_SDKError)")
                return
            }
            
            OCTAlertPopView.pop("验证码发送成功")
            self.authButton.setTitle("\(self.timeCountDown)秒后重新发送", forState: UIControlState.Disabled)
            self.authButton.enabled = false
            self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "countDown", userInfo: nil, repeats: true)
        }
        
    }
    
    
    func countDown() {
        guard self.timeCountDown > 0 else {
            self.timeCountDown = 30
            self.authButton.enabled = true
            self.timer?.invalidate()
            return
        }
        
        self.authButton.setTitle("\(timeCountDown--)秒后重新发送", forState: UIControlState.Disabled)
        
    }
    
    
    func didClickSignupButton(sender: UIButton) {
        do {
            try self.delegate?.checkValidation(account: self.accountField.text, password: self.passwordField.text)
            
            self.delegate?.didClickSignupButton(account: self.accountField.text!, password: self.passwordField.text!, completion: { [unowned self] () -> Void in
                self.navigationController?.pushViewController(self.delegate!.getRootViewController(), animated: false)
            })
            
        } catch _ {
            Logger.debug("error")
            OCTAlertPopView.pop("账号密码格式错误")
        }
        
    }
}


private extension UITextField {
    func uniform(placeHolder: String = "") -> UITextField {
        self.backgroundColor = AppLightBackgroundColor
        self.textColor = AppForegroundColor
        self.keyboardAppearance = .Dark
        self.font = UIFont.systemFontOfSize(12)
        self.attributedPlaceholder  = NSAttributedString(string: placeHolder, attributes: [NSForegroundColorAttributeName: AppForegroundColor.colorWithAlphaComponent(0.7)])
        
        return self
    }
    
}

