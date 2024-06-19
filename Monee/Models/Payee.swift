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
    var name: String
    
    @Relationship(deleteRule: .cascade)
    var transactions = [Transaction]()
    
    
    init(name: String = "") {
        self.name = name
    }
}
