//
//  XOButton.swift
//  TicTacToe
//
//  Created by jrasmusson on 2022-04-27.
//

import SwiftUI

struct XOButton: View {
    @State private var isXTurn: Bool = false

    var body: some View {
        VStack {
            VStack {
                XOButtonView(isXTurn: $isXTurn)
                Toggle("Is X Turn", isOn: $isXTurn)
                    .padding()
            }.padding()
        }
    }
}

struct XOButtonView: View {
    @Binding var isXTurn: Bool

    var body: some View {
        Button(action: {
            self.isXTurn.toggle()
        }) {
            Image(systemName: isXTurn ? "x.square.fill" : "o.square.fill")
                .resizable()
                .frame(width: 100, height: 100)

        }
    }
}

struct XOButton_Previews: PreviewProvider {
    static var previews: some View {
        XOButton()
    }
}
