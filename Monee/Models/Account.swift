//
//  Account.swift
//  Monee
//
//  Created by MZiO on 17/5/24.
//

import Foundation
import SwiftData

@Model
class Account {
    var name: String
    var type: AccountType
    var amount: Decimal
    
    static var currencyLocaleIdentifier: String {
        Locale.current.currency?.identifier ?? "USD"
    }
    
    init(name: String = "", type: AccountType = .savings, amount: Decimal = 0) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}


// MARK: - sample data
extension Account {
    static let sampleData = [
        Account(name: "Sabadell", type: .savings, amount: 2_340.86),
        Account(name: "Cash", type: .cash, amount: 1_045)
    ]
}
