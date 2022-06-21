//
//  FriendDetails.swift
//  Places
//
//  Created by jrasmusson on 2022-06-21.
//

import SwiftUI

struct FriendDetails: View {
    @State var showingAddFriend = false

    var body: some View {
        List {
            Section(header: Text("Friends")) {
                NavigationLink {
                    Text("Kate Grella")
                } label: {
                    FriendRow(fullname: "Kate Grella")
                }
                NavigationLink {
                    Text("Jeremy Sheldon")
                } label: {
                    FriendRow(fullname: "Jeremy Sheldon")
                }
                Button(action: {
                    self.showingAddFriend.toggle()
                }) {
                    AddFriendRow()
                }
                .foregroundColor(appColor)
            }
            .headerProminence(.increased)
        }
        .sheet(isPresented: $showingAddFriend) {
            Text("Add friend")
        }
    }
}

struct FriendDetails_Previews: PreviewProvider {
    static var previews: some View {
        FriendDetails()
            .preferredColorScheme(.dark)
    }
}
