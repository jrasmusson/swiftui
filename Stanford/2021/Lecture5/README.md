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

<!--![](images/6.png)

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

-->
![](images/12.png)

<!--![](images/13.png)-->

<!--![](images/14.png)-->

<!--![](images/15.png)-->

<!--![](images/16.png)-->

<!--![](images/17.png)-->

<!--![](images/18.png)-->

## GeometryReader

How to use `GeometryReader` to make the font better fit the size of our card.

### Links that help

- [Lecture 5](https://www.youtube.com/watch?v=ayQl_F_uMS4&ab_channel=Stanford)
- [Standford 2021](https://cs193p.sites.stanford.edu/)



