//
//  XOButton.swift
//  TicTacToe
//
//  Created by jrasmusson on 2022-04-27.
//

import SwiftUI

struct XOButtonContainer: View {
    var body: some View {
        VStack {
            VStack {
                XOButtonView()
            }.padding()
        }
    }
}

struct XOButtonView: View {
    @State private var isSelected = false
    @State private var isXTurn = false

    var body: some View {
        Button(action: {
            isSelected = true
            isXTurn.toggle()
        }) {
            if isSelected {
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

struct XOButton_Previews: PreviewProvider {
    static var previews: some View {
        XOButtonContainer()
    }
}
