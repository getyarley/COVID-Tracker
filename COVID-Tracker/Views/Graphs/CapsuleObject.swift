//
//  CapsuleObject.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/12/20.
//

import SwiftUI

struct CapsuleObject: View {
    var geometry: GeometryProxy
    
    var heightOffsetScale: Double
    var percentDelay: Double
    var width: CGFloat
    var heightPercent: Double
    var xPercent: Double
    var heightPadding: CGFloat = 15
    
    
    var height: CGFloat {
        if heightPercent == 0 {
            return CGFloat(16)
        } else {
            let topOffset = CGFloat(heightOffsetScale)
            let value = max((CGFloat(heightPercent) * (geometry.size.height * topOffset - heightPadding)) + heightPadding, 0)
            return value
        }
    }
    
    var xPosition: CGFloat {
        CGFloat(xPercent) * (geometry.size.width - heightPadding)
    }
    
    var capsuleAnimation: Animation {
        Animation.spring(dampingFraction: 0.7)
    }
    
    
    var body: some View {
        VStack {
            Spacer()
            Capsule()
                .fill(Color.blue)
                .frame(width: width, height: height, alignment: .bottom)
                .animation(capsuleAnimation)
                .offset(x: xPosition, y: heightPadding)
        }
    }
}

