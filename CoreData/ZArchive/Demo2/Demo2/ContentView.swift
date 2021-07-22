//
//  ContentView.swift
//  Demo
//
//  Created by jrasmusson on 2021-07-20.
//

import SwiftUI

struct Employee: Identifiable, Hashable {
    var id: String { name }
    let name: String
}

struct Company: Identifiable, Hashable {
    var id: String { name}
    let name: String
    let employees: [Employee]
}

let steve = Employee(name: "Steve")
let watson = Employee(name: "Watson")

let apple = Company(name: "Apple", employees: [steve, watson])
let ibm = Company(name: "IBM", employees: [watson, steve])

let companies = [apple, ibm]

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            CompanyView(companies: companies)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
