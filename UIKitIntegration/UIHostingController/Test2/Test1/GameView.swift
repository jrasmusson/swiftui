//
//  GameView.swift
//  Test1
//
//  Created by jrasmusson on 2022-04-18.
//

import SwiftUI
import Combine

class GameViewDelegate: ObservableObject {
    @Published var rating: String = ""
}

struct GameView: View {
    let name: String
    @ObservedObject var delegate: GameViewDelegate
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            Text(name)
            List {
                Button("⭐️") {
                    delegate.rating = "⭐️"
                    dismiss()
                }
                Button("⭐️⭐️") {
                    delegate.rating = "⭐️⭐️"
                    dismiss()
                }
                Button("⭐️⭐️⭐️") {
                    delegate.rating = "⭐️⭐️⭐️"
                    dismiss()
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let delegate = GameViewDelegate()
        GameView(name: "Pacman", delegate: delegate)
    }
}

