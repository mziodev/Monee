//
//  TransactionList.swift
//  Monee
//
//  Created by MZiO on 4/6/24.
//

/*
    TODO:
    
    Search info for properly delete each transaction with .onDelete
 
 */

import SwiftData
import SwiftUI

struct TransactionList: View {
    let account: Account?
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(
        sort: [
            SortDescriptor(\Transaction.date, order: .reverse),
            SortDescriptor(\Transaction.payee?.name)
        ]
    ) var transactions: [Transaction]
    
    @State private var showingAccountDetailSheet: Bool = false
     
    
    // MARK: - computed propeties
    private var transactionsGroupedByDate: [(Date, [Transaction])] {
        Dictionary(grouping: transactions) {
            Calendar.current.startOfDay(for: $0.date)
        }
        .sorted { $0.key > $1.key }
        .map { ($0.key, $0.value) }
    }
    
    
    //MARK: - init
    init(account: Account? = nil) {
        self.account = account
        
        let accountName = self.account?.name ?? ""
        
        if self.account != nil {
            _transactions = Query(
                filter: #Predicate { $0.account?.name == accountName },
                sort: [
                    SortDescriptor(\Transaction.date, order: .reverse),
                    SortDescriptor(\Transaction.payee?.name)
                ])
        }
    }
    
    
    // MARK: - body
    var body: some View {
        NavigationStack {
            List {
                ForEach(transactionsGroupedByDate, id: \.0) {
                    date,
                    transactions in
                    Section(date.formatted(date: .abbreviated, time: .omitted)) {
                        ForEach(
                            Array(zip(transactions.indices, transactions)),
                            id: \.1
                        ) { index, transaction in
                            NavigationLink {
                                TransactionDetail(transaction: transaction)
                            } label: {
                                TransactionListRow(
                                    payeeName: transaction.payee?.name,
                                    categoryName: transaction.category?.name,
                                    amount: transaction.amount
                                )
                            }
                        }
                        .onDelete { offsets in
                            for offset in offsets {
                                let transactionToDelete = transactions[offset]
                                
                                modelContext.delete(transactionToDelete)
                            }
                        }
                    }
                }
            }
            .navigationTitle(account != nil ? account!.name : "All accounts")
            .navigationBarTitleDisplayMode(.inline)
            
            
            // MARK: - edit account sheet
            .sheet(isPresented: $showingAccountDetailSheet) {
                if let account = self.account {
                    NavigationStack {
                        AccountDetail(account: account)
                            .interactiveDismissDisabled()
                    }
                }
            }
            
            
            // MARK: - toolbar
            .toolbar {
                if account != nil {
                    ToolbarItem {
                        Button {
                            showingAccountDetailSheet.toggle()
                        } label: {
                            Label("Edit account", systemImage: "square.and.pencil")
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
        }
    }
}


// MARK: - previews
#Preview("All accounts") {
    TransactionList()
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Filtered by account") {
    TransactionList(account: SampleData.shared.account)
        .modelContainer(SampleData.shared.modelContainer)
}
