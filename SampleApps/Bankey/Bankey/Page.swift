//
//  Page1.swift
//  Bankey
//
//  Created by jrasmusson on 2022-06-22.
//

import SwiftUI

struct Page: View {
    @EnvironmentObject var modelData: ModelData

    let imageName: String
    let text: String
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                Text(text)
                    .font(.title)
                    .padding(.top, 20)
            }
            .padding()
            .toolbar {
                Button(action: {
                    modelData.hasOnboarded = true
                }) {
                    Text("Close")
                }
            }
        }
    }
}

struct Page_Previews: PreviewProvider {
    static var previews: some View {
        Page(imageName: "delorean",
              text: "Bankey is faster, easier, and fun!")
            .environmentObject(ModelData())
    }
}
