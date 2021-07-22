//
//  EmployeeView.swift
//  Demo2
//
//  Created by jrasmusson on 2021-07-21.
//

import SwiftUI

struct EmployeeView: View {
    let employee: Employee
    
    var body: some View {
        Text("\(employee.name)")
    }
}

struct EmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeView(employee: Employee(name: "Steve"))
    }
}
