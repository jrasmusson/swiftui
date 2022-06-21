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
            List {
                Section(header: Text("Trip Details")) {
                    Label("Foo", image: "sf")
                    Text("Static row 2")
                }

                Section(header: Text("Section 2")) {
                    ForEach(0..<5) {
                        Text("Dynamic row \($0)")
                    }
                }

                Section(header: Text("Section 3")) {
                    Text("Static row 3")
                    Text("Static row 4")
                }
            }
                .toolbar {
                    addButton
                    cancelButton
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
