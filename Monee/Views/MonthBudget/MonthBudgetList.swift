//
//  MonthBudgetList.swift
//  Monee
//
//  Created by MZiO on 20/8/24.
//

import SwiftData
import SwiftUI

struct MonthBudgetList: View {
    @Environment(\.dismiss) private var dismiss
    
    let budget: Budget
    
    @Binding var shownMonthBudget: MonthBudget
    
    private var monthBudgetsGroupedByYear: [(String, [MonthBudget])] {
        return Dictionary(grouping: budget.monthBudgets) {
            $0.yearName
        }
        .sorted { $0.key > $1.key }
        .map { ($0.key, $0.value) }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(monthBudgetsGroupedByYear, id: \.0) {
                    year,
                    monthBudgets in
                    Section(year) {
                        ForEach(monthBudgets.sortedByMonth) { monthBudget in
                            HStack {
                                Text(monthBudget.monthName)
                                    .font(
                                        monthBudget.matchesCurrentMonth ? .headline : .body
                                    )
                                
                                Spacer()
                                
                                if monthBudget == shownMonthBudget {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(Color.accentColor)
                                }
                            }
                            .onTapGesture {
                                changeShownMonthBudget(to: monthBudget)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Month Budget List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: dismissView)
                }
            }
        }
    }
    
    private func dismissView() { dismiss() }
    
    private func changeShownMonthBudget(to monthBudget: MonthBudget) {
        shownMonthBudget = monthBudget
        dismiss()
    }
}

#Preview {
    MonthBudgetList(
        budget: SampleData.shared.budget,
        shownMonthBudget: .constant(SampleData.shared.monthBudget)
    )
}
