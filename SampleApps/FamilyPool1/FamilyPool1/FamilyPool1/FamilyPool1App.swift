//
//  FamilyPool1App.swift
//  FamilyPool1
//
//  Created by jrasmusson on 2021-06-30.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var hasOnboarded: Bool

    init(hasOnboarded: Bool) {
        self.hasOnboarded = hasOnboarded
    }
}

@main
struct FamilyPool1App: App {
    
    @ObservedObject var appState = AppState(hasOnboarded: false)
    @ObservedObject var pool = PoolVM()
        
    var body: some Scene {
        WindowGroup {

            if appState.hasOnboarded {
                ResultsView()
                    .environmentObject(appState)
                    .environmentObject(pool)
            } else {
                OnboardingFlowView()
                    .environmentObject(appState)
                    .environmentObject(pool)
            }
        }
    }
}
