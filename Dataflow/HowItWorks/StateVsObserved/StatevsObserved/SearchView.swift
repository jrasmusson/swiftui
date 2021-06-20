//
//  EmojiCollectionView.swift
//  StatevsObserved
//
//  Created by jrasmusson on 2021-06-20.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var manager: SearchManager
    @ObservedObject var player = Player(name: "kickstarter", type: "mp3")
    
    @State private var isPlaying: Bool = true
    
    var body: some View {
        VStack {
            Text("Search result: \(manager.message)")
            
            Button(action: {
                isPlaying.toggle()
                player.togglePlayer()
            }) {
                Image(systemName: isPlaying ? "pause.circle" : "play.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
                    .foregroundColor(isPlaying ? .red : .blue)
            }
        }
        .onAppear {
            self.player.togglePlayer()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(manager: SearchManager())
    }
}
