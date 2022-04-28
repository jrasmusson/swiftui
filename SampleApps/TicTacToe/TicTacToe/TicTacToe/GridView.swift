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
}

struct TileState2 {
    var value: Value
    var isLocked: Bool = false
    var isX: Bool { value == .x }

    static func blank() -> TileState2 {
        TileState2(value: .b)
    }
}

struct GridView: View {
    @State var upperLeft = TileState2.blank()
    @State var upperMid = TileState2.blank()
    @State var isXTurn = false

    var body: some View {
        VStack {
            GridButtonView(tileState: $upperLeft, isXTurn: $isXTurn)
            GridButtonView(tileState: $upperMid, isXTurn: $isXTurn)
        }
    }
}

struct GridButtonView: View {
    @Binding var tileState: TileState2
    @Binding var isXTurn: Bool

    var body: some View {
        Button(action: {
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
