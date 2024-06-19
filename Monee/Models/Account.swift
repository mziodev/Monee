//
//  Account.swift
//  Monee
//
//  Created by MZiO on 17/5/24.
//

import Foundation
import SwiftData

@Model
class Account: Named {
    var name: String
    var type: AccountType
    var amount: Decimal
    
    @Relationship(deleteRule: .cascade)
    var transactions = [Transaction]()
    
    
    init(name: String = "", type: AccountType = .savings, amount: Decimal = 0) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}
