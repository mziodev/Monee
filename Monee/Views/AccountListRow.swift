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
    
    var body: some View {
        HStack {
            Text(name)
                .font(.headline)
            
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
    AccountListRow(name: "ABANCA", amount: 2345.67)
        .padding(.horizontal)
}
