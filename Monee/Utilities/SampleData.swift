//
//  SampleData.swift
//  Monee
//
//  Created by MZiO on 5/8/24.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
    static let shared = SampleData()
    
    let modelContainer: ModelContainer
    
    var modelContext: ModelContext {
        modelContainer.mainContext
    }
    
    var budget: Budget {
        Budget.sampleData[0]
    }
    
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
        for budget in Budget.sampleData {
            modelContext.insert(budget)
        }
    }
}
