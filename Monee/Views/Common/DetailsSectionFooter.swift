//
//  DetailsSectionFooter.swift
//  Monee
//
//  Created by MZiO on 20/8/24.
//

import SwiftUI

struct DetailsSectionFooter: View {
    let date: Date
    
    var body: some View {
        HStack(spacing: 5) {
            Spacer()
            
            Text("Created on:")
                .font(.caption.smallCaps())
            
            Text(
                date.formatted(
                    date: .abbreviated,
                    time: .omitted
                )
            )
            .fontDesign(.rounded)
            .bold()
            
            Spacer()
        }
    }
}

#Preview {
    DetailsSectionFooter(date: SampleData.shared.budget.creationDate)
}
