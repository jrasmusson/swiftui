# Data Flow

## @State > @Binding

`@State` is for when the view acts as the source of truth.

![](images/state.png)

```swift
struct PlayerView: View {
    @State private var isPlaying: Bool = false
```

And it passes it to its subviews via a `$isPlaying` `@Binding`.

```swift
var body: some View {
        VStack {       
            PlayButton(isPlaying: $isPlaying)
            
struct PlayButton: View {
    @Binding var isPlaying: Bool

```

For example.

```swift
import SwiftUI

struct Episode {
    let title: String
    let showTitle: String
}

struct PlayerView: View {
    let episode: Episode
    @State private var isPlaying: Bool = false
    
    var body: some View {
        VStack {
            Text(episode.title)
            Text(episode.showTitle).font(.caption).foregroundColor(.gray)
            
            PlayButton(isPlaying: $isPlaying)
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        let episode = Episode(title: "The Grid", showTitle: "Rinzler's Return")
        PlayerView(episode: episode)
    }
}

struct PlayButton: View {
    @Binding var isPlaying: Bool
    
    var body: some View {
        Button(action: {
            withAnimation { self.isPlaying.toggle() }
        }, label: {
            Image(systemName: isPlaying ? "pause.circle" : "play.circle" )
        })
    }
}
```



### Links that help
- [WWDC 2019 - Data Flow Through SwiftUI](https://developer.apple.com/videos/play/wwdc2019/226/)
