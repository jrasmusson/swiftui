//
//  DetailHeaderBalance.swift
//  Bankey
//
//  Created by jrasmusson on 2022-06-24.
//

import SwiftUI

struct AccountDetailHeaderBalance: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Current balance")
                Text("$100,000.00")
                    .font(.headline)
            }
            Rectangle().frame(width: 1, height: 40)
                .foregroundColor(.secondary)
            VStack(alignment: .leading) {
                Text("Available balance")
                Text("$100,000.00")
                    .font(.headline)
            }
            Spacer()
        }
    }
}

struct AcountDetailHeaderBalance_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetailHeaderBalance()
    }
}
