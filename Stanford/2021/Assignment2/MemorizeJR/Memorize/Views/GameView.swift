//
//  ContentView.swift
//  Memorize
//
//  Created by jrasmusson on 2022-03-27.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    @State private var emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚡", "🚜", "🛴", "✈️"]

    var body: some View {
        VStack {
            cards
            Spacer()
        }
        .padding(.horizontal)
        .navigationBarTitle(Text("Halloween"))
    }
}

// MARK: Buttons
extension GameView {
    var cards: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.red)
    }

    private func adaptiveWidth() -> CGFloat {
        return UIScreen.main.bounds.width / CGFloat(emojis.count) * 2
    }
}

struct CardView: View {
    let card: Card
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let theme = themeData.first!
        let game = EmojiMemoryGame(theme: theme)
        NavigationView {
            GameView(viewModel: game)
                .preferredColorScheme(.light)
        }
    }
}
