//
//  InformationView.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/19/20.
//

import SwiftUI

enum PresentedWebView: Identifiable {
    case covidTrackingProject, privacyPolicy, cdcGuidelines
    
    var id: Int {
        hashValue
    }
}


struct InformationView: View {
    
    @State var showingWebView: PresentedWebView?
    
    var closeView: (() -> Void)
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top) {
                    Text("About")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button(action: {self.closeView()}) {
                        Text("Close")
                            .font(.headline)
                    }.foregroundColor(Color.divider)
                } //HSTACK
                .padding(.top)
                .padding(.bottom, 12)
                
                
                VStack(alignment: .leading, spacing: 8){
                    Text("Welcome, and thank you for downloading!")
                        .fontWeight(.semibold)
                    Text("This app was created solely to raise awareness about the spread of COVID-19 and present it in a simple format. COVID-19 is very real and very deadly, and I don't want anybody to suffer from this terrible virus. Therefore, I made this app in my personal time to be completely free with no intention of making a profit. For my family and yours, please be safe by following the CDC COVID-19 guidelines to flatten the curve.")
                        .font(.subheadline)
                        .opacity(0.8)
                    
                    Text("Feedback on this app is always appreciated, but please keep in mind this app was created and maintained by only one person outside of their normal 9-5 job. Follow me on Twitter linked at the bottom of this page to keep up with updates and new features!")
                        .font(.caption)
                }
                   
                Divider().padding(.bottom)
                
                HStack(spacing: 0) {
                    Text("Source: ")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text("The COVID Tracking Project")
                        .font(.headline)
                        .fontWeight(.bold)
                        .opacity(0.7)
                } //HSTACK
                
                Group{
                    Text("All data shown in this app was collected by The COVID Tracking Project, a volunteer organization launched from The Atlantic. To see the source data and learn more about The COVID Tracking Project:")
                        .font(.caption)
                        .padding(.bottom, 8)
                    
                    Button(action: {self.showingWebView = .covidTrackingProject}) {
                        Text("Visit covidtracking.com ")
                    }
                    .modifier(LeftViewMod())
                    
                    
                    Divider().padding(.bottom)
                
                    Text("COVID-19 CDC Guidelines")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text("Help flatten the curve by following the CDC's COVID-19 safety guidelines:")
                        .font(.caption)
                        .padding(.bottom, 8)
                    
                    Button(action: {self.showingWebView = .cdcGuidelines}) {
                        Text("CDC Guidelines")
                    }
                    .modifier(LeftViewMod())
                } //GROUP
                
                
                Divider().padding(.bottom)
                
                Group {
                    Text("Privacy Policy")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text("This app does not collect any personal data from you whatsoever. This app does not have access to your location, microphone, camera, bluetooth, or any other app on your device. The only data this app stores is your last search criteria when the app is closed, which is stored locally on your device only and is not accessible to us.")
                        .font(.caption)

                    Divider().padding(.bottom, 20)
                } //GROUP
                                                
                
                VStack(alignment: .center, spacing: 2) {
                    Text("Created by: Jeremy Yarley")
                    Text("Twitter: @JeremyYarley")
                    Text("Version 1.0")
                }
                .font(.caption)
                .opacity(0.75)
                .modifier(CenterViewMod())
                
            } //VSTACK
            .padding(.horizontal)
        } //SCROLLVIEW

        .sheet(item: self.$showingWebView) { item in
            switch item {
                case .covidTrackingProject:
                    WebView(urlString: .constant("https://covidtracking.com/"))
                case .privacyPolicy:
                    Text("Privacy Policy")
                case .cdcGuidelines:
                    WebView(urlString: .constant("https://www.cdc.gov/coronavirus/2019-ncov/index.html"))
            }
        } //SHEET PRESENT
        
    }
}


struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(closeView: {})
    }
}
