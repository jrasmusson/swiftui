//
//  ContentView.swift
//  Drawing
//
//  Created by jrasmusson on 2021-05-07.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        Path { path in
            path.move(to: CGPoint(x: 200, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 300))
            path.addLine(to: CGPoint(x: 300, y: 300))
            path.addLine(to: CGPoint(x: 200, y: 100))
        }
        .stroke(Color.blue.opacity(0.25), lineWidth: 10)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
