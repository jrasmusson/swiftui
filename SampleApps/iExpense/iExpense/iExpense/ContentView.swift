//
//  ContentView.swift
//  iExpense
//
//  Created by jrasmusson on 2021-05-02.
//

import SwiftUI

struct SecondView: View {
    var name: String

    var body: some View {
        Text("Hello, \(name)!")
    }
}

struct ContentView: View {
    @State private var showingSheet = false

    var body: some View {
        Button("Show Sheet") {
            self.showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
