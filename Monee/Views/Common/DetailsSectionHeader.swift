//
//  DetailsHeadSymbol.swift
//  Monee
//
//  Created by MZiO on 19/8/24.
//

import SwiftUI

struct DetailsSectionHeader: View {
    let imageName: String
    let description: String
    
    var body: some View {
        HStack {
            Spacer()
            
            Image(systemName: imageName)
                .font(.system(size: 100))
                .foregroundStyle(Color.accentColor)
                .accessibilityLabel(description)
            
            Spacer()
        }
    }
}

#Preview {
    let budget = SampleData.shared.budget
    
    return DetailsSectionHeader(
        imageName: budget.type.systemImage,
        description: budget.type.localizedDescription
    )
}
