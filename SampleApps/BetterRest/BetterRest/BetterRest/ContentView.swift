//
//  ContentView.swift
//  BetterRest
//
//  Created by jrasmusson on 2021-05-01.
//

import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = Date()
    
    var body: some View {
    
        DatePicker("Please enter a date", selection: $wakeUp, in: Date()...)
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
