//
//  PlaceDetail.swift
//  Places
//
//  Created by jrasmusson on 2022-06-18.
//

import SwiftUI

struct PlaceDetail: View {
    let place: Place

    var header: some View {
        Image("sf-detail")
            .resizable()
            .scaledToFit()
    }

    var title: some View {
        VStack(spacing: 6) {
            HStack {
                Text(place.location)
                    .foregroundColor(.secondary)
                Spacer()
            }

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(place.title)
                        .font(.title)
                    Spacer()
                }

                HStack {
                    Image(systemName: "map")
                    Text(place.subTitle)
                    Spacer()
                }
            }
            .foregroundColor(.primary)
        }
        .padding()
    }

    var noteworthy: some View {
        List(place.noteworthy) { worthy in
            NavigationLink(value: worthy) {
                NoteworthyRow(noteworthy: worthy)
            }
            .navigationTitle(worthy.title)
            .navigationDestination(for: Noteworthy.self) { item in
                NoteworthyDetail()
            }
        }
    }

    var body: some View {

        VStack {
            header
            title
            noteworthy

            Spacer()
        }
        .edgesIgnoringSafeArea(.top)

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
        .tint(.primary)
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
