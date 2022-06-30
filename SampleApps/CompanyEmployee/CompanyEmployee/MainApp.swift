//
//  CompanyEmployeeApp.swift
//  CompanyEmployee
//
//  Created by jrasmusson on 2022-06-30.
//

import SwiftUI

@main
struct MainApp: App {
    @StateObject private var companies = Companies()

    var body: some Scene {
        WindowGroup {
            ContentView(companies: companies)
        }
    }
}
