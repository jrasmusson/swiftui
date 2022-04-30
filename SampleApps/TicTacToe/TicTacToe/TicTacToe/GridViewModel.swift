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
    @Published var tileState = TileState3(value: .b)
    @Published var isXTurn = false

    func choose(_ position: Position3) {
        if isXTurn {
            tileState = TileState3(value: .x, isLocked: true)
        } else {
            tileState = TileState3(value: .o, isLocked: true)
        }
    }
}

struct GridView3: View {
    @ObservedObject var viewModel: ViewModel3

    var body: some View {
        VStack {
            HStack {
                GridButtonView3(tileState: viewModel.tileState)
                    .onTapGesture {
                        viewModel.choose(.upperLeft)
                    }
            }
        }
    }
}

struct GridButtonView3: View {
    let tileState: TileState3

    var body: some View {
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

struct GridModelView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel3()
        GridView3(viewModel: viewModel)
    }
}
