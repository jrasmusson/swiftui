//
//  MemoryGame.swift
//  Memorize
//
//  Created by jrasmusson on 2022-03-31.
//

// Model

import Foundation

struct Card: Identifiable {
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    var content: String
    var id: Int
}

struct GameModel {
    var theme: Theme
    var cards: [Card]
    var indexOfTheOneAndOnlyFaceUpCard: Int?

    init(_ theme: Theme) {
        self.theme = theme
        self.cards = [Card]()
        for pairIndex in 0..<4 {
            print("pairInde: \(pairIndex)")
            let content = theme.emojis[pairIndex]
            self.cards.append(Card(content: content, id: pairIndex*2))
            self.cards.append(Card(content: content, id: pairIndex*2 + 1))
        }
    }
}

// MARK: - Game play
extension GameModel {
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
}
