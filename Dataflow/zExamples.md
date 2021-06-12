# Data Flow

## ObservableObject

### Store

This is good for when you want to update the whole `Weather` object.

```swift
import SwiftUI
import Combine

struct Weather {
    let cityName: String
}

class WeatherStore: ObservableObject {
    @Published var weather: Weather
    
    init(weather: Weather = Weather(cityName: "Calgary")) {
        self.weather = weather
    }
}

struct ContentView: View {
    @ObservedObject var store = WeatherStore()
    
    var body: some View {
        Button(action: addRoom) {
            Text("Add Room")
        }
        Text(store.weather.cityName)
    }
    
    func addRoom() {
        store.weather = Weather(cityName: "Edmonton")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```

### Single object

This works if you just want to update single attribute of weather like city name.

```swift
import SwiftUI
import Combine

class Weather: ObservableObject {
    @Published var cityName: String
    
    init(cityName: String = "Calgary") {
        self.cityName = cityName
    }
}

struct ContentView: View {
    @ObservedObject var weather = Weather()
    
    var body: some View {
        Button(action: addRoom) {
            Text("Add Room")
        }
        Text(weather.cityName)
    }
    
    func addRoom() {
        weather.cityName = "Edmonton"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```