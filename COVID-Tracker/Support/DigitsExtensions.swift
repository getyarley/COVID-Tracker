//
//  DigitsExtensions.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/15/20.
//

import Foundation
import SwiftUI

extension StringProtocol {
    var digits: [Int] {compactMap(\.wholeNumberValue)}
}


extension LosslessStringConvertible {
    var string: String {.init(self)}
}


extension Numeric where Self: LosslessStringConvertible {
    var digits: [Int] {string.digits}
}

