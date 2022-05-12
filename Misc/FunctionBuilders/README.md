# Function Builders

You can only type certain syntax when creating a view:

![](images/10.png)

This is because SwiftUI uses a function builder called `@ViewBuilder`.

```swift
public protocol View {
    associatedtype Body : View
    @ViewBuilder var body: Self.Body { get }
}

VStack {
    Text("Hi")
    Text("Hi")
}
```

It takes code attributed with `@ViewBuilder` and the compiler converts this:

```swift
@ViewBuilder
func combineWords() -> TupleView<(Text, Text)> {
    Text("Hello")
    Text("World")
}
combineWords()
```

Into something like this:

```swift
func combineWords() -> TupleView<(Text, Text)> {
  let _a = Text("Hello")
  let _b = Text("World")
  return ViewBuilder.buildBlock(_a, _b)
}
```

### Links that help

- [Article1](https://www.andyibanez.com/posts/understanding-function-builders/)
- [Article2](https://medium.com/@carson.katri/create-your-first-function-builder-in-5-minutes-b4a717390671)

