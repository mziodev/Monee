//
//  Budget+SampleData.swift
//  Monee
//
//  Created by MZiO on 19/8/24.
//

import Foundation

extension Budget {
    static let sampleData = [
        Budget(
            creationDate: .now - (86400 * 15),
            name: "Familia DSS",
            sortingIndex: 0
        ),
        Budget(
            type: .business,
            name: "Ciencias con Raquel",
            sortingIndex: 1
        ),
    ]
}
