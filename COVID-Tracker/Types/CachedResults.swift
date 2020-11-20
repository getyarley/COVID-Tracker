//
//  CachedResults.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/18/20.
//

import Foundation


class CachedResults: NSObject, NSCoding {
    
    var dateChecked: String
    var rawData: [Int]
    
    
    init(dateChecked: String, rawData: [Int]) {
        self.dateChecked = dateChecked
        self.rawData = rawData
    }
    
    
    required init(coder aDecoder: NSCoder) {
        dateChecked = aDecoder.decodeObject(forKey: CachedResults.dateCheckedKey) as? String ?? ""
        rawData = aDecoder.decodeObject(forKey: CachedResults.rawDatakey) as? [Int] ?? [Int]()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(dateChecked, forKey: CachedResults.dateCheckedKey)
        aCoder.encode(rawData, forKey: CachedResults.rawDatakey)
    }
    
    
    static var cachedResultsKey = "cachedResults"
    static var rawDatakey = "rawData"
    static var dateCheckedKey = "dateChecked"
}

