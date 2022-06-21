//
//  AddItineraryView.swift
//  Places
//
//  Created by jrasmusson on 2022-06-21.
//

import SwiftUI

struct AddItineraryView: View {
    var body: some View {
        NavigationStack {
            Text("Hello, World!")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Add") {
                            print("Trailing")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            print("Pressed")
                        }
                    }
                }
                .navigationTitle("New Itinerary")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AddItineraryView_Previews: PreviewProvider {
    static var previews: some View {
        AddItineraryView()
            .preferredColorScheme(.dark)
    }
}
