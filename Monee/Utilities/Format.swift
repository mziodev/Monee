//
//  Format.swift
//  Monee
//
//  Created by MZiO on 19/8/24.
//

import Foundation
import SwiftUI

struct Format {
    static var currencyCode: String {
        Locale.current.currency?.identifier ?? "USD"
    }
    
    static func getColor(for amount: Decimal) -> Color {
        amount > 0 ? .green : (amount < 0 ? .red : .secondary)
    }
}
