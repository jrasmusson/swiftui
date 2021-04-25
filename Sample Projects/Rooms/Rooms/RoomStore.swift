//
//  RoomStore.swift
//  Rooms
//
//  Created by jrasmusson on 2021-04-25.
//

import SwiftUI
import Combine

class RoomStore: ObservableObject {
    @Published var rooms: [Room]
    
    init(rooms: [Room] = []) {
        self.rooms = rooms
    }
}
