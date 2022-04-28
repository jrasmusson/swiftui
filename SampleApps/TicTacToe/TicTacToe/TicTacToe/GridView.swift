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
    @State var gameOver: GameOver = .draw

    var isGameOver: Bool {
        if upperLeft.value == .x && upperMiddle.value == .x && upperRight.value == .x {
            gameOver = .xWins
            return true
        }

        gameOver = .oWins
        return false
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
            if isGameOver {
                Text("\(gameOver.description)")
            } else {
                Text("Play on...")
            }
            Button(action: {
                gameOver = .xWins
            }) {
                Text("Tap me!")
            }
        }
    }
}

// U R HERE figure out how to detect Xwins!

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
