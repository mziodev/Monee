//
//  BudgetList.swift
//  Monee
//
//  Created by MZiO on 19/8/24.
//

import SwiftData
import SwiftUI

struct BudgetList: View {
    @Query(sort: \Budget.sortingIndex) private var budgets: [Budget]
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var showingAddBudgetSheet = false
    @State private var showingBudgetDetailsSheet = false
    @State private var selectedBudgetHolder = SelectedItemHolder()
    
    var body: some View {
        NavigationStack {
            List {
                if !budgets.isEmpty {
                    Section("Active budgets") {
                        ForEach(budgets) { budget in
                            NavigationLink {
                                MonthBudgetDetails(
                                    budget: budget,
                                    monthBudget: budget.monthBudgets.current
                                )
                            } label: {
                                BudgetListRow(budget: budget)
                                    .swipeActions {
                                        detailsSwipeAction(budget: budget)
                                    }
                            }
                        }
                        .onMove(perform: moveBudget)
                    }
                }
            }
            .navigationTitle("Budgets")
            .overlay {
                if budgets.isEmpty { BudgetEmpty() }
            }
            .sheet(isPresented: $showingAddBudgetSheet) {
                BudgetDetails(
                    budget: Budget(sortingIndex: budgets.count),
                    isNew: true
                )
            }
            .sheet(isPresented: $showingBudgetDetailsSheet) {
                if let budget = selectedBudgetHolder.budget {
                    BudgetDetails(budget: budget)
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        showingAddBudgetSheet = true
                    } label: {
                        Label("Add budget", systemImage: "plus")
                    }
                }
                
                if !budgets.isEmpty {
                    ToolbarItem {
                        EditButton()
                    }
                    
                    ToolbarItem(placement: .status) {
                        Text("\(budgets.count) budgets")
                            .font(.caption)
                    }
                }
            }
        }
        
    }
    
    private func moveBudget(from source: IndexSet, to destination: Int) {
        var budgetsToMove = budgets.sorted {
            $0.sortingIndex < $1.sortingIndex
        }
        
        budgetsToMove
            .move(fromOffsets: source, toOffset: destination)
        budgetsToMove
            .enumerated()
            .forEach { index, budget in
                budget.sortingIndex = index
            }
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    private func detailsSwipeAction(budget: Budget) -> some View {
        Button {
            selectedBudgetHolder.budget = budget
            DispatchQueue
                .main
                .async {
                    showingBudgetDetailsSheet = true
                }
        } label: {
            Label("Edit budget", systemImage: "info.circle")
        }
        .tint(.orange)
    }
}

#Preview {
    BudgetList()
        .modelContainer(SampleData.shared.modelContainer)
}
