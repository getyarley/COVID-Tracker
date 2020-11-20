//
//  Results.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/9/20.
//

import Foundation

struct COVIDResults: Codable {
    
    var date: Int
    var positive: Int?
    var negative: Int?
    var pending: Int?
    var hospitalizedCurrently: Int?
    var hospitalizedCumulative: Int?
    var death: Int?
    var totalTestResults: Int?
    var deathIncrease: Int?
    var hospitalizedIncrease: Int?
    var negativeIncrease: Int?
    var positiveIncrease: Int?
    var hash: String
    var dateChecked: String?
    
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case positive = "positive"
        case negative = "negative"
        case pending = "pending"
        case hospitalizedCurrently = "hospitalizedCurrently"
        case hospitalizedCumulative = "hospitalizedCumulative"
        case death = "death"
        case totalTestResults = "totalTestResults"
        case deathIncrease = "deathIncrease"
        case hospitalizedIncrease = "hospitalizedIncrease"
        case negativeIncrease = "negativeIncrease"
        case positiveIncrease = "positiveIncrease"
        case hash = "hash"
        case dateChecked = "dateChecked"
    }
    
    
    static var emptyCases = COVIDResults(date: 0, positive: 0, negative: 0, pending: 0, hospitalizedCurrently: 0, hospitalizedCumulative: 0, death: 0, totalTestResults: 0, deathIncrease: 0, hospitalizedIncrease: 0, negativeIncrease: 0, positiveIncrease: 0, hash: "", dateChecked: "")
    
    
    static func dateConverter(from date: String?) -> String {
        guard let date = date else {
            return "Today"
        }
        
        let checkedDate = COVIDResults.checkForMidnight(from: date) //Convert from 24:00 midnight format
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SSS'Z'"
        guard let formattedDate = dateFormatter.date(from: checkedDate) else {
            return "ERROR"
        }

        let shortFormatter = DateFormatter()
        shortFormatter.dateFormat = "MMM d, yyyy 'at' hh:mm a"
                
        return shortFormatter.string(from: formattedDate)
    }
    
    
    static func checkForMidnight(from value: String) -> String {
        var stringArr = Array(value)
        
        if stringArr[11] == "2" && stringArr[12] == "4" {
            stringArr[11] = "0"
            stringArr[12] = "0"
            
            var newValue = ""
            for val in 0..<stringArr.count {
                newValue += String(stringArr[val])
            }
            return newValue
        } else {
            return value
        }
    }
    
}

