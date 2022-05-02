//
//  ContentView.swift
//  TicTacToe2
//
//  Created by jrasmusson on 2022-05-01.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published private var model = Model()

    func choose(_ position: Position) {
        let currentState = model.get(position)
        guard !currentState.isLocked else { return }

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

    var hasWinCondition: Bool {
        model.hasWinCondition
    }

    var isGameOver: Bool {
        model.isGameOver
    }

    var gameState: GameState {
        model.gameState
    }

    var xScore: Int {
        model.xScore
    }

    var oScore: Int {
        model.oScore
    }

    func reset() {
        model.reset()
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
    }

    var header: some View {
        HStack {
            Text("X: \(viewModel.xScore)")
            Spacer()
            Text("O: \(viewModel.oScore)")
        }.padding()
    }

    func button(for position: Position) -> some View {
        GridButtonView(tileState: viewModel.get(position))
            .onTapGesture {
                print("tap: \(viewModel.get(position))")
                if !viewModel.isGameOver {
                    print("Game not over")
                    viewModel.choose(position)
                    viewModel.toggleTurn()
                }
            }
    }

    var footer: some View {
        VStack {
            Text(viewModel.gameState.description)
            resetButton
        }
    }

    var resetButton: some View {
        Button("Reset", action: { viewModel.reset() })
    }
}

// U R HERE use geometry reader to figure out view space

struct GridButtonView: View {
    let tileState: TileState

    var body: some View {
        if tileState.isLocked {
            Image(systemName: tileState.isX ? "x.square.fill" : "o.square.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
        } else {
            Image(systemName: "placeholdertext.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        ContentView(viewModel: viewModel)
    }
}
