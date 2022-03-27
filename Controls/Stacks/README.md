# Stacks

Every `View` needs to return one type of view. Which is why this is OK.

```swift
var body: some View {
    Text("Hello World")
}
```

But this isn't as it returns x2 views.

```swift
var body: some View {
    Text("Hello World")
    Text("This is another text view")
}
```

The way we get around this is with stacks.

## VStack

```swift
var body: some View {
    VStack {
        Text("Hello World")
        Text("This is inside a stack")
    }
}
```

![](images/vstack.png)

### alignment
```swift
VStack(alignment: .leading) {
    Text("Hello World")
    Text("This is inside a stack")
}
```

![](images/leading.png)

### spacing

```swift
VStack(spacing: 20) {
    Text("Welcome to Family Pool").font(.title)
    Text("Create your pool by swiping through the next couple of screens.")
}
```

![](images/3.png)

## HStack

```swift
HStack(spacing: 20) {
    Text("Hello World")
    Text("This is inside a stack")
}
```

![](images/hstack.png)

## ZStack

`ZStack` arranges things by depth. It makes the views overlap.

```swift
ZStack {
    Text("Hello World")
    Text("This is inside a stack")
}
```

![](images/zstack.png)

From [Stanford](https://youtu.be/ayQl_F_uMS4?t=3589):

- If even one of its children is fully flexible size, then the `ZStack` will be too.

### .background modifier
An alternative is `.backgroundModifier`.

```swift
Text("hello").background(Rectangle().foregroundColor(.red))
```

![](images/4.png)

This is similar to making a `ZStack` of `Text` and `Rectangle`, however there is a big difference. In this case the resultant view is *sized to the text* (the `Rectangle` is not involved). In otherwords the `Text` solely determines the layout of this *mini-ZStack of two things*.

But it is a handy trick for when you want the background of the text to be a certain color, but not be flexible to fill the entire view.

### .overlay modifier

Same layout rules as `.background`, but stacked the other way around.

```swift
Circle().overlay(Text("Hello").foregroundColor(.red), alignment: .center)
```

This will be *sized to the Circle* (i.e. it will be fully-flexible size). The `Text` will be stacked on top of the `Circle` with the specified alignment inside the `Circle`.

![](images/5.png)

## Spacers

Vertical and horizontal stacks automatically fill their available space in the center. If you want to push the content to the side, you need to use a spacer.

These automatically take up all the remaining space. So if you add one at the end of a `VStack` it wil push all your views to the top of the screen.

![](images/spacer.png)

## LazyHGrid

A container view that arranges its child views in a grid that grows horizontally, creating items only as needed.

![](images/1.png)

```swift
import SwiftUI

struct ContentView: View {
    
    var rows: [GridItem] = Array(repeating: .init(.fixed(20)), count: 2)

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, alignment: .top) {
                ForEach((0...79), id: \.self) {
                    let codepoint = $0 + 0x1f600
                    let codepointString = String(format: "%02X", codepoint)
                    Text("\(codepointString)")
                        .font(.footnote)
                    let emoji = String(Character(UnicodeScalar(codepoint)!))
                    Text("\(emoji)")
                        .font(.largeTitle)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```

## LazyHStack

A view that arranges its children in a line that grows horizontally, creating items only as needed.

- These *lazy* versions don't build any of their Views that are not visible. 
- They also size themselves to fit their views. 
- So they don't take up all the space offerred to them even if they have flexible views inside. 
- You'd use these when you have a stack that is in a `ScrollView`.

![](images/2.png)

```swift
import SwiftUI

struct ContentView: View {

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(alignment: .top, spacing: 10) {
                ForEach((0...79), id: \.self) {
                    let codepoint = $0 + 0x1f600
                    let codepointString = String(format: "%02X", codepoint)
                    Text("\(codepointString)")
                        .font(.footnote)
                    let emoji = String(Character(UnicodeScalar(codepoint)!))
                    Text("\(emoji)")
                        .font(.largeTitle)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```

- [Apple Docs](https://developer.apple.com/documentation/swiftui/lazyhstack)


### Links that help

- [Using stacks to arrange views](https://www.hackingwithswift.com/books/ios-swiftui/using-stacks-to-arrange-views)
- [Lecture 5: Properties Layout](https://www.youtube.com/watch?v=ayQl_F_uMS4&ab_channel=Stanford)
