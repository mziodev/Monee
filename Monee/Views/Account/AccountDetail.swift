//
//  AccountDetail.swift
//  Monee
//
//  Created by MZiO on 18/5/24.
//

import SwiftData
import SwiftUI

struct AccountDetail: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Query(sort: \Account.name) var accounts: [Account]
    
    @Bindable var account: Account
    
    @FocusState var nameTextFieldFocused: Bool
    
    @State private var showingDuplicateAlert: Bool = false
    
    let isNew: Bool
    
    private var isAccountNameValid: Bool {
        ValidationUtilities.isAboveMinimumLength(account.name)
    }
    
    init(account: Account, isNew: Bool = false) {
        self.account = account
        self.isNew = isNew
    }
    
    var body: some View {
        VStack {
            Image(systemName: "building.columns.fill")
                .font(.system(size: 120))
                .foregroundStyle(.tint)
                .padding(.top)
            
            Form {
                Section("Account info") {
                    TextField("Account name", text: $account.name)
                        .padding(.horizontal, 5)
                        .focused($nameTextFieldFocused)
                    
                    TextField(
                        "Account amount",
                        value: $account.amount,
                        format: .currency(code: FormatUtilities.currencyCode)
                    )
                    .padding(.horizontal, 5)
                    .keyboardType(.decimalPad)
                    
                    Picker("Account type", selection: $account.type) {
                        ForEach(AccountType.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                    .padding(.horizontal, 5)
                }
            }
        }
        .navigationTitle(isNew ? "New account" : account.name)
        .navigationBarTitleDisplayMode(.inline)
        .interactiveDismissDisabled()
        .onAppear {
            if isNew { nameTextFieldFocused.toggle() }
        }
        .alert(
            "Duplicate account name!",
            isPresented: $showingDuplicateAlert,
            actions: { },
            message: { Text("There is already an account named '\(account.name)'") }
        )
        .toolbar {
            if isNew {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: addAccount)
                        .disabled(!isAccountNameValid)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            } else {
                ToolbarItem {
                    Button("Done") { dismiss() }
                        .disabled(!isAccountNameValid)
                }
            }
        }
    }

    
    private func addAccount() {
        if accounts.contains(where: { $0.name == account.name }) {
            showingDuplicateAlert = true
        } else {
            modelContext.insert(account)
            dismiss()
        }
    }
}

#Preview("New account") {
    NavigationStack {
        AccountDetail(account: Account(), isNew: true)
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Existing account") {
    NavigationStack {
        AccountDetail(account: SampleData.shared.account)
    }
}
