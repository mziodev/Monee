//
//  RemoveZerosFromEnd.swift
//  Monee
//
//  Created by MZiO on 29/5/24.
//

import Foundation

extension Double {
    func currencyFormatter() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        formatter.minimumFractionDigits = 0 // minimum digits after dot (ending zeros case)
        formatter.maximumFractionDigits = 2 //maximum digits after dot (maximum precision)
        
        return String(formatter.string(from: number) ?? "")
    }
}
