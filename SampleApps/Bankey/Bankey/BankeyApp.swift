//
//  BankeyApp.swift
//  Bankey
//
//  Created by jrasmusson on 2022-06-22.
//

import SwiftUI

@main
struct BankeyApp: App {
    @StateObject var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            if modelData.hasOnboarded {
                if modelData.isLoggedIn {
                    AccountsView().environmentObject(modelData)
                } else {
                    LoginView().environmentObject(modelData)
                }
            } else {
                OnboardingView().environmentObject(modelData)
            }
        }
    }
}
