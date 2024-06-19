//
//  Transaction+SampleData.swift
//  Monee
//
//  Created by MZiO on 17/6/24.
//

import Foundation

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
