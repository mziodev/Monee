//
//  Transaction.swift
//  Monee
//
//  Created by MZiO on 17/5/24.
//

import Foundation
import SwiftData

@Model
class Transaction {
    let payee: Payee
    let category: Category
    let account: Account
    let date: Date
    let memo: String
    let amount: Float
    
    init(
        payee: Payee,
        category: Category,
        account: Account,
        date: Date,
        memo: String,
        amount: Float
    ) {
        self.payee = payee
        self.category = category
        self.account = account
        self.date = date
        self.memo = memo
        self.amount = amount
    }
}

/*
extension Transaction {
    static let sampleData = [
        Transaction(
            payee: Payee(name: "Froiz"),
            category: Category(name: "Alimentación"),
            account: Account(name: <#T##String#>, amount: <#T##Float#>),
            date: .now,
            memo: "",
            amount: -24.62
        ),
        
        Transaction(
            payee: "Carrefour",
            category: "Gasolina",
            account: "Sabadell",
            date: .now,
            memo: "",
            amount: -20
        ),
        
        Transaction(
            payee: "CLRK",
            category: "Para ingresar",
            account: "Cash",
            date: .now,
            memo: "Eugenio, mes pagado",
            amount: 50
        ),
    ]
}
*/
