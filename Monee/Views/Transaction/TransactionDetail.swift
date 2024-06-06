//
//  TransactionDetail.swift
//  Monee
//
//  Created by MZiO on 4/6/24.
//

import SwiftData
import SwiftUI

struct TransactionDetail: View {
    @Query(sort: \Account.name) private var accounts: [Account]
    @Query(sort: \Payee.name) private var payees: [Payee]
    @Query(sort: \Category.name) private var categories: [Category]
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var transaction: Transaction
    
    let isNew: Bool
    
    
    // MARK: - init
    init(transaction: Transaction, isNew: Bool = false) {
        self.transaction = transaction
        self.isNew = isNew
    }
    
    
    // MARK: - body
    var body: some View {
        NavigationStack {
            VStack {
                TextField(
                    "Amount",
                    value: $transaction.amount,
                    format: .currency(code: Transaction.currencyCode)
                )
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.center)
                .font(.system(size: 50, weight: .heavy, design: .serif))
                .padding(.top, 50)
                .padding(.bottom, 10)
                .foregroundStyle(transaction.amount < 0 ? .red : .primary)
                
                
                // MARK: - form
                Form {
                    Section {
                        Picker("Account", selection: $transaction.account) {
                            Text("None")
                                .tag(nil as Account?)
                            
                            ForEach(accounts, id: \.self) { account in
                                Text(account.name)
                                    .tag(account as Account?)
                            }
                        }
                        .pickerStyle(.navigationLink)
                        
                        Picker("Payee", selection: $transaction.payee) {
                            Text("None")
                                .tag(nil as Payee?)
                            
                            ForEach(payees, id: \.self) { payee in
                                Text(payee.name)
                                    .tag(payee as Payee?)
                            }
                        }
                        .pickerStyle(.navigationLink)
                        
                        Picker("Category", selection: $transaction.category) {
                            Text("None")
                                .tag(nil as Category?)
                            
                            ForEach(categories, id: \.self) { category in
                                Text(category.name)
                                    .tag(category as Category?)
                            }
                        }
                        .pickerStyle(.navigationLink)
                    }
                    
                    Section {
                        DatePicker("Date", selection: $transaction.date, displayedComponents: .date)
                        
                        TextField(
                            "Memo",
                            text: $transaction.memo,
                            axis: .vertical
                        )
                        .lineLimit(5)
                    }
                }
                .navigationTitle(
                    isNew ? "New transaction" : "Edit transaction"
                )
            }
            .navigationBarTitleDisplayMode(.inline)
            
            
            // MARK: - toolbar
            .toolbar {
                if isNew {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { dismiss() }
                    }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            modelContext.insert(transaction)
                            
                            dismiss()
                        }
                    }
                } else {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") { dismiss() }
                    }
                }
            }
        }
    }
}


// MARK: - previews
#Preview("New transaction") {
    TransactionDetail(transaction: Transaction(), isNew: true)
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Existing transaction") {
    TransactionDetail(transaction: SampleData.shared.transaction)
        .modelContainer(SampleData.shared.modelContainer)
}
