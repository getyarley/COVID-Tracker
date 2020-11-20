//
//  DataLoader.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/9/20.
//

import Foundation


class DataLoader {
    
    //URL Builder
    static func buildURLFromType(region: Region, state: SelectedState?, dataFrequency: DataFrequency) -> String {
        let domain = "https://api.covidtracking.com"
        let version = "/v1/"
        let caboose = ".json"
        
        if region == .us {
            return domain + version + region.rawValue + "/" + dataFrequency.rawValue + caboose //National data
        } else if let state = state {
            return domain + version + region.rawValue + "/" + state.rawValue.lowercased() + "/" + dataFrequency.rawValue + caboose  //State data
        } else {
            return "ERROR"
        }
    }
    
    
    static func loadData(region: Region, state: SelectedState?, dataFrequency: DataFrequency, success: @escaping (_ data: Data?) -> Void) {
        let urlString = buildURLFromType(region: region, state: state, dataFrequency: dataFrequency)
        
        guard let url = URL(string: urlString) else {
            print("URL not valid")
            success(nil)
            return
        }
                
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: url) {
                success(data)
            } else {
                print("ERROR: Unable to get data")
                success(nil)
            }
        }
    }
    
    
    
    
}
