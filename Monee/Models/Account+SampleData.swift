//
//  Account+SampleData.swift
//  Monee
//
//  Created by MZiO on 20/8/24.
//

import Foundation

extension Account {
    static let sampleData = [
        Account(
            name: "Sabadell",
            amount: 1000,
            sortingIndex: 0
        ),
        Account(
            name: "Cash",
            type: .cash,
            amount: 500,
            sortingIndex: 1
        ),
        Account(
            name: "ABANCA",
            type: .savings,
            amount: 0,
            isOpen: false,
            sortingIndex: 1
        ),
    ]
}
