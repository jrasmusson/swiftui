//
//  ContentView.swift
//  StatevsObserved
//
//  Created by jrasmusson on 2021-06-20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var messenger = SearchManager()
    
    var body: some View {
        VStack {
            TextField("Search for music here", text: $messenger.message)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SearchView(messenger: messenger)
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
