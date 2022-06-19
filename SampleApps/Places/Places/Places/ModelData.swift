//
//  ModelData.swift
//  Places
//
//  Created by jrasmusson on 2022-06-18.
//

import Foundation

struct Place: Hashable, Identifiable {
    let id: UUID = UUID()
    let location: String
    let title: String
    let description: String
    let imageName: String
}

final class ModelData: ObservableObject {
    var places: [Place] = [
        place,
        place2
    ]
}

let place = Place(location: "Colorado, US", title: "Aspen", description: "14 Routes · Mountainous", imageName: "aspen")
let place2 = Place(location: "California, US", title: "San Francisco", description: "12 Routes · Coastal", imageName: "sf")

struct Noteworthy: Hashable, Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let iconName: String
}

let notworthy1 = Noteworthy(title: "Carl the Fog", description: "Layering for rides is an art with the microclimages of the Bay. Here's tips from the locals.", iconName: "cloud.fog")
