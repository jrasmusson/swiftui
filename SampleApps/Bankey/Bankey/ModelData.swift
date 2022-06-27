//
//  ModelData.swift
//  Bankey
//
//  Created by jrasmusson on 2022-06-22.
//

import Foundation
import SwiftUI

enum AccountType: String, CustomStringConvertible {
    case banking
    case creditCard
    case investment

    var description: String {
        switch self {
        case .banking:
            return "Banking"
        case .creditCard:
            return "Credit Card"
        case .investment:
            return "Investment"
        }
    }
}

struct Account: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let type: AccountType
    let color: Color
}

let account1 = Account(name: "Basic Savings", type: .banking, color: .teal)
let account2 = Account(name: "Visa Avion Card", type: .creditCard, color: .orange)
let account3 = Account(name: "Balanced Fund", type: .investment, color: .purple)

class ModelData: ObservableObject {
    @Published var hasOnboarded = true
    @Published var isLoggedIn = true
    @Published var accounts = [account1, account2, account3]
}
