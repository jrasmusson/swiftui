//
//  ContentView.swift
//  FamilyPool1
//
//  Created by jrasmusson on 2021-06-30.
//

import SwiftUI

class Pool: ObservableObject {
    @Published var name: String
    
    init(name: String) {
        self.name = name
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            Text("What's your family name?")
            Text("How many players?")
            Text("Pick your teams")
            Text("Start your pool!")
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let pool = Pool(name: "")
        ContentView()
            .environmentObject(pool)
    }
}
