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
                        Text("\(currentData.positiveIncrease ?? 0)")
                            .font(.title)
                        Text("Positive")
                            .font(.callout)
                    } //VSTACK
                    
                    VStack {
                        Text("\(currentData.deathIncrease ?? 0)")
                            .font(.title)
                        Text("Deaths")
                            .font(.callout)
                    } //VSTACK
                    
                    VStack {
                        Text("\(currentData.negativeIncrease ?? 0)")
                            .font(.title)
                        Text("Negative")
                            .font(.callout)
                    } //VSTACK
                    
                    VStack {
                        Text("\(currentData.death ?? 0)")
                            .font(.title)
                        Text("Total Deaths")
                            .font(.callout)
                    } //VSTACK
                    
                    VStack {
                        Text("\(currentData.hospitalizedIncrease ?? 0)")
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

struct CurrentDataRow_Previews: PreviewProvider {
    static var previews: some View {
        CurrentDataRow(caseStore: CaseStore())
    }
}
