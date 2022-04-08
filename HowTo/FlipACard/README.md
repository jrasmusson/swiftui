# Flip a Card

## Initial shape

Let's start with something simple. Like changing the color of a card.

```swift
struct ContentView: View {
    @State var isFaceUp = false

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(isFaceUp ? Color.blue : .red)
                .frame(width:200, height:200)
                .animation(.linear(duration: 1.0), value: isFaceUp)

            Button("flip card") {
                isFaceUp.toggle()
            }
        }
    }
}
```

![](images/demo1.gif)

## Add an image

Next let's add an image.

```swift
struct ContentView: View {
    @State var isFaceUp = false

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(isFaceUp ? Color.clear : .orange)
                if isFaceUp {
                    Color.orange.opacity(0.5).cornerRadius(20.0)
                    Text("👻")
                        .font(.system(size: 100))
                        .scaledToFit()
                        .clipped()
                        .cornerRadius(15.0)
                        .padding(10)
                }
            }
            .animation(.linear(duration: 1.0), value: isFaceUp)
            .frame(width:200, height:200)

            Button("flip card") {
                isFaceUp.toggle()
            }
        }
    }
}
```
            
## Rotate in 3D

```swift
struct ContentView: View {
    @State var isFaceUp = false

    var body: some View {
        VStack {
            HStack(spacing:40) {
                VStack {
                    CardView(isFaceUp: isFaceUp, content: "👻", axis: (0,1,0))
                        .animation(.linear(duration: 1.0), value: isFaceUp)
                        .frame(width:100, height:100)
                }
            }

            Spacer().frame(height:40)

            Button("flip card") {
                isFaceUp.toggle()
            }

            Spacer()
        }
    }
}

struct CardView: View {
    var isFaceUp: Bool
    var content: String
    var axis:(CGFloat,CGFloat,CGFloat) = (1.0,0.0,0.0)

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.orange.opacity(isFaceUp ? 0.5 : 1.0))
            if isFaceUp {
                Text(content)
                    .font(.system(size: 50))
                    .scaledToFit()
                    .clipped()
                    .cornerRadius(15.0)
                    .padding(10)
            }
        }
        .rotation3DEffect(
            Angle.degrees(isFaceUp ? 0: 180),
            axis: axis
        )
    }
}
```

## Use a custom ViewModifier

```swift
import SwiftUI

struct ContentView: View {
    @State var isFaceUp = false

    var body: some View {
        VStack {
            HStack(spacing:40) {
                VStack {
                    CardView(isFaceUp: isFaceUp, content: "👻")
                        .animation(.linear(duration: 1.0), value: isFaceUp)
                        .frame(width:100, height:100)
                }
            }

            Spacer().frame(height:40)

            Button("flip card") {
                isFaceUp.toggle()
            }

            Spacer()
        }
    }
}

struct CardView: View {
    var isFaceUp: Bool
    var content: String

    var body: some View {
        Text(content)
            .font(.system(size: 50))
                .scaledToFit()
                .clipped()
                .cornerRadius(15.0)
                .padding(10)
                .cardFlip(isFaceUp: isFaceUp)
    }
}

struct CardFlip: ViewModifier {
    var isFaceUp: Bool

    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.orange.opacity(isFaceUp ? 0.5 : 1.0))
            content.opacity(isFaceUp ? 1.0 : 0.0)
        }
        .rotation3DEffect(
            Angle.degrees(isFaceUp ? 0: 180),
            axis: (0,1,0),
            perspective: 0.3
        )
    }
}


extension View {
    func cardFlip(isFaceUp: Bool) -> some View {
        modifier(CardFlip(isFaceUp: isFaceUp))
    }
}
```

## AnimatableModifier

```swift
struct ContentView: View {
    @State var isFaceUp = false

    var body: some View {
        VStack {
            HStack(spacing:40) {
                VStack {
                    CardView(isFaceUp: isFaceUp, content: "👻")
                        .animation(.linear(duration: 1.0), value: isFaceUp)
                        .frame(width:100, height:100)
                }
            }

            Spacer().frame(height:40)

            Button("flip card") {
                isFaceUp.toggle()
            }

            Spacer()
        }
    }
}

struct CardView: View {
    var isFaceUp: Bool
    var content: String

    var body: some View {
        Text(content)
            .font(.system(size: 50))
                .scaledToFit()
                .clipped()
                .cornerRadius(15.0)
                .padding(10)
                .cardFlip(isFaceUp: isFaceUp)
    }
}

struct CardFlip: AnimatableModifier {
    init(isFaceUp: Bool) {
        rotationAngle = isFaceUp ? 0 : 180
    }

    var animatableData: Double {
        get { rotationAngle }
        set { rotationAngle = newValue }
    }

    private var rotationAngle: Double

    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.orange.opacity(rotationAngle < 90 ? 0.5 : 1.0))
            content
                .opacity(rotationAngle < 90 ? 1.0 : 0.0)
        }
        .rotation3DEffect(
            Angle.degrees(rotationAngle),
            axis: (0, 1, 0),
            perspective: 0.3
        )
    }
}

extension View {
    func cardFlip(isFaceUp: Bool) -> some View {
        modifier(CardFlip(isFaceUp: isFaceUp))
    }
}
```

### Links that help

- [Article](https://swdevnotes.com/swift/2021/flip-card-in-swiftui)





