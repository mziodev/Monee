//
//  AccountList.swift
//  Monee
//
//  Created by MZiO on 21/8/24.
//

import SwiftUI

struct AccountList: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var budget: Budget
    
    @State private var selectedAccountHolder = SelectedItemHolder()
    @State private var showingAddAccountSheet = false
    @State private var showingAccountDetailsSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                if !budget.accounts.isEmpty {
                    Section {
                        ForEach(budget.accounts.sortedBySortingIndex) { account in
                            if account.isOpen {
                                AccountListRow(account: account)
                                    .swipeActions {
                                        detailsSwipeAction(
                                            account: account
                                        )
                                    }
                            }
                        }
                        .onMove(perform: moveAccount)
                    } header: {
                        Text("Open accounts")
                    } footer: {
                        AccountListSectionFooter(
                            totalInAccounts: budget.accounts.totalInAccounts
                        )
                    }
                    
                    Section("Closed Accounts") {
                        ForEach(budget.accounts.sortedBySortingIndex) { account in
                            if !account.isOpen {
                                AccountListRow(account: account)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Accounts")
            .navigationBarTitleDisplayMode(.inline)
            .overlay {
                if budget.accounts.isEmpty {
                    AccountEmpty()
                }
            }
            .sheet(isPresented: $showingAddAccountSheet) {
                AccountDetails(
                    budget: budget,
                    account: Account(sortingIndex: budget.accounts.count),
                    isNew: true
                )
            }
            .sheet(isPresented: $showingAccountDetailsSheet) {
                if let account = selectedAccountHolder.account {
                    AccountDetails(
                        budget: budget,
                        account: account,
                        isNew: true
                    )
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                
                ToolbarItem {
                    Button {
                        showingAddAccountSheet = true
                    } label: {
                        Label("Add account", systemImage: "plus")
                    }
                }
                
                if !budget.accounts.isEmpty {
                    ToolbarItem {
                        EditButton()
                    }
                    
                    ToolbarItem(placement: .status) {
                        Text("\(budget.accounts.count) accounts")
                            .font(.caption)
                    }
                }
            }
        }
    }
    
    private func moveAccount(from source: IndexSet, to destination: Int) {
        var accountsToMove = budget.accounts.sorted {
            $0.sortingIndex < $1.sortingIndex
        }
        
        accountsToMove.move(fromOffsets: source, toOffset: destination)
        accountsToMove.enumerated().forEach { index, account in
            account.sortingIndex = index
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    private func detailsSwipeAction(account: Account) -> some View {
        Button {
            selectedAccountHolder.account = account
            DispatchQueue.main.async {
                showingAccountDetailsSheet = true
            }
        } label: {
            Label("Edit account", systemImage: "info.circle")
        }
        .tint(.orange)
    }
}

#Preview("No accounts budget") {
    AccountList(budget: SampleData.shared.budgetNoAccounts)
}

#Preview("Budget with accounts") {
    AccountList(budget: SampleData.shared.budget)
}
