//
//  ContentView.swift
//  Memorize
//
//  Created by jrasmusson on 2022-03-27.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        VStack {
            cards
            Spacer()
        }
        .padding(.horizontal)
        .navigationBarTitle(Text(viewModel.title))
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
        let vm = GameViewModel(theme: theme)
        NavigationView {
            GameView(viewModel: vm).preferredColorScheme(.light)
        }
    }
}
