# CoreData Intro


![](images/1.png)

## Convenience wrapper and save in context 

**PersistenceController.swift**

```swift
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

        // Companies
        let newCompany = Company(context: viewContext)
        newCompany.name = "Apple"

        shared.saveContext()
        
        return result
    }()

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "--REPLACEME--") // else UnsafeRawBufferPointer with negative count
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
```

## Save when app goes to background

**App.swift**

```swift
import SwiftUI

@main
struct JRMoviesApp: App {
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
```

## FetchRequest automatically refreshes the view

**ContentView.swift**

```swift
//
//  ContentView.swift
//  CoreDataIntro
//
//  Created by jrasmusson on 2021-07-23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var companyName: String = ""
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Company.name, ascending: true)],
        animation: .default)
    private var companies: FetchedResults<Company>
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Company name", text: $companyName)
                        .textFieldStyle(.roundedBorder)
                    Button(action: addCompany) {
                        Label("", systemImage: "plus")
                    }
                }.padding()
                List {
                    ForEach(companies) { company in
                        NavigationLink(destination: UpdateView(company: company)) {
                            Text(company.name ?? "")
                        }
                    }.onDelete(perform: deleteCompany)
                }.toolbar { EditButton() }
            }.navigationTitle("Companies")
        }
    }
    
    private func deleteCompany(offsets: IndexSet) {
      withAnimation {
        offsets.map { companies[$0] }.forEach(viewContext.delete)
          PersistenceController.shared.saveContext()
        }
    }

    private func addCompany() {
        withAnimation {
            let newCompany = Company(context: viewContext)
            newCompany.name = companyName
            PersistenceController.shared.saveContext()
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext,
         PersistenceController.preview.container.viewContext)
    }
}
```

**UpdateView.swift**

![](images/2.png)

```swift
//
//  UpdateView.swift
//  CoreDataIntro
//
//  Created by jrasmusson on 2021-07-23.
//

import SwiftUI

struct UpdateView: View {
    @StateObject var company: Company
    
    @State private var companyName: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Update company name", text: $companyName)
                    .textFieldStyle(.roundedBorder)
                Button(action: updateCompany) {
                    Label("", systemImage: "arrowshape.turn.up.left")
                }
            }.padding()
            Text(company.name ?? "")
            Spacer()
        }
    }
    
    private func updateCompany() {
        withAnimation {
            company.name = companyName
            PersistenceController.shared.saveContext()
        }
    }
}

struct UpdateView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let newCompany = Company(context: viewContext)
        newCompany.name = "IBM"
                
        return UpdateView(company: newCompany)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
```


### Links that help

- [One-to-many relationships with @FetchRequest and SwiftUI](https://www.youtube.com/watch?v=y1oWprQqLJY&ab_channel=PaulHudson)
