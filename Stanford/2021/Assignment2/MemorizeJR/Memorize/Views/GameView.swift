//
//  ContentView.swift
//  Memorize
//
//  Created by jrasmusson on 2022-03-27.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var vehicles = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚡", "🚜", "🛴", "✈️"]
    var food = ["🍏", "🍎", "🍐", "🍊", "🍌", "🍉", "🍇", "🍓", "🫐"]
    var flags = ["🏴‍☠️", "🚩", "🏁", "🏳️‍🌈", "🇦🇽", "🇦🇺", "🇦🇹", "🇹🇩"]

    @State private var emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚡", "🚜", "🛴", "✈️"]

    var body: some View {
        VStack {
            cards
            Spacer()
        }
        .padding(.horizontal)
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

    var buttons: some View {
        HStack {
            vehiclesButton
            Spacer()
            foodButton
            Spacer()
            flagButton
        }
        .padding(.horizontal)
    }

    var vehiclesButton: some View {
        Button {
            emojis = randomNumberOfCardsFrom(vehicles).shuffled()
        } label: {
            VStack {
                Image(systemName: "car")
                Text("Vehicles").font(.subheadline)
            }
        }
    }

    var foodButton: some View {
        Button {
            emojis = randomNumberOfCardsFrom(food).shuffled()
        } label: {
            VStack {
                Image(systemName: "cart")
                Text("Food").font(.subheadline)
            }
        }
    }

    var flagButton: some View {
        Button {
            emojis = randomNumberOfCardsFrom(flags).shuffled()
        } label: {
            VStack {
                Image(systemName: "flag")
                Text("Flags").font(.subheadline)
            }
        }
    }

    private func randomNumberOfCardsFrom(_ cards: [String]) -> [String] {
        let random = Int.random(in: 4...cards.count - 1)
        return cards.dropLast(cards.count - random)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
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
        let game = EmojiMemoryGame()
        GameView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
