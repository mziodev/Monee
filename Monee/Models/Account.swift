//
//  Account.swift
//  Monee
//
//  Created by MZiO on 20/8/24.
//

import Foundation
import SwiftData

@Model
class Account: SortableByIndex {
    var budget: Budget?
    var name: String
    var type: AccountType
    var amount: Decimal?
    var isOpen: Bool
    var sortingIndex: Int
    
    init(
        name: String = "",
        type: AccountType = .checking,
        amount: Decimal? = nil,
        isOpen: Bool = true,
        sortingIndex: Int
    ) {
        self.name = name
        self.type = type
        self.amount = amount
        self.isOpen = isOpen
        self.sortingIndex = sortingIndex
    }
}
