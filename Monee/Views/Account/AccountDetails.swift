//
//  AccountDetails.swift
//  Monee
//
//  Created by MZiO on 21/8/24.
//

import SwiftData
import SwiftUI

struct AccountDetails: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var budget: Budget
    @Bindable var account: Account
    
    @FocusState private var nameTextFieldFocused: Bool
    
    @State private var showingCloseAccountAlert = false
    
    let isNew: Bool
    
    init(
        budget: Budget,
        account: Account,
        isNew: Bool = false
    ) {
        self.account = account
        self.budget = budget
        self.isNew = isNew
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    DetailsSectionHeader(
                        imageName: account.type.systemImage,
                        description: account.type.localizedDescription
                    )
                }
                .listRowBackground(Color.clear)
                .listSectionSpacing(-5)
                
                Section("Account info") {
                    TextField("Name", text: $account.name)
                        .focused($nameTextFieldFocused)
                    
                    TextField(
                        "Amount",
                        value: $account.amount,
                        format: .currency(code: Format.currencyCode)
                    )
                    .fontDesign(.rounded)
                    .foregroundStyle(
                        Format.getColor(for: account.amount ?? 0)
                    )
                    .keyboardType(.decimalPad)
                    
                    Picker(
                        "Account type",
                        selection: $account.type.animation()
                    ) {
                        ForEach(AccountType.allCases, id: \.self) { type in
                            Text(type.localizedDescription)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .navigationTitle(isNew ? "New Account" : "Edit Account")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if isNew {
                    nameTextFieldFocused = true
                }
            }
            .overlay {
                if !isNew {
                    if account.isOpen {
                        DeleteButton(
                            title: "Close Account",
                            showingAlert: $showingCloseAccountAlert
                        )
                    } else {
                        // show open account button
                    }
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
                                budget.accounts.append(account)
                                
                                dismiss()
                            }
                        } else {
                            Button("Done") { dismiss() }
                        }
                    }
                    .disabled(!account.name.isAboveMinimumLength())
                }
            }
        }
    }
}

#Preview("New account") {
    AccountDetails(
        budget: SampleData.shared.budget,
        account: Account(sortingIndex: 2),
        isNew: true
    )
}

#Preview("Existing Open Account") {
    AccountDetails(
        budget: SampleData.shared.budget,
        account: SampleData.shared.openAccount
    )
}
