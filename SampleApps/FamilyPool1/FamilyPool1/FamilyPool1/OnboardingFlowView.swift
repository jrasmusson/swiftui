//
//  ContentView.swift
//  FamilyPool1
//
//  Created by jrasmusson on 2021-06-30.
//

import SwiftUI

struct OnboardingFlowView: View {
    var body: some View {
        TabView() {
            IntroView()
            ChooseTeamsView()
            StartPoolView()
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFlowView()
    }
}
