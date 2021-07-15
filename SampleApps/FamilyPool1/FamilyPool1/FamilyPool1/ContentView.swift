//
//  ContentView.swift
//  FamilyPool1
//
//  Created by jrasmusson on 2021-06-30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView() {
            IntroView()
            ChooseTeamsView()
            Button("Start Pool!", action: createPool)
                .buttonStyle(.bordered)
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
    
    func createPool() {
        print("Create pool")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let pool = Pool()
        ContentView()
            .environmentObject(pool)
    }
}
