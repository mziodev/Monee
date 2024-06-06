//
//  TransactionListRow.swift
//  Monee
//
//  Created by MZiO on 4/6/24.
//

import SwiftUI

struct TransactionListRow: View {
    let payeeName: String?
    let categoryName: String?
    let amount: Decimal
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(payeeName ?? "")
                    .font(.headline)
                
                Text(categoryName ?? "")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text(
                amount.formatted(
                    .currency(
                        code: Transaction.currencyCode
                    )
                )
            )
            .foregroundStyle(amount < 0 ? .red : .green)
            .font(.title3.bold())
            .fontDesign(.serif)
        }
//        .padding(.vertical, 10)
    }
}


// MARK: - previews
#Preview("Positive transaction") {
    List {
        TransactionListRow(
            payeeName: "Payee",
            categoryName: "Category",
            amount: 55
        )
    }
}

#Preview("Negative transaction") {
    List {
        TransactionListRow(
            payeeName: "Payee",
            categoryName: "Category",
            amount: -34.45
        )
    }
}
