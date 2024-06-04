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
                    NavigationLink(
                        destination: CategoryDetail(category: category)
                    ) {
                        Text(category.name)
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
    
    func deleteCategories(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(categories[index])
        }
    }
}

#Preview {
    CategoryList()
        .modelContainer(SampleData.shared.modelContainer)
}
