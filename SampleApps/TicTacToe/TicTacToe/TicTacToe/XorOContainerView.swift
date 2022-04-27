//
//  TileView.swift
//  TicTacToe
//
//  Created by jrasmusson on 2022-04-27.
//

import SwiftUI

struct XorOContainerView: View {
    @State private var isX: Bool = false

    var body: some View {
        VStack {
            VStack {
                XorOView(isX: $isX)
                Toggle("Is X or O", isOn: $isX)
                    .padding()
            }.padding()
        }
    }
}

struct XorOView: View {
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

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        XorOContainerView()
    }
}


