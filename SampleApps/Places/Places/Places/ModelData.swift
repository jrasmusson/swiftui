//
//  ModelData.swift
//  Places
//
//  Created by jrasmusson on 2022-06-18.
//

import Foundation
import SwiftUI

let appColor = Color(red: 128/255, green: 165/255, blue: 117/255)

struct Place: Hashable, Identifiable {
    let id: UUID = UUID()
    let location: String
    let title: String
    let subtitle: String
    let imageName: String
    let description: String
    let noteworthy: [Noteworthy]
}

let description = "With strong cycling infrastructure and spectacular terrain just over the Golden Gate Bridge, cyclists enjoy one of the best bike-friendly cities."
let place = Place(location: "Colorado, US", title: "Aspen", subtitle: "14 Routes · Mountainous", imageName: "aspen", description: description, noteworthy: noteworthy)
let place2 = Place(location: "California, US", title: "San Francisco", subtitle: "12 Routes · Coastal", imageName: "sf", description: description, noteworthy: noteworthy)

struct Noteworthy: Hashable, Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let iconName: String
}

let noteworthy1 = Noteworthy(title: "Carl the Fog", description: "Layering for rides is an art with the microclimages of the Bay. Here's tips from the locals.", iconName: "cloud.fog")
let noteworthy2 = Noteworthy(title: "Diverse Scenery", description: "From the Golden Gate bridge to the Redwoods, discover the most photographed places.", iconName: "binoculars")
let noteworthy3 = Noteworthy(title: "Hawk Hill", description: "Try beating these KOM's on this favorite local climb right over the Golden Gate bridge.", iconName: "mappin")
let noteworthy = [noteworthy1, noteworthy2, noteworthy3]

struct Itinerary: Hashable, Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let friends: String
    let imageName: String
}

let itinerary1 = Itinerary(title: "Santa Cruz", subtitle: "San Francisco · July 22-30, 2022", friends: "Kate, Jeremy, Dave, Matt, and 2 others", imageName: "itinerary1")

final class ModelData: ObservableObject {
    var places: [Place] = [
        place,
        place2
    ]
}

