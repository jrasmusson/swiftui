//
//  DetailHeader.swift
//  Bankey
//
//  Created by jrasmusson on 2022-06-24.
//

import SwiftUI

struct AccountDetailHeader: View {
    let account: Account
    let size: CGFloat = 60

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text("ATB Advantage")
                        .font(.title)
                    Text("(5878)")
                }
                Spacer()
                Image(systemName: "building.columns")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size, height: size)
            }
            AccountDetailHeaderBalance()
            Rectangle().frame(width: .infinity, height: 1)
                .foregroundColor(.secondary)
                .padding([.top, .bottom], 8)
            Text("Posted transactions")
                .font(.title2)
        }
    }
}

struct AccountDetailHeader_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetailHeader(account: account1)
    }
}
