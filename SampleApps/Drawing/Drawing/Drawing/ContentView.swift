//
//  ContentView.swift
//  Drawing
//
//  Created by jrasmusson on 2021-05-07.
//

import SwiftUI


struct ContentView: View {
    var body: some View {


        Image("Tron")
            .resizable()
            .scaledToFit()
            .frame(width: 400, height: 400)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
