# How Data Flow works

Swift has over six ways to pass around data.

- @State - local view state
- @Binding - local view state passed to subviews
- @StateObject - passed around
- @ObservedObject - passed around managed by SwiftUI
- @EnvironmentObject - ?
- @Environment - ?
- @Published - ?

Let's see how each works.

## @State

While we can define `vars` in a `structs`

```swift
struct PlayerView: View {
    var isPlaying: Bool = false // OK

```

We can't change their state.

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

To track state locally in SwiftUI views we use the `@State` property wrapper.

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

- @State tracks the stack of variables locally within our views
- Works on with value types (no classes).
- Is good to define as `private` so its clear that is state local only to this view.
- Use @State for tracking local view state within your app.


### Links that help
- [WWDC 2019 - Data Flow Through SwiftUI](https://developer.apple.com/videos/play/wwdc2019/226/)
