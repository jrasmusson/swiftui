# Image

## Resizeable

```swift
Image("Tron")
    .resizable()
    .scaledToFit()
    .frame(width: 300, height: 300)
```

![](images/1.png)

## SF Symbols

```swift
Image(systemName: "chevron.left").imageScale(.small)
Image(systemName: "chevron.left").imageScale(.medium)
Image(systemName: "chevron.left").imageScale(.large)
```

## Tint

```swift
Image("Tron")
    .colorMultiply(.red)
```

![](images/2.png)




### Links that help

- [Formatting our mission view](https://www.hackingwithswift.com/books/ios-swiftui/formatting-our-mission-view)
