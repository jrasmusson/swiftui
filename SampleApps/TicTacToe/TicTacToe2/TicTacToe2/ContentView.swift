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
        print(tileState)
        model.set(.upperLeft, tileState)
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
    @State var username: String = "Peter"

    var body: some View {
        VStack {
            HStack {
                GridButtonView(tileState: viewModel.get(.upperLeft))
                    .onTapGesture {
                        username = "Paul"
                        viewModel.choose(.upperLeft)
                    }
                Text(username)
            }
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
