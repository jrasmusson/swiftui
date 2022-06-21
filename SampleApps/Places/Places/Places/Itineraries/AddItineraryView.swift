//
//  AddItineraryView.swift
//  Places
//
//  Created by jrasmusson on 2022-06-21.
//

import SwiftUI

struct AddItineraryView: View {
    var body: some View {
        Text("Hello, World!")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("First") {
                        print("Pressed")
                    }

                    Button("Second") {
                        print("Pressed")
                    }
                    Spacer()
                }
            }
    }
}

struct AddItineraryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddItineraryView()
                .preferredColorScheme(.dark)
        }
    }
}
