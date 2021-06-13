# Data Flow

## State

Tracks and updates transient value state objects within a view.

```swift
struct PlayerView: View {
    @State private var isPlaying: Bool = false
    
    var body: some View {
        VStack {
            PlayButton(isPlaying: $isPlaying)
            
            Toggle(isOn: $isPlaying) {
                Text("Hello World")
            }
        }
    }
}

struct PlayButton: View {
    @Binding var isPlaying: Bool
    
    var body: some View {
        Button(action: {
            self.isPlaying.toggle()
        }) {
            Image(systemName: isPlaying ? "pause.circle" : "play.circle")
        }
    }
}
```

## ObservableObject

Define an object to observe at the top of your view hierarchy, and then explicitly pass to each child all the way down.

```swift
import SwiftUI

// Define your observable
class Book: ObservableObject {
    @Published var title: String
    @Published var author: String

    init(title: String, author: String) {
        self.title = title
        self.author = author
    }
}

// Inject into parent view at the top
struct ContentView: View {
    @ObservedObject var book: Book // 1
    
    var body: some View {
        DetailView(book: book)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let book = Book(title: "The Hitchhiker's Guide to the Galaxy", author: "Douglas Adams")
        ContentView(book: book)
    }
}

// And then explicitly pass to each child
struct DetailView: View
{
    @ObservedObject var book: Book // 2
    
    var body: some View {
        VStack {
            DetailHeader(book: book)
        }
    }
}

// And subview (tighter coupling)
struct DetailHeader: View
{
    @ObservedObject var book: Book // 3

    var body: some View {
        VStack {
            Text(book.title)
            Text(book.author)
        }
    }
}
```

## StateObject

Same mechanics as ``ObservableObject`. Just replace `ObservableObject` with `StateObject`.

## EnvironmentObject

Define once at the top, and have it automatically appear in all subviews without explicitly having to pass.

```swift
import SwiftUI

// Define your observable
class Book: ObservableObject {
    @Published var title: String
    @Published var author: String

    init(title: String, author: String) {
        self.title = title
        self.author = author
    }
}

// Define once at the top
struct ContentView: View {
    var book = Book(title: "The Hitchhiker's Guide to the Galaxy", author: "Douglas Adams")
    
    var body: some View {
        DetailView()
            .environmentObject(book) // 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Automtically available
struct DetailView: View
{
    var body: some View {
        VStack {
            DetailHeader()
        }
    }
}

// All the way down in decendent subviews
struct DetailHeader: View
{
    @EnvironmentObject var book: Book

    var body: some View {
        VStack {
            Text(book.title)
            Text(book.author)
        }
    }
}
```

### Links that help

- [Learn App Making](https://learnappmaking.com/pass-data-between-views-swiftui-how-to/)