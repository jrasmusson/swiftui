//
//  Persistence.swift
//  CompanyEmployee2
//
//  Created by jrasmusson on 2021-07-18.
//

import CoreData

struct PersistenceController {
    let container: NSPersistentContainer
    
    static let shared = PersistenceController()
    
    // Convenience
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<1 {
            let newCompany = Company(context: viewContext)
            newCompany.name = "Apple"
        }
        shared.saveContext()
        
        return result
    }()
    
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CompanyEmployee2")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    // Better save
    func saveContext() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}
