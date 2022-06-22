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
            Page(imageName: "delorean", text: "Bankey is faster, easier, and fun!")
            .environmentObject(modelData)
            Page(imageName: "world", text: "Move money quickly and safely.")
            .environmentObject(modelData)
            Page(imageName: "thumbs", text: "Learn more at bankey.com.")
            .environmentObject(modelData)
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
