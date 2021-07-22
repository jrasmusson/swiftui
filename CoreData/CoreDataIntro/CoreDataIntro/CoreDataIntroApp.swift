//
//  CoreDataIntroApp.swift
//  CoreDataIntro
//
//  Created by jrasmusson on 2021-07-22.
//

import SwiftUI

@main
struct CoreDataIntroApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
