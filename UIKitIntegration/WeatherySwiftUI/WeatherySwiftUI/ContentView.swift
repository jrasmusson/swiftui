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
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            VStack(alignment: .trailing) {
                SearchView(store: store)
                WeatherView(conditionName: store.weatherModel.conditionName)
                TemperatureView(temperature: store.weatherModel.temperature)
                Text(store.weatherModel.cityName).font(.largeTitle)
                Spacer()
            }
            .padding()
        }
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
            TextField("Search", text: $cityName,
                onCommit: {
                    fetchWeather(for: cityName)
                })
                .searchable()
            Image(systemName: "magnifyingglass")
                .iconable(.medium)
        }
    }
    
    private func fetchWeather(for cityName: String) {
        guard let urlEncodedCityName = cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            assertionFailure("Could not encode city named: \(cityName)")
            return
        }
        
        let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=ce5edb27133f4b3a9eab5abfe8072942&units=metric")!
        let urlString = "\(weatherURL)&q=\(urlEncodedCityName)"
        
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { data, response, error in

            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }

            guard let decodedData = try? JSONDecoder().decode(WeatherData.self, from: data) else {
                print("Error decoding JSON response.")
                return
            }
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            DispatchQueue.main.async {
                let weatherModel = WeatherModel(conditionId: id, cityName: name, temperature: temp)
                store.weatherModel = weatherModel // 🦄 Magic!
            }
        }.resume()
    }
}

struct WeatherView: View {
    let conditionName: String
    
    var body: some View {
        Image(systemName: conditionName)
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

// MARK: - JSON
struct WeatherData: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Weather: Codable {
    let id: Int
    let description: String
}

struct Main: Codable {
    let temp: Double
}

// MARK: - Extensions
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

extension TextField {
    func searchable() -> some View {
        self.font(.title)
            .padding(8)
            .background(Color(.systemFill))
            .cornerRadius(10)
            .keyboardType(.asciiCapable)
    }
}
