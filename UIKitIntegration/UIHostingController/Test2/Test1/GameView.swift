//
//  GameView.swift
//  Test1
//
//  Created by jrasmusson on 2022-04-18.
//

import SwiftUI
import Combine

class GameViewDelegate: ObservableObject {
    @Published var name: String = ""
}

struct GameView: View {
    let game: String
    @ObservedObject var delegate: GameViewDelegate

    var body: some View {
        List {
            Button("Alice") {
                delegate.name = "Alice"
            }
            Button("Bob") {

            }
            Button("Trudy") {

            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let delegate = GameViewDelegate()
        GameView(game: "Pacman", delegate: delegate)
    }
}

