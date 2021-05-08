# Image

## Resizeable

```swift
Image("Tron")
    .resizable()
    .scaledToFit()
    .frame(width: 300, height: 300)
```

![](images/1.png)

## Tint

```swift
Image("Tron")
    .colorMultiply(.red)
```

![](images/2.png)

## Interpolation

SwiftUI will interpolate and stretch an image making it sometimes blurry.

```swift
Image("example")
    .resizable()
    .scaledToFit()
    .frame(maxHeight: .infinity)
    .background(Color.black)
    .edgesIgnoringSafeArea(.all)
```

![](images/3.png)

You can turn this off by setting `interpolation(.none)`.

```swift
Image("example")
    .interpolation(.none)
    .resizable()
    .scaledToFit()
    .frame(maxHeight: .infinity)
    .background(Color.black)
    .edgesIgnoringSafeArea(.all)
```
![](images/4.png)

### Links that help

- [Formatting our mission view](https://www.hackingwithswift.com/books/ios-swiftui/formatting-our-mission-view)
