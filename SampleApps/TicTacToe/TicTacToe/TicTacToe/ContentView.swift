//
//  ContentView.swift
//  TicTacToe
//
//  Created by jrasmusson on 2022-04-25.
//

import SwiftUI

struct ContentView: View {
    var button: some View {
        Button(action: {}) {
            Image(systemName: "x.square.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
        }
    }

    var body: some View {
        VStack {
            HStack {
                button
                button
                button
            }
            HStack {
                button
                button
                button
            }
            HStack {
                button
                button
                button
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
