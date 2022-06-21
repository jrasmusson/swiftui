//
//  FriendDetails.swift
//  Places
//
//  Created by jrasmusson on 2022-06-21.
//

import SwiftUI

struct FriendDetails: View {
    var body: some View {
        List {
            Section(header: Text("Friends")) {
                NavigationLink {
                    Text("Detail")
                } label: {
                    FriendRow()
                }
            }
            .headerProminence(.increased)
        }
    }
}

struct FriendDetails_Previews: PreviewProvider {
    static var previews: some View {
        FriendDetails()
            .preferredColorScheme(.dark)
    }
}
