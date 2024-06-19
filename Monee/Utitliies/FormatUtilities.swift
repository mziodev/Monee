//
//  FormatUtilities.swift
//  Monee
//
//  Created by MZiO on 18/6/24.
//

import Foundation

struct FormatUtilities {
    static var currencyCode: String {
        Locale.current.currency?.identifier ?? "USD"
    }
}
