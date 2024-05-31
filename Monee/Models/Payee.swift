//
//  Payee.swift
//  Monee
//
//  Created by MZiO on 17/5/24.
//

import Foundation
import SwiftData

@Model
class Payee {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

extension Payee {
    static let sampleData = [
        Payee(name: "Froiz"),
        Payee(name: "Gadis"),
        Payee(name: "El Corte Inglés"),
        Payee(name: "Amazon"),
        Payee(name: "Decimas"),
        Payee(name: "Carrefour"),
        Payee(name: "O2"),
        Payee(name: "Gas Natural Fenosa"),
        Payee(name: "ACS"),
        Payee(name: "CLRK"),
    ]
}
