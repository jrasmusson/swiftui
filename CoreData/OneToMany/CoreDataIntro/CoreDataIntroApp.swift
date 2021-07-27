//
//  CoreDataIntroApp.swift
//  CoreDataIntro
//
//  Created by jrasmusson on 2021-07-22.
//

import SwiftUI

@main
struct CoreDataIntroApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.viewContext)
        }.onChange(of: scenePhase) { _ in
            persistenceController.saveContext()
        }
    }
}
