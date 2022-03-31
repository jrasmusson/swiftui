//
//  MemorizeApp.swift
//  Memorize
//
//  Created by jrasmusson on 2022-03-27.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
