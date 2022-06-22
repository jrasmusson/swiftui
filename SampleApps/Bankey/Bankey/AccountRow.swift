//
//  AccountRow.swift
//  Bankey
//
//  Created by jrasmusson on 2022-06-22.
//

import SwiftUI

struct AccountRow: View {
    let account: Account

    var body: some View {
        VStack(alignment: .leading) {
            Text("Banking")
            Rectangle().frame(width: 100, height: 5)

            Spacer()
        }
    }
}

struct AccountRow_Previews: PreviewProvider {
    static var previews: some View {
        AccountRow(account: account1)
    }
}
