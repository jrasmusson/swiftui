//
//  GridViewModel.swift
//  TicTacToe
//
//  Created by jrasmusson on 2022-04-30.
//

import SwiftUI

enum Position3 {
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

struct TileState3 {
    var value: Value
    var isLocked: Bool = false
    var isX: Bool { value == .x }

    static func blank() -> TileState2 {
        TileState2(value: .b)
    }
}

enum GameOver3: CustomStringConvertible {
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

class ViewModel3: ObservableObject {
    @Published var xScore = 0
}

struct GridView3: View {
    @ObservedObject var viewModel: ViewModel3

    @State var upperLeft = TileState3.blank()
    @State var upperMiddle = TileState3.blank()
    @State var upperRight = TileState3.blank()
    @State var middleLeft = TileState3.blank()
    @State var middleMiddle = TileState3.blank()
    @State var middleRight = TileState3.blank()
    @State var bottomLeft = TileState3.blank()
    @State var bottomMiddle = TileState3.blank()
    @State var bottomRight = TileState3.blank()

    @State var isXTurn = false
    @State var xScore = 0

    var gameState: GameOver3 {
        if upperLeft.value == .x && upperMiddle.value == .x && upperRight.value == .x {
            xScore += 1
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
                Text("X Score: \(xScore)")
                Spacer()
            }
            HStack {
                GridButtonView3(tileState: $upperLeft, isXTurn: $isXTurn)
                GridButtonView3(tileState: $upperMiddle, isXTurn: $isXTurn)
                GridButtonView3(tileState: $upperRight, isXTurn: $isXTurn)
            }
            HStack {
                GridButtonView3(tileState: $middleLeft, isXTurn: $isXTurn)
                GridButtonView3(tileState: $middleMiddle, isXTurn: $isXTurn)
                GridButtonView3(tileState: $middleRight, isXTurn: $isXTurn)
            }
            HStack {
                GridButtonView3(tileState: $bottomLeft, isXTurn: $isXTurn)
                GridButtonView3(tileState: $bottomMiddle, isXTurn: $isXTurn)
                GridButtonView3(tileState: $bottomRight, isXTurn: $isXTurn)
            }
            Button(action: {
                reset()
            }) {
                Text("Reset")
            }
            Button(action: {
                xScore += 1
            }) {
                Text("+1 X")
            }
            Text("Game over: \(gameState.description)")
        }
    }

    func reset() {
        upperLeft = TileState3.blank()
        upperMiddle = TileState3.blank()
        upperRight = TileState3.blank()
        middleLeft = TileState3.blank()
        middleMiddle = TileState3.blank()
        middleRight = TileState3.blank()
        bottomLeft = TileState3.blank()
        bottomMiddle = TileState3.blank()
        bottomRight = TileState3.blank()

        isXTurn = false
        xScore = 0
    }
}

struct GridButtonView3: View {
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

struct GridModelView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel3()
        GridView3(viewModel: ViewModel3)
    }
}
