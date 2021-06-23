# Text

```swift
Text("Hamlet")
    .font(.title)
```

![](images/2.png)

```swift
Text("by William Shakespeare")
    .font(.system(size: 12, weight: .light, design: .serif))
    .italic()
```

![](images/3.png)

```swift
Text("To be, or not to be, that is the question:")
    .frame(width: 100)
```

![](images/4.png)

```swift
Text("Brevity is the soul of wit.")
    .frame(width: 100)
    .lineLimit(1)
```

![](images/5.png)

## Specifier

```swift
Text("\(temperature, specifier: "%.2f")") // x2 decimal
```

```swift
Text("\(temperature, specifier: "%.0f")") // 0 decimal
```

## submitLabel

```swift
struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        Form {
            TextField("Username", text: $username)
                .submitLabel(.continue)
            SecureField("Password", text: $password)
                .submitLabel(.done)
        }
    }
}
```

### Links that help

- [Apple docs Text](https://developer.apple.com/documentation/swiftui/text)
