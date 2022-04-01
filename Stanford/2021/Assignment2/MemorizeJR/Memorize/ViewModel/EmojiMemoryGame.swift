//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by jrasmusson on 2022-03-31.
//

// ViewModel

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame

    var cards: [Card] {
        return model.cards
    }

    init(theme: Theme) {
        model = MemoryGame(theme)
    }
}

// MARK: Factory
//extension EmojiMemoryGame {
//    static func createMemoryGame() -> MemoryGame {
//        MemoryGame()
//    }
//}

// MARK: - Intent(s)
extension EmojiMemoryGame {
    func choose(_ card: Card) {
        model.choose(card)
    }
}
