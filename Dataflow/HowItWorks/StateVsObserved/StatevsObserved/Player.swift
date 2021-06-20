//
//  Player.swift
//  StatevsObserved
//
//  Created by jrasmusson on 2021-06-20.
//

import Foundation
import Combine
import AVFoundation

class Player: ObservableObject {
    
    let name: String
    let type: String
    
    private var audioPlayer = AVAudioPlayer()
    
    @Published var isPlaying: Bool = false
    
    init(name: String, type: String) {
        
        self.name = name
        self.type = type
        
        if let url = Bundle.main.url(forResource: name, withExtension: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer.prepareToPlay()
            } catch {
                print( "Could not find file: \(error.localizedDescription)")
            }
        }
    }
    
    private func pause()  {
        isPlaying = false
        audioPlayer.pause()
    }
    
    private func play()  {
        isPlaying = true
        audioPlayer.play()
    }
    
    func togglePlayer() {
        isPlaying ? pause() : play()
    }
}
