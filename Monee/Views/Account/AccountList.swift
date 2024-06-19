//
//  AccountList.swift
//  Monee
//
//  Created by MZiO on 18/5/24.
//

import SwiftData
import SwiftUI

struct AccountList: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: \Account.name) var accounts: [Account]
    
    @State private var showingAddAccountSheet: Bool = false
    
    private var allAccountsTotalAmount: Decimal {
        accounts.reduce(0) { $0 + $1.amount }
    }
    private var allAccountsTotalTransactions: Int {
        accounts.reduce(0) { $0 + $1.transactions.count }
    }
    
    
    var body: some View {
        NavigationStack {
            List {
                Section("My accounts") {
                    ForEach(accounts) { account in
                        NavigationLink {
                            TransactionList(account: account)
                        } label: {
                            AccountListRow(
                                name: account.name,
                                amount: account.amount,
                                transactionsNumber: account.transactions.count
                            )
                        }
                    }
                    .onDelete(perform: deleteAccounts)
                }
                
                Section() {
                    NavigationLink {
                        TransactionList()
                    } label: {
                        AccountListRow(
                            name: "All accounts",
                            amount: allAccountsTotalAmount,
                            transactionsNumber: allAccountsTotalTransactions
                        )
                    }
                }
            }
            .navigationTitle("Accounts")
            .sheet(isPresented: $showingAddAccountSheet) {
                NavigationStack {
                    AccountDetail(account: Account(), isNew: true)
                } 
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
                
                ToolbarItem {
                    Button {
                        showingAddAccountSheet.toggle()
                    } label: {
                        Label("Add account", systemImage: "plus")
                    }
                }
            }
        }
    }
    
    
    private func deleteAccounts(offsets: IndexSet) {
        offsets.forEach { modelContext.delete(accounts[$0]) }
    }
}

#Preview {
    AccountList()
        .modelContainer(SampleData.shared.modelContainer)
}
