# Lecture 3: MVVM

![](images/1.png)

# Creating the model

## Model

Here is our model. Which is UI independent `<CardContent>` ( a don't care).

**MemoryGame** 

```swift
// Model

struct MemoryGame<CardContent> {
    var cards: [Card]

    func choose(_ card: Card) {

    }

    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
```

## ViewModel

- The view model is part of the view. So it can import `SwiftUI`.
- View models are `class`.
- Here the view model is going to create the model.
- In other cases it might be passed in as a result of a network call.
- If the view model is creating the model it is the source of truth for our UI.

**EmojiMemoryGame**

```swift
import SwiftUI

// ViewModel

class EmojiMemoryGame {
    static var emojis = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🚃", "🚡", "🛵", "🚗", "🚚", "🚇", "🛻", "🚄"]

    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            EmojiMemoryGame.emojis[pairIndex]
        }
    }

    private var model: MemoryGame<String> = createMemoryGame()

    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
}
```


### Links that help

- [Lecture 3](https://www.youtube.com/watch?v=--qKOhdgJAs&ab_channel=Stanford)
- [Standford 2021](https://cs193p.sites.stanford.edu/)



