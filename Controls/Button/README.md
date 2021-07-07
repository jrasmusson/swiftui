# Button

![](images/4.png)

```swift
import SwiftUI

struct ContentView: View {

    var body: some View {
        HStack {
            Button("Sign In", action: signIn)
            Button("Register", action: register)
        }
        .buttonStyle(.bordered)
    }
    
    func signIn() {}
    func register() {}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```

`.buttonStyle(.automatic)`

![](images/5.png)

`.buttonStyle(.plain)`

![](images/6.png)


## Simple

```swift
Button("Tap me!") {
    print("Button was tapped")
}
```

Or

```swift
Button(action: {
    print("Button was tapped")
}) { 
    Text("Tap me!")
}
```

![](images/1.png)

## With image

```swift
Button(action: {
    print("Edit button was tapped")
}) { 
    Image(systemName: "pencil")
}
```

![](images/2.png)

## With image and text

```swift
Button(action: {
    print("Edit button was tapped")
}) {
    HStack(spacing: 10) { 
        Image(systemName: "pencil")
        Text("Edit")
    }
}
```

![](images/3.png)

> Tip: If you find that your images have become filled in with a color, for example showing as solid blue rather than your actual picture, this is probably SwiftUI coloring them to show that they are tappable. To fix the problem, use the `renderingMode(.original)` modifier to force SwiftUI to show the original image rather than the recolored version.



### Links that help

- [Apple Docs](https://developer.apple.com/documentation/swiftui/button)
