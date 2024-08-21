//
//  AccountEmpty.swift
//  Monee
//
//  Created by MZiO on 21/8/24.
//

import SwiftUI

struct AccountEmpty: View {
    var body: some View {
        ContentUnavailableView {
            Label(
                "No Accounts yet",
                systemImage: "building.columns"
            )
            .foregroundStyle(Color.accentColor)
        } description: {
            Text("Tap on the plus button to add a new account.")
        }
    }
}

#Preview {
    AccountEmpty()
}
