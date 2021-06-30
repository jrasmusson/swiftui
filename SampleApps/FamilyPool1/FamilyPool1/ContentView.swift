//
//  ContentView.swift
//  FamilyPool1
//
//  Created by jrasmusson on 2021-06-30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FirstView()
            SecondView()
            ThirdView()
        }
        .tabViewStyle(.page)
    }
}

struct FirstView: View {
    var body: some View {
        Text("View 1")
    }
}

struct SecondView: View {
    var body: some View {
        Text("View 2")
    }
}

struct ThirdView: View {
    var body: some View {
        Text("View 3")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
