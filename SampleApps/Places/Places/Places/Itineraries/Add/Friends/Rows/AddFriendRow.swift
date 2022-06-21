//
//  AddFriendRow.swift
//  Places
//
//  Created by jrasmusson on 2022-06-21.
//

import SwiftUI

struct AddFriendRow: View {
    var body: some View {
        HStack {
            Image(systemName: "plus.circle.fill")
            Text("Add People")
            Spacer()
        }
        .foregroundColor(appColor)
    }
}

struct AddFriendRow_Previews: PreviewProvider {
    static var previews: some View {
        AddFriendRow()
            .preferredColorScheme(.dark)
    }
}
