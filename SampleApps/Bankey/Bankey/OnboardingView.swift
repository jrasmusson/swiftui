//
//  OnboardingView.swift
//  Bankey
//
//  Created by jrasmusson on 2022-06-22.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var appState: ModelData

    var body: some View {
        TabView {
            Text("First")
            Text("Second")
            Text("Third")
            Button("Done") {
                appState.hasOnboarded = true // change
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
