//
//  FamilyPool1App.swift
//  FamilyPool1
//
//  Created by jrasmusson on 2021-06-30.
//

import SwiftUI

class Onboarded: ObservableObject {
    @Published var hasOnboarded = false

}

@main
struct FamilyPool1App: App {
    @StateObject private var onboarded = false
    
    var body: some Scene {
        WindowGroup {
            let pool = Pool()
            
            if pool.isOnboardingComplete {
                ResultsView()
                    .accentColor(pool.isOnboardingComplete ? .white: .black)
            } else {
                OnboardingFlowView()
                    .environmentObject(pool)
                    .accentColor(pool.isOnboardingComplete ? .white: .black)
            }
        }
    }
}

// Add logic to track when user has gone through onboarding
// Present the new main app flow
// Convert to Core Data
// https://www.hackingwithswift.com/quick-start/swiftui/how-to-run-code-when-your-app-launches
