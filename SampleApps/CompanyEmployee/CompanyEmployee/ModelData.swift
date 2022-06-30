//
//  ModelData.swift
//  CompanyEmployee
//
//  Created by jrasmusson on 2022-06-30.
//

import Foundation

struct Company: Hashable, Identifiable {
    let id = UUID()
    let name: String
}

let company1 = Company(name: "Apple")
let company2 = Company(name: "Microsoft")

class ModelData: ObservableObject {
    var companies = [company1, company2]
}
