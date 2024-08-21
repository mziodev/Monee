//
//  AccountListRow.swift
//  Monee
//
//  Created by MZiO on 21/8/24.
//

import SwiftUI

struct AccountListRow: View {
    let account: Account
    
    var body: some View {
        HStack {
            Image(systemName: account.type.systemImage)
                .font(.largeTitle)
                .foregroundStyle(
                    account.isOpen ? Color.accentColor : Color.secondary
                )
                .frame(width: 30)
                .accessibilityLabel(account.type.localizedSymbolDescription)
            
            VStack(alignment: .leading) {
                Text(account.name)
                    .font(.headline)
                    .foregroundStyle(account.isOpen ? .primary : .secondary)
                
                Text(account.type.localizedDescription)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text(
                account.amount ?? 0,
                format: .currency(code: Format.currencyCode)
            )
            .font(.title3)
            .fontDesign(.rounded)
            .foregroundStyle(Format.getColor(for: account.amount ?? 0))
        }
    }
}

#Preview("Closed Account") {
    List {
        AccountListRow(account: SampleData.shared.closedAccount)
    }
}

#Preview("Open Account") {
    List {
        AccountListRow(account: SampleData.shared.openAccount)
    }
}
