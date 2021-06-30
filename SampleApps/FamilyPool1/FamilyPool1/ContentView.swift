//
//  ContentView.swift
//  FamilyPool1
//
//  Created by jrasmusson on 2021-06-30.
//

import SwiftUI

class Pool: ObservableObject {
    @Published var name: String = ""
    
    init() {}
}

struct ContentView: View {
    var body: some View {
        TabView {
            FamilyNameView()
            NumberOfPlayersView()
            Text("Pick your teams")
            Text("Start your pool!")
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct FamilyNameView: View {
    @EnvironmentObject var pool: Pool
    
    var body: some View {
        VStack {
            TextField("What's your family name?", text: $pool.name)
            Text("Swipe to continue >")
        }.padding()
    }
}

struct NumberOfPlayersView: View {
    @State private var numberOfPlayers = 0
    
    var body: some View {
        VStack {
            Text("How many players?")
            Picker("", selection: $numberOfPlayers) {
                ForEach(0 ..< 6) {
                    Text("\($0)")
                }
            }
            Text("\(numberOfPlayers) players")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let pool = Pool()
        ContentView()
            .environmentObject(pool)
    }
}
