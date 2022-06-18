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
        place
    ]
}

let place = Place(location: "Colorado, US", title: "Aspen", description: "12 Routes · Mountainous", imageName: "aspen")
