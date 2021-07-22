//
//  PaulCoreDataApp.swift
//  PaulCoreData
//
//  Created by jrasmusson on 2021-07-17.
//

import SwiftUI

@main
struct PaulCoreDataApp: App {
    @Environment(\.scenePhase) var scenePhase

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.saveContext()
        }
    }
}
