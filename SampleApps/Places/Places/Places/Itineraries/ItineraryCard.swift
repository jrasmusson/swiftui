//
//  ItineraryCard.swift
//  Places
//
//  Created by jrasmusson on 2022-06-21.
//

import SwiftUI

struct ItineraryCard: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image("itinerary1")
                .resizable()
                .scaledToFit()
            VStack(alignment: .leading) {
                Text("San Francisco · July 22-30, 2022")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("Santa Cruz")
                    .font(.title)
                    .foregroundColor(.primary)
                Text("kate, Jeremy, Dave, Matt, and 2 others")
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
        ItineraryCard()
            .preferredColorScheme(.dark)
    }
}
