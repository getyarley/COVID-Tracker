//
//  ViewExtensions.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/21/20.
//

import Foundation
import SwiftUI


struct CenterViewMod: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}

struct LeftViewMod: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            content
            Spacer()
        }
    }
}
