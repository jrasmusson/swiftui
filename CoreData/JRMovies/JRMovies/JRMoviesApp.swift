//
//  JRMoviesApp.swift
//  JRMovies
//
//  Created by jrasmusson on 2021-07-17.
//

import SwiftUI

@main
struct JRMoviesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
