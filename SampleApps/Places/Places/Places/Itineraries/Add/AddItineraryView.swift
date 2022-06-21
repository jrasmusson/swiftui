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
            TripDetailsView()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Add") {
                            print("Trailing")
                        }.foregroundColor(appColor)
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            print("Pressed")
                        }.foregroundColor(appColor)
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
