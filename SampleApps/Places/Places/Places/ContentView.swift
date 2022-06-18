//
//  ContentView.swift
//  Places
//
//  Created by jrasmusson on 2022-06-18.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        NavigationStack {
            ForEach(modelData.places) { place in
                NavigationLink(value: place) {
                    PlaceCard(place: place)
                }
            }
            .navigationTitle("Places")
            .navigationDestination(for: Place.self) { item in
                PlaceDetail(place: place)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .environmentObject(ModelData())
    }
}

//List(modelData.places) { place in
//    NavigationLink(value: place) {
//        PlaceCard(place: place)
//    }
//}
