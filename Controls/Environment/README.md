# Environment

## Dismissing a view

```swift
import SwiftUI

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Text("Hello")
            .onTapGesture {
                self.presentationMode.wrappedValue.dismiss()
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

- [Hacking in Swift](https://www.hackingwithswift.com/books/ios-swiftui/using-size-classes-with-anyview-type-erasure)