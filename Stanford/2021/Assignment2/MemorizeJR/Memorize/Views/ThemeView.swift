//
//  ThemeView.swift
//  Memorize
//
//  Created by jrasmusson on 2022-04-01.
//

import SwiftUI

struct Theme: Identifiable {
    let id = UUID()
    let name: String
    let emojis: [String]
    let numberOfPairs: Int
    let color: UIColor
}

struct ThemeView: View {

    let themes: [Theme]
    var body: some View {
        NavigationView {
            List {
                ForEach(themes) { theme in
                    ThemeCell(theme: theme)
                }
            }
            .navigationBarItems(leading: addButton,
                                trailing: editButton)
            .navigationBarTitle(Text("Memorize"))
        }
    }

    var addButton: some View {
        Button(action: {
            // Add action
        }, label: {
            Text("+")
        })
    }

    var editButton: some View {
        Button(action: {
            // Add action
        }, label: {
            Text("Edit")
        })
    }
}

struct ThemeCell: View {
    let theme: Theme
    let game = EmojiMemoryGame()

    var body: some View {
        NavigationLink(
            destination: GameView(viewModel: game)) {
            VStack(alignment: .leading) {
                VStack {
                    Text("Theme Cell")
                }
            }
        }
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView(themes: themeData)
    }
}
