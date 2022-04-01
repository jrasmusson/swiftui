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

struct ThemeDetail: View {
    var body: some View {
        Text("This is the game")
    }
}

// NavigationLink

//struct ThemeView: View {
//    @State private var numbers = [Int]()
//    @State private var currentNumber = 1
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                List {
//                    ForEach(numbers, id: \.self) {
//                        Text("\($0)")
//                    }.onDelete(perform: removeRows)
//                }
//
//                Button("Add Number") {
//                    self.numbers.append(self.currentNumber)
//                    self.currentNumber += 1
//                }
//            }.navigationBarItems(leading: EditButton())
//        }
//    }
//
//    func removeRows(at offsets: IndexSet) {
//        numbers.remove(atOffsets: offsets)
//    }
//}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView()
    }
}
