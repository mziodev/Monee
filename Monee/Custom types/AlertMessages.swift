//
//  AlertMessages.swift
//  Monee
//
//  Created by MZiO on 19/6/24.
//

import Foundation

enum AlertMessages {
    case duplicateModel(modelName: String)
    
    var customDescription: String {
        switch self {
        case let .duplicateModel(name):
            "There is already a category named '\(name)'"
        }
    }
}
