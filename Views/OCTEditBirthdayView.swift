//
//  OCTEditBirthdayView.swift
//  ZhaiClans
//
//  Created by yuhan zhang on 2/4/16.
//  Copyright © 2016 Octopus. All rights reserved.
//

import UIKit

protocol OCTDatePickerDelegate: NSObjectProtocol {
    func datePickerValueChanged(picker: UIDatePicker)
}


class OCTEditBirthdayView: UIView {
    
    var date: NSDate {
        return picker.date
    }
    
    var ageKey: UILabel!
    var ageValue: UILabel!
    
    var constellationKey: UILabel!
    var constellationValue: UILabel!
    
    
    var picker: UIDatePicker!
    weak var delegate: OCTDatePickerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = AppBackgroundColor
        
        configTopContainer()
        configPickerView()
    }
    
    
    private func configTopContainer() {
        let container = UIView(frame: CGRect(x: 0, y: 64, width: OCTScreenWidth, height: 72))
        container.backgroundColor = AppLightBackgroundColor
        
        
        func uniform(label: UILabel) {
            label.backgroundColor = UIColor.clearColor()
            label.font = UIFont.systemFontOfSize(13)
        }
        
        let labelSize = CGSize(width: 80, height: 36)
        
        ageKey = UILabel(frame: CGRect(x: 15, y: 0, width: labelSize.width, height: labelSize.height))
        ageValue = UILabel(frame: CGRect(x: OCTScreenWidth - 100, y: ageKey.y, width: 80, height: 36))
        
        ageKey.textColor = UIColor.whiteColor()
        ageValue.textColor = AppLightForegroundColor
        
        ageKey.textAlignment = .Left
        ageValue.textAlignment = .Right
        
        ageKey.text = "年龄"
//        ageValue.text = "26岁"
        
        uniform(ageKey)
        uniform(ageValue)
        
        
        constellationKey = UILabel(frame: CGRect(x: ageKey.x, y: 36, width: 80, height: 36))
        constellationValue = UILabel(frame: CGRect(x: ageValue.x, y: constellationKey.y, width: 80, height: 36))
        
        constellationKey.textColor = UIColor.whiteColor()
        constellationValue.textColor = AppLightForegroundColor
        
        constellationKey.textAlignment = .Left
        constellationValue.textAlignment = .Right
        
        constellationKey.text = "星座"
//        constellationValue.text = "白羊座"
        
        uniform(constellationKey)
        uniform(constellationValue)
        
        container.addSubview(ageKey)
        container.addSubview(ageValue)
        container.addSubview(constellationKey)
        container.addSubview(constellationValue)
        
        let line = UIView(frame: CGRect(x: 15, y: 36, width: container.width - 30, height: 1))
        line.backgroundColor = AppForegroundColor.colorWithAlphaComponent(0.3)
        container.addSubview(line)
        
        self.addSubview(container)
        
    }
    
    
    private func configPickerView() {
        picker = UIDatePicker()
        picker.frame.origin = CGPoint(x: 0, y: self.height - picker.height)
        picker.frame.size = CGSize(width: self.width, height: picker.height)
        picker.datePickerMode = .Date
        picker.backgroundColor = UIColor(r: 100, g: 100, b: 100, a: 1) //.colorWithAlphaComponent(0.5)

        picker.addTarget(self, action: "pickerViewValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        pickerViewValueChanged(picker)
        self.addSubview(picker)
        
        let label = UILabel(frame: CGRect(x: 0, y: picker.y - 36, width: self.width, height: 32))
        label.textColor = AppLightForegroundColor
        label.font = UIFont.systemFontOfSize(12)
        label.textAlignment = .Center
        label.text = "选择出生日期，系统将会自动转换为年龄和星座"
        
        self.addSubview(label)
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func pickerViewValueChanged(picker: UIDatePicker) {
        let birthday = OCTBirthday(date: picker.date)
        ageValue.text = "\(birthday.age)岁"
        constellationValue.text = birthday.constellation.rawValue
        
        self.delegate?.datePickerValueChanged(picker)
    }
    
    
    
}














