//
//  BudgetListRow.swift
//  Monee
//
//  Created by MZiO on 19/8/24.
//

import SwiftUI

struct BudgetListRow: View {
    let budget: Budget
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(budget.name)")
                    .font(.headline)
                
                Text(
                    budget.creationDate.formatted(
                        date: .abbreviated,
                        time: .omitted
                    )
                )
                .font(.caption)
                .foregroundStyle(.secondary)
                
                Text("\(budget.type.localizedDescription) budget")
                    .font(.caption.smallCaps())
            }
            
            Spacer()
            
            Image(systemName: budget.type.systemImage)
                .font(.title)
                .foregroundStyle(Color.accentColor)
                .accessibilityLabel(budget.type.localizedSymbolDescription)
        }
    }
}

#Preview("Active budget") {
    List {
        BudgetListRow(budget: SampleData.shared.budget)
    }
}
