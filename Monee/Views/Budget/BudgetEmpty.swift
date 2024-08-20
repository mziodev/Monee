//
//  BudgetEmpty.swift
//  Monee
//
//  Created by MZiO on 19/8/24.
//

import SwiftUI

struct BudgetEmpty: View {
    var body: some View {
        ContentUnavailableView {
            Label("No budgets yet", systemImage: "creditcard")
                .foregroundStyle(Color.accentColor)
        } description: {
            Text("Tap on the plus button to add a new budget.")
        }
    }
}

#Preview {
    BudgetEmpty()
}
