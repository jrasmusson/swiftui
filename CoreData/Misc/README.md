# CoreData Misc

## Save when app goes to background

**App.swift**

```swift
import SwiftUI

@main
struct MyApp: App {
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

## Convert String into Enum

Store your property as a `String` then convert to an `enum` like this.

```swift
extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var id: UUID
    @NSManaged public var numberOfSlices: Int16
    @NSManaged public var pizzaType: String
    @NSManaged public var status: String
    @NSManaged public var tableNumber: String

    var orderStatus: Status {
        set {
            status = newValue.rawValue
        }
        get {
            Status(rawValue: status) ?? .pending
        }
    }
}

extension Order : Identifiable {

}

enum Status: String {
    case pending = "Pending"
    case preparing = "Preparing"
    case completed = "Completed"
}
```
