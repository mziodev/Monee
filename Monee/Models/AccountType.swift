//
//  AccountType.swift
//  Monee
//
//  Created by MZiO on 29/5/24.
//

import Foundation

enum AccountType: String, Codable, CaseIterable {
    case cash
    case savings
    case checking
    
    var id: Self { self }
}
