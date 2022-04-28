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

    mutating func set(_ value: Value) {
        self.value = value
        self.isLocked = true
    }

    static func blank() -> TileState1 {
        TileState1(value: .b)
    }
}

struct Model1 {
    private var state: [[TileState1]] = [[TileState1.blank(), TileState1.blank()]]

    mutating func set(_ position: Position1, _ value: Value) {
        switch position {
        case .upperLeft:
            state[0][0].set(value)
        case .upperMiddle:
            state[0][1].set(value)
        }
    }
}

class ViewModel1: ObservableObject {
    @Published private var model = Model1()

    func set(_ position: Position1, _ value: Value) {
        model.set(position, value)
    }
}

struct LockableContainer: View {
    @ObservedObject var viewModel: ViewModel1
    @State var isXTurn = true // X goes first

    var body: some View {
        VStack {
            LockableButtonView(isXTurn: $isXTurn)
            LockableButtonView(isXTurn: $isXTurn)
            LockableButtonView(isXTurn: $isXTurn)
        }
        .contentShape(Rectangle())
        .background(Color.orange)
        .onTapGesture {
            print("foo")
            isXTurn.toggle()
        }
    }
}

struct LockableButtonView: View {
    @Binding var isXTurn: Bool
    @State private var isLocked = false

    var body: some View {
        Button(action: {
            isLocked = true
        }) {
            if isLocked {
                Image(systemName: isXTurn ? "x.square.fill" : "o.square.fill")
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
