//
//  Page1.swift
//  Bankey
//
//  Created by jrasmusson on 2022-06-22.
//

import SwiftUI

struct Page1: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("delorean")
                    .resizable()
                    .scaledToFit()
                Text("Bankey is faster, easier, and fun!")
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

struct Page1_Previews: PreviewProvider {
    static var previews: some View {
        Page1()
            .environmentObject(ModelData())
    }
}
