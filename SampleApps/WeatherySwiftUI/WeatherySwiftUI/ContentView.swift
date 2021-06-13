//
//  ContentView.swift
//  WeatherySwiftUI
//
//  Created by jrasmusson on 2021-06-04.
//

import SwiftUI

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}

class WeatherStore: ObservableObject {
    @Published var weatherModel: WeatherModel
    
    init(weatherModel: WeatherModel) {
        self.weatherModel = weatherModel
    }
}

struct ContentView: View {
    @StateObject var store: WeatherStore
        
    var body: some View {
        VStack(alignment: .trailing) {
            SearchView(store: store)
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
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            let model = WeatherModel(conditionId: 200, cityName: "Unknown", temperature: 0)
            let store = WeatherStore(weatherModel: model)
            ContentView(store: store)
        }
    }
}

struct SearchView: View {
    @StateObject var store: WeatherStore
    @State private var cityName: String = ""
    
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
