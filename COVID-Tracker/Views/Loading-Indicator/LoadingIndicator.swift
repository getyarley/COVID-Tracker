//
//  LoadingIndicator.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/16/20.
//

import Foundation
import SwiftUI
import UIKit


struct LoadingIndicatorMedium: UIViewRepresentable {
    
    //Vars
    @Binding var shouldAnimate: Bool
    let style = UIActivityIndicatorView.Style.medium
    
    func makeUIView(context: UIViewRepresentableContext<LoadingIndicatorMedium>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<LoadingIndicatorMedium>) {
        shouldAnimate ? uiView.startAnimating() : uiView.stopAnimating()
    }
    
}

