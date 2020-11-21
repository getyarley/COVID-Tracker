//
//  LoadingView.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/16/20.
//

import Foundation
import SwiftUI

struct LoadingView<Content>: View where Content: View {
    
    @Binding var isShowing: Bool
    var content: () -> Content
    
    var body: some View {
        ZStack(alignment: .center) {
            self.content()
                .disabled(isShowing)
                .blur(radius: self.isShowing ? 5 : 0)
            
            LoadingIndicatorMedium(shouldAnimate: self.$isShowing)
                .opacity(self.isShowing ? 1 : 0)
        }
    }
}

