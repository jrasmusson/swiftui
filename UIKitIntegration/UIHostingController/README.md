# UIHostingController

## UIViewController

The way we host SwiftUI views in `UIKit` view controllers is via the `UIHostingController`:

```swift
let vc = UIHostingController(rootView: Text("Hello"))
```

## UIView

To add a SwiftUI view in Interface Builder we use a `Container View`.

![](images/1.png)

Programmatically we do it like this:

```swift
let childView = UIHostingController(rootView: SwiftUIView())
addChild(childView)
childView.view.frame = frame
view.addSubview(childView.view)
childView.didMove(toParent: self)
```

## Example

Here is a more complicated example of a `UITableView` where upon row selection, a SwiftUI view is presented called `GameView`.

We facilitate communication back via 



### Links that help

- [Wrapping a UIViewController in a SwiftUI view](https://www.hackingwithswift.com/books/ios-swiftui/wrapping-a-uiviewcontroller-in-a-swiftui-view)
- [Using coorindators to manage Swift UI view controllers](https://www.hackingwithswift.com/books/ios-swiftui/using-coordinators-to-manage-swiftui-view-controllers)
- [Apple Interfacing with UIKit](https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit)
- [Stanford Lecture 15](https://github.com/jrasmusson/swiftui/blob/main/Stanford/2021/Lecture15/README.md)





