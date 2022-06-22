//
//  BankeyApp.swift
//  Bankey
//
//  Created by jrasmusson on 2022-06-22.
//

import SwiftUI

@main
struct BankeyApp: App {
    @StateObject var modelData = ModelData(hasOnboarded: false)
    
    var body: some Scene {
        WindowGroup {
            if modelData.hasOnboarded {
                MainView()
                    .environmentObject(modelData)
            } else {
                OnboardingView()
                    .environmentObject(modelData)
            }
        }
    }
}
