//
//  ContentView.swift
//  WeatherySwiftUI
//
//  Created by jrasmusson on 2021-06-04.
//

import SwiftUI

struct ContentView: View {
    @State private var cityName = ""
    
    var body: some View {
        SearchView(cityName: $cityName)
    }
}

struct SearchView: View {
    @Binding var cityName: String
    
    var body: some View {
        HStack {
            Image(systemName: "location.circle.fill")
                .iconable()
            TextField("Search", text: $cityName)
                .font(.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.asciiCapable)
            Image(systemName: "magnifyingglass")
                .iconable()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Image {
    func iconable() -> some View {
        self.resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 44, height: 44)
    }
}
