//
//  EmojiCollectionView.swift
//  StatevsObserved
//
//  Created by jrasmusson on 2021-06-20.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var messenger: SearchManager
    @StateObject var player = Player(name: "kickstarter", type: "mp3")
    
    var body: some View {
        VStack {
            Text("Search result: \(messenger.message)")
            
            Button(action: {
                player.togglePlayer()
            }, label: {
                Text(player.isPlaying ? "pause audio" : "start audio")
            })
            .foregroundColor(player.isPlaying ? .red : .blue)
            .padding()
        }
        .onAppear {
            self.player.togglePlayer()
        }
    }
}

struct EmojiCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(messenger: SearchManager())
    }
}
