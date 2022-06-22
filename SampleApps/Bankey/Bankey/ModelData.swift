//
//  ModelData.swift
//  Bankey
//
//  Created by jrasmusson on 2022-06-22.
//

import Foundation

struct Account: Identifiable, Hashable {
    let id = UUID()
    let name: String
}

let account1 = Account(name: "Basic Savings")
let account2 = Account(name: "No-Fee All-In Chequing")
let account3 = Account(name: "Visa Avion Card")

class ModelData: ObservableObject {
    @Published var hasOnboarded = true
    @Published var isLoggedIn = true
    @Published var accounts = [account1, account2, account3]
}
