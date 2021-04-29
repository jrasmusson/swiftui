//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by jrasmusson on 2021-04-29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .leading) {
            Text("Hello World")
            Text("This is inside a stack")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
