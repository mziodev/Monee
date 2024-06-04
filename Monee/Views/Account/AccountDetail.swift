//
//  AccountDetail.swift
//  Monee
//
//  Created by MZiO on 18/5/24.
//

import SwiftUI

struct AccountDetail: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Bindable var account: Account
    
    @FocusState var nameTextFieldFocused: Bool
    
    let isNew: Bool
    
    
    // MARK: - init
    init(account: Account, isNew: Bool = false) {
        self.account = account
        self.isNew = isNew
    }
    
    
    // MARK: - body
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
                        format: .currency(
                            code: Account.currencyLocaleIdentifier
                        )
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
        
        
        // MARK: - onAppear
        .onAppear {
            if isNew { nameTextFieldFocused.toggle() }
        }
        
        
        // MARK: - toolbar
        .toolbar {
            if isNew {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { dismiss() }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            } else {
                ToolbarItem {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}


// MARK: - previews
#Preview("New account") {
    NavigationStack {
        AccountDetail(
            account: Account(),
            isNew: true
        )
        .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Existing account") {
    NavigationStack {
        AccountDetail(account: SampleData.shared.account)
    }
}
