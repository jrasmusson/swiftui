//
//  CompanyDetail.swift
//  CompanyEmployee2
//
//  Created by jrasmusson on 2021-07-18.
//

import SwiftUI

struct CompanyDetail: View {
    let company: Company
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var employeeName: String = ""
    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Company.name, ascending: true)],
//        animation: .default)
//    private var employees: FetchedResults<Employee>

    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Employee name", text: $employeeName)
                        .textFieldStyle(.roundedBorder)
                    Button(action: addEmployee) {
                        Label("", systemImage: "plus")
                    }
                }.padding()
                if let employees = company.employees?.allObjects as? [Employee] {
                    List {
                        ForEach(employees) { employee in
                            NavigationLink(destination: EmployeeDetail(employee: employee)) {
                                Text(employee.name ?? "")
                            }
                        }
                        .onDelete(perform: deleteEmployee)
                    }
                    .toolbar {
                        HStack { EditButton() }
                    }
                }
            }
            .navigationTitle("Companies")
        }

        Text("Ready for employees")
            .navigationTitle(company.name ?? "Unknown")
    }
    
    private func addEmployee() {
        withAnimation {
            let newEmployee = Employee(context: viewContext)
            newEmployee.name = employeeName
            PersistenceController.shared.saveContext()
        }
    }

    private func deleteEmployee(offsets: IndexSet) {
        withAnimation {
//            offsets.map { company.employees[$0] }.forEach(viewContext.delete)
            PersistenceController.shared.saveContext()
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
