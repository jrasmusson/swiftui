//
//  AccountModelData.swift
//  Bankey
//
//  Created by jrasmusson on 2022-06-27.
//

import Foundation

struct Transaction: Identifiable, Hashable, Comparable {
    let id = UUID()
    let date: Date
    let description: String
    let amount: String = "$100.00"

    static func < (lhs: Transaction, rhs: Transaction) -> Bool {
        if lhs.date == rhs.date {
            return lhs.description < rhs.description
        }
        return lhs.date < rhs.date
    }
}

let jan1 = makeDate(day: 1, month: 1, year: 2000)
let feb1 = makeDate(day: 1, month: 2, year: 2000)
let feb11 = makeDate(day: 1, month: 2, year: 2000)
let mar1 = makeDate(day: 1, month: 3, year: 2000)
let mar11 = makeDate(day: 1, month: 3, year: 2000)
let mar111 = makeDate(day: 1, month: 3, year: 2000)


let tx1 = Transaction(date: jan1, description: "INTERACT e-Tranfer Auto-claimed")
let tx21 = Transaction(date: feb1, description: "Interact e-Transfer Sent")
let tx22 = Transaction(date: feb11, description: "Transfer from Springboar Saving account")
let tx31 = Transaction(date: mar1, description: "Interact e-Transfer Received")
let tx32 = Transaction(date: mar11, description: "VISA Payment")
let tx33 = Transaction(date: mar111, description: "The Apple Store - DISCOUNT 10%")

let trans = [tx1, tx21, tx22, tx31, tx32, tx33]

let grouped: [Date: [Transaction]] = Dictionary(grouping: trans, by: { $0.date.cutTimestamp() })

struct TxSection: Comparable, Identifiable {
    let id = UUID()
    let date: Date
    var title: String {
        return date.monthDayYearString
    }
    var transactions: [Transaction]

    static func < (lhs: TxSection, rhs: TxSection) -> Bool {
        return lhs.date < rhs.date
    }
}

var txSections: [TxSection] = grouped.keys.map { key -> TxSection in
    let unsortedTransactions: [Transaction] = grouped[key] ?? []
    return TxSection(date: key, transactions: unsortedTransactions.sorted().reversed())
}

// Then we sort the sections by reverse date as well
//sections.sorted().reversed()

class AccountModelData: ObservableObject {
    @Published var sortedTxSections = txSections.sorted().reversed()
}
