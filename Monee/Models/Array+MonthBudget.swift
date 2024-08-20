//
//  Array+MonthBudget.swift
//  Monee
//
//  Created by MZiO on 20/8/24.
//

import Foundation

extension Array where Element == MonthBudget {
    var current: MonthBudget {
        self.first { $0.matchesCurrentMonth } ?? MonthBudget()
    }
    
    var sortedByMonth: [MonthBudget] {
        self.sorted { $0.monthNumber > $1.monthNumber }
    }
}
