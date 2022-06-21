//
//  ItineraryCard.swift
//  Places
//
//  Created by jrasmusson on 2022-06-21.
//

import SwiftUI

struct ItineraryCard: View {
    let itinerary: Itinerary

    var body: some View {
        VStack(alignment: .leading) {
            Image(itinerary.imageName)
                .resizable()
                .scaledToFit()
            VStack(alignment: .leading) {
                Text(itinerary.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(itinerary.title)
                    .font(.title)
                    .foregroundColor(.primary)
                Text(itinerary.friends)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .background(.thinMaterial)
        .cornerRadius(10)
    }
}

struct ItineraryCard_Previews: PreviewProvider {
    static var previews: some View {
        ItineraryCard(itinerary: itinerary1)
            .preferredColorScheme(.dark)
    }
}
