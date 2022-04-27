//
//  ContentView.swift
//  TicTacToe
//
//  Created by jrasmusson on 2022-04-25.
//

import SwiftUI

struct ContentView: View {
    @State var isXTurn = false

    var body: some View {
        if isXTurn {
            Text("X Turn")
        } else {
            Text("Y Turn")
        }

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
