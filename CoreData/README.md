# CoreData

## Save

```swift
//
//  ContentView.swift
//  Bookworm
//
//  Created by jrasmusson on 2021-05-07.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
    
    var body: some View {
        VStack {
            List {
                ForEach(students, id: \.id) { student in
                    Text(student.name ?? "Unknown")
                }
            }
            Button("Add") {
                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

                let chosenFirstName = firstNames.randomElement()!
                let chosenLastName = lastNames.randomElement()!

                // Create
                let student = Student(context: self.moc)
                student.id = UUID()
                student.name = "\(chosenFirstName) \(chosenLastName)"
                
                try? self.moc.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
```

![](images/1.png)

## Delete

```swift
func deleteBooks(at offsets: IndexSet) {
    for offset in offsets {
        // find this book in our fetch request
        let book = books[offset]

        // delete it from the context
        moc.delete(book)
    }

    // save the context
    try? moc.save()
}
```

### Links that help

- [How to combine CoreData and SwiftUI](https://www.hackingwithswift.com/books/ios-swiftui/how-to-combine-core-data-and-swiftui)
