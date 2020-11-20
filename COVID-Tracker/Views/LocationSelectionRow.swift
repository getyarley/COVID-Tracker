//
//  LocationSelectionRow.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/14/20.
//

import SwiftUI

struct LocationSelectionRow: View {
        
    @Binding var region: Region
    @Binding var state: SelectedState
    
    var reloadData: (() -> Void)
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Region")
            
            HStack(spacing: 8) {
                Picker(selection: self.$region, label: SelectionButton(inputText: Constants.region[region.rawValue] ?? "")) {
                    ForEach(Region.allCases, id: \.self) {
                        Text(Constants.region[$0.rawValue] ?? "").tag($0)
                    }
                } //PICKER
                .pickerStyle(MenuPickerStyle())
                .onReceive([self.region].publisher.first()) { _ in
                    self.reloadData()
                }
                
                
                if region == .states {
                    Picker(selection: self.$state, label: SelectionButton(inputText: Constants.states[state.rawValue] ?? "")) {
                        ForEach(SelectedState.allCases.sorted(by: {$0.rawValue > $1.rawValue}), id: \.self) {
                            Text(Constants.states[$0.rawValue] ?? "").tag($0)
                        }
                    } //PICKER
                    .pickerStyle(MenuPickerStyle())
                    .onReceive([self.state].publisher.first()) { _ in
                        self.reloadData()
                    }
                    
                    Spacer()
                }
                
            } //HSTACK
        } //VSTACK
    }
}

struct LocationSelectionRow_Previews: PreviewProvider {
    static var previews: some View {
        LocationSelectionRow(region: .constant(.us), state: .constant(.ny), reloadData: {})
    }
}
