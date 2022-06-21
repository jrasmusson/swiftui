//
//  FriendRow.swift
//  Places
//
//  Created by jrasmusson on 2022-06-21.
//

import SwiftUI

struct FriendRow: View {
    let fullname: String
    var body: some View {
        HStack {
            Image(systemName: "person")
            Text(fullname)
            Spacer()
        }
    }
}

struct FriendRow_Previews: PreviewProvider {
    static var previews: some View {
        FriendRow(fullname: "Kate Grella")
            .preferredColorScheme(.dark)
    }
}
