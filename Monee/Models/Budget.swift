//
//  Budget.swift
//  Monee
//
//  Created by MZiO on 19/8/24.
//

import Foundation
import SwiftData

@Model
class Budget {
    var creationDate: Date
    var type: BudgetType
    var name: String
    var sortingIndex: Int
    
    init(
        creationDate: Date = .now,
        type: BudgetType = .personal,
        name: String = "",
        sortingIndex: Int
    ) {
        self.creationDate = creationDate
        self.type = type
        self.name = name
        self.sortingIndex = sortingIndex
    }
}
