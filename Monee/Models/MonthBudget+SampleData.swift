//
//  MonthBudget+SampleData.swift
//  Monee
//
//  Created by MZiO on 20/8/24.
//

import Foundation

extension MonthBudget {
    static let sampleData = [
        MonthBudget(creationDate: .now),
        MonthBudget(creationDate: .now - (86400 * 30)),
        MonthBudget(creationDate: .now - (86400 * 60)),
    ]
}
