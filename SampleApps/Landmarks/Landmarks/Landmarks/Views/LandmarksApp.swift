//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by jrasmusson on 2022-05-16.
//

import SwiftUI

@main
struct LandmarksApp: App {
    @StateObject private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
