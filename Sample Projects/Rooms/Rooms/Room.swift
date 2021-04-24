//
//  Room.swift
//  Rooms
//
//  Created by jrasmusson on 2021-04-24.
//

import SwiftUI

struct Room: Identifiable { // Necessary for List
    var id = UUID()
    var name: String
    var capacity: Int
    var hasVideo: Bool = false
    
    var imageName: String { return name }
    var thumbnailName: String { return name + "Thumb" }
}

#if DEBUG
let testData = [
    Room(name: "Observation Deck", capacity: 6, hasVideo: true),
    Room(name: "Rainbow Room", capacity: 20, hasVideo: true),
    Room(name: "Tron Room", capacity: 3, hasVideo: true),
    Room(name: "Elephant Room", capacity: 14, hasVideo: true),
]
#endif
