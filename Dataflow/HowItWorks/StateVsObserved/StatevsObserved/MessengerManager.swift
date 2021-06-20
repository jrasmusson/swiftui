//
//  MessengerManager.swift
//  StatevsObserved
//
//  Created by jrasmusson on 2021-06-20.
//

import Foundation
import Combine

class MessengerManager: ObservableObject {
    
    @Published var message: String = ""
    
    var subscriptions = Set<AnyCancellable>()
        
    func clear() {
        message = ""
    }
    
    func add(_ text: String) {
        message.append(text)
    }
    
    let emojis = [["😇", "🙂", "🤬"],["🤯","🥱", "🤔"],["😸", "😿", "🙀"]]
}
