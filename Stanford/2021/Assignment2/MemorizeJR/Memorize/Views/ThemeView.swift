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
    let color: Color
}

struct ThemeView: View {
    @State private var showingAddScreen = false

    let themes: [Theme]
    var body: some View {
        NavigationView {
            List {
                ForEach(themes) { theme in
                    ThemeCell(theme: theme)
                }
            }
            .navigationBarItems(leading: addButton, trailing: editButton)
            .navigationBarTitle(Text("Memorize"))
        }
        .sheet(isPresented: $showingAddScreen) {
            AddThemeView()
        }
    }

    var addButton: some View {
        Button(action: {
            self.showingAddScreen.toggle()
        }, label: {
            Image(systemName: "plus")
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

    var body: some View {
        NavigationLink(
            destination: GameView(viewModel: GameViewModel(theme: theme))) {
            VStack(alignment: .leading) {
                Text(theme.name).foregroundColor(theme.color)
            }
        }
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView(themes: themeData)
    }
}
