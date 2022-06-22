//
//  MainView.swift
//  Bankey
//
//  Created by jrasmusson on 2022-06-22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var appState: ModelData

    var body: some View {
        VStack {
            Text("Main")
            Button("Reset") {
                appState.hasOnboarded = false // change
            }
        }
    }
}
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
