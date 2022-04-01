//
//  ThemeView.swift
//  Memorize
//
//  Created by jrasmusson on 2022-04-01.
//

import SwiftUI

struct ThemeView: View {
    var body: some View {
        NavigationView {
            List {
                ThemeCell()
            }
            .navigationBarItems(leading: Button(action: {
                // Add action
            }, label: {
                Text("+")
            }),
                                trailing: Button(action: {
                // Add action
            }, label: {
                Text("Edit")
            }))
            .navigationBarTitle(Text("Memorize"))
        }
    }
}

struct ThemeCell: View {
    let game = EmojiMemoryGame()

    var body: some View {
        NavigationLink(
            destination: GameView(viewModel: game)) {
            VStack(alignment: .leading) {
                Text("Theme Cell")
            }
        }
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView()
    }
}
