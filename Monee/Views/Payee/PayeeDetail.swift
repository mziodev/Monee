//
//  PayeeDetail.swift
//  Monee
//
//  Created by MZiO on 4/6/24.
//

import SwiftData
import SwiftUI

struct PayeeDetail: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Query(sort: \Payee.name) var payees: [Payee]
    
    @Bindable var payee: Payee
    
    @FocusState private var nameTextFieldFocused: Bool
    
    @State private var showingDuplicatePayeeNameAlert: Bool = false
    
    let isNew: Bool
    
    private var isPayeeNameValid: Bool {
        ValidationUtilities.isAboveMinimumLength(payee.name)
    }

    init(payee: Payee, isNew: Bool = false) {
        self.payee = payee
        self.isNew = isNew
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Payee name", text: $payee.name)
                    .focused($nameTextFieldFocused)
            }
            .navigationTitle("Edit payee")
            .navigationBarTitleDisplayMode(.inline)
            .alert(
                "Duplicate payee name!",
                isPresented: $showingDuplicatePayeeNameAlert,
                actions: { },
                message: {
                    Text("There is already a payee named '\(payee.name)'")
                }
            )
            .onAppear {
                if isNew { nameTextFieldFocused = true }
            }
            .toolbar {
                if isNew {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { dismiss() }
                    }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save", action: savePayee)
                            .disabled(!isPayeeNameValid)
                    }
                } else {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") { dismiss () }
                            .disabled(!isPayeeNameValid)
                    }
                }
            }
        }
    }
    
    private func savePayee() {
        if payees.contains(where: { $0.name == payee.name }) {
            showingDuplicatePayeeNameAlert = true
        } else {
            modelContext.insert(payee)
            dismiss()
        }
    }
}

#Preview("New payee") {
    PayeeDetail(payee: Payee(), isNew: true)
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Existing payee") {
    PayeeDetail(payee: SampleData.shared.payee)
}
