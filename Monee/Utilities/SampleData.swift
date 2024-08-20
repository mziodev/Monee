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
    var openAccount: Account { Account.sampleData[0] }
    var closedAccount: Account { Account.sampleData[2] }
    
    init() {
        let schema = Schema([
            Account.self,
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
        
        Account.sampleData.forEach {
            modelContext.insert($0)
            Budget.sampleData[0].accounts.append($0)
        }
    }
}
