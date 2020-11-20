//
//  PlotView.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/12/20.
//

import SwiftUI

struct PlotView: View {
    
    @EnvironmentObject var caseStore: CaseStore
    
    @Binding var frequency: DataFrequency
    @Binding var dailyData: [COVIDResults]
    @Binding var criteria: DataCriteria
        
    var showingDataTest: [Double] = [2, 4, 5, 3, 5, 7, 8, 4]

    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack {
                //MARK: Vertical Axis Labels
                ForEach(caseStore.caseScale.scale.indices, id: \.self) { value in
                    if value == caseStore.caseScale.scale.count - 1 {
                        Text("\(caseStore.caseScale.scale[caseStore.caseScale.scale.count - 1 - value])")
                            .font(.callout)
                    } else {
                        Text("\(caseStore.caseScale.scale[caseStore.caseScale.scale.count - 1 - value])")
                            .font(.callout)
                        Spacer()
                    }
                }.animation(.easeInOut)
            } //VSTACK
            .padding(.bottom, 20)
            
            ZStack {
                //MARK: Plot Dividers
                VStack {
                    ForEach(caseStore.caseScale.scale.indices, id: \.self) { value in
                        if value != caseStore.caseScale.scale.count - 1 {
                            Divider().background(Color.divider)
                            Spacer()
                        }
                    }.animation(.easeInOut)
                } //VSTACK
                .padding(.bottom, 20)
                .padding(.vertical, 8)
                
                
                VStack {
                    //MARK: Data
                    GeometryReader{ geometry in
                        HStack(alignment: .bottom, spacing: 0) {
                            
                            if frequency == .daily {
                                ForEach(caseStore.rawData.indices, id: \.self) {value in
                                    CapsuleObject(geometry: geometry,
                                                  heightOffsetScale: caseStore.geometryScalar,
                                                  percentDelay: Double(value / caseStore.rawData.count),
                                                  width: geometry.size.width / CGFloat(caseStore.rawData.count),
                                                  heightPercent: self.showingZero ?  0 : (Double(caseStore.rawData[value] / (caseStore.rawData.max() ?? 100))),
                                                  xPercent: Double(value / caseStore.rawData.count))
                                    
                                } //FOREACH
                                .offset(y: self.showingZero ? geometry.size.height : 0 )
                                Spacer()
                            }
                        } //HSTACK
                        .frame(height: geometry.size.height)
                        .clipped()
                    } //GEOMETRYREADER
                    .overlay(Rectangle().frame(width: nil, height: 0.2, alignment: .bottom).foregroundColor(Color.divider), alignment: .bottom)
                    
                    
                    //MARK: Horizontal Axis Labels
                    HStack {
                        ForEach(caseStore.monthScale.scale.indices, id: \.self) { value in
                            if value == caseStore.monthScale.scale.count - 1 {
                                Text("\(caseStore.monthScale.scale[caseStore.monthScale.scale.count - 1 - value])")
                                    .font(.callout)
                            } else {
                                Text("\(caseStore.monthScale.scale[caseStore.monthScale.scale.count - 1 - value])")
                                    .font(.callout)
                                Spacer()
                            }
                        }.animation(.easeInOut)
                    } //HSTACK
                } //VSTACK
            } //ZSTACK
        } //HSTACK
    }
}


extension PlotView {
    
    var showingZero: Bool {
//        if showingData.max() == 0 {
        if caseStore.rawData.max() == 0 {
            return true
        } else {
            return false
        }
    }
    
    var showingData: [Double] {
        var newValues = [Double](repeating: 0, count: dailyData.count)
        
        switch criteria {
        case .death:
            for index in 0..<newValues.count {
                newValues[index] = Double(dailyData[dailyData.count - 1 - index].death ?? 0)
            }
            return newValues
        case .positiveIncrease:
            for index in 0..<newValues.count {
                newValues[index] = Double(dailyData[dailyData.count - 1 - index].positiveIncrease ?? 0)
            }
            return newValues
        case .deathIncrease:
            for index in 0..<newValues.count {
                newValues[index] = Double(dailyData[dailyData.count - 1 - index].deathIncrease ?? 0)
            }
            return newValues
        case .negativeIncrease:
            for index in 0..<newValues.count {
                newValues[index] = Double(dailyData[dailyData.count - 1 - index].negativeIncrease ?? 0)
            }
            return newValues
        case .hospitalizedIncrease:
            for index in 0..<newValues.count {
                newValues[index] = Double(dailyData[dailyData.count - 1 - index].hospitalizedIncrease ?? 0)
            }
            return newValues
        case .positive:
            for index in 0..<newValues.count {
                newValues[index] = Double(dailyData[dailyData.count - 1 - index].positive ?? 0)
            }
            return newValues
        case .negative:
            for index in 0..<newValues.count {
                newValues[index] = Double(dailyData[dailyData.count - 1 - index].negative ?? 0)
            }
            return newValues
        }
    }
}



struct PlotView_Previews: PreviewProvider {
    static var previews: some View {
        PlotView(frequency: .constant(.daily), dailyData: .constant([]), criteria: .constant(.positiveIncrease))
    }
}
