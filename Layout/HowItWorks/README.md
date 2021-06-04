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


### Links that help
- [A guide to the SwiftUI layout system - Part 1](https://www.swiftbysundell.com/articles/swiftui-layout-system-guide-part-1/)