//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by jrasmusson on 2021-04-29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
    }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
