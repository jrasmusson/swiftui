//
//  Persistence.swift
//  PaulCoreData
//
//  Created by jrasmusson on 2021-07-17.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        
        // Create 10 example programming languages.
        for _ in 0..<10 {
            let language = ProgrammingLanguage(context: controller.container.viewContext)
            language.name = "Example Language 1"
            language.creator = "A. Programmer"
        }
        
        return controller
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PaulCoreData")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func saveContext() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Show some error here
            }
        }
    }
}
