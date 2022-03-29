# Assignment I: Memorize

![](images/1.png)

### Links that help

- [Assignment I pdf](https://cs193p.sites.stanford.edu/sites/g/files/sbiybj16636/files/media/file/assignment_1.pdf)


## Declarative vs Imperative

Notices the change in language. In SwiftUI we update the view by changing the state (declarative) vs telling it what to do (imperative).

**Imperative**

```swift
Button {
    // show vehicles
}
```

**Declarative**

```swift
Button {
    // Change state to vehicles
}
```

## Two different ways to extact views

Here are two different ways to extract views:

1. As new views.
2. As vars.


### As new views

Here you extract the view as a `struct` and pass it whatever data it needs as part of the constructor.

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            CardsView(emojis: emojis)
        }
}

struct CardsView: View {
    let emojis: [String]

    var body: some View { ... }
}
```

### As vars

With vars you create a local `var` within the current view and get access to all the state within the struct. No need to pass anything.

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            buttons
        }
    }

    var buttons: some View {
        HStack {
            vehiclesButton
            Spacer()
            foodButton
            Spacer()
            flagButton
        }
    }
}
```

You can also extract vars into extensions:

```swift
// MARK: Buttons
extension ContentView {
    var flagButton: some View {
        Button {
            emojis = flags
        } label: {
            VStack {
                Image(systemName: "flag")
                Text("Flags").font(.subheadline)
            }
        }
    }
}
```

## Extra credit

### Random number of cards

```swift
private func randomNumberOfCardsFrom(_ cards: [String]) -> [String] {
    let random = Int.random(in: 4...cards.count - 1)
    return cards.dropLast(cards.count - random)
}
```

### Adaptive width

```swift
private func adaptiveWidth() -> CGFloat {
    return UIScreen.main.bounds.width / CGFloat(emojis.count) * 2
}
```

### Final Solution

```swift
//
//  ContentView.swift
//  Memorize
//
//  Created by jrasmusson on 2022-03-27.
//

import SwiftUI

struct ContentView: View {
    var vehicles = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚡", "🚜", "🛴", "✈️"]
    var food = ["🍏", "🍎", "🍐", "🍊", "🍌", "🍉", "🍇", "🍓", "🫐"]
    var flags = ["🏴‍☠️", "🚩", "🏁", "🏳️‍🌈", "🇦🇽", "🇦🇺", "🇦🇹", "🇹🇩"]

    @State private var emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚡", "🚜", "🛴", "✈️"]

    var body: some View {
        VStack {
            title
            cards
            Spacer()
            buttons
        }
        .padding(.horizontal)
    }
}

// MARK: Buttons
extension ContentView {
    var title: some View {
        Text("Memorize").font(.largeTitle)
    }

    var cards: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: adaptiveWidth()))]) {
                ForEach(emojis[0..<emojis.count], id: \.self, content: { emoji in
                    CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                })
            }
        }
        .foregroundColor(.red)
    }

    private func adaptiveWidth() -> CGFloat {
        return UIScreen.main.bounds.width / CGFloat(emojis.count) * 2
    }

    var buttons: some View {
        HStack {
            vehiclesButton
            Spacer()
            foodButton
            Spacer()
            flagButton
        }
        .padding(.horizontal)
    }

    var vehiclesButton: some View {
        Button {
            emojis = randomNumberOfCardsFrom(vehicles).shuffled()
        } label: {
            VStack {
                Image(systemName: "car")
                Text("Vehicles").font(.subheadline)
            }
        }
    }

    var foodButton: some View {
        Button {
            emojis = randomNumberOfCardsFrom(food).shuffled()
        } label: {
            VStack {
                Image(systemName: "cart")
                Text("Food").font(.subheadline)
            }
        }
    }

    var flagButton: some View {
        Button {
            emojis = randomNumberOfCardsFrom(flags).shuffled()
        } label: {
            VStack {
                Image(systemName: "flag")
                Text("Flags").font(.subheadline)
            }
        }
    }

    private func randomNumberOfCardsFrom(_ cards: [String]) -> [String] {
        let random = Int.random(in: 4...cards.count - 1)
        return cards.dropLast(cards.count - random)
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
```