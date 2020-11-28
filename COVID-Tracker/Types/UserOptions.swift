//
//  UserOptions.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/26/20.
//

import Foundation


struct UserOptions {
    
    var region: Region
    var state: SelectedState
    var searchCriteria: DataCriteria
    
}


extension UserOptions {
    
    init() {
        region = .us
        state = .ny
        searchCriteria = .positiveIncrease
    }
    
}
