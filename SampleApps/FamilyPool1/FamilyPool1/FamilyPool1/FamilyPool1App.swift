//
//  FamilyPool1App.swift
//  FamilyPool1
//
//  Created by jrasmusson on 2021-06-30.
//

import SwiftUI

@main
struct FamilyPool1App: App {
    
    private var pool = Pool()
        
    var body: some Scene {
        WindowGroup {
            
//            if onboarding.hasOnboarded {
//                ResultsView()
//                    .environmentObject(pool)
//            } else {
                OnboardingFlowView()
                    .environmentObject(pool)
//            }
        }
    }
}

// Figure out flow to switch from onboarding to non-onboarding
