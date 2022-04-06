//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by jrasmusson on 2022-03-29.
//

import SwiftUI

// ViewModel

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card

    static var emojis = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🚃", "🚡", "🛵", "🚗", "🚚", "🚇", "🛻", "🚄"]

    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 8) { pairIndex in
            EmojiMemoryGame.emojis[pairIndex]
        }
    }

    @Published private var model = createMemoryGame()

    var cards: [Card] {
        return model.cards
    }

    // MARK: - Intent(s)
    func choose(_ card: Card) {
        model.choose(card)
    }

    func shuffle() {
        model.shuffle()
    }
}
