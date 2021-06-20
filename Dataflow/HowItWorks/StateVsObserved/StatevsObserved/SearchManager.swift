//
//  MessengerManager.swift
//  StatevsObserved
//
//  Created by jrasmusson on 2021-06-20.
//

import Foundation
import Combine

class SearchManager: ObservableObject {
    
    @Published var message: String = ""
            
    func clear() {
        message = ""
    }
    
    func add(_ text: String) {
        message.append(text)
    }
}
