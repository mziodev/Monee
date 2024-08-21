//
//  Array+Sorting.swift
//  Monee
//
//  Created by MZiO on 21/8/24.
//

import Foundation

extension Array where Element: SortableByIndex {
    var sortedBySortingIndex: [Element] {
        self.sorted { $0.sortingIndex < $1.sortingIndex }
    }
}
