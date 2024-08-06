//
//  Budget+SampleData.swift
//  Monee
//
//  Created by MZiO on 5/8/24.
//

import Foundation

extension Budget {
    static let sampleData = [
        Budget(creationDate: .now - (86400 * 15), name: "DSS Family", sortingIndex: 0),
        Budget(type: .business, name: "CLRK", sortingIndex: 1)
    ]
}
