# ScrollViewReader

A view that provides programmatic scrolling, by working with a proxy to scroll to known child views.

![](images/1.png)

```swift
import SwiftUI

struct ContentView: View {
    
    @State private var vibrateOnRing = true

    var body: some View {
        Toggle("Vibrate on Ring", isOn: $vibrateOnRing)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```

### Links that help

- [Apple docs](https://developer.apple.com/documentation/swiftui/toggle)
