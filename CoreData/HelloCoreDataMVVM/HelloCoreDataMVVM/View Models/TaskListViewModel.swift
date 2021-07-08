//
//  TaskListViewModel.swift
//  HelloCoreDataMVVM
//
//  Created by jrasmusson on 2021-07-08.
//

import Foundation
import CoreData

class TaskListViewModel: ObservableObject {
    var title: String = ""
    
    @Published var tasks: [TaskViewModel] = []
    
    func save() {
        let task = Task(context: CoreDataManager.shared.viewContext)
        task.title = title
        
        CoreDataManager.shared.save()
    }
    
    func delete(_ task: TaskViewModel) {
        // Need to get the Core Data object and call delete on it
        guard let existingTask = CoreDataManager.shared.getTaskById(id: task.id) else { return }
        CoreDataManager.shared.deleteTask(task: existingTask)
    }
    
    func getAllTasks() {
        // Convert CoreData Task > TaskViewModel
        // Task is passed into TaskViewModel constructor
        tasks = CoreDataManager.shared.getAllTasks().map(TaskViewModel.init)
    }
}

struct TaskViewModel {
    
    let task: Task
    
    var id: NSManagedObjectID {
        task.objectID
    }
    
    var title: String {
        task.title ?? ""
    }
}
