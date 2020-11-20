//
//  Store.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/10/20.
//

import Foundation
import SwiftUI

final class CaseStore: ObservableObject {
    
    //Selection vars
    @Published var region: Region = .states
    @Published var state: SelectedState = .ny
    @Published var dataFrequency: DataFrequency = .daily
    @Published var searchCriteria: DataCriteria = .positiveIncrease
    
    //Data vars
//    @Published var currentCases: COVIDResults?
    @Published var dailyCases: [COVIDResults] = [COVIDResults](repeating: COVIDResults.emptyCases, count: 250)
    @Published var rawData = [Double](repeating: 0, count: 300)
    @Published var lastUpdated: String = ""
    @Published var loading: Bool = true
    
    @Published var caseScale: CaseScale = CaseScale(scale: [])
    @Published var monthScale: MonthScale = MonthScale(scale: [])
    @Published var geometryScalar: Double = 0.0
    
    
    init() {
        loadUserDefaults()
    }
    
    
    func loadUserDefaults() {
        let defaults = UserDefaults.standard

        if let cachedOptions = defaults.object(forKey: CachedOptions.cachedOptionsKey) as? Data {
            if let decodedOptions = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(cachedOptions) as? CachedOptions {
                self.region = Region(rawValue: decodedOptions.region) ?? .us
                self.state = SelectedState(rawValue: decodedOptions.state) ?? .ny
                self.searchCriteria = DataCriteria(rawValue: decodedOptions.searchCriteria) ?? .positive
                loadJSONData()
            }
        }
    }
    
    
    func saveOptions() {
        let currentOptions = CachedOptions(region: self.region.rawValue, state: self.state.rawValue, searchCriteria: self.searchCriteria.rawValue)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: currentOptions, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: CachedOptions.cachedOptionsKey)
        }
    }
    
    
    
    func loadJSONData() {
        DataLoader.loadData(region: self.region, state: self.state, dataFrequency: self.dataFrequency) { (data) in
            guard let loadedData = data else {
                print("ERROR: JSON Data loading error")
                //MARK: Display error
                self.loading = false
                return
            }
            
//            if self.region == .states, self.dataFrequency == .current {
//                self.parseCurrentStateJSON(loadedData)
//            } else {
                self.parseJSONData(loadedData)
//            }
        }
    }
    
    
    func parseJSONData(_ data: Data) {
        let decoder = JSONDecoder()
        
        do {
            let loadedData = try decoder.decode([COVIDResults].self, from: data)
                        
//            if dataFrequency == .daily {
                DispatchQueue.main.async {
                    self.dailyCases = loadedData
                    self.lastUpdated = COVIDResults.dateConverter(from: loadedData.first?.dateChecked)
                    self.monthScale = MonthScale.getMonthScale(firstMonth: self.dailyCases[self.dailyCases.count - 1].date, lastMonth: self.dailyCases[0].date)
                    self.transferValues()
                }
//            } else {
//                DispatchQueue.main.async {
//                    self.currentCases = loadedData[0]
//                    //MARK: Update lastUpdated value
//                    self.loading = false
//                }
//            }
            
        } catch {
            print("ERROR: Failure to decode JSON data")
        }
    }
    
    
    func transferValues() {
        self.rawData = [Double](repeating: 0, count: self.dailyCases.count)
        
        switch searchCriteria {
        case .death:
            for index in 0..<rawData.count {
                rawData[index] = Double(dailyCases[dailyCases.count - 1 - index].death ?? 0)
            }
        
        case .deathIncrease:
            for index in 0..<rawData.count {
                rawData[index] = Double(dailyCases[dailyCases.count - 1 - index].deathIncrease ?? 0)
            }
        
        case .hospitalizedIncrease:
            for index in 0..<rawData.count {
                rawData[index] = Double(dailyCases[dailyCases.count - 1 - index].hospitalizedIncrease ?? 0)
            }
            
        case .negative:
            for index in 0..<rawData.count {
                rawData[index] = Double(dailyCases[dailyCases.count - 1 - index].negative ?? 0)
            }
            
        case .negativeIncrease:
            for index in 0..<rawData.count {
                rawData[index] = Double(dailyCases[dailyCases.count - 1 - index].negativeIncrease ?? 0)
            }
            
        case .positive:
            for index in 0..<rawData.count {
                rawData[index] = Double(dailyCases[dailyCases.count - 1 - index].positive ?? 0)
            }
            
        case .positiveIncrease:
            for index in 0..<rawData.count {
                rawData[index] = Double(dailyCases[dailyCases.count - 1 - index].positiveIncrease ?? 0)
            }
        }
        
        self.caseScale = CaseScale.getCaseScale(maxValue: rawData.max() ?? 1000)
        self.geometryScalar = (rawData.max() ?? 1000.0) / Double(self.caseScale.scale.last ?? 1000)
        self.loading = false
    }
    
    
    
//    func parseCurrentStateJSON(_ data: Data) { //API data for current state data isn't in an array
//        let decoder = JSONDecoder()
//
//        do {
//            let loadedData = try decoder.decode(COVIDResults.self, from: data)
//
//            DispatchQueue.main.async {
//                self.currentCases = loadedData
//            }
//        } catch {
//            print("ERROR: Failure to decide Current State JSON data")
//        }
//    }
    
}

