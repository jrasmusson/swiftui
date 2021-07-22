//
//  CompanyDetailView.swift
//  Demo2
//
//  Created by jrasmusson on 2021-07-21.
//

import SwiftUI

struct CompanyDetailView: View {
    var body: some View {
        NavigationLink(destination: EmployeeView()) {
            Text("Push Employee")
        }
    }
}

struct CompanyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyDetailView()
    }
}
