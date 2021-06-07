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

## NSAttributedStrings

SwiftUI doesn't yet have them. But you can fake by either bringing in `UILabel` or working with `Text`.

### UIViewRepresentable

```swift
struct UIKLabel: UIViewRepresentable {

    typealias TheUIView = UILabel
    fileprivate var configuration = { (view: TheUIView) in }

    func makeUIView(context: UIViewRepresentableContext<Self>) -> TheUIView { TheUIView() }
    func updateUIView(_ uiView: TheUIView, context: UIViewRepresentableContext<Self>) {
        configuration(uiView)
    }
}
```

And then use:

```swift
var body: some View {
    UIKLabel {
        $0.attributedText = NSAttributedString(string: "HelloWorld")
    }
}
```

### Concatenate Text

```swift
Group {
    Text("Bold")
        .fontWeight(.bold) +
    Text("Underlined")
        .underline() +
    Text("Color")
        .foregroundColor(Color.red)
}
```

![](images/6.png)

- [StackOverFlow](https://stackoverflow.com/questions/59531122/how-to-use-attributed-string-in-swiftui)

### Links that help

- [Apple docs Text](https://developer.apple.com/documentation/swiftui/text)
