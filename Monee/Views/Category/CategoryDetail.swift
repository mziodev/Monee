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
    
    @Query(sort: \Category.name) var categories: [Category]
    
    @Bindable var category: Category
    
    @FocusState private var nameTextFieldFocused: Bool
    
    @State private var showingDuplicateAlert: Bool = false
    
    let isNew: Bool
    
    private var isCategoryNameValid: Bool {
        ValidationUtilities.isAboveMinimumLength(category.name)
    }
    
    init(category: Category, isNew: Bool = false) {
        self.category = category
        self.isNew = isNew
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Category name", text: $category.name)
                    .focused($nameTextFieldFocused)
            }
            .navigationTitle("Edit category")
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled()
            .alert(
                "Duplicate category name!",
                isPresented: $showingDuplicateAlert,
                actions: { },
                message: {
                    Text("There is already a catagory named '\(category.name)'")
                }
            )
            .onAppear {
                if isNew { nameTextFieldFocused = true }
            }
            .toolbar {
                if isNew {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save", action: addCategory)
                            .disabled(!isCategoryNameValid)
                    }
                    
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { dismiss() }
                    }
                } else {
                    ToolbarItem(placement: .primaryAction) {
                        Button("Done") { dismiss() }
                            .disabled(!isCategoryNameValid)
                    }
                }
            }
        }
    }
    
    
    private func addCategory() {
        if categories.contains(where: { $0.name == category.name }) {
            showingDuplicateAlert = true
        } else {
            modelContext.insert(category)
            dismiss()
        }
    }
}

#Preview("New category") {
    CategoryDetail(category: Category(name: ""), isNew: true)
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Existing category") {
    CategoryDetail(category: SampleData.shared.category)
}
