//
//  BudgetDetails.swift
//  Monee
//
//  Created by MZiO on 6/8/24.
//

import SwiftData
import SwiftUI

struct BudgetDetails: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var budget: Budget
    
    @FocusState private var nameTextFieldFocused: Bool
    @State private var showingDeleteBudgetAlert = false
    
    let isNew: Bool
    
    init(
        budget: Budget,
        isNew: Bool = false
    ) {
        self.budget = budget
        self.isNew = isNew
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        HStack {
                            Spacer()
                            
                            Image(systemName: budget.type.systemImage)
                                .font(.system(size: 100))
                                .foregroundStyle(Color.accentColor)
                                .accessibilityLabel(
                                    budget.type.localizedSymbolDescription
                                )
                            
                            Spacer()
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listSectionSpacing(0)
                    
                    Section {
                        TextField("Name", text: $budget.name)
                            .focused($nameTextFieldFocused)
                        
                        Picker(
                            "Budget type",
                            selection: $budget.type.animation()
                        ) {
                            ForEach(BudgetType.allCases, id: \.self) { type in
                                Text(type.localizedDescription)
                            }
                        }
                        .pickerStyle(.menu)
                    } header: {
                        Text("Budget info")
                    } footer: {
                        HStack {
                            Spacer()
                            
                            Text(
                                "Created on \(budget.creationDate.formatted(date: .abbreviated, time: .omitted))"
                            )
                        }
                        .padding(.top, 0)
                    }
                }
            }
            .navigationTitle(isNew ? "New budget" : "Edit budget")
            .navigationBarTitleDisplayMode(.inline)
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
                message: {
                    Text("All the budget transactions, payees, categories and accounts will be deleted too.")
                }
            )
            .overlay {
                if !isNew {
                    VStack {
                        Spacer()
                        
                        Button(
                            "Delete \(budget.name) budget",
                            role: .destructive
                        ) {
                            showingDeleteBudgetAlert = true
                        }
                        .padding(.horizontal, 10)
                        .frame(maxWidth: .infinity, maxHeight: 44)
                        .background(.red)
                        .foregroundColor(.white)
                        .clipShape(.rect(cornerRadius: 10))
                        .padding(.bottom, 10)
                    }
                    .padding(.horizontal, 30)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                
                ToolbarItem {
                    Group {
                        if isNew {
                            Button("Save") {
                                modelContext.insert(budget)
                                dismiss()
                            }
                        } else {
                            Button("Done") {
                                dismiss()
                            }
                        }
                    }
                    .disabled(!budget.name.isAboveMinimumLength())
                }
            }
        }
    }
}

#Preview("New budget") {
    BudgetDetails(budget: Budget(sortingIndex: 3), isNew: true)
}

#Preview("Existing budget") {
    BudgetDetails(budget: SampleData.shared.budget)
}
