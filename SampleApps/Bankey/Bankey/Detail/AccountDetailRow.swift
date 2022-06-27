//
//  DetailRow.swift
//  Bankey
//
//  Created by jrasmusson on 2022-06-24.
//

import SwiftUI

struct AccountDetailRow: View {
    let transaction: Transaction

    var body: some View {
        HStack {
            Text(transaction.description)
            Spacer()
            Text(transaction.amount)
        }
    }
}

struct DetailRow_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetailRow(transaction: tx1)
    }
}
