//
//  OCTBirthday.swift
//  ZhaiClans
//
//  Created by yuhan zhang on 2/28/16.
//  Copyright © 2016 Octopus. All rights reserved.
//

import Foundation

enum OCTConstellation: String {
    case Capricorn = "魔羯座"
    case Aquarius = "水平座"
    case Pisces = "双鱼座"
    case Aries = "白羊座"
    case Taurus = "金牛座"
    case Gemini = "双子座"
    case Cancer = "巨蟹座"
    case Leo = "狮子座"
    case Virgo = "处女座"
    case Libra = "天枰座"
    case Scorpio = "天蝎座"
    case Sagittarius = "射手座"
}

class OCTBirthday: NSObject {
    
    var age: Int!
    var constellation: OCTConstellation!
    
    init(date: NSDate) {
        super.init()
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond], fromDate: date)
        
        let year = components.year
        let month = components.month
        let day = components.day
        
        self.age = calculateAge(year, month: month, day: day)
        self.constellation = calculateConstellation(month, day: day)
        
    }
    
    
    func calculateAge(year: Int, month: Int, day: Int) -> Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year], fromDate: NSDate())
        
        let curYear = components.year
        let curMonth = components.month
        let curDay = components.day
        
        var age = curYear - year
        
        if curMonth < month {
            age--
        } else if curDay < day {
            age--
        }
        
        return max(age,0)
        
    }
    
    
    func calculateConstellation(month: Int, day: Int) -> OCTConstellation {
        
        var constellation: OCTConstellation
        if (month == 12 && day >= 22) || (month == 1 && day <= 19){
            constellation = .Capricorn
        } else if (month == 1 && day >= 20) || (month == 2 && day <= 18) {
            constellation = .Aquarius
        } else if (month == 2 && day >= 19) || (month == 3 && day <= 20) {
            constellation = .Pisces
        } else if (month == 3 && day >= 21) || (month == 4 && day <= 19) {
            constellation = .Aries
        } else if (month == 4 && day >= 20) || (month == 5 && day <= 20) {
            constellation = .Taurus
        } else if (month == 5 && day >= 21) || (month == 6 && day <= 21) {
            constellation = .Gemini
        } else if (month == 6 && day >= 22) || (month == 7 && day <= 22) {
            constellation = .Cancer
        } else if (month == 7 && day >= 23) || (month == 8 && day <= 22) {
            constellation = .Leo
        } else if (month == 8 && day >= 23) || (month == 9 && day <= 22) {
            constellation = .Virgo
        } else if (month == 9 && day >= 23) || (month == 10 && day <= 23) {
            constellation = .Libra
        } else if (month == 10 && day >= 24) || (month == 11 && day <= 21) {
            constellation = .Scorpio
        } else {
            constellation = .Sagittarius
        }
        
        return constellation
    }
    
    
    
}