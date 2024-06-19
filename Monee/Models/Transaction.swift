//
//  Transaction.swift
//  Monee
//
//  Created by MZiO on 17/5/24.
//


/*
    TODO:
 
    Add different hours for the same day transactions to try a grouping list.
 
 */

import Foundation
import SwiftData

@Model
class Transaction {
    var payee: Payee?
    var category: Category?
    var account: Account?
    var date: Date
    var memo: String
    var amount: Decimal
    
    
    init(date: Date = .now, memo: String = "", amount: Decimal = 0) {
        self.date = date
        self.memo = memo
        self.amount = amount
    }
}
