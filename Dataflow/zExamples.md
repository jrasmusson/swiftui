# Data Flow

## State

Transient value state within a view.

```swift
struct PlayerView: View {
    @State private var isPlaying: Bool = false
    
    var body: some View {
        VStack {
            PlayButton(isPlaying: $isPlaying)
            
            Toggle(isOn: $isPlaying) {
                Text("Hello World")
            }
        }
    }
}

struct PlayButton: View {
    @Binding var isPlaying: Bool
    
    var body: some View {
        Button(action: {
            self.isPlaying.toggle()
        }) {
            Image(systemName: isPlaying ? "pause.circle" : "play.circle")
        }
    }
}
```

## ObservableObject

For reference objects created externally to a view.

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

## StateObject

For objects initialized local to a view. Just replace `ObservableObject` with `StateObject`.

## EnvironmentObject

This environment is shared between views and their decendants (subviews), which makes it perfect for passing an object down a hiearchy of views.

```swift
class Book: ObservableObject {
    @Published var title: String
    @Published var author: String

    init(title: String, author: String) {
        self.title = title
        self.author = author
    }
}
```

Parent

```swift
struct DetailView: View
{
    var body: some View {
        VStack {
            DetailHeader()
            Text("Lorem ipsum dolor sit amet")
        }
    }
}
```

Decendent

```swift
struct DetailHeader: View
{
    @EnvironmentObject var book: Book

    var body: some View {
        VStack {
            Text(book.title)
            Text(book.author)
        }
    }
}
```

Passing it in

```swift
@main
struct BookApp: App
{
    var book = Book(title: "The Hitchhiker's Guide to the Galaxy", author: "Douglas Adams")

    var body: some Scene {
        WindowGroup {
            DetailView()
                .environmentObject(book)
        }
    }
}
```


### Links that help

- [Learn App Making](https://learnappmaking.com/pass-data-between-views-swiftui-how-to/)