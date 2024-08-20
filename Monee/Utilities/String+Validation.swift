//
//  String+Validation.swift
//  Monee
//
//  Created by MZiO on 19/8/24.
//

import Foundation

extension String {
    func isAboveMinimumLength(minLength: Int = 1) -> Bool {
        self.count > minLength
    }
}
