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
    
    var body: some View {
        VStack {
            Text("Employees")
            HStack {
                TextField("Employee name", text: $employeeName)
                    .textFieldStyle(.roundedBorder)
                Button(action: addEmployee) {
                    Label("", systemImage: "plus")
                }
            }.padding()
            
            List {
                ForEach(company.employeesArray) { employee in
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
                if let employees = company.employees?.allObjects as? [Employee] {
                    let employee = employees[index]
                    viewContext.delete(employee)
                    PersistenceController.shared.saveContext()
                }
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
