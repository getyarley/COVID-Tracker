//
//  WidgetPlotView.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/24/20.
//

import SwiftUI
import WidgetKit

struct WidgetPlotView: View {
    
    @Environment(\.widgetFamily) var family: WidgetFamily
    
    var plotData: PlotDataPackage
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(spacing: 0) {
                //MARK: Vertical Axis Labels
                ForEach(plotData.caseScale.scale.indices, id: \.self) { value in
                    if plotData.caseScale.scale.count == 5, (value == 1 || value == 3) {
                        Spacer()
                    } else if value == plotData.caseScale.scale.count - 1 {
                        Text("\(checkMagnitude(value: plotData.caseScale.scale[plotData.caseScale.scale.count - 1 - value]))")
                            .font(.caption2)
                    } else {
                        Text("\(checkMagnitude(value: plotData.caseScale.scale[plotData.caseScale.scale.count - 1 - value]))")
                            .font(.caption2)
                        Spacer()
                    }
                }.animation(.easeInOut)
            } //VSTACK
            .padding(.bottom, 12)
            
            ZStack {
                //MARK: Plot Dividers
                VStack(spacing: 0) {
                    ForEach(plotData.caseScale.scale.indices, id: \.self) { value in
                        if value != plotData.caseScale.scale.count - 1 {
                            Divider().background(Color.divider)
                            Spacer()
                        }
                    }.animation(.easeInOut)
                } //VSTACK
                .padding(.bottom, 12)
                .padding(.vertical, 8)
                
                
                VStack(spacing: 4) {
                    
                    //MARK: Data
                    GeometryReader{ geometry in
                        HStack(alignment: .bottom, spacing: 0) {
                            ForEach(plotData.rawData.indices, id: \.self) {value in
                                CapsuleObject(geometry: geometry,
                                              heightOffsetScale: plotData.geometryScalar,
                                              percentDelay: Double(value / plotData.rawData.count),
                                              width: geometry.size.width / CGFloat(plotData.rawData.count),
                                              heightPercent: Double(plotData.rawData[value] / (plotData.rawData.max() ?? 100)),
                                              xPercent: Double(value / plotData.rawData.count))
                                
                            } //FOREACH
                            .offset(y: self.showingZero ? geometry.size.height : 0 )
                            Spacer()
                        } //HSTACK
                        .frame(height: geometry.size.height)
                        .clipped()
                    } //GEOMETRYREADER
                    .overlay(Rectangle().frame(width: nil, height: 0.2, alignment: .bottom).foregroundColor(Color.divider), alignment: .bottom)
                    
                    
                    //MARK: Horizontal Axis Labels
                    HStack {
                        ForEach(plotData.monthScale.scale.indices, id: \.self) { value in
                            if value == plotData.monthScale.scale.count - 1 {
                                Text("\(plotData.monthScale.scale[plotData.monthScale.scale.count - 1 - value])")
                                    .font(.caption2)
                            } else {
                                Text("\(plotData.monthScale.scale[plotData.monthScale.scale.count - 1 - value])")
                                    .font(.caption2)
                                Spacer()
                            }
                        }.animation(.easeInOut)
                    } //HSTACK
                } //VSTACK
            } //ZSTACK
        } //HSTACK
    }
}


extension WidgetPlotView {
    
    var showingZero: Bool {
        if plotData.rawData.max() == 0 {
            return true
        } else {
            return false
        }
    }
    
    
    func checkMagnitude(value: Int) -> String {
        if value > 1000000 {
            if value % 1000000 == 0 {
                return String(value/1000000) + "M"
            } else {
                let number = Double(value)/1000000
                return String(number) + "M"
            }
        } else if value > 1000 {
            if value % 1000 == 0 {
                return String(value/1000) + "K"
            } else {
                let number = Double(value)/1000
                return String(number) + "K"
            }
        } else {
            return String(value)
        }
    }
    
}


