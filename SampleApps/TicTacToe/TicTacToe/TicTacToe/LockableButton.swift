//
//  LockableButton.swift
//  TicTacToe
//
//  Created by jrasmusson on 2022-04-28.
//

import SwiftUI

enum Position1 {
    case upperLeft
    case upperMiddle
}

struct TileState1 {
    var value: Value
    var isLocked: Bool = false
    var isX: Bool { value == .x }

    mutating func set(_ value: Value) {
        self.value = value
        self.isLocked = true
    }

    static func blank() -> TileState1 {
        TileState1(value: .b)
    }
}


struct LockableContainer: View {
    @State var upperLeft = TileState1.blank()
    @State var upperMid = TileState1.blank()
    @State var isXTurn = false

    var body: some View {
        VStack {
            LockableButtonView(tileState: $upperLeft, isXTurn: $isXTurn)
            LockableButtonView(tileState: $upperMid, isXTurn: $isXTurn)
        }
    }
}

struct LockableButtonView: View {
    @Binding var tileState: TileState1
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

struct LockableButton_Previews: PreviewProvider {
    static var previews: some View {
        LockableContainer()
    }
}
