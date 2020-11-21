//
//  CachedOptions.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/19/20.
//

import Foundation


class CachedOptions: NSObject, NSCoding {
    
    var region: String
    var state: String
    var searchCriteria: String
    
    
    init(region: String, state: String, searchCriteria: String) {
        self.region = region
        self.state = state
        self.searchCriteria = searchCriteria
        
    }
    
    
    required init(coder aDecoder: NSCoder) {
        region = aDecoder.decodeObject(forKey: CachedOptions.cachedRegionKey) as? String ?? ""
        state = aDecoder.decodeObject(forKey: CachedOptions.cachedStateKey) as? String ?? ""
        searchCriteria = aDecoder.decodeObject(forKey: CachedOptions.cachedSearchCriteriaKey) as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(region, forKey: CachedOptions.cachedRegionKey)
        aCoder.encode(state, forKey: CachedOptions.cachedStateKey)
        aCoder.encode(searchCriteria, forKey: CachedOptions.cachedSearchCriteriaKey)
    }
    
    
    static var cachedOptionsKey = "cachedOptions"
    static var cachedRegionKey = "region"
    static var cachedStateKey = "state"
    static var cachedSearchCriteriaKey = "searchCriteria"
    
}
