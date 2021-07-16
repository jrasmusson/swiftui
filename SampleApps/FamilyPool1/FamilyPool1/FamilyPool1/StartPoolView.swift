//
//  StartPoolView.swift
//  FamilyPool1
//
//  Created by jrasmusson on 2021-07-15.
//

import SwiftUI

struct StartPoolView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Button("Start Pool!") {
            appState.hasOnboarded = true
        }
        .buttonStyle(.bordered)
    }
}

struct StartPoolView_Previews: PreviewProvider {
    static var previews: some View {
        let pool = Pool()
        StartPoolView()
            .environmentObject(pool)
    }
}
