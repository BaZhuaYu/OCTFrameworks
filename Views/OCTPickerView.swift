//
//  OCTPickerView.swift
//  ZhaiClans
//
//  Created by yuhan zhang on 1/25/16.
//  Copyright © 2016 Octopus. All rights reserved.
//

import UIKit


protocol OCTPickerViewDelegate: NSObjectProtocol {
    func didSelect(master master: String, detail: String)
    func didClickPickerViewLeftButton()
}


class OCTPickerView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var data: NSDictionary!
    
    var master: [String]!
    var detail: [String]!
    
    private var selectedMasterIndex = 0
    private var selectedDetailIndex = 0
    
    weak var delegate: OCTPickerViewDelegate!
    
    
    init(data: NSDictionary, delegate: OCTPickerViewDelegate) {
        
        super.init(frame: CGRect(x: 0, y: OCTScreenHeight, width: OCTScreenWidth, height: 216))
        
        
        let pickerView = UIPickerView(frame: CGRect(origin: CGPointZero, size: self.size))
        pickerView.backgroundColor = UIColor(r: 100, g: 100, b: 100, a: 1) 
        
        pickerView.delegate = self
        pickerView.dataSource = self
        self.delegate = delegate
        
        
        self.data = data
        self.master = data.allKeys as! [String]
        self.detail = data.objectForKey(master[0]) as! [String]

        
        self.backgroundColor = AppLightForegroundColor
        
        self.addSubview(pickerView)
        configButtons()
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configButtons() {
        let button = UIButton(frame: CGRect(x: 20, y: 10, width: 40, height: 30))
        button.backgroundColor = UIColor.clearColor()
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        button.setTitle("取消", forState: UIControlState.Normal)
        button.setTitleColor(AppLightBackgroundColor, forState: UIControlState.Normal)
        button.addTarget(self, action: "didClickLeftButton", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(button)
        
        let button2 = UIButton(frame: CGRect(x: self.width - 60, y: 10, width: 40, height: 30))
        button2.backgroundColor = UIColor.clearColor()
        button2.titleLabel?.font = UIFont.systemFontOfSize(14)
        button2.setTitle("确定", forState: UIControlState.Normal)
        button2.setTitleColor(AppLightBackgroundColor, forState: UIControlState.Normal)
        button2.addTarget(self, action: "didClickRightButton", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(button2)
        
    }
    
    
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        self.showFromBottom(true)
    }
    
    
    
    func didClickLeftButton() {
        self.showFromBottom(false)
        self.delegate.didClickPickerViewLeftButton()
    }
    
    
    func didClickRightButton() {
        self.delegate.didSelect(master: master[selectedMasterIndex], detail: detail[selectedDetailIndex])
        didClickLeftButton()
    }
    
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return master.count
        } else if component == 1 {
            return detail.count
        } else {
            return 0
        }
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            self.detail = data.objectForKey(master[row]) as! [String]
            self.selectedMasterIndex = row
            pickerView.reloadComponent(1)
        } else if component == 1 {
            self.selectedDetailIndex = row
        }
    }
    
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {

        let attributes = [NSForegroundColorAttributeName : AppBackgroundColor, NSFontAttributeName: UIFont.systemFontOfSize(14)]
        
        if component == 0 {
            return NSAttributedString(string: master[row], attributes: attributes)
        } else if component == 1 {
            return NSAttributedString(string: detail[row], attributes: attributes)
        }
        return nil
    }
    
    
}










