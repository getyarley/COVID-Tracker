//
//  PlotDataPackage.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/26/20.
//

import Foundation

struct PlotDataPackage {
    var rawData: [Double]
    var caseScale: CaseScale
    var monthScale: MonthScale
    var dateUpdated: String
    var geometryScalar: Double
}


extension PlotDataPackage {
    init() {
        rawData = [Double](repeating: 0, count: 200)
        caseScale = CaseScale(scale: [0, 100, 200, 300, 400])
        monthScale = MonthScale(scale: ["Jan", "Apr", "Aug", "Dec"])
        dateUpdated = "..."
        geometryScalar = 10
    }
}

