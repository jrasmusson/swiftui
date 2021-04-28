//
//  PodcastPlayerStore.swift
//  Dataflow
//
//  Created by jrasmusson on 2021-04-28.
//

import Foundation

class PodcastPlayerStore: ObservableObject {
    @Published var episode: Episode
    
    init(episode: Episode = Episode(title: "Unknown", showTitle: "Unknown")) {
        self.episode = episode
    }
}
