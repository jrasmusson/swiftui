//
//  TileView.swift
//  TicTacToe
//
//  Created by jrasmusson on 2022-04-27.
//

import SwiftUI

struct XOToggle: View {
    @State private var isX: Bool = false

    var body: some View {
        VStack {
            VStack {
                XOToggleView(isX: $isX)
                Toggle("Is X or O", isOn: $isX)
                    .padding()
            }.padding()
        }
    }
}

struct XOToggleView: View {
    @Binding var isX: Bool

    var body: some View {
        Button(action: {
            self.isX.toggle()
        }) {
            Image(systemName: isX ? "x.square.fill" : "o.square.fill")
                .resizable()
                .frame(width: 100, height: 100)

        }
    }
}

struct XOToggle_Previews: PreviewProvider {
    static var previews: some View {
        XOToggle()
    }
}


