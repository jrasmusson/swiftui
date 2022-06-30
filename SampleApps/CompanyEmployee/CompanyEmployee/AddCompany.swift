//
//  AddCompany.swift
//  CompanyEmployee
//
//  Created by jrasmusson on 2022-06-30.
//

import SwiftUI

struct AddCompany: View {
    @State var name = ""

    var body: some View {
        TextField("New company name", text: $name,
                  onCommit: {
                
        })
    }
}

struct AddCompany_Previews: PreviewProvider {
    static var previews: some View {
        AddCompany()
    }
}
