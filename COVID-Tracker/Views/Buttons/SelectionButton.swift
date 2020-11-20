//
//  SelectionButton.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/14/20.
//

import SwiftUI

struct SelectionButton: View {
    
    var inputText: String
    
    var body: some View {
        HStack {
            Text(inputText)
                .fontWeight(.semibold)
                .foregroundColor(Color.white)
            
            Image(systemName: "chevron.down.circle.fill")
                .resizable()
                .frame(width: 18, height: 18)
                .foregroundColor(Color.white)
        }
        .padding(.vertical, 6)
        .padding(.leading)
        .padding(.trailing, 10)
        .background(Color.gray)
        .mask(RoundedRectangle(cornerRadius: 20))
    }
}

struct SelectionButton_Previews: PreviewProvider {
    static var previews: some View {
        SelectionButton(inputText: "Connecticut")
    }
}
