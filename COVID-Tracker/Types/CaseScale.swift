//
//  CaseScale.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/14/20.
//

import Foundation


struct CaseScale {
    
    var scale: [Int]
    
    
    init(scale: [Int]) {
        self.scale = scale
    }
    
    
    static func getCaseScale(maxValue: Double) -> CaseScale {
        var scale = CaseScale(scale:[])
        
        if maxValue > 18000 {
            let multiplier = Int(maxValue / 5000)
            let maxScaleValue = (multiplier + 1) * 5000
            
            scale.scale.append(0)
            scale.scale.append(maxScaleValue/4)
            scale.scale.append(maxScaleValue/2)
            scale.scale.append(maxScaleValue*3/4)
            scale.scale.append(maxScaleValue)
            return scale
        } else if maxValue < 2000 {
            var multiplier = 1
            while multiplier * 100 <= Int(maxValue) {
                multiplier += 1
            }
            
            let maxScaleValue = multiplier * 100
            
            if maxScaleValue % 300 == 0 {
                //Divide by 3
                scale.scale.append(0)
                scale.scale.append(maxScaleValue/3)
                scale.scale.append(maxScaleValue*2/3)
                scale.scale.append(maxScaleValue)
                return scale
            } else {
                scale.scale.append(0)
                scale.scale.append(maxScaleValue/4)
                scale.scale.append(maxScaleValue/2)
                scale.scale.append(maxScaleValue*3/4)
                scale.scale.append(maxScaleValue)
                return scale
            }
            
        } else {
            var multiplier = 1
            while multiplier * 1000 <= Int(maxValue) {
                multiplier += 1
            }
            
            let maxScaleValue = multiplier * 1000
            
            if maxScaleValue % 3000 == 0 {
                //Divide by 3
                scale.scale.append(0)
                scale.scale.append(maxScaleValue/3)
                scale.scale.append(maxScaleValue*2/3)
                scale.scale.append(maxScaleValue)
                return scale
            } else {
                scale.scale.append(0)
                scale.scale.append(maxScaleValue/4)
                scale.scale.append(maxScaleValue/2)
                scale.scale.append(maxScaleValue*3/4)
                scale.scale.append(maxScaleValue)
                return scale
            }
        }
    }
    
    
}
