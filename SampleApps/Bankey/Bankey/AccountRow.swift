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
        HStack {
            MiniHeaderView(account: account)
            Spacer()
            VStack(alignment: .trailing) {
                Text("Current balance")
                Text("$929,466.23")
                Spacer()
            }
            .offset(y: 24)
        }
    }
}

struct AccountRow_Previews: PreviewProvider {
    static var previews: some View {
        AccountRow(account: account1)
    }
}

struct AccountDivider: View {
    let color: Color
    var body: some View {
        Rectangle().frame(width: 100, height: 5)
            .foregroundColor(color)
    }
}

struct MiniHeaderView: View {
    let account: Account
    var body: some View {
        VStack(alignment: .leading) {
            Text(account.type.description)
                .font(.subheadline)
            AccountDivider(color: account.color)
            Text(account.name)
            Spacer()
        }
    }
}
