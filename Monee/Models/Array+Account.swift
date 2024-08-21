//
//  Array+Account.swift
//  Monee
//
//  Created by MZiO on 21/8/24.
//

import Foundation

extension Array where Element == Account {
    var totalInAccounts: Decimal {
        self.reduce(0, { $0 + ($1.amount ?? 0) })
    }
}
