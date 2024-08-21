//
//  AccountListSectionFooter.swift
//  Monee
//
//  Created by MZiO on 21/8/24.
//

import SwiftUI

struct AccountListSectionFooter: View {
    let totalInAccounts: Decimal
    
    var body: some View {
        HStack {
            Spacer()
            
            Text("Total in accounts")
                .font(.caption.smallCaps())
            
            Text(
                totalInAccounts,
                format: .currency(code: Format.currencyCode)
            )
            .font(.title3)
            .fontDesign(.rounded)
        }
        .padding(.top, 10)
        .padding(.bottom, 30)
    }
}

#Preview {
    AccountListSectionFooter(totalInAccounts: 1765.80)
}
