//
//  MainView.swift
//  Bankey
//
//  Created by jrasmusson on 2022-06-22.
//

import SwiftUI

enum Tab {
    case accounts
    case moveMoney
    case more
}

struct AccountsView: View {
    @EnvironmentObject var modelData: ModelData
    @State var selection: Tab = .accounts

    var body: some View {
        TabView(selection: $selection) {
            AccountsTab().environmentObject(modelData)
            MoveMoneyTab()
            MoreTab()
        }
    }
}

struct AccountsTab: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        NavigationStack {
            List(modelData.accounts) { account in
                NavigationLink(value: account) {
                    AccountRow(account: account)
                }
            }
            .navigationTitle("Accounts")
            .navigationDestination(for: Account.self) { item in
                Text(item.name)
            }
        }
        .tabItem {
            Label("Accounts", systemImage: "list.dash.header.rectangle")
        }
        .tag(Tab.accounts)
    }
}

struct MoveMoneyTab: View {
    var body: some View {
        Text("Move Money")
            .tabItem {
                Label("Move Money", systemImage: "arrow.left.arrow.right")
            }
            .tag(Tab.moveMoney)
    }
}

struct MoreTab: View {
    var body: some View {
        Text("More")
            .tabItem {
                Label("More", systemImage: "ellipsis.circle")
            }
            .tag(Tab.more)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        AccountsView()
            .environmentObject(ModelData())
    }
}
