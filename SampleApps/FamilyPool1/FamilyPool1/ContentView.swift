//
//  ContentView.swift
//  FamilyPool1
//
//  Created by jrasmusson on 2021-06-30.
//

import SwiftUI

struct Player {
    let name: String
    var team: [String]
}

class Pool: ObservableObject {
    @Published var name: String = ""
    @Published var numberOfPlayers: Int = 2
    @Published var players: [Player] = []
    init() {}
}

struct ContentView: View {
    var body: some View {
        TabView() {
            IntroView()
            FamilyNameView()
            NumberOfPlayersView()
            Text("Pick your teams")
            Text("Start your pool!")
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct IntroView: View {
    var body: some View {
        VStack {
            Image("intro").resizable().scaledToFit()
            Text("Welcome to Family Pool").font(.title)
            Text("Create your pool by swiping through the next couple screens and answering a few simple questions.")
                .padding()
            Spacer()
            Label("Swipe", systemImage: "arrow.backward")
            Spacer()
        }
    }
}

struct FamilyNameView: View {
    @EnvironmentObject var pool: Pool
    @State private var isEditing = false

    var body: some View {
        VStack {
            Image("billboard").resizable().scaledToFit()
            Spacer()
            if !pool.name.isEmpty {
                Text("\(pool.name) family pool")
            }
            TextField("Enter your pool name", text: $pool.name) { isEditing in
                self.isEditing = isEditing
            }
            .disableAutocorrection(true)
            .textFieldStyle(.roundedBorder)
            Spacer()
            Spacer()
            Label("Swipe", systemImage: "arrow.backward").opacity(isEditing ? 0 : 1)

            Spacer()
        }.padding()
    }
}

struct NumberOfPlayersView: View {
    @EnvironmentObject var pool: Pool
    
    var body: some View {
        VStack {
            Image("player")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300, alignment: .center)
            Text("How many players in the pool?")
            HStack {
                Button("2", action: twoPlayers)
                Button("4", action: fourPlayers).disabled(true)
            }
            .buttonStyle(.bordered)
            Text("\(pool.numberOfPlayers) players")
            Spacer()
        }
    }
    
    private func twoPlayers() {
        pool.numberOfPlayers = 2
        pool.players.append(Player(name: "Player1", team: []))
        pool.players.append(Player(name: "Player2", team: []))
    }
    
    private func fourPlayers() {
        pool.numberOfPlayers = 4
    }
}

struct TaskRow: View {
    var body: some View {
        Text("Task data goes here")
    }
}

struct ChooseTeamsView: View {
    @EnvironmentObject var pool: Pool
    
    var body: some View {
        List {
            Section(header: Text("Player1 Team")) {
                TaskRow()
                TaskRow()
                TaskRow()
            }
            
            Section(header: Text("Player2 Team")) {
                TaskRow()
                TaskRow()
                TaskRow()
            }
        }
    }
}

// U R HERE - figure out how to select 2 or 4 people (maybe buttons better)

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let pool = Pool()
//        ContentView()
//            .environmentObject(pool)
//        NumberOfPlayersView()
//            .environmentObject(pool)
        ChooseTeamsView()
            .environmentObject(pool)
    }
}
