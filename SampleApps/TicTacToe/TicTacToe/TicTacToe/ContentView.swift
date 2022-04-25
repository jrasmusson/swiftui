//
//  ContentView.swift
//  TicTacToe
//
//  Created by jrasmusson on 2022-04-25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    // next add bool isXTurn
    var button: some View {
        Button(action: {}) {
            Image(systemName: "x.square.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
        }
    }

    func textFor(position: Position) -> some View {
        Text(viewModel.get(position).description)
            .font(.largeTitle)
            .frame(width: 50, height: 50)
            .padding()
    }

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                }) {
                    textFor(position: .upperLeft)
                }
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
        ContentView(viewModel: ViewModel())
    }
}
