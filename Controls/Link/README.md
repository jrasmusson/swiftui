# Link

A control for navigating to a URL.

![](images/1.png)

```swift
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Link("View Our Terms of Service",
              destination: URL(string: "https://www.example.com/TOS.html")!)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```

### Links that help

- [Apple Docs](https://developer.apple.com/documentation/swiftui/link)