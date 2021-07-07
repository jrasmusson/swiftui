//
//  ContentView.swift
//  FamilyPool1
//
//  Created by jrasmusson on 2021-06-30.
//

import SwiftUI

var teams = ["Edmonton Oilers", "Calgary Flames", "Winnipeg Jets", "Montreal Canadians"]

struct Player {
    let name: String
    
    var team1Index: Int = 0
    var team2Index: Int = 0
    
    var team1Name: String { teams[team1Index] }
    var team2Name: String { teams[team2Index] }
}

class Pool: ObservableObject {
    @Published var name: String = ""
    @Published var player1: Player = Player(name: "Player1")
    @Published var player2: Player = Player(name: "Player2")
    init() {}
}

struct ContentView: View {
    var body: some View {
        TabView() {
            IntroView()
            ChooseTeamsView()
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

struct ChooseTeamsView: View {
    @EnvironmentObject var pool: Pool
    @State private var selectedTeamIndex = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Player1 team")) {
                    Picker("Select team1", selection: $pool.player1.team1Index) {
                        ForEach(0..<teams.count) {
                            Text(teams[$0])
                        }
                    }
                    Picker("Select team2", selection: $pool.player1.team2Index) {
                        ForEach(0..<teams.count) {
                            Text(teams[$0])
                        }
                    }
                }
                Section(header: Text("Player2 team")) {
                    Picker("Select team1", selection: $pool.player2.team1Index) {
                        ForEach(0..<teams.count) {
                            Text(teams[$0])
                        }
                    }
                    Picker("Select team2", selection: $pool.player2.team2Index) {
                        ForEach(0..<teams.count) {
                            Text(teams[$0])
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let pool = Pool()
//        ContentView()
//            .environmentObject(pool)
        ChooseTeamsView()
            .environmentObject(pool)
    }
}
