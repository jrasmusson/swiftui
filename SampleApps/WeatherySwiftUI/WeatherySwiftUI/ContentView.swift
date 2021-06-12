//
//  ContentView.swift
//  WeatherySwiftUI
//
//  Created by jrasmusson on 2021-06-04.
//

import SwiftUI

struct ContentView: View {
    @State private var cityName = ""
    @State private var weather = defaultWeather
        
    static var defaultWeather: WeatherModel {
        return WeatherModel(conditionId: 800, cityName: "", temperature: 0)
    }
    
    var body: some View {
        VStack(alignment: .trailing) {
            SearchView(cityName: $cityName)
            WeatherView()
            TemperatureView(temperature: weather.temperature)
            Text(weather.cityName).font(.largeTitle)
            Spacer()
        }.padding()
        .background(Image("background")
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
        )
    }
}

struct WeatherView: View {
    var body: some View {
        Image(systemName: "sun.max")
            .iconable(.large)
            .padding(.top)
    }
}

struct TemperatureView: View {
    let temperature: Double
    
    var body: some View {
        Text("\(temperature, specifier: "%.0f")")
            .font(.system(size: 100, weight: .bold))
            +
            Text("°C")
            .font(.system(size: 80))
    }
}

struct SearchView: View {
    @Binding var cityName: String
    
    var body: some View {
        HStack {
            Image(systemName: "location.circle.fill")
                .iconable(.medium)
            TextField(
                    "Search",
                     text: $cityName,
                     onCommit: {
                        // cityNameChanged
                })
                .font(.title)
                .padding(8)
                .background(Color(.systemFill))
                    .cornerRadius(10)
                .keyboardType(.asciiCapable)
            Image(systemName: "magnifyingglass")
                .iconable(.medium)
        }
    }
    
    private func fetchWeather(for cityName: String) {
        // how do you tell the parent to do something?
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
