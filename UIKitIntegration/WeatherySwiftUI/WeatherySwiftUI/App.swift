//
//  WeatherySwiftUIApp.swift
//  WeatherySwiftUI
//
//  Created by jrasmusson on 2021-06-04.
//

import SwiftUI

@main
struct WeatherySwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: WeatherStore(weatherModel: testData))
        }
    }
}

// MARK: - ViewModel
class WeatherStore: ObservableObject {
    @Published var weatherModel: WeatherModel

    init(weatherModel: WeatherModel) {
        self.weatherModel = weatherModel
    }
}

// MARK: - Model
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

#if DEBUG
let testData = WeatherModel(conditionId: 1, cityName: "Tokyo", temperature: 20)
#endif
