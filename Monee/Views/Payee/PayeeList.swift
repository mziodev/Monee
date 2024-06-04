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
    
    
    // MARK: - body
    var body: some View {
        NavigationStack {
            List {
                ForEach(payees) { payee in
                    NavigationLink {
                        PayeeDetail(payee: payee)
                    } label: {
                        Text(payee.name)
                    }
                }
                .onDelete(perform: deletePayees)
            }
            .navigationTitle("Payees")
            
            
            // MARK: - add payee sheet
            .sheet(isPresented: $showingAddPayeeSheet) {
                PayeeDetail(payee: Payee(), isNew: true)
                    .interactiveDismissDisabled()
            }
            
            
            // MARK: - toolbar
            .toolbar {
                ToolbarItem {
                    Button {
                        showingAddPayeeSheet.toggle()
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
    
    
    // MARK: - functions
    func deletePayees(indexSet: IndexSet) {
        for index in indexSet {
            modelContext.delete(payees[index])
        }
    }
}


// MARK: - preview
#Preview {
    PayeeList()
        .modelContainer(SampleData.shared.modelContainer)
}
