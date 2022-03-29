//
//  ContentView.swift
//  Memorize
//
//  Created by jrasmusson on 2022-03-27.
//

import SwiftUI

struct ContentView: View {
    var vehicles = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚡", "🚜", "🛴", "✈️"]
    var food = ["🍏", "🍎", "🍐", "🍊", "🍌", "🍉", "🍇", "🍓", "🫐", "🍒"]
    var flags = ["🏴‍☠️", "🚩", "🏁", "🏳️‍🌈", "🇦🇽", "🇦🇺", "🇦🇹", "🇹🇩", "🇨🇦", "🇨🇩"]

    @State private var emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚡", "🚜", "🛴", "✈️"]
    @State var emojiCount = 10

    var body: some View {
        VStack {
            CardsView(emojisCount: emojiCount, emojis: emojis)
            .foregroundColor(.red)
            Spacer()
            HStack {
                vehiclesButton
                Spacer()
                foodButton
                Spacer()
                flagButton
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }

    var vehiclesButton: some View {
        Button {
            emojis = vehicles
        } label: {
            VStack {
                Image(systemName: "car")
                Text("Vehicles").font(.subheadline)
            }
        }
    }

    var foodButton: some View {
        Button {
            emojis = food
        } label: {
            VStack {
                Image(systemName: "cart")
                Text("Food").font(.subheadline)
            }
        }
    }

    var flagButton: some View {
        Button {
            emojis = flags
        } label: {
            VStack {
                Image(systemName: "flag")
                Text("Flags").font(.subheadline)
            }
        }
    }
}

struct CardsView: View {
    let emojisCount: Int
    let emojis: [String]

    var body: some View {
        ScrollView {
            if emojisCount != emojis.count {
                Text("Emoj counts don't match.")
            } else {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojisCount], id: \.self, content: { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    })
                }
            }
        }
    }
}

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
