//
//  CompanyEmployeeApp.swift
//  CompanyEmployee
//
//  Created by jrasmusson on 2021-07-18.
//

import SwiftUI

@main
struct CompanyEmployeeApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.saveContext()
        }
    }
}
