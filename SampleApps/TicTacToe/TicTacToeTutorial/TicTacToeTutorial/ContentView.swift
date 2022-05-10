//
//  ContentView.swift
//  TicTacToeTutorial
//
//  Created by jrasmusson on 2022-05-07.
//

import SwiftUI

enum Value: CustomStringConvertible {
    case b, x, o

    var description: String {
        switch self {
        case .b: return "-"
        case .x: return "X"
        case .o: return "O"
        }
    }
}

enum Position {
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

struct TileState {
    var value: Value
    var isLocked: Bool = false
    var isX: Bool { value == .x }

    static func blank() -> TileState {
        TileState(value: .b)
    }
}

struct Model {
    private var state: [[TileState]] = [
        [TileState.blank(), TileState.blank(), TileState.blank()],
        [TileState.blank(), TileState.blank(), TileState.blank()],
        [TileState.blank(), TileState.blank(), TileState.blank()]
    ]

    mutating func set(_ position: Position, _ tileState: TileState) {
        switch position {
        case .upperLeft:
            state[0][0] = tileState
        case .upperMiddle:
            state[0][1] = tileState
        case .upperRight:
            state[0][2] = tileState
        case .middleLeft:
            state[1][0] = tileState
        case .middleMiddle:
            state[1][1] = tileState
        case .middleRight:
            state[1][2] = tileState
        case .lowerLeft:
            state[2][0] = tileState
        case .lowerMiddle:
            state[2][1] = tileState
        case .lowerRight:
            state[2][2] = tileState
        }
    }

    func get(_ position: Position) -> TileState {
        switch position {
        case .upperLeft:
            return state[0][0]
        case .upperMiddle:
            return state[0][1]
        case .upperRight:
            return state[0][2]
        case .middleLeft:
            return state[1][0]
        case .middleMiddle:
            return state[1][1]
        case .middleRight:
            return state[1][2]
        case .lowerLeft:
            return state[2][0]
        case .lowerMiddle:
            return state[2][1]
        case .lowerRight:
            return state[2][2]
        }
    }

    private var _isXTurn = false

    var isXTurn: Bool {
        _isXTurn
    }

    mutating func toggleTurn() {
        self._isXTurn.toggle()
    }
}

class ViewModel: ObservableObject {
    @Published private var model = Model()

    func choose(_ position: Position) {
        var tileState: TileState
        if isXTurn {
            tileState = TileState(value: .x, isLocked: true)
        } else {
            tileState = TileState(value: .o, isLocked: true)
        }
        model.set(position, tileState)
    }

    func set(_ position: Position, _ state: TileState) {
        model.set(position, state)
    }

    func get(_ position: Position) -> TileState {
        model.get(position)
    }

    var isXTurn: Bool {
        model.isXTurn
    }

    func toggleTurn() {
        model.toggleTurn()
    }
}

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            header
            HStack {
                button(for: .upperLeft)
                button(for: .upperMiddle)
                button(for: .upperRight)
            }
            HStack {
                button(for: .middleLeft)
                button(for: .middleMiddle)
                button(for: .middleRight)
            }
            HStack {
                button(for: .lowerLeft)
                button(for: .lowerMiddle)
                button(for: .lowerRight)
            }
            footer
        }
        .navigationTitle("TicTacToe")
    }

    var header: some View {
        HStack {
            Text("X: 0")
            Spacer()
            Text("O: 0")
        }.padding()
    }

    func button(for position: Position) -> some View {
        let tileState = viewModel.get(position)

        return GridButtonView(tileState: tileState)
            .onTapGesture {
                viewModel.choose(position)
                viewModel.toggleTurn()
            }
    }

    var footer: some View {
        VStack {
            Text("Game on!")
            resetButton
        }
    }

    var resetButton: some View {
        Button("Reset", action: {  })
    }
}

struct GridButtonView: View {
    let tileState: TileState

    var body: some View {
        if tileState.isLocked {
            Image(systemName: tileState.isX ? "x.square.fill" : "o.square.fill")
                .resizable()
                .foregroundColor(.blue)
        } else {
            Image(systemName: "placeholdertext.fill")
                .resizable()
                .foregroundColor(.blue)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView(viewModel: ViewModel())
        }
    }
}
