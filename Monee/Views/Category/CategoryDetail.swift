//
//  CategoryDetail.swift
//  Monee
//
//  Created by MZiO on 3/6/24.
//

import SwiftData
import SwiftUI

struct CategoryDetail: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var category: Category
    
    @FocusState private var nameTextFieldFocused: Bool
    
    let isNew: Bool
    
    
    // MARK: - init
    init(category: Category, isNew: Bool = false) {
        self.category = category
        self.isNew = isNew
    }
    
    
    // MARK: - body
    var body: some View {
        NavigationStack {
            Form {
                TextField("Category name", text: $category.name)
                    .focused($nameTextFieldFocused)
            }
            .navigationTitle("Edit category")
            .navigationBarTitleDisplayMode(.inline)
            
            
            // MARK: - onAppear
            .onAppear {
                nameTextFieldFocused.toggle()
            }
            
            
            // MARK: - toolbar
            .toolbar {
                if isNew {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            modelContext.insert(category)
                            
                            dismiss()
                        }
                    }
                    
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { dismiss() }
                    }
                } else {
                    ToolbarItem(placement: .primaryAction) {
                        Button("Done") {
                            dismiss()
                        }
                    }
                }
        }
        }
    }
}


// MARK: - previews
#Preview("New category") {
    NavigationStack {
        CategoryDetail(category: Category(name: ""), isNew: true)
    }
}

#Preview("Existing category") {
    CategoryDetail(category: SampleData.shared.category)
}
