# How Data Flow works

Swift has over six ways to pass around data.

- @State - local to a view
- @Binding - how you bind
- @StateObject - passed around
- @ObservedObject - passed around managed by SwiftUI
- @EnvironmentObject - ?
- @Environment - ?
- @Published - ?

Let's see how each works.

## @State

While we can define `var` in a `struct`

```swift
struct PlayerView: View {
    var isPlaying: Bool = false // OK

```

We can't change its state.

```swift
struct PlayerView: View {
    var isPlaying: Bool = true // OK
    
    var body: some View {
        Button(action: {
            self.isPlaying.toggle() // 💥 `self` is immutable
        }) {
            Image(systemName: isPlaying ? "pause.circle" : "play.circle")
        }
    }
}
```

To get around this, the creators of SwiftUI created the property wrapper @State.

> @State - for tracking local view state of value types

```swift
struct PlayerView: View {
    @State private var isPlaying: Bool = false // 🚀
    
    var body: some View {
        Button(action: {
            self.isPlaying.toggle()
        }) {
            Image(systemName: isPlaying ? "pause.circle" : "play.circle")
        }
    }
}
```

- Works on with value types (no classes).
- Tracks state local to the view.
 - Good to define with `private`.
- Use for tracking local view state within that view of the app.


### Links that help
- [WWDC 2019 - Data Flow Through SwiftUI](https://developer.apple.com/videos/play/wwdc2019/226/)
