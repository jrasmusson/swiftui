//
//  ContentView.swift
//  Moonshot
//
//  Created by jrasmusson on 2021-05-05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        NavigationView {
            VStack {
                NavigationLink(destination: Text("Detail View")) {
                    Text("Hello World")
                }
            }
            .navigationBarTitle("SwiftUI")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
