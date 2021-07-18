//
//  CompanyDetail.swift
//  CompanyEmployee
//
//  Created by jrasmusson on 2021-07-18.
//

import SwiftUI

struct CompanyDetail: View {
    
    let company: Company
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("\(company.name!)")
            Button("Update") {
                company.name = "Pixar"
                PersistenceController.shared.saveContext()
                presentationMode.wrappedValue.dismiss()
            }
            Spacer()
        }
    }
    
}

struct CompanyDetail_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let newCompany = Company(context: viewContext)
        newCompany.name = "Apple"
        
        return CompanyDetail(company: newCompany)
            .environment(\.managedObjectContext, PersistenceController.preview.viewContext)
    }
}
