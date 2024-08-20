//
//  BudgetDetails.swift
//  Monee
//
//  Created by MZiO on 20/8/24.
//

import SwiftData
import SwiftUI

struct BudgetDetails: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var budget: Budget
    
    @FocusState private var nameTextFieldFocused: Bool
    
    @State private var showingDeleteBudgetAlert = false
    
    let isNew: Bool
    let alertMessage = "All the budget transactions, payees, categories and accounts will be deleted too."
    
    init(budget: Budget, isNew: Bool = false) {
        self.budget = budget
        self.isNew = isNew
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $budget.name)
                        .focused($nameTextFieldFocused)
                    
                    Picker("Type", selection: $budget.type.animation()) {
                        ForEach(BudgetType.allCases, id: \.self) { type in
                            Text(type.localizedDescription)
                        }
                    }
                    .pickerStyle(.menu)
                } header: {
                    DetailsSectionHeader(
                        name: budget.type.systemImage,
                        description: budget.type.localizedDescription
                    )
                    .padding(.bottom, 10)
                } footer: {
                    DetailsSectionFooter(date: budget.creationDate)
                        .padding(.top, 10)
                }
            }
            .navigationTitle(isNew ? "New budget" : "Edit budget")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if isNew { nameTextFieldFocused = true }
            }
            .alert(
                "\(budget.name) budget will be deleted!",
                isPresented: $showingDeleteBudgetAlert,
                actions: {
                    Button("Cancel", role: .cancel) { }
                    Button("Delete", role: .destructive) {
                        modelContext.delete(budget)
                        dismiss()
                    }
                },
                message: { Text(alertMessage) }
            )
            .overlay {
                if !isNew {
                    DeleteButton(
                        itemName: "Budget",
                        showingAlert: $showingDeleteBudgetAlert
                    )
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: dismissView)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Group {
                        if isNew {
                            Button("Save", action: saveBudget)
                        } else {
                            Button("Done", action: dismissView)
                        }
                    }
                    .disabled(!budget.name.isAboveMinimumLength())
                }
            }
        }
    }
    
    private func dismissView() {
        dismiss()
    }
    
    private func saveBudget() {
        modelContext.insert(budget)
        dismiss()
    }
}

#Preview("New budget") {
    BudgetDetails(
        budget: Budget(sortingIndex: 99),
        isNew: true
    )
}

#Preview("Existing budget") {
    BudgetDetails(budget: SampleData.shared.budget)
}
