//
//  WidgetManager.swift
//  COVID ChartExtension
//
//  Created by Jeremy Yarley on 11/26/20.
//

import Foundation
import SwiftUI


class WidgetManager {
    
    func fetchData(region: Region, state: SelectedState, searchCriteria: DataCriteria, completion: @escaping ((PlotDataPackage) -> Void)) {
        self.loadJSONData(region: region, state: state) { (data) in
            self.parseJSONData(data: data) { (results) in
                self.populatePlotDataPackage(results: results, searchCriteria: searchCriteria) { (dataPackage) in
                    completion(dataPackage)
                } //populatePlotDataPackage
            } //parseJSONData
        } //loadJSONData
    }
    
    
    func loadUserDefaults(completion: @escaping ((UserOptions) -> Void)) {
        guard let defaults = UserDefaults(suiteName: Constants.userDefaultsIdentifier) else {
            print("Suitename not found")
            return
        }
        NSKeyedUnarchiver.setClass(CachedOptions.self, forClassName: "CachedOptions")
        
        if let cachedOptions = defaults.object(forKey: CachedOptions.cachedOptionsKey) as? Data {
            if let decodedOptions = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(cachedOptions) as? CachedOptions {
                let region = Region(rawValue: decodedOptions.region) ?? .us
                let state = SelectedState(rawValue: decodedOptions.state) ?? .ny
                let searchCriteria = DataCriteria(rawValue: decodedOptions.searchCriteria) ?? .positiveIncrease
                completion(UserOptions(region: region, state: state, searchCriteria: searchCriteria))
            } else {
                print("Something failed 1")
            }
        } else {
            print("Something failed 2")
        }
        
    }
    
    
    
    func loadJSONData(region: Region, state: SelectedState, completion: @escaping ((Data) -> Void)) {
        DataLoader.loadData(region: region, state: state, dataFrequency: .daily) { (data) in
            guard let loadedData = data else {
                print("ERROR: JSON Data Loading Error")
                return
            }
            completion(loadedData)
        }
    }
    
    
    func parseJSONData(data: Data, completion: @escaping (([COVIDResults]) -> Void)) {
        let decoder = JSONDecoder()
        
        do {
            let loadedData = try decoder.decode([COVIDResults].self, from: data)
            completion(loadedData)
        } catch {
            print("ERROR: Failure to decode JSON data")
            return
        }
    }
    
    
    func populatePlotDataPackage(results: [COVIDResults], searchCriteria: DataCriteria, completion: @escaping ((PlotDataPackage) -> Void)) {
        self.getRawData(from: results, for: searchCriteria) { (rawData) in
            let maxValue = rawData.max() ?? 1000.0
            let caseScale = CaseScale.getCaseScale(maxValue: maxValue)
            let geometryScalar = maxValue / Double(caseScale.scale.last ?? 1000)
            let dateUpdated = COVIDResults.dateConverter(from: results.first?.dateChecked)
            let monthScale = MonthScale.getMonthScale(firstMonth: results[results.count - 1].date, lastMonth: results[0].date)
            
            let plotDataPackage = PlotDataPackage(rawData: rawData, caseScale: caseScale, monthScale: monthScale, dateUpdated: dateUpdated, geometryScalar: geometryScalar)
            completion(plotDataPackage)
        }
    }
    
    
    func getRawData(from results: [COVIDResults], for criteria: DataCriteria, completion: @escaping (([Double]) -> Void)) {
        var rawData = [Double](repeating: 0, count: results.count)
        
        switch criteria {
        case .death:
            for index in 0..<rawData.count {
                rawData[index] = Double(results[results.count - 1 - index].death ?? 0)
            }
        
        case .deathIncrease:
            for index in 0..<rawData.count {
                rawData[index] = Double(results[results.count - 1 - index].deathIncrease ?? 0)
            }
        
        case .hospitalizedIncrease:
            for index in 0..<rawData.count {
                rawData[index] = Double(results[results.count - 1 - index].hospitalizedIncrease ?? 0)
            }
            
        case .negative:
            for index in 0..<rawData.count {
                rawData[index] = Double(results[results.count - 1 - index].negative ?? 0)
            }
            
        case .negativeIncrease:
            for index in 0..<rawData.count {
                rawData[index] = Double(results[results.count - 1 - index].negativeIncrease ?? 0)
            }
            
        case .positive:
            for index in 0..<rawData.count {
                rawData[index] = Double(results[results.count - 1 - index].positive ?? 0)
            }
            
        case .positiveIncrease:
            for index in 0..<rawData.count {
                rawData[index] = Double(results[results.count - 1 - index].positiveIncrease ?? 0)
            }
        }
        
        completion(rawData)
    }
    
    
}
