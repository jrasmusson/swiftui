//
//  PlayerView.swift
//  HowItWorks
//
//  Created by jrasmusson on 2021-05-29.
//

import SwiftUI

struct PlayerView: View {
    @State private var isPlaying: Bool = false
    
    var body: some View {
        Button(action: {
            self.isPlaying.toggle()
        }) {
            Image(systemName: isPlaying ? "pause.circle" : "play.circle")
                .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
