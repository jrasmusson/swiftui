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
                    addButton
                    cancel
                }
                .navigationTitle("New Itinerary")
                .navigationBarTitleDisplayMode(.inline)
        }
    }

    let addButton: ToolbarItem<(), some View> = ToolbarItem(placement: .navigationBarTrailing) {
        Button("Add") {
            print("Trailing")
        }.foregroundColor(appColor)
    }
    
    let cancelButton: ToolbarItem<(), some View> = ToolbarItem(placement: .navigationBarLeading) {
        Button("Cancel") {
            print("Pressed")
        }.foregroundColor(appColor)
    }
}

struct AddItineraryView_Previews: PreviewProvider {
    static var previews: some View {
        AddItineraryView()
            .preferredColorScheme(.dark)
    }
}
