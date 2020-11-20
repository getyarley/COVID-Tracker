//
//  CriteriaSelectionRow.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/14/20.
//

import SwiftUI

struct CriteriaSelectionRow: View {
    
    @Binding var dataFrequency: DataFrequency
    @Binding var searchCriteria: DataCriteria
    
    var reloadData: (() -> Void)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Criteria")
            
            HStack(spacing: 8) {
//                Picker(selection: self.$dataFrequency,
//                       label: SelectionButton(inputText: Constants.dataFrequency[dataFrequency.rawValue] ?? "")) {
//                    ForEach(DataFrequency.allCases, id: \.self) {
//                        Text(Constants.dataFrequency[$0.rawValue] ?? "").tag($0)
//                    }
//                } //PICKER
//                .pickerStyle(MenuPickerStyle())
//                .onReceive([self.dataFrequency].publisher.first()) { _ in
//                    self.reloadData()
//                }
                                
//                if dataFrequency == .daily {
                    Picker(selection: self.$searchCriteria,
                           label: SelectionButton(inputText: Constants.dataCriteria[searchCriteria.rawValue] ?? "")) {
                        ForEach(DataCriteria.allCases, id: \.self) {
                            Text(Constants.dataCriteria[$0.rawValue] ?? "").tag($0)
                        }
                    } //PICKER
                    .pickerStyle(MenuPickerStyle())
                    .onReceive([self.searchCriteria].publisher.first()) { _ in
                        self.reloadData()
                    }
                    
                    Spacer()
//                }
                
            } //HSTACK
        } //VSTACK
    }
}

struct CriteriaSelectionRow_Previews: PreviewProvider {
    static var previews: some View {
        CriteriaSelectionRow(dataFrequency: .constant(.current), searchCriteria: .constant((.death)), reloadData: {})
    }
}
