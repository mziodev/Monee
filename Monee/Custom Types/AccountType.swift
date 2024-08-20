//
//  AccountType.swift
//  Monee
//
//  Created by MZiO on 20/8/24.
//

import Foundation

enum AccountType: Codable, CaseIterable {
    case cash
    case savings
    case checking
    case creditCard
    
    var localizedDescription: String {
        switch self {
        case .cash:
            String(localized: "Cash")
        case .savings:
            String(localized: "Savings")
        case .checking:
            String(localized: "Checking")
        case .creditCard:
            String(localized: "Credit Card")
        }
    }
    
    var systemImage: String {
        switch self {
        case .cash:
            "dollarsign.circle"
        case .savings:
            "lock.circle"
        case .checking:
            "building.columns.circle"
        case .creditCard:
            "creditcard.circle"
        }
    }
    
    var localizedSymbolDescription: String {
        switch self {
        case .cash:
            "Dollar sign"
        case .savings:
            "Closed lock"
        case .checking:
            "Institution building"
        case .creditCard:
            "Credit card"
        }
    }
}
