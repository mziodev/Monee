//
//  Account+SampleData.swift
//  Monee
//
//  Created by MZiO on 17/6/24.
//

import Foundation

extension Account {
    static let sampleData = [
        Account(name: "Sabadell", type: .savings, amount: 2_340.86),
        Account(name: "Cash", type: .cash, amount: 1_045)
    ]
}
