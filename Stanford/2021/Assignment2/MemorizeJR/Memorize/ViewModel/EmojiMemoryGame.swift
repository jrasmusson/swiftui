//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by jrasmusson on 2022-03-31.
//

// ViewModel

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame = createMemoryGame()

    var cards: [Card] {
        return model.cards
    }
}

// MARK: Factory
extension EmojiMemoryGame {
    static func createMemoryGame() -> MemoryGame {
        MemoryGame(numberOfPairsOfCards: 4)
    }
}

// MARK: - Intent(s)
extension EmojiMemoryGame {
    func choose(_ card: Card) {
        model.choose(card)
    }
}
