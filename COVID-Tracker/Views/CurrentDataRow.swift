//
//  CurrentDataRow.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/16/20.
//

import SwiftUI

struct CurrentDataRow: View {
    
    @ObservedObject var caseStore: CaseStore
    
    var currentData: COVIDResults {
        caseStore.dailyCases.first ?? COVIDResults.emptyCases
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Today in \((caseStore.region == .us) ? "the United States" : Constants.states[caseStore.state.rawValue] ?? "")")
                .font(.headline)
            
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    VStack {
                        Text("\(checkForEmpty(data: currentData.positiveIncrease))")
                            .font(.title)
                        
                        Text("Positive")
                            .font(.callout)
                    } //VSTACK
                    
                    
                    VStack {
                        Text("\(checkForEmpty(data: currentData.deathIncrease))")
                            .font(.title)
                        
                        Text("Deaths")
                            .font(.callout)
                    } //VSTACK
                    
                    
                    VStack {
                        Text("\(checkForEmpty(data: currentData.negativeIncrease))")
                            .font(.title)
                        
                        Text("Negative")
                            .font(.callout)
                    } //VSTACK
                    
                    
                    VStack {
                        Text("\(checkForEmpty(data: currentData.death))")
                            .font(.title)
                        
                        Text("Total Deaths")
                            .font(.callout)
                    } //VSTACK
                    
                    
                    VStack {
                        Text("\(checkForEmpty(data: currentData.hospitalizedIncrease))")
                            .font(.title)
                        
                        Text("Hospitalizations")
                            .font(.callout)
                    } //VSTACK

                } //HSTACK
                .animation(.easeInOut)
                .padding(.vertical, 6)
            } //SCROLLVIEW
        } //VSTACK
    }
}


extension CurrentDataRow {
    
    func checkForEmpty(data: Int?) -> NSObject {
        guard let value = data, value != 0 else {
            return "..." as NSObject
        }
        return value as NSObject
    }
    
}

struct CurrentDataRow_Previews: PreviewProvider {
    static var previews: some View {
        CurrentDataRow(caseStore: CaseStore())
    }
}
