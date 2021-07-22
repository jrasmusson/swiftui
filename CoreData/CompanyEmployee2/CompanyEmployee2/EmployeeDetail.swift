//
//  EmployeeDetail.swift
//  CompanyEmployee2
//
//  Created by jrasmusson on 2021-07-19.
//

import SwiftUI

struct EmployeeDetail: View {
    @StateObject var employee: Employee
    @State private var employeeName: String = ""
        
    var body: some View {
        VStack {
            HStack {
                TextField(employee.unwrappedName, text: $employeeName)
                    .textFieldStyle(.roundedBorder)
                Button(action: updateEmployee) {
                    Label("", systemImage: "arrow.counterclockwise")
                }
            }.padding()
            Text("\(employee.unwrappedName)")
            Spacer()
        }
    }
    
    private func updateEmployee() {
        withAnimation {
            employee.name = employeeName
            PersistenceController.shared.saveContext()
        }
    }
}

struct EmployeeDetail_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let newEmployee = Employee(context: viewContext)
        newEmployee.name = "Steve"
        
        return EmployeeDetail(employee: newEmployee)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
