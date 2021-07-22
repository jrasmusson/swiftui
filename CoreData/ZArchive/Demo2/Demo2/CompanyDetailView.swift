//
//  CompanyDetailView.swift
//  Demo2
//
//  Created by jrasmusson on 2021-07-21.
//

import SwiftUI

struct CompanyDetailView: View {
    let company: Company
    
    var body: some View {
        let employees = company.employees
        List {
            ForEach(employees, id: \.self) { employee in
                NavigationLink(destination: EmployeeView(employee: employee)) {
                    Text("\(employee.name)")
                }
            }
        }
    }
}

struct CompanyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyDetailView(company: apple)
    }
}
