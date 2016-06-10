//
//  OCTEditInfoTextField.swift
//  ZhaiClans
//
//  Created by yuhan zhang on 2/4/16.
//  Copyright © 2016 Octopus. All rights reserved.
//

import UIKit

class OCTEditInfoTextFieldView: UITextField {
    
    init(delegate: UITextFieldDelegate) {
        super.init(frame: CGRect(x: 4, y: 68, width: OCTScreenWidth - 8, height: 80))
        
        self.becomeFirstResponder()

        self.returnKeyType = .Done
        self.backgroundColor = AppLightBackgroundColor
        self.textColor = AppLightForegroundColor
        self.delegate = delegate
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
