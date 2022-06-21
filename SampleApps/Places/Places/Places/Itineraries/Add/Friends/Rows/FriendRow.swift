//
//  FriendRow.swift
//  Places
//
//  Created by jrasmusson on 2022-06-21.
//

import SwiftUI

struct FriendRow: View {
    var body: some View {
        HStack {
            Image(systemName: "person")
            Text("Kate Grella")
            Spacer()
        }
    }
}

struct FriendRow_Previews: PreviewProvider {
    static var previews: some View {
        FriendRow()
            .preferredColorScheme(.dark)
    }
}
