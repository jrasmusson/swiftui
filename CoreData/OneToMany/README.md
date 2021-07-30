# CoreData One-To-Many

- Add bi-directional relationship between company and employee.

- Set one-to-many.

- Manually generate Core Data files

Editor > Create NSManagedObject subclass 

- Update to more nicely work with SwiftUI

**Company+CoreDataProperties.swift**

```swift
import Foundation
import CoreData

extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var name: String?
    @NSManaged public var employees: NSSet?
    
    public var unwrappedName: String {
        name ?? "Unknown name"
    }

    public var employeesArray: [Employee] {
        let employeeSet = employees as? Set<Employee> ?? []
        
        return employeeSet.sorted {
            $0.unwrappedName < $1.unwrappedName
        }
    }
}

// MARK: Generated accessors for employees
extension Company {

    @objc(addEmployeesObject:)
    @NSManaged public func addToEmployees(_ value: Employee)

    @objc(removeEmployeesObject:)
    @NSManaged public func removeFromEmployees(_ value: Employee)

    @objc(addEmployees:)
    @NSManaged public func addToEmployees(_ values: NSSet)

    @objc(removeEmployees:)
    @NSManaged public func removeFromEmployees(_ values: NSSet)

}
```

**Employee+CoreDataProperties.swift**

```swift
import Foundation
import CoreData

extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var name: String?
    @NSManaged public var company: Company?
    
    public var unwrappedName: String {
        name ?? "Unknown name"
    }
}

extension Employee : Identifiable {

}
```

- Use in app.

```swift
import SwiftUI

@main
struct CoreDataIntroApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.viewContext)
        }.onChange(of: scenePhase) { _ in
            persistenceController.saveContext()
        }
    }
}
```

```swift
//
//  ContentView.swift
//  CoreDataIntro
//
//  Created by jrasmusson on 2021-07-22.
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
                        NavigationLink(destination: CompanyDetail(company: company)) {
                            Text(company.name ?? "")
                        }
                    }.onDelete(perform: deleteCompany)
                }
            }.navigationTitle("Companies")
        }
    }
    
    private func addCompany() {
        withAnimation {
            let newCompany = Company(context: viewContext)
            newCompany.name = companyName
            PersistenceController.shared.saveContext()
        }
    }

    private func deleteCompany(offsets: IndexSet) {
        withAnimation {
            offsets.map { companies[$0] }.forEach(viewContext.delete)
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

```swift
//
//  CompanyDetail.swift
//  CoreDataIntro
//
//  Created by jrasmusson on 2021-07-29.
//

import SwiftUI

struct CompanyDetail: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject var company: Company
    @State private var employeeName: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Employee name", text: $employeeName)
                    .textFieldStyle(.roundedBorder)
                Button(action: addEmployee) {
                    Label("", systemImage: "plus")
                }
            }.padding()
            
            List {
                ForEach(company.employeesArray) { employee in
                    Text(employee.unwrappedName)
                }.onDelete(perform: deleteEmployee)
            }
       }.navigationTitle("Employees")
    }
    
    private func addEmployee() {
        withAnimation {
            let newEmployee = Employee(context: viewContext)
            newEmployee.name = employeeName
            
            company.addToEmployees(newEmployee)
            PersistenceController.shared.saveContext()
        }
    }
    
    func deleteEmployee(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let employee = company.employeesArray[index]
                viewContext.delete(employee)
                PersistenceController.shared.saveContext()
            }
        }
    }
}

struct CompanyDetail_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let newCompany = Company(context: viewContext)
        newCompany.name = "Apple"
        
        let employee1 = Employee(context: viewContext)
        employee1.name = "Jobs"
        
        let employee2 = Employee(context: viewContext)
        employee2.name = "Woz"
        
        newCompany.addToEmployees(employee1)
        newCompany.addToEmployees(employee2)
        
        return CompanyDetail(company: newCompany)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
```

### Links that help

- [One-to-many relationships with @FetchRequest and SwiftUI](https://www.youtube.com/watch?v=y1oWprQqLJY&ab_channel=PaulHudson)
