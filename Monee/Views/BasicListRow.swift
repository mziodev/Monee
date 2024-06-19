//
//  BasicListRow.swift
//  Monee
//
//  Created by MZiO on 4/6/24.
//

import SwiftUI

struct BasicListRow: View {
    let name: String
    let transactionsNumber: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.headline)
            
            Text("^[\(transactionsNumber) transactions](inflect: true)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview("One transaction") {
    List {
        BasicListRow(name: "Item name", transactionsNumber: 1)
    }
}

#Preview("Several transactions") {
    List {
        BasicListRow(name: "Item name", transactionsNumber: 3)
    }
}
