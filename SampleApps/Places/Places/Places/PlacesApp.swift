//
//  PlacesApp.swift
//  Places
//
//  Created by jrasmusson on 2022-06-18.
//

import SwiftUI

@main
struct PlacesApp: App {
    @StateObject private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
