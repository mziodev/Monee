//
//  MonthBudgetDetails.swift
//  Monee
//
//  Created by MZiO on 20/8/24.
//

import SwiftData
import SwiftUI

struct MonthBudgetDetails: View {
    @Bindable var budget: Budget
    @Bindable var monthBudget: MonthBudget
    
    @State private var shownMonthBudget = MonthBudget()
    
    @State private var showingMonthBudgetList = false
    @State private var showingAccountList = false
    
    init(budget: Budget, monthBudget: MonthBudget) {
        self.budget = budget
        self.monthBudget = monthBudget
        
        if budget.monthBudgets.isEmpty {
            self.budget.monthBudgets.append(monthBudget)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Category Groups") {
                    // Show grouped categories
                }
            }
            .navigationTitle(shownMonthBudget.monthName)
            .onAppear {
                shownMonthBudget = monthBudget
            }
            .sheet(isPresented: $showingMonthBudgetList) {
                MonthBudgetList(
                    budget: budget,
                    shownMonthBudget: $shownMonthBudget
                )
            }
            .sheet(isPresented: $showingAccountList) {
                AccountList(budget: budget)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        showingMonthBudgetList = true
                    } label: {
                        Label("Month budget list", systemImage: "calendar")
                    }
                }
                
                ToolbarItem {
                    Menu {
                        Button { } label: {
                            Label("Transactions", systemImage: "dollarsign")
                        }
                        
                        Button { showingAccountList = true } label: {
                            Label("Accounts", systemImage: "building.columns")
                        }
                        
                        Button{ } label: {
                            Label("Payees", systemImage: "person.3")
                        }
                        
//                        Menu() {
//                            Button("New Category Group") {
//                                // showing add group
//                            }
//                            
//                            Button("New Category") {
//                                // showing add category
//                            }
//                        } label: {
//                            Label("Add...", systemImage: "plus")
//                        }
                        
                    } label: {
                        Label("Add Menu", systemImage: "ellipsis.circle")
                    }
                }
                
                ToolbarItem(placement: .status) {
                    Button {
                        // showing add transaction sheet
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            
                            Text("Add transaction")
                        }
                    }
                    .font(.headline)
                }
            }
        }
    }
}

#Preview {
    MonthBudgetDetails(
        budget: SampleData.shared.budget,
        monthBudget: SampleData.shared.monthBudget
    )
}
