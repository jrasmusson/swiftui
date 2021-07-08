//
//  ContentView.swift
//  HelloCoreDataMVVM
//
//  Created by jrasmusson on 2021-07-08.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var taskListVM = TaskListViewModel()
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter task name", text: $taskListVM.title)
                    .textFieldStyle(.roundedBorder)
                Button("Save") {
                    taskListVM.save()
                    taskListVM.getAllTasks()
                }
            }
            
            List {
                ForEach(taskListVM.tasks, id: \.id) { task in
                    Text(task.title)
                }
                .onDelete(perform: deleteTask)
                
                Spacer()
            }
        }
        .padding()
        .onAppear {
            taskListVM.getAllTasks()
        }
    }
    
    func deleteTask(at offsets: IndexSet) {
        offsets.forEach { index in
            let task = taskListVM.tasks[index]
            taskListVM.delete(task)
        }
        
        taskListVM.getAllTasks()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

