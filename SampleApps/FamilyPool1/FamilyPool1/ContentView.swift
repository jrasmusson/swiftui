//
//  ContentView.swift
//  FamilyPool1
//
//  Created by jrasmusson on 2021-06-30.
//

import SwiftUI

class Pool: ObservableObject {
    @Published var name: String = ""
    @Published var numberOfPlayers: Int = 1
    
    init() {}
}

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            IntroView(selectedTab: $selectedTab).tag(0)
            FamilyNameView().tag(1)
            NumberOfPlayersView()
            Text("Pick your teams")
            Text("Start your pool!")
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct IntroView: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack {
            Image("intro")
                .resizable()
                .scaledToFit()
            Text("Welcome to Family Pool").font(.title)
            Text("Create your pool by clicking next or swiping through the next couple of screens to answer a few simple questions.")
                .padding()
            Button("Next", action: next)
                .buttonStyle(.bordered)
            Spacer()
        }
    }
    
    func next() {
        // U R HERE - how to change state to advance next
        selectedTab = 1
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
    @EnvironmentObject var pool: Pool
    
    var body: some View {
        VStack {
            Text("How many players?")
            Picker("", selection: $pool.numberOfPlayers) {
                ForEach(2 ..< 5) {
                    Text("\($0)")
                }
            }
            Text("\(pool.numberOfPlayers + 2) players")
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
