# Data Flow

![](images/dataflow.png)

## View

### @State

If you want to modify a `View` state you need to use the `@State` property wrapper.

```swift
struct ContentView: View {
    @State var tapCount = 0

    var body: some View {
        Button("Tap Count: \(tapCount)") {
            self.tapCount += 1
        }
    }
}
```

This allows us to modify a structs internal state, and SwiftUI manages this for us.

#### Binding

To bind state to a control, you need to use the *two-way-binding* symbol `$`.

```swift
struct ContentView: View {
    @State private var name = ""

    var body: some View {
        Form {
            TextField("Enter your name", text: $name)
            Text("Your name is \(name)")
        }
    }
}
```

![](images/bindstate.gif)

## App Wide

### @ObservableObject / @Published / @ObservedObject

The Combine framework lets you define a `class` app wide, and publish `@ObservableObjects` to `@ObservedObjects` listeners.

Define a struct.

```swift
struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}
```

Make it observable - note `class`.

```swift
class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}
```

Use it.

```swift
struct ContentView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    @ObservedObject var expenses = Expenses()

    var body: some View {
        
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    Text(item.name)
                }.onDelete(perform: removeItems)
            }
            .navigationBarItems(trailing:
                Button(action: {
                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                    self.expenses.items.append(expense)
                }) {
                    Image(systemName: "plus")
                }
            )
        }
        
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}
```

![](images/observable1.gif)


### Environment

`@Environment` is like a shared global state across your app. You don't need to directly bind to it. But it is always there, and you can pull data from it whenever you need to.


## You can't directly modify a views state

Something you can't do in SwiftUI is modify a `Views` state.

```swift
struct ContentView: View {
    var tapCount = 0

    var body: some View {
        Button("Tap Count: \(tapCount)") {
            self.tapCount += 1
        }
    }
}
```

You can define a `var` in a `struct`. You just can't modify it from within the `struct`. 

```swift
struct SecondView: View {
    var name: String

    var body: some View {
        Text("Hello, \(name)!")
    }
}
```


This is because structs are immutable in Swift. They aren't meant to be modified.


### Links that help
- [WWDC 2019 - Data Flow Through SwiftUI](https://developer.apple.com/videos/play/wwdc2019/226/)
