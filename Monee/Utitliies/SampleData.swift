//
//  SampleData.swift
//  Monee
//
//  Created by MZiO on 17/5/24.
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
    
    private init() {
        let schema = Schema([
            Account.self,
            Category.self,
            Payee.self,
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
    
    func insertSampleData() {
        for account in Account.sampleData {
            modelContext.insert(account)
        }
        
        for category in Category.sampleData {
            modelContext.insert(category)
        }
        
        for payee in Payee.sampleData {
            modelContext.insert(payee)
        }
        
//        Friend.sampleData[0].favoriteMovie = Movie.sampleData[1]
//        Friend.sampleData[2].favoriteMovie = Movie.sampleData[0]
//        Friend.sampleData[3].favoriteMovie = Movie.sampleData[4]
//        Friend.sampleData[4].favoriteMovie = Movie.sampleData[0]
        
        do {
            try modelContext.save()
        } catch {
            print("Sample data modelContext failed to save.")
        }
    }
    
    var account: Account {
        Account.sampleData[0]
    }
    
    var category: Category {
        Category.sampleData[0]
    }
    
    var payee: Payee {
        Payee.sampleData[0]
    }
}
