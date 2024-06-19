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
            .sheet(isPresented: $showingAddCategorySheet) {
                CategoryDetail(category: Category(), isNew: true) 
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        showingAddCategorySheet = true
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
    
    
    func deleteCategories(offsets: IndexSet) {
        offsets.forEach { modelContext.delete(categories[$0]) }
    }
}


#Preview {
    CategoryList()
        .modelContainer(SampleData.shared.modelContainer)
}
