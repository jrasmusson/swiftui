//
//  PlacesView.swift
//  Places
//
//  Created by jrasmusson on 2022-06-21.
//

import SwiftUI

struct PlacesView: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(modelData.places) { place in
                    NavigationLink(value: place) {
                        PlaceCard(place: place)
                    }
                }
            }
            .navigationTitle("Places")
            .navigationDestination(for: Place.self) { item in
                PlaceDetail(place: place)
            }
        }
    }
}

struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesView()
            .preferredColorScheme(.dark)
            .environmentObject(ModelData())
    }
}
