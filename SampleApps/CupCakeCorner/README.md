# Cupcake Corner

## Adding Codable conformance for @Published properties

Property wrappers like `@Published` aren't by default `Codeable`. We need to do some extra work.

```swift
class User: ObservableObject, Codable {
    @Published var name = "Paul Hudson"
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}
```

## Sending and receiving Codable data with URLSession and SwiftUI


### Links that help

- [Cup Cake Corner](https://www.hackingwithswift.com/books/ios-swiftui/cupcake-corner-introduction)
- [Adding Codable conformance for @Published properties](https://www.hackingwithswift.com/books/ios-swiftui/adding-codable-conformance-for-published-properties)
- [Sending and receiving Codable data with URLSession and SwiftUI](https://www.hackingwithswift.com/books/ios-swiftui/sending-and-receiving-codable-data-with-urlsession-and-swiftui)
