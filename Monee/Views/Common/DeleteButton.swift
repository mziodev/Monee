//
//  DeleteButton.swift
//  Monee
//
//  Created by MZiO on 20/8/24.
//

import SwiftUI

struct DeleteButton: View {
    var itemName: String
    
    @Binding var showingAlert: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            Button(
                "Delete \(itemName)",
                role: .destructive
            ) {
                showingAlert = true
            }
            .padding(.horizontal, 10)
            .frame(maxWidth: 250, maxHeight: 44)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(.rect(cornerRadius: 12))
            .padding(.bottom, 10)
        }
    }
}

#Preview {
    DeleteButton(itemName: "Budget", showingAlert: .constant(false))
}
