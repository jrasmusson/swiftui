//
//  PizzaRestaurantApp.swift
//  PizzaRestaurant
//
//  Created by jrasmusson on 2021-07-13.
//

import SwiftUI

@main
struct PizzaRestaurantApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
