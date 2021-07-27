//
//  CompanyDetail.swift
//  CoreDataIntro
//
//  Created by jrasmusson on 2021-07-26.
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
                ForEach(company.employees) { employee in
                    Text(employee.name ?? "")
                }.onDelete(perform: deleteEmployee)
            }
        }.navigationTitle(company.name ?? "Unknown")
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
