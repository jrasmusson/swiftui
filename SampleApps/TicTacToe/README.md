# TicTacToe

## Initial UI

![](images/1.png)

```swift
struct ContentView: View {
    var button: some View {
        Button(action: {}) {
            Image(systemName: "x.square.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
        }
    }

    var body: some View {
        VStack {
            HStack {
                button
                button
                button
            }
            HStack {
                button
                button
                button
            }
            HStack {
                button
                button
                button
            }
        }
    }
}
```

## Experiment #1

## Experiment #2

## Game State

Perhaps the most confusing part - detecting the win conditions.

### Before

What I so wanted to do was...

```swift
// define a variable
@State var gameOver: GameOver = .draw

// Set it's state
Button(action: {
    gameOver = .xWins
}) {
    Text("Tap me!")
}

// Display the result
Text("Game over: \(gameOver.description)")
```

But that's the wrong way to think about it.
 
### After

Instead I should think:

> Don't set the state. Instead just react to it.

Each tile already knows its current value and state. All I need to do it react to it. 

So instead of tracking a win condition as a `var`, create a computed `var` and react to it.

```swift
// How we react
var gameState: GameOver {
    if upperLeft.value == .x && upperMiddle.value == .x && upperRight.value == .x {
        return .xWins
    }

    if upperLeft.value == .o && upperMiddle.value == .o && upperRight.value == .o {
        return .oWins
    }

    return .draw
}

// How we display
Text("Game over: \(gameState.description)")
```

Full source:

```swift
//
//  GridView.swift
//  TicTacToe
//
//  Created by jrasmusson on 2022-04-28.
//

import SwiftUI

enum Position2 {
    case upperLeft
    case upperMiddle
    case upperRight
    case middleLeft
    case middleMiddle
    case middleRight
    case lowerLeft
    case lowerMiddle
    case lowerRight
}

struct TileState2 {
    var value: Value
    var isLocked: Bool = false
    var isX: Bool { value == .x }

    static func blank() -> TileState2 {
        TileState2(value: .b)
    }
}

enum GameOver: CustomStringConvertible {
    case xWins
    case oWins
    case draw

    var description: String {
        switch self {
        case .xWins:
            return "X wins!"
        case .oWins:
            return "O wins!"
        case .draw:
            return "Draw!"
        }
    }
}

struct GridView: View {
    @State var upperLeft = TileState2.blank()
    @State var upperMiddle = TileState2.blank()
    @State var upperRight = TileState2.blank()
    @State var middleLeft = TileState2.blank()
    @State var middleMiddle = TileState2.blank()
    @State var middleRight = TileState2.blank()
    @State var bottomLeft = TileState2.blank()
    @State var bottomMiddle = TileState2.blank()
    @State var bottomRight = TileState2.blank()

    @State var isXTurn = false

    var gameState: GameOver {
        if upperLeft.value == .x && upperMiddle.value == .x && upperRight.value == .x {
            return .xWins
        }

        if upperLeft.value == .o && upperMiddle.value == .o && upperRight.value == .o {
            return .oWins
        }

        return .draw
    }

    var body: some View {
        VStack {
            HStack {
                GridButtonView(tileState: $upperLeft, isXTurn: $isXTurn)
                GridButtonView(tileState: $upperMiddle, isXTurn: $isXTurn)
                GridButtonView(tileState: $upperRight, isXTurn: $isXTurn)
            }
            HStack {
                GridButtonView(tileState: $middleLeft, isXTurn: $isXTurn)
                GridButtonView(tileState: $middleMiddle, isXTurn: $isXTurn)
                GridButtonView(tileState: $middleRight, isXTurn: $isXTurn)
            }
            HStack {
                GridButtonView(tileState: $bottomLeft, isXTurn: $isXTurn)
                GridButtonView(tileState: $bottomMiddle, isXTurn: $isXTurn)
                GridButtonView(tileState: $bottomRight, isXTurn: $isXTurn)
            }
            Button(action: {

            }) {
                Text("Tap me!")
            }
            // Don't think of setting state / think of reacting to it
            Text("Game over: \(gameState.description)")
        }
    }
}

struct GridButtonView: View {
    @Binding var tileState: TileState2
    @Binding var isXTurn: Bool

    var body: some View {
        Button(action: {
            if tileState.isLocked { return }
            tileState.isLocked = true
            tileState.value = isXTurn ? .x : .o
            isXTurn.toggle()
        }) {
            if tileState.isLocked {
                Image(systemName: tileState.isX ? "x.square.fill" : "o.square.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
            } else {
                Image(systemName: "placeholdertext.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
```