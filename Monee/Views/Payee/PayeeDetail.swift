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
    
    @Bindable var payee: Payee
    
    @FocusState private var nameTextFieldFocused: Bool
    
    let isNew: Bool
    
    
    // MARK: - init
    init(payee: Payee, isNew: Bool = false) {
        self.payee = payee
        self.isNew = isNew
    }
    
    
    // MARK: - body
    var body: some View {
        NavigationStack {
            Form {
                TextField("Payee name", text: $payee.name)
                    .focused($nameTextFieldFocused)
            }
            .navigationTitle("Edit payee")
            .navigationBarTitleDisplayMode(.inline)
            
            
            // MARK: - onAppear
            .onAppear {
                if isNew { nameTextFieldFocused.toggle() }
            }
            
            
            // MARK: - toolbar
            .toolbar {
                if isNew {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { dismiss() }
                    }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            modelContext.insert(payee)
                            
                            dismiss()
                        }
                        .disabled(payee.name.isEmpty)
                    }
                } else {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") { dismiss () }
                            .disabled(!nameTextFieldFocused)
                    }
                }
            }
        }
    }
}


// MARK: - previews
#Preview("New payee") {
    PayeeDetail(payee: Payee(), isNew: true)
}

#Preview("Existing payee") {
    PayeeDetail(payee: SampleData.shared.payee)
}
