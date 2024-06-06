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
            Transaction.self,
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
        
        for transaction in Transaction.sampleData {
            modelContext.insert(transaction)
        }
        
        
        // MARK: - transactions
        // account transactions
        Account.sampleData[0].transactions = [
            Transaction.sampleData[0],
            Transaction.sampleData[1],
            Transaction.sampleData[3],
            Transaction.sampleData[6],
        ]
        
        Account.sampleData[1].transactions = [
            Transaction.sampleData[2],
            Transaction.sampleData[4],
            Transaction.sampleData[5],
        ]
        
        // payee transactions
        Payee.sampleData[0].transactions = [
            Transaction.sampleData[0],
        ]
        
        Payee.sampleData[1].transactions = [
            Transaction.sampleData[4],
        ]
        
        Payee.sampleData[2].transactions = [
            Transaction.sampleData[1],
            Transaction.sampleData[5],
        ]
        
        Payee.sampleData[5].transactions = [
            Transaction.sampleData[1],
        ]
        
        Payee.sampleData[9].transactions = [
            Transaction.sampleData[2],
            Transaction.sampleData[6],
        ]
        
        Payee.sampleData[10].transactions = [
            Transaction.sampleData[3],
        ]
        
        // category transactions
        Category.sampleData[0].transactions = [
            Transaction.sampleData[0],
            Transaction.sampleData[4],
        ]
        
        Category.sampleData[3].transactions = [
            Transaction.sampleData[3],
            Transaction.sampleData[5],
        ]
        
        Category.sampleData[5].transactions = [
            Transaction.sampleData[1],
        ]
        
        Category.sampleData[7].transactions = [
            Transaction.sampleData[2],
            Transaction.sampleData[6],
        ]
        
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
    
    var transaction: Transaction {
        Transaction.sampleData[0]
    }
}
