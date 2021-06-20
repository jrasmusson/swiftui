//
//  ContentView.swift
//  StatevsObserved
//
//  Created by jrasmusson on 2021-06-20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var manager = SearchManager()
    
    var body: some View {
        VStack {
            TextField("Search for music here", text: $manager.message)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SearchView(manager: manager)
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
