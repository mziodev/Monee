//
//  BudgetList.swift
//  Monee
//
//  Created by MZiO on 5/8/24.
//

import SwiftData
import SwiftUI

struct BudgetList: View {
    @Query(sort:\Budget.sortingIndex) var budgets: [Budget]
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var showingAddBudgetSheet = false
    @State private var showingBudgetDetailsSheet = false
    @State private var selectedBudgetHolder = SelectedBudgetHolder()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(budgets) { budget in
                    NavigationLink {
                        Text("\(budget.name) budget details.")
                    } label: {
                        BudgetListRow(budget: budget)
                            .swipeActions(allowsFullSwipe: false) {
                                Button {
                                    selectedBudgetHolder.selectedBudget = budget
                                    DispatchQueue.main.async {
                                        showingBudgetDetailsSheet = true
                                    }
                                } label: {
                                    Label(
                                        "Edit budget",
                                        systemImage: "info.circle"
                                    )
                                }
                                .tint(.orange)
                            }
                    }
                }
                .onMove(perform: moveBudget)
            }
            .navigationTitle("Budgets")
            .overlay {
                if budgets.isEmpty { BudgetEmpty() }
            }
            .sheet(isPresented: $showingAddBudgetSheet) {
                BudgetDetails(
                    budget: Budget(sortingIndex: getNewSortingIndex()),
                    isNew: true
                )
            }
            .sheet(isPresented: $showingBudgetDetailsSheet) {
                if let selectedBudget = selectedBudgetHolder.selectedBudget {
                    BudgetDetails(budget: selectedBudget)
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
                
                ToolbarItem {
                    EditButton()
                }
            }
        }
    }
    
    private func moveBudget(from source: IndexSet, to destination: Int) {
        var budgetsToMove = budgets.sorted {
            $0.sortingIndex < $1.sortingIndex
        }
        
        budgetsToMove.move(fromOffsets: source, toOffset: destination)
        budgetsToMove.enumerated().forEach { index, budget in
            budget.sortingIndex = index
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    private func getNewSortingIndex() -> Int {
        let descriptor = FetchDescriptor<Budget>()
        let count = (try? modelContext.fetchCount(descriptor)) ?? 0
        
        return count
    }
}

#Preview {
    BudgetList()
        .modelContainer(SampleData.shared.modelContainer)
}
