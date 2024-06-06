//
//  AccountListRow.swift
//  Monee
//
//  Created by MZiO on 30/5/24.
//

import SwiftUI

struct AccountListRow: View {
    let name: String
    let amount: Decimal
    let transactionsNumber: Int
    
    var body: some View {
        HStack {
            BasicListRow(
                name: name,
                transactionsNumber: transactionsNumber
            )
            
            Spacer()
            
            Text(
                amount,
                format: .currency(
                    code: Account.currencyLocaleIdentifier
                )
            )
        }
    }
}

#Preview {
    AccountListRow(name: "ABANCA", amount: 2345.67, transactionsNumber: 3)
        .padding(.horizontal)
}
