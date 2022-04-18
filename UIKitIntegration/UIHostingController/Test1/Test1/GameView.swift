//
//  GameView.swift
//  Test1
//
//  Created by jrasmusson on 2022-04-18.
//

import SwiftUI

struct GameView: View {
    let game: String

    var body: some View {
        Text(game)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: "Pacman")
    }
}
