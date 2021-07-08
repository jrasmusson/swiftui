//
//  HelloCoreDataApp.swift
//  HelloCoreData
//
//  Created by jrasmusson on 2021-07-07.
//

import SwiftUI

@main
struct HelloCoreDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: CoreDataManager())
        }
    }
}
