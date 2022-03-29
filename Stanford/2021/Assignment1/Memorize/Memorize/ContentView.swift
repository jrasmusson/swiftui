//
//  ContentView.swift
//  Memorize
//
//  Created by jrasmusson on 2022-03-27.
//

import SwiftUI

struct ContentView: View {
    var vehicles = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚡", "🚜", "🛴", "✈️"]
    var food = ["🍏", "🍎", "🍐", "🍊", "🍌", "🍉", "🍇", "🍓", "🫐"]
    var flags = ["🏴‍☠️", "🚩", "🏁", "🏳️‍🌈", "🇦🇽", "🇦🇺", "🇦🇹", "🇹🇩"]

    @State private var emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚡", "🚜", "🛴", "✈️"]

    var body: some View {
        VStack {
            Text("Memorize").font(.largeTitle)
            CardsView(emojis: emojis)
            .foregroundColor(.red)
            Spacer()
            buttons
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}

// MARK: Buttons
extension ContentView {
    var buttons: some View {
        HStack {
            vehiclesButton
            Spacer()
            foodButton
            Spacer()
            flagButton
        }
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

struct CardsView: View {
    let emojis: [String]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(emojis[0..<emojis.count], id: \.self, content: { emoji in
                    CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                })
            }
        }
    }
}

// Buttons

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
