//
//  ReloadButton.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/16/20.
//

import SwiftUI

struct ReloadButton: View {
    var body: some View {
        Image(systemName: "arrow.clockwise")
            .resizable()
            .frame(width: 14, height: 16)
            .foregroundColor(Color.blue)
    }
}

struct ReloadButton_Previews: PreviewProvider {
    static var previews: some View {
        ReloadButton()
    }
}
