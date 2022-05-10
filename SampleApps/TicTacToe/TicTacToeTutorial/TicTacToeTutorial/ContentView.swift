//
//  ContentView.swift
//  TicTacToeTutorial
//
//  Created by jrasmusson on 2022-05-07.
//

import SwiftUI

enum Position {
    case upperLeft
    case upperMiddle
    case upperRight
    case middleLeft
    case middleMiddle
    case middleRight
    case lowerLeft
    case lowerMiddle
    case lowerRight
}

struct ContentView: View {

    var body: some View {
        VStack {
            header
            HStack {
                button(for: .upperLeft)
                button(for: .upperMiddle)
                button(for: .upperRight)
            }
            HStack {
                button(for: .middleLeft)
                button(for: .middleMiddle)
                button(for: .middleRight)
            }
            HStack {
                button(for: .lowerLeft)
                button(for: .lowerMiddle)
                button(for: .lowerRight)
            }
            footer
        }
        .navigationTitle("TicTacToe")
    }

    var header: some View {
        HStack {
            Text("X: 0")
            Spacer()
            Text("O: 0")
        }.padding()
    }

    func button(for position: Position) -> some View {
        GridButtonView()
    }

    var footer: some View {
        VStack {
            Text("Game on!")
            resetButton
        }
    }

    var resetButton: some View {
        Button("Reset", action: {  })
    }
}

struct GridButtonView: View {

    var body: some View {
        Image(systemName: "x.square.fill")
            .resizable()
            .foregroundColor(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
