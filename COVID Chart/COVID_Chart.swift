//
//  COVID_Chart.swift
//  COVID Chart
//
//  Created by Jeremy Yarley on 11/24/20.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    var widgetManager = WidgetManager()
    
    
    func placeholder(in context: Context) -> COVIDEntry {
        COVIDEntry(date: Date(), data: PlotDataPackage(), userOptions: UserOptions())
    }

    func getSnapshot(in context: Context, completion: @escaping (COVIDEntry) -> ()) {
        let entry: COVIDEntry
        
        entry = COVIDEntry(date: Date(), data: PlotDataPackage(), userOptions: UserOptions())
//        if context.isPreview {
//            entry = SimpleEntry(date: Date(), configuration: configuration) //PREVIEW CONTENT
//        } else {
//            entry = SimpleEntry(date: Date(), configuration: configuration)
//        }
        
//        widgetManager.fetchData { (<#[Double]#>) in
//            <#code#>
//        }
        
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let nextDate = Calendar.current.date(byAdding: .hour, value: 2, to: Date())! //Reload after 2 hours
        
        widgetManager.loadUserDefaults { (userOptions) in
            widgetManager.fetchData(region: userOptions.region, state: userOptions.state, searchCriteria: userOptions.searchCriteria) { (results) in
                let entries = [COVIDEntry(date: Date(), data: results, userOptions: userOptions)]
                let timeline = Timeline(entries: entries, policy: .after(nextDate))
                completion(timeline)
            }
        }
    }
}


struct COVIDEntry: TimelineEntry {
    let date: Date
    let data: PlotDataPackage
    let userOptions: UserOptions
}



struct COVID_ChartEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 0) {
                Text((entry.userOptions.region == .us) ? "United States" : Constants.states[entry.userOptions.state.rawValue] ?? "")
                    .font(.callout)
                
                Text(", ")
                    .font(.callout)
                
                Text(Constants.dataCriteria[entry.userOptions.searchCriteria.rawValue] ?? "")
            }
                       
            HStack(spacing: 0) {
                Text("Updated: ")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.gray)
                
                Text("\(entry.data.dateUpdated)")
                    .font(.caption2)
                    .foregroundColor(Color.gray)
            }
            
            WidgetPlotView(plotData: entry.data)
        }.padding(.horizontal, 10)
        .padding(.vertical, 8)
    }
}




@main
struct COVID_Chart: Widget {
    let kind: String = "COVID_Chart"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            COVID_ChartEntryView(entry: entry)
            
        }
        .configurationDisplayName("COVID Tracker")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}



