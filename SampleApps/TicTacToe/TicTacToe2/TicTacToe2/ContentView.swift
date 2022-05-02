//
//  ContentView.swift
//  TicTacToe2
//
//  Created by jrasmusson on 2022-05-01.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published private var model = Model()
    @Published var isXTurn = false

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
}

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            HStack {
                button(for: .upperLeft)
                button(for: .upperMiddle)
                button(for: .upperRight)
            }
        }
    }

    func button(for position: Position) -> some View {
        GridButtonView(tileState: viewModel.get(position))
            .onTapGesture {
                viewModel.choose(position)
                viewModel.isXTurn.toggle()
            }
    }
}

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
