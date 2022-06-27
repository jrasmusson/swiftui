//
//  AccountDetailView.swift
//  Bankey
//
//  Created by jrasmusson on 2022-06-27.
//

import SwiftUI

struct AccountDetailView: View {
    @StateObject var modelData: AccountModelData

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AccountDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetailView(modelData: AccountModelData())
    }
}
