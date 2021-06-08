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

#if DEBUG
let testData = WeatherModel(conditionId: 1, cityName: "Tokyo", temperature: 20)
#endif
