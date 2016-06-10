//
//  EnrollProtocol.swift
//  ZhaiClans
//
//  Created by yuhan zhang on 1/21/16.
//  Copyright © 2016 Octopus. All rights reserved.
//

import UIKit

protocol OCTEnrollable: NSObjectProtocol {
    func checkValidation(account account: String?, password: String?) throws
    
    func didClickSignupButton(account account: String, password: String, completion: (()->Void)?)
    func didClickLoginButton(account account: String, password: String, completion: (()->Void)?)
    func getRootViewController() -> UIViewController
    func logout()
}


extension OCTEnrollable {
    
    func checkValidation(account account: String?, password: String?) throws {
        guard let a = account else {
            throw OCTEnrollError.NoAccount
        }
        
        guard let p = password else {
            throw OCTEnrollError.NoPassword
        }
        
        guard a.characters.count > 6 else {
            throw OCTEnrollError.AccountTooShort
        }
        
        guard p.characters.count > 6 else {
            throw OCTEnrollError.PasswordTooShort
        }
    }
}


enum OCTEnrollError: ErrorType {
    case NoAccount
    case NoPassword
    case AccountTooShort
    case PasswordTooShort
    case AccountWithUnknownCharacter
    case PasswordWithUnknownCharacter
}


