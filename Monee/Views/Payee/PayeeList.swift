//
//  PayeeList.swift
//  Monee
//
//  Created by MZiO on 4/6/24.
//

import SwiftData
import SwiftUI

struct PayeeList: View {
    @Query(sort: \Payee.name) private var payees: [Payee]
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var showingAddPayeeSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(payees) { payee in
                    NavigationLink {
                        PayeeDetail(payee: payee)
                    } label: {
                        BasicListRow(
                            name: payee.name,
                            transactionsNumber: payee.transactions.count
                        )
                    }
                }
                .onDelete(perform: deletePayees)
            }
            .navigationTitle("Payees")
            .sheet(isPresented: $showingAddPayeeSheet) {
                PayeeDetail(payee: Payee(), isNew: true)
                    .interactiveDismissDisabled()
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        showingAddPayeeSheet = true
                    } label: {
                        Label("Add payee", systemImage: "plus")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
        }
    }
    
    func deletePayees(offsets: IndexSet) {
        offsets.forEach { modelContext.delete(payees[$0]) }
    }
}

#Preview {
    PayeeList()
        .modelContainer(SampleData.shared.modelContainer)
}
