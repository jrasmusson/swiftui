//
//  OnboardingView.swift
//  Bankey
//
//  Created by jrasmusson on 2022-06-22.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        TabView {
            Page1().environmentObject(modelData)
            Text("Second")
            Text("Third")
            Button("Done") {
                modelData.hasOnboarded = true // change
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environmentObject(ModelData())
    }
}
