//
//  MemorizeApp.swift
//  Memorize
//
//  Created by jrasmusson on 2022-03-27.
//

import SwiftUI

let themeData = [
    Theme(name: "Halloween", emojis: ["💀", "👻", "🎃", "🍫"], color: .orange),
    Theme(name: "Vehicles", emojis: ["🚗", "🚕", "🚙", "🚌"], color: .red),
    Theme(name: "Fruit", emojis: ["🍏", "🍎", "🍐", "🍊"], color: .green),
    Theme(name: "Flags", emojis: ["🏴‍☠️", "🚩", "🏁", "🏳️‍🌈"], color: .blue),
]

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = ThemeViewModel(themes: themeData)
            ThemeView(viewModel: viewModel)
        }
    }
}
