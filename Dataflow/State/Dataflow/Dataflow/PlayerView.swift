//
//  PlayerView.swift
//  Dataflow
//
//  Created by jrasmusson on 2021-04-28.
//

import SwiftUI

struct Episode {
    let title: String
    let showTitle: String
}

struct PlayerView: View {
    @EnvironmentObject var store: PodcastPlayerStore
    @State private var isPlaying: Bool = false
    
    var body: some View {
        VStack {
            Text(store.episode.title)
            Text(store.episode.showTitle).font(.caption).foregroundColor(.gray)
            
            PlayButton(isPlaying: $isPlaying)
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}

struct PlayButton: View {
    @Binding var isPlaying: Bool
    
    var body: some View {
        Button(action: {
            withAnimation { self.isPlaying.toggle() }
        }, label: {
            Image(systemName: isPlaying ? "pause.circle" : "play.circle" )
        })
    }
}
