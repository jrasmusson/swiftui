//
//  AccountDetailView.swift
//  Bankey
//
//  Created by jrasmusson on 2022-06-27.
//

import SwiftUI

struct AccountDetailView: View {
    let account: Account

    @StateObject var modelData: AccountModelData

    var body: some View {
        List {
            VStack(alignment: .leading) {
                AccountDetailHeader(account: account)
                AccountDetailHeaderBalance()
            }
            ForEach(modelData.sortedTxSections) { section in
                Section(header: Text(section.title)) {
                    ForEach(section.transactions) { tx in
                        Text("Hi")
                    }
                }
            }
        }
    }
}

struct AccountDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetailView(account: account1,
                          modelData: AccountModelData())
    }
}
