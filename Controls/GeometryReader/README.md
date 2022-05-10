# GeometryReader

Gives you a `GeometryProxy` which lets us query our environment and set an image's size specifically.

```swift
VStack {
    GeometryReader { geo in
        Image("Example")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: geo.size.width, height: 300)
    }
}
```

![](images/7.png)

Or to the full width of the screen depending on the device.

```swift
VStack {
    GeometryReader { geo in
        Image("Example")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: geo.size.width)
    }
}
```

![](images/8.png)

## Adjusting layout

Because `GeometryReader` wants to take all the space offered, adding one to your view will change the layout.

## Layout not centered

If your layout looks off after wrapping, your can center it like this:

```swift
func button(for position: Position) -> some View {
    let tileState = viewModel.get(position)
    let reduceFactor = 0.9
    return GeometryReader { proxy in
    		GridButtonView()
            .frame(width: proxy.size.width, height: proxy.size.height)
    }
}
```

## Stanford

![](images/9.png)

![](images/10.png)

### Links that help

- [Resizing images with GeometryReader](https://www.hackingwithswift.com/books/ios-swiftui/resizing-images-to-fit-the-screen-using-geometryreader)
- [Stanford](https://youtu.be/ayQl_F_uMS4?t=3989)