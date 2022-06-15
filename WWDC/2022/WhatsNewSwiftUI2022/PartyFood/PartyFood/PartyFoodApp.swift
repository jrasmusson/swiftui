//
//  PartyFoodApp.swift
//  PartyFood
//
//  Created by jrasmusson on 2022-06-15.
//

import SwiftUI

@main
struct PartyFoodApp: App {
    @StateObject private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
