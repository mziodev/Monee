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
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

extension Category {
    static let sampleData = [
        Category(name: "Alimentación"),
        Category(name: "Electricidad"),
        Category(name: "Fibra"),
        Category(name: "Ropa"),
        Category(name: "Salud"),
        Category(name: "Gasolina"),
        Category(name: "Seguro coche"),
        Category(name: "Para ingresar"),
    ]
}
