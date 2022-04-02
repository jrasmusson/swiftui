//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by jrasmusson on 2022-03-31.
//

import SwiftUI

class GameViewModel: ObservableObject {
    @Published private var model: GameModel

    var cards: [Card] {
        model.cards
    }

    var title: String {
        model.theme.name
    }

    init(theme: Theme) {
        model = GameModel(theme)
    }
}

// MARK: - Intent(s)
extension GameViewModel {
    func choose(_ card: Card) {
        model.choose(card)
    }
}
