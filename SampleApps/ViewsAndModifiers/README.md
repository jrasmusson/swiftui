# Views and Modifiers


## Views

- Are immutable structs.
- They continuously get re-rendered based on state
- Contain only they which they need (inherit nothing).

### Only take the space they need

When you set the background behind a Text field many expect it to fill the entire screen. Except it doesn't.

```swift
struct ContentView: View {
    var body: some View {
        Text("Hello World")
            .background(Color.red)
    }
}
```

![](images/1.png)

To fill the entire view you need to do this.

```swift
Text("Hello World")
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.red)
```

There is nothing behind the SwiftUI views you put on screen. maxWidth means the view can take the max space. But if something else needs space, SwiftUI will accomodate it too.

[What is behind the manin SwiftUI view?](https://www.hackingwithswift.com/books/ios-swiftui/what-is-behind-the-main-swiftui-view)

## Why modifier order matters

When you apply a modifier to a SwiftUI view, you create a new view with that change applied. But the order in which we apply these matters.

```swift
Button("Hello World") {
    // do nothing
}    
.background(Color.red)
.frame(width: 200, height: 200)
```

![](images/2.png)

```swift
Button("Hello World") {
    print(type(of: self.body))
}
.frame(width: 200, height: 200)
.background(Color.red)
```

![](images/3.png)

Best way to think about this is that SwiftUI renders your view after every single modifier.

```swift
Text("Hello World")
        .padding()
        .background(Color.red)
        .padding()
        .background(Color.blue)
        .padding()
        .background(Color.green)
        .padding()
        .background(Color.yellow)
```

![](images/4.png)

[Why modifier order matters](https://www.hackingwithswift.com/books/ios-swiftui/why-modifier-order-matters)

### Links that help

- [Start - Views and Modifiers](https://www.hackingwithswift.com/books/ios-swiftui/views-and-modifiers-introduction)
