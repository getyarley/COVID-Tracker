//
//  Store.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/10/20.
//

import Foundation
import SwiftUI
import WidgetKit

final class CaseStore: ObservableObject {
    
    //Selection vars
    @Published var region: Region = .states
    @Published var state: SelectedState = .ny
    @Published var dataFrequency: DataFrequency = .daily
    @Published var searchCriteria: DataCriteria = .positiveIncrease
    
    //Data vars
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
        guard let defaults = UserDefaults(suiteName: Constants.userDefaultsIdentifier) else {
            print("Defaults not found on load")
            return
        }
        NSKeyedUnarchiver.setClass(CachedOptions.self, forClassName: "CachedOptions")

        if let cachedOptions = defaults.object(forKey: CachedOptions.cachedOptionsKey) as? Data {
            if let decodedOptions = try?
                NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(cachedOptions) as? CachedOptions {
                self.region = Region(rawValue: decodedOptions.region) ?? .us
                self.state = SelectedState(rawValue: decodedOptions.state) ?? .ny
                self.searchCriteria = DataCriteria(rawValue: decodedOptions.searchCriteria) ?? .positive
                loadJSONData()
            }
        }
    }
    
    
    func saveOptions() {
        NSKeyedArchiver.setClassName("CachedOptions", for: CachedOptions.self)
        
        let currentOptions = CachedOptions(region: self.region.rawValue, state: self.state.rawValue, searchCriteria: self.searchCriteria.rawValue)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: currentOptions, requiringSecureCoding: false) {
            guard let defaults = UserDefaults(suiteName: Constants.userDefaultsIdentifier) else {
                print("Defaults not found on save")
                return
            }
            
            defaults.set(savedData, forKey: CachedOptions.cachedOptionsKey)
            WidgetCenter.shared.reloadAllTimelines()
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
            
            self.parseJSONData(loadedData)
        }
    }
    
    
    func parseJSONData(_ data: Data) {
        let decoder = JSONDecoder()
        
        do {
            let loadedData = try decoder.decode([COVIDResults].self, from: data)
                        
            DispatchQueue.main.async {
                self.dailyCases = loadedData
                self.lastUpdated = COVIDResults.dateConverter(from: loadedData.first?.dateChecked)
                self.monthScale = MonthScale.getMonthScale(firstMonth: self.dailyCases[self.dailyCases.count - 1].date, lastMonth: self.dailyCases[0].date)
                self.transferValues()
            }
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
}

