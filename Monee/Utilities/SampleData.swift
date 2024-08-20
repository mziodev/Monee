//
//  SampleData.swift
//  Monee
//
//  Created by MZiO on 19/8/24.
//

import SwiftData
import Foundation

@MainActor
class SampleData {
    static let shared = SampleData()
    
    let modelContainer: ModelContainer
    var modelContext: ModelContext { modelContainer.mainContext }
    
    var budget: Budget { Budget.sampleData[0] }
    var budgetNoAccounts: Budget { Budget.sampleData[1] }
    
    init() {
        let schema = Schema([
            Budget.self,
        ])
        
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: true
        )
        
        do {
            modelContainer = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
            
            insertSampleData()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    private func insertSampleData() {
        Budget.sampleData.forEach { modelContext.insert($0) }
    }
}