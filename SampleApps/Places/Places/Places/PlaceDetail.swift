//
//  PlaceDetail.swift
//  Places
//
//  Created by jrasmusson on 2022-06-18.
//

import SwiftUI

struct PlaceDetail: View {
    let place: Place
    var body: some View {
        
        Text("Hello, World!").padding()
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("Share")
                    }) {
                        Image(systemName: "square.and.arrow.up")
                    }

                    Button(action: {
                        print("Like")
                    }) {
                        Image(systemName: "heart")
                    }
                }
            }
    }
}

struct PlaceDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PlaceDetail(place: place)
                .preferredColorScheme(.dark)
        }
    }
}
