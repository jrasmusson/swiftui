# How layout works

## Setting a view's frame

```swift
struct ContentView: View {
    var body: some View {
        Image(systemName: "calendar")
            .frame(width: 50, height: 50)
    }
}
```

Problem is image won't fill the frame. For that we need resizeable.

```swift
struct CalendarView: View {
    var body: some View {
        Image(systemName: "calendar")
            .resizable()
            .frame(width: 50, height: 50)
            .padding()
            .background(Color.red)
            .cornerRadius(10)
            .foregroundColor(.white)
    }
}
```

## Stacks and spacers

![](images/stacks.png)

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            CalendarView()
        }
    }
}
```

- `VStacks` don't stretch themselves to occupy their parent.
- Instead they simply resize themselves according to the total size of their children.
- To actually move your view we need a spacer.

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            CalendarView()
            Spacer()
        }
    }
}
```

![](images/1.png)

To push to the top leading corner.

```swift
struct ContentView: View {
    var body: some View {
        HStack {
            VStack {
                CalendarView()
                Spacer()
            }
            Spacer()
        }.padding()
    }
}
```

![](images/2.png)

By default HStack keeps everything centered.

```swift
struct ContentView: View {
    var body: some View {
        HStack {
            VStack {
                CalendarView()
                Spacer()
            }
            Text("Event title").font(.title)
            Spacer()
        }.padding()
    }
}
```

![](images/3.png)

To get our text to the top we can tell our HStack to align at top.

```swift
struct ContentView: View {
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                CalendarView()
                Spacer()
            }
            Text("Event title").font(.title)
            Spacer()
        }.padding()
    }
}
```

![](images/4.png)

## ZStacks and offset

Say we want to optionally add a checkmark to the top trailing corner of a view. We can generically do that by wrapping any view within a `ZStack` (which in itself won't affect the views layout), and optionally add a checkmark.

```swift
extension View {
    func addVerifiedBadge(_ isVerified: Bool) -> some View {
        ZStack(alignment: .topTrailing) {
            self

            if isVerified {
                Image(systemName: "checkmark.circle.fill")
                    .offset(x: 3, y: -3)
            }
        }
    }
}
```

Can then add our conditional badge to `CalendarView` like this:

```swift
struct CalendarView: View {
    var eventIsVerified = true

    var body: some View {
        Image(systemName: "calendar")
            .resizable()
            .frame(width: 50, height: 50)
            .padding()
            .background(Color.red)
            .cornerRadius(10)
            .foregroundColor(.white)
            .addVerifiedBadge(eventIsVerified)
    }
}
```

![](images/5.png)

### Summary

- SwiftUI’s core layout engine works by asking each child view to determine its own size based on the bounds of its parent, and then asks each parent to position its children within its own bounds.
- Using the `.frame()` and `.padding()` modifiers lets us adjust a view’s size and internal margin, as long as that view is configured to resize itself accordingly.
- Using `offset()` we can move a view without affecting its surroundings, which is very useful when implementing overlays and other kinds of overlapping views.


### Links that help
- [A guide to the SwiftUI layout system - Part 1](https://www.swiftbysundell.com/articles/swiftui-layout-system-guide-part-1/)