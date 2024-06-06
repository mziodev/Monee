//
//  Category.swift
//  Monee
//
//  Created by MZiO on 17/5/24.
//

import Foundation
import SwiftData

@Model
class Category {
    var name: String
    
    @Relationship(deleteRule: .cascade)
    var transactions = [Transaction]()
    
    
    // MARK: - init
    init(name: String = "") {
        self.name = name
    }
}


// MARK: - sample data extension
extension Category {
    static let sampleData = [
        Category(name: "Alimentación"),
        Category(name: "Electricidad"),
        Category(name: "Fibra"),
        Category(name: "Ropa y cosmética"),
        Category(name: "Salud"),
        Category(name: "Gasolina"),
        Category(name: "Seguro coche"),
        Category(name: "Para ingresar"),
    ]
}
