# Image

## Frame

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

![](images/3.png)


## Resizeable

```swift
Image("Tron")
    .resizable()
    .scaledToFit()
    .frame(width: 300, height: 300)
```

![](images/1.png)

## SF Symbols

```swift
Image(systemName: "chevron.left").imageScale(.small)
Image(systemName: "chevron.left").imageScale(.medium)
Image(systemName: "chevron.left").imageScale(.large)
```

## AsyncImage

```swift
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        AsyncImage(url: URL(string: "https://www.hackingwithswift.com/img/paul.png"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```

Has a grey default image placeholder until image loads. 

To specify a resizable background image and make everything line up do this.

```swift
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://www.hackingwithswift.com/img/paul.png")) { image in
                image.resizable()
            } placeholder: {
                Color.red
            }
            .frame(width: 128, height: 128)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            Text("Hello, world!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```

![](images/4.png)



## Tint

```swift
Image("Tron")
    .colorMultiply(.red)
```

![](images/2.png)




### Links that help

- [Formatting our mission view](https://www.hackingwithswift.com/books/ios-swiftui/formatting-our-mission-view)
- [A guide to the SwiftUI layout system - Part 1](https://www.swiftbysundell.com/articles/swiftui-layout-system-guide-part-1/)
