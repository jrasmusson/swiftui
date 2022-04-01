//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by jrasmusson on 2022-03-31.
//

// ViewModel

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static var emojis = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🚃", "🚡", "🛵", "🚗", "🚚", "🚇", "🛻", "🚄"]

    static func createMemoryGame() -> MemoryGame {
        MemoryGame(numberOfPairsOfCards: 4) { pairIndex in
            EmojiMemoryGame.emojis[pairIndex]
        }
    }

    @Published private var model: MemoryGame = createMemoryGame()

    var cards: [Card] {
        return model.cards
    }

    // MARK: - Intent(s)
    func choose(_ card: Card) {
        model.choose(card)
    }
}
