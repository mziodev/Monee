//
//  ContentView.swift
//  Monee
//
//  Created by MZiO on 5/8/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Groups") {
                    ForEach(1...3, id: \.self) { group in
                        DisclosureGroup("Group \(group)") {
                            ForEach(1...5, id: \.self) {
                                Text($0.description)
                            }
                        }
                    }
                    .onMove(perform: { indices, newOffset in
                        //
                    })
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Test")
            .toolbar {
                EditButton()
            }
        }
    }
}

#Preview {
    ContentView()
}
