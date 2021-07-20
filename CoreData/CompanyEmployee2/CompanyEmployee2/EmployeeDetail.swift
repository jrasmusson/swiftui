//
//  EmployeeDetail.swift
//  CompanyEmployee2
//
//  Created by jrasmusson on 2021-07-19.
//

import SwiftUI

struct EmployeeDetail: View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject var employee: Employee
    @State private var employeeName: String = ""
        
    var body: some View {
        HStack {
            TextField(employee.unwrappedName, text: $employeeName)
                .textFieldStyle(.roundedBorder)
            Button(action: updateEmployee) {
                Label("", systemImage: "arrow.counterclockwise")
            }
        }.padding()
    }
    
    private func updateEmployee() {
        withAnimation {
            employee.name = employeeName
            PersistenceController.shared.saveContext()
            presentationMode.wrappedValue.dismiss()
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

// Spike how to dismiss a navigationview link programmatically
