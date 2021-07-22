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

struct Company: Identifiable {
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
            CompanyView()
        }
    }
}

struct CompanyView: View {
    @State private var showDetail = false

    var body: some View {
        VStack {
            NavigationLink(destination: CompanyDetailView(showSelf: $showDetail), isActive: $showDetail) {
                Text("Push Company")
            }
        }
    }
}

struct CompanyDetailView: View {
    @Binding var showSelf: Bool
    
    var body: some View {
        VStack {
            NavigationLink(destination: EmployeesView()) {
                Text("Push Employee")
            }
            Button(action: {
                self.showSelf = false
            }) {
                Text("Pop Company Detail")
            }
        }
    }
}

struct EmployeesView: View {
    @State private var showDetail = false
    
    var body: some View {
        VStack {
            NavigationLink(destination: EmployeeDetailView(showSelf: $showDetail), isActive: $showDetail) {
                Text("Push Employee")
            }
        }
    }
}

struct EmployeeDetailView: View {
    @Binding var showSelf: Bool
    
    var body: some View {
        Text("Employee")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
