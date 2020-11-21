//
//  ContentView.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/9/20.
//

import SwiftUI

struct MainPageView: View {
    
    @EnvironmentObject var caseStore: CaseStore
    
    @State var region: Region = .us
    @State var state: SelectedState = .ny
    @State var dataFrequency: DataFrequency = .daily
    @State var searchCriteria: DataCriteria = .positiveIncrease
    
    @State var rotateReloadButton: Bool = false
    @State var showInfoSheet: Bool = false
    
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Text((caseStore.region == .us) ? "United States" : Constants.states[caseStore.state.rawValue] ?? "")
                            .font(.largeTitle)
                        
                        Spacer()
                        
                        Button(action: {self.showInfoSheet.toggle()}) {
                            Image(systemName: "info.circle")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        .foregroundColor(Color.divider)
                    } //HSTACK
                    
                    Text(Constants.dataCriteria[caseStore.searchCriteria.rawValue] ?? "")
                        .font(.headline)
                        .padding(.bottom)
                    
                    PlotView(frequency: self.$dataFrequency, dailyData: self.$caseStore.dailyCases, criteria: self.$searchCriteria)
                        .environmentObject(self.caseStore)
                        .frame(height: 300)
                        .blur(radius: self.caseStore.loading ? 5 : 0)
                } //VSTACK
                .padding()
                
                CurrentDataRow(caseStore: self.caseStore)
                    .padding(.horizontal)
                
                HStack(alignment: .center) {
                    Text("Data Reported: \(self.caseStore.lastUpdated)")
                        .font(.caption)
                        .foregroundColor(Color.divider)
                                    
                    LoadingView(isShowing: self.$caseStore.loading) {
                        Button(action: {
                            reloadData()
                            withAnimation(.easeOut(duration: 0.6)) { self.rotateReloadButton.toggle() }
                            self.rotateReloadButton.toggle()
                        }) {
                            ReloadButton()
                                .rotationEffect(Angle.degrees(self.rotateReloadButton ? 360 : 0))
                        }
                    }
                } //HSTACK
                .padding(.horizontal)
                
                
                Divider().background(Color.divider)
                
                LocationSelectionRow(region: self.$caseStore.region, state: self.$caseStore.state, reloadData: self.reloadData)
                    .padding(.bottom, 8)
                    .padding(.horizontal)
                
                CriteriaSelectionRow(dataFrequency: self.$caseStore.dataFrequency, searchCriteria: self.$caseStore.searchCriteria, reloadData: self.reloadData)
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                
                Spacer()
            } //VSTACK
        } //SCROLLVIEW
        .sheet(isPresented: self.$showInfoSheet) {
            InformationView(closeView: self.closeInfoSheet)
        }
    }
}


extension MainPageView {
    
    func reloadData() {
        if caseStore.region == self.region, caseStore.dataFrequency == self.dataFrequency, caseStore.state == self.state, caseStore.searchCriteria == self.searchCriteria {
            return
        } else {
            self.caseStore.loading = true
            self.region = caseStore.region
            self.dataFrequency = caseStore.dataFrequency
            self.state = caseStore.state
            self.searchCriteria = caseStore.searchCriteria
            caseStore.loadJSONData()
        }
    }
    
    
    func closeInfoSheet() {
        self.showInfoSheet = false
    }
    
}


struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
