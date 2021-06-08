//
//  WeatherStore.swift
//  WeatherySwiftUI
//
//  Created by jrasmusson on 2021-06-08.
//

import SwiftUI
import Combine

class WeatherStore: ObservableObject {
    @Published var weatherModel: WeatherModel
    
    init(weatherModel: WeatherModel = WeatherModel(conditionId: 1, cityName: "Default", temperature: 11.0)) {
        self.weatherModel = weatherModel
    }
}
