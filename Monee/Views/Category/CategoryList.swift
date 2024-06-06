//
//  CategoryList.swift
//  Monee
//
//  Created by MZiO on 3/6/24.
//

import SwiftData
import SwiftUI

struct CategoryList: View {
    @Query(sort: \Category.name) private var categories: [Category]
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var showingAddCategorySheet: Bool = false
    
    
    // MARK: - body
    var body: some View {
        NavigationStack {
            List {
                ForEach(categories) { category in
                    NavigationLink {
                        CategoryDetail(category: category)
                    } label: {
                        BasicListRow(
                            name: category.name,
                            transactionsNumber: category.transactions.count
                        )
                    }
                }
                .onDelete(perform: deleteCategories)
            }
            .navigationTitle("Categories")
            
            
            // MARK: - add category sheet
            .sheet(isPresented: $showingAddCategorySheet) {
                CategoryDetail(category: Category(), isNew: true)
                    .interactiveDismissDisabled()
            }
            
            
            // MARK: - toolbar
            .toolbar {
                ToolbarItem {
                    Button {
                        showingAddCategorySheet.toggle()
                    } label: {
                        Label("Add category", systemImage: "plus")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
        }
    }
    
    
    // MARK: - functions
    func deleteCategories(indexSet: IndexSet) {
        for index in indexSet {
            modelContext.delete(categories[index])
        }
    }
}


// MARK: - previews
#Preview {
    CategoryList()
        .modelContainer(SampleData.shared.modelContainer)
}
