//
//  EmojiCollectionView.swift
//  StatevsObserved
//
//  Created by jrasmusson on 2021-06-20.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var messenger: SearchManager
    @StateObject var player = Player(name: "yes", type: "mp3")
    
    @State private var isPlaying: Bool = true
    
    var body: some View {
        VStack {
            Text("Search result: \(messenger.message)")
            
            Button(action: {
                isPlaying.toggle()
                player.togglePlayer()
            }) {
                Image(systemName: isPlaying ? "pause.circle" : "play.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
                    .foregroundColor(isPlaying ? .blue : .red)
            }
        }
        .onAppear {
            self.player.togglePlayer()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(messenger: SearchManager())
    }
}
