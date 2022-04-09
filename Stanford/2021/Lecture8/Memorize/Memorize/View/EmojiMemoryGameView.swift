//
//  ContentView.swift
//  Memorize
//
//  Created by jrasmusson on 2022-03-27.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    @State private var dealt = Set<Int>()

    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }

    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }

    var body: some View {
        VStack {
            gameBody
            shuffleButton
        }
        .padding()
    }

    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            cardView(for: card)
        }
        .onAppear {
            withAnimation {
                for card in game.cards {
                    deal(card)
                }
            }
        }
        .foregroundColor(.red)
    }

    var shuffleButton: some View {
        Button("Shuffle") {
            withAnimation {
                game.shuffle()
            }
        }
    }

    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if isUndealt(card) ||  (card.isMatched && !card.isFaceUp) {
            Color.clear
        } else {
            CardView(card: card)
                .padding(4)
                .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity).animation(.easeInOut(duration: 3)))
                .onTapGesture {
                    withAnimation {
                        game.choose(card)
                    }
                }
        }
    }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card

    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                Pie(startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 30)).padding(4).opacity(0.6)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: card.isMatched)
                    .font(font(in: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }

    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height)*DrawingConstants.fontScale)
    }

    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.6
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
    }
}
