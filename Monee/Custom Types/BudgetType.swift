//
//  BudgetType.swift
//  Monee
//
//  Created by MZiO on 19/8/24.
//

import Foundation

enum BudgetType: CaseIterable, Codable {
    case personal
    case business
    
    var localizedDescription: String {
        switch self {
        case .personal:
            String(localized: "Personal")
        case .business:
            String(localized: "Business")
        }
    }
    
    var systemImage: String {
        switch self {
        case .personal:
            "house"
        case .business:
            "building.2"
        }
    }
    
    var localizedSymbolDescription: String {
        switch self {
        case .personal:
            "House symbol"
        case .business:
            "Two building symbol"
        }
    }
}
