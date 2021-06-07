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
        VStack(alignment: .trailing) {
            SearchView(cityName: $cityName)
            Image(systemName: "sun.max")
                .iconable(.large)
                .padding(.top)
            Text("11")
                .font(.system(size: 100, weight: .bold))
                +
                Text("°C")
                .font(.system(size: 80))
            Text("Cupertino")
                .font(.largeTitle)
            Spacer()
        }.padding()
    }
}

struct SearchView: View {
    @Binding var cityName: String
    
    var body: some View {
        HStack {
            Image(systemName: "location.circle.fill")
                .iconable(.medium)
            TextField("Search", text: $cityName)
                .font(.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.asciiCapable)
            Image(systemName: "magnifyingglass")
                .iconable(.medium)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Image {
    
    enum Size: CGFloat {
        case small = 22
        case medium = 44
        case large = 120
    }
    
    func iconable(_ size: Size) -> some View {
        self.resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: CGFloat(size.rawValue), height: size.rawValue)
    }
}
