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

struct MainView: View {
    @EnvironmentObject var modelData: ModelData
    @State var selection: Tab = .accounts

    var body: some View {
        TabView(selection: $selection) {
                    NavigationStack {
                        ScrollView {
                            ForEach(modelData.accounts) { account in
                                NavigationLink(value: account) {
                                    Text(account.name)
                                }
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

                    Text("Move Money")
                        .tabItem {
                            Label("Itineraries", systemImage: "arrow.left.arrow.right")
                        }
                        .tag(Tab.moveMoney)

                    Text("More")
                        .tabItem {
                            Label("Profile", systemImage: "ellipsis.circle")
                        }
                        .tag(Tab.more)
                }
    }
}
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
