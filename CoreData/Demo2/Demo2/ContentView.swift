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

let apple = Company(name: "Apple", employees: [steve])
let ibm = Company(name: "IBM", employees: [watson])

let companies = [apple, ibm]

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            CompanyView(companies: companies)
        }
    }
}

struct CompanyDetailView: View {
    var body: some View {
        NavigationLink(destination: EmployeesView()) {
            Text("Push Employees")
        }
        
    }
}

struct EmployeesView: View {
    var body: some View {
        NavigationLink(destination: EmployeeDetailView()) {
            Text("Push Employee")
        }
    }
}

struct EmployeeDetailView: View {    
    var body: some View {
        Text("Employee")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
