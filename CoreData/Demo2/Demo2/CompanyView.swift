//
//  CompanyView.swift
//  Demo2
//
//  Created by jrasmusson on 2021-07-21.
//

import SwiftUI

struct CompanyView: View {
    let companies: [Company]
    
    var body: some View {
        List {
            ForEach(companies) { company in
                NavigationLink(destination: CompanyDetailView()) {
                    Text("\(company.name)")
                }
            }
        }
    }
}

struct CompanyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CompanyView(companies: companies)
        }
    }
}
