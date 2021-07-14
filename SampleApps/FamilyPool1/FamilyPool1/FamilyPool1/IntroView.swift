//
//  IntroView.swift
//  FamilyPool1
//
//  Created by jrasmusson on 2021-07-14.
//

import SwiftUI

struct IntroView: View {
    var body: some View {
        VStack {
            Image("intro").resizable().scaledToFit()
            Text("Welcome to Family Pool").font(.title)
            Text("Create your pool by swiping through the next couple screens and answering a few simple questions.")
                .padding()
            Spacer()
            Label("Swipe", systemImage: "arrow.backward")
            Spacer()
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
