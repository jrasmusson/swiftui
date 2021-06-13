//
//  ContentView.swift
//  WeatherySwiftUI
//
//  Created by jrasmusson on 2021-06-04.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store = WeatherStore()
        
    var body: some View {
        VStack(alignment: .trailing) {
            SearchView()
            WeatherView()
            TemperatureView(temperature: store.weatherModel.temperature)
            Text(store.weatherModel.cityName).font(.largeTitle)
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
    @State private var cityName: String = "C"
    @ObservedObject var store = WeatherStore()
    
    var body: some View {
        HStack {
            Image(systemName: "location.circle.fill")
                .iconable(.medium)
            TextField(
                "Search",
                text: $cityName,
                onCommit: {
                    fetchWeather(for: cityName)
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
        store.weatherModel = WeatherModel(conditionId: 400, cityName: cityName, temperature: 22)
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
