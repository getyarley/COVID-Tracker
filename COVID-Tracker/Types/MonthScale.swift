//
//  MonthScale.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/15/20.
//

import Foundation


struct MonthScale {
    
    var scale: [String]
    
    init(scale: [String]) {
        self.scale = scale
    }
    
    
    static func getMonthScale(firstMonth: Int, lastMonth: Int) -> MonthScale {
        var scale = MonthScale(scale: [])
        
        let first = MonthScale.getMonth(from: firstMonth)
        let last = MonthScale.getMonth(from: lastMonth)
        let delta = last - first
        
        if delta < 8 {
            let increment = 2
            var multiplier = 0
            while scale.scale.count < 4 {
                let monthValue = last - increment * multiplier
                scale.scale.append(Constants.months[monthValue] ?? "")
                multiplier += 1
            }
            
            return scale
        } else {
            let increment = 3
            var multiplier = 0
            while scale.scale.count < 4 {
                let monthValue = last - increment * multiplier
                scale.scale.append(Constants.months[monthValue] ?? "")
                multiplier += 1
            }
            
            return scale
        }
    }
    
    
    static func getMonth(from date: Int) -> Int {
        let digits = date.digits
        let monthDigits = String(digits[4]) + String(digits[5])
        let month = Int(monthDigits) ?? 0
        return month
    }
    
}
