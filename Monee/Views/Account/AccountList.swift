//
//  AccountList.swift
//  Monee
//
//  Created by MZiO on 18/5/24.
//

import SwiftData
import SwiftUI

struct AccountList: View {
    @Query(sort: \Account.name) private var accounts: [Account]
    
    @Environment(\.modelContext) var modelContext
    
    @State private var newAccount: Account?
    @State private var showingAddAccountSheet: Bool = false
    
    
    // MARK: - body
    var body: some View {
        NavigationStack {
            List {
                ForEach(accounts) { account in
                    NavigationLink {
                        AccountDetail(account: account)
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
            .navigationTitle("Accounts")
            
            
            // MARK: - new account sheet
            .sheet(isPresented: $showingAddAccountSheet) {
                NavigationStack {
                    AccountDetail(account: Account(), isNew: true)
                }
                .interactiveDismissDisabled()
            }
            
            // MARK: - toolbar
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
    
    
    // MARK: - functions
    private func addAccount() {
        withAnimation {
            let newItem = Account(name: "", type: .savings, amount: 0)
            
            modelContext.insert(newItem)
            
            newAccount = newItem
        }
    }
    
    private func deleteAccounts(indexSet: IndexSet) {
        for index in indexSet {
            modelContext.delete(accounts[index])
        }
    }
}

#Preview {
    AccountList()
        .modelContainer(SampleData.shared.modelContainer)
//        .environment(\.locale, Locale(identifier: "es_ES"))
}
