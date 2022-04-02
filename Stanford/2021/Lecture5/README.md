# Lecture 5: Properties Layout @ViewBuilder

![](images/1.png)

## @State

![](images/2.png)

![](images/3.png)

![](images/4.png)

## How to manipulate model struct indices

**MemoryGame**

```swift
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]

    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) }}
    }

extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}
```

## Property Observers

![](images/5.png)

## Layout

![](images/6.png)

![](images/7.png)

So `HStack` `VStack` basically let their subviews size themselves, and then they size themselves based on what their subviews decide.

If a subview is "very flexible", the stack will be "very flexible" too.

![](images/8.png)

![](images/9.png)

![](images/10.png)

`VStack` centers by default.

![](images/11.png)

Lazy versions don't build the bodies of what is not on screen. They only draw what's on screen. *They are never flexible*. They make them as small as possible. Use these within `ScrollView`.

`ScrollView` always accepts the space offered to it, but scrolls around its content inside.

`List Form OutlineGroup` are awesome. More later.

![](images/12.png)

`ZStack` sizes itself to children. If child fexible it will be flexible.

Alternative to `ZStack` is `.background` modifier. Difference is background only affect the thing it is backgrounding.

`overlay` is same thing but in other direction. It overlays the view.


![](images/13.png)

With `backgroud` and `overlay` modifiers what you are seeing are view modifiers that are kind of acting like container views.

Most modifiers just pass size onto the view they are modifying. But some are involved in the layout process. i.e. `padding`.

`.aspectRatio` does this too. It affects the layout process.


![](images/14.png)

![](images/15.png)

## GeometryReader

![](images/16.png)

This thing let's you figure out how much spacing is being offered to a view. Handy for when you need to make your view dynamic, and resizable based on the space being offered.

The way it works is you simply wrap the `Geometry` reader around the view you want to size, it's only input is a `ViewBuilder` so it can take anything.

And it passes back `GeometryProxy` which contains are `size`.

So now that view inside can draw normally, but it also know how much space it has.

> Note: Geometry sizes itself to fit the space offered to it. It is maximum flexible. That means the view you put inside a GeometryReader wants to be big and flexible. Always contains "fully flexible" views.


![](images/17.png)

![](images/18.png)

## How to make the card resize itself

Let's use `GeometryReader` to make the font better fit the size of our card.

![](images/19.png)


**EmojiMemoryGameView**

```swift
struct CardView: View {
    let card: EmojiMemoryGame.Card
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack { ... }
        })
    }
}
```

So we drop a `GeometryReader` in like this. And it is going to take the full size offered to it which is what the `ZStack` would do anyways.

But now we can ue `GeometryReader` proxy to pick a better title size than `.largeTitle`.

Here we can approximate and way the size of our `system` font to be the minimum of the width or height of the card.

```swift
struct CardView: View {
    let card: EmojiMemoryGame.Card
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 20)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: 3)
                    Text(card.content).font(Font.system(size: min(geometry.size.width, geometry.size.height)*0.8))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        }
    }
}
```

## ViewBuilder

Is a list of views.


![](images/20.png)

![](images/21.png)

![](images/22.png)

![](images/23.png)

### Links that help

- [Lecture 5](https://www.youtube.com/watch?v=ayQl_F_uMS4&ab_channel=Stanford)
- [Standford 2021](https://cs193p.sites.stanford.edu/)



