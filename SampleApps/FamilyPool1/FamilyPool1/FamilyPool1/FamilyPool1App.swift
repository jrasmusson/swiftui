//
//  FamilyPool1App.swift
//  FamilyPool1
//
//  Created by jrasmusson on 2021-06-30.
//

import SwiftUI

@main
struct FamilyPool1App: App {
    var body: some Scene {
        WindowGroup {
            let pool = Pool()
            OnboardingFlowView()
                .environmentObject(pool)
        }
    }
}

// https://www.hackingwithswift.com/quick-start/swiftui/how-to-run-code-when-your-app-launches
