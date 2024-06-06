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
    
    
    // MARK: - computed properties
    static var currencyCode: String {
        Locale.current.currency?.identifier ?? "USD"
    }
    
    
    // MARK: - init
    init(date: Date = .now, memo: String = "", amount: Decimal = 0) {
        self.date = date
        self.memo = memo
        self.amount = amount
    }
}


// MARK: - sample data extension
extension Transaction {
    static let sampleData = [
        Transaction(
            date: .now - (86400 * 3),
            memo: "",
            amount: -24.62
        ),
        
        Transaction(
            date: .now - (86400 * 10),
            memo: "",
            amount: -20
        ),
        
        Transaction(
            date: .now - (86400 * 2),
            memo: "Eugenio, mes pagado",
            amount: 55
        ),
        
        Transaction(
            date: .now - (86400 * 1),
            memo: "CeraVe cleanser",
            amount: 12.95
        ),
        
        Transaction(
            date: .now - (86400 * 10),
            memo: "",
            amount: -43.35
        ),
        
        Transaction(
            date: .now - (86400 * 10),
            memo: "",
            amount: -12.95
        ),
        
        Transaction(
            date: .now - (86400 * 2),
            memo: "Lucía, mes pagado",
            amount: 100
        ),
    ]
}
