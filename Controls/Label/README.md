# Label

A standard label for user interface items, consisting of an icon with a title.

![](images/1.png)

```swift
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            Label("Lightning", systemImage: "bolt.fill")
            Label("Lightning", systemImage: "bolt.fill")
                .labelStyle(TitleOnlyLabelStyle())
            Label("Lightning", systemImage: "bolt.fill")
                .labelStyle(IconOnlyLabelStyle())
            Label {
                Text("Jonathan")
                    .font(.body)
                    .foregroundColor(.primary)
                Text("Rasmusson")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            } icon: {
                Circle()
                    .fill(.red)
                    .frame(width: 44, height: 44, alignment: .center)
                    .overlay(Text("JR"))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```

### Links that help

- [Apple docs Text](https://developer.apple.com/documentation/swiftui/label)
