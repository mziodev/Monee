//
//  MoneeApp.swift
//  Monee
//
//  Created by MZiO on 19/8/24.
//

import SwiftData
import SwiftUI

@main
struct MoneeApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Account.self,
            Budget.self,
            MonthBudget.self,
        ])
        
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )
        
        do {
            return try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            BudgetList()
                .modelContainer(sharedModelContainer)
        }
    }
}
