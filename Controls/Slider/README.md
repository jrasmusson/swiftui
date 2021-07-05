# Slider

A control for selecting a value from a bounded linear range of values.

![](images/1.png)

```swift
import SwiftUI

struct ContentView: View {
    
    @State private var speed = 50.0
    @State private var isEditing = false

    var body: some View {
        VStack {
            Slider(
                value: $speed,
                in: 0...100,
                onEditingChanged: { editing in
                    isEditing = editing
                }
            )
            Text("\(speed)")
                .foregroundColor(isEditing ? .red : .blue)
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

- [Apple Docs](https://developer.apple.com/documentation/swiftui/slider)