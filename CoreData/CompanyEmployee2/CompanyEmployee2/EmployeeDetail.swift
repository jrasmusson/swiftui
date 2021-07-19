//
//  EmployeeDetail.swift
//  CompanyEmployee2
//
//  Created by jrasmusson on 2021-07-19.
//

import SwiftUI

struct EmployeeDetail: View {
    
    let employee: Employee
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
