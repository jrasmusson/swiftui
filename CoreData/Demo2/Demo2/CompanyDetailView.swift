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
        NavigationLink(destination: EmployeeView()) {
            Text(company.employees[0].name)
        }
    }
}

struct CompanyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyDetailView(company: apple)
    }
}
