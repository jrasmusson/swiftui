//
//  MemoryGame.swift
//  Memorize
//
//  Created by jrasmusson on 2022-03-29.
//

import Foundation

// Model

struct MemoryGame<CardContent> {
    private(set) var cards: [Card]

    func choose(_ card: Card) {

    }

    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = [Card]()
        // add numberOfPairsOfCards x 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }

    struct Card {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
