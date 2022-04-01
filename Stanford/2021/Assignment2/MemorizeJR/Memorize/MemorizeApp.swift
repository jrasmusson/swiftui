//
//  MemorizeApp.swift
//  Memorize
//
//  Created by jrasmusson on 2022-03-27.
//

import SwiftUI

let themeData = [
    Theme(name: "Halloween", emojis: ["💀", "👻", "🎃"],
          numberOfPairs: 3, color: .orange),
    Theme(name: "Vehicles", emojis: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚡", "🚜", "🛴", "✈️"],
          numberOfPairs: 8, color: .red),
    Theme(name: "Fruit", emojis: ["🍏", "🍎", "🍐", "🍊", "🍌", "🍉", "🍇", "🍓", "🫐"],
          numberOfPairs: 6, color: .green),
    Theme(name: "Flags", emojis: ["🏴‍☠️", "🚩", "🏁", "🏳️‍🌈", "🇦🇽", "🇦🇺", "🇦🇹", "🇹🇩"],
          numberOfPairs: 5, color: .blue),
]

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()

    var body: some Scene {
        WindowGroup {
//            GameView(viewModel: game)
            ThemeView(themes: themeData)
        }
    }
}


