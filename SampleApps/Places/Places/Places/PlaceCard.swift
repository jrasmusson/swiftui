//
//  PlaceCard.swift
//  Places
//
//  Created by jrasmusson on 2022-06-18.
//

import SwiftUI

struct PlaceCard: View {
    var body: some View {
        VStack {
            HStack {
                Text("Colorado, US")
                Spacer()
                Image(systemName: "ellipsis.circle")
            }

            VStack(alignment: .leading) {
                HStack {
                    Text("Aspen")
                    Spacer()
                }

                HStack {
                    Image(systemName: "map")
                    Text("12 Routes · Mountainous")
                    Spacer()
                }

                Image("aspen")
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
        PlaceCard()
    }
}
