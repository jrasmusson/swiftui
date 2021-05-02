//
//  ContentView.swift
//  iExpense
//
//  Created by jrasmusson on 2021-05-02.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var name: String

    var body: some View {
        Button("Dismiss") {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ContentView: View {
    @State private var showingSheet = false

    var body: some View {
        Button("Show Sheet") {
            self.showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "Tron")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
