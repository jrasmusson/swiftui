//
//  CoreDataManager.swift
//  HelloCoreDataMVVM
//
//  Created by jrasmusson on 2021-07-08.
//

import Foundation
import CoreData

class CoreDataManager {
    
    var persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "TodoAppModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data Stack \(error)")
            }
        }
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    func deleteTask(task: Task) {
        viewContext.delete(task)
        save() // always need to call save after delete
    }
    
    func getTaskById(id: NSManagedObjectID) -> Task? {
        do {
            return try viewContext.existingObject(with: id) as? Task
        } catch {
            return nil
        }
    }
    
    func getAllTasks() -> [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
