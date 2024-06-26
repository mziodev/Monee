//
//  MoneeApp.swift
//  Monee
//
//  Created by MZiO on 17/5/24.
//

import SwiftData
import SwiftUI

@main
struct MoneeApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Account.self,
            Category.self,
            Payee.self,
            Transaction.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            TransactionList()
        }
        .modelContainer(sharedModelContainer)
    }
}
