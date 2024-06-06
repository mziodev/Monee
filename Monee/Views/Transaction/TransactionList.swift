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
    let accountName: String
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(
        sort: [
            SortDescriptor(\Transaction.date, order: .reverse),
            SortDescriptor(\Transaction.payee?.name)
        ]
    ) var transactions: [Transaction]
    
    @State private var showingAddTransactionSheet: Bool = false
     
    
    // MARK: - computed propeties
    private var transactionsGroupedByDate: [(Date, [Transaction])] {
        Dictionary(grouping: transactions) {
            Calendar.current.startOfDay(for: $0.date)
        }
        .sorted { $0.key > $1.key }
        .map { ($0.key, $0.value) }
    }
    
    
    //MARK: - init
    init(accountName: String = "") {
        self.accountName = accountName
        
        if !self.accountName.isEmpty {
            _transactions = Query(
                filter: #Predicate { $0.account?.name == accountName ?? "" },
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
            .navigationTitle("Transactions")
            
            
            // MARK: - add transaction sheet
            .sheet(isPresented: $showingAddTransactionSheet) {
                TransactionDetail(
                    transaction: Transaction(),
                    isNew: true
                )
                .interactiveDismissDisabled()
            }
            
            
            // MARK: - toolbar
            .toolbar {
                ToolbarItem {
                    Button {
                        showingAddTransactionSheet.toggle()
                    } label: {
                        Label("Add transaction", systemImage: "plus")
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
#Preview("All accounts list") {
    TransactionList()
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Filtered by account list") {
    TransactionList(accountName: "Sabadell")
        .modelContainer(SampleData.shared.modelContainer)
}
