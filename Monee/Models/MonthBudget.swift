//
//  MonthBudget.swift
//  Monee
//
//  Created by MZiO on 20/8/24.
//

import Foundation
import SwiftData

@Model
class MonthBudget {
    var budget: Budget?
    var creationDate: Date
    
    init(creationDate: Date = .now) {
        self.creationDate = creationDate
    }
    
    static func nextMonthBudget() -> MonthBudget {
        MonthBudget(creationDate: .now + (86400 * 30))
    }
}
