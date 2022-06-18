//
//  PlaceCard.swift
//  Places
//
//  Created by jrasmusson on 2022-06-18.
//

import SwiftUI

struct PlaceCard: View {
    let place: Place

    var body: some View {
        VStack {
            HStack {
                Text(place.location)
                Spacer()
                Image(systemName: "ellipsis.circle")
            }

            VStack(alignment: .leading) {
                HStack {
                    Text(place.title)
                    Spacer()
                }

                HStack {
                    Image(systemName: "map")
                    Text(place.description)
                    Spacer()
                }

                Image(place.imageName)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)

            }
        }
        .padding()
    }
}

struct PlaceCard_Previews: PreviewProvider {
    static var previews: some View {
        PlaceCard(place: place)
    }
}
