# Data Flow

![](images/dataflow.png)

## View

### @State

For storing state in a view.

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

This allows us to modify a structs internal state, and SwiftUI manages this for us. Two-way binding.

### @Binding

Connecting `@State` to a view's underlying data model.

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

- [Binding](https://www.hackingwithswift.com/books/ios-swiftui/creating-a-custom-component-with-binding)

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

#### Dismiss sheet

For example, this is how we dismiss sheets.

```swift
@Environment(\.presentationMode) var presentationMode
```

Then when we are ready to dismiss.

```swift
Text("Hello World")
    .onTapGesture {
        self.presentationMode.wrappedValue.dismiss()
    }
```

#### Size classes

How much space you have for a view.

Say you want to adjust your view depending on the `sizeClass`.

```swift
struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        if sizeClass == .compact {
            return VStack {
                Text("Active size class:")
                Text("COMPACT")
            }
            .font(.largeTitle)
        } else {
            return HStack {
                Text("Active size class:")
                Text("REGULAR")
            }
            .font(.largeTitle)
        }
    }
}
```

This almost works. Except you get an oninous error: 

 > “Function declares an opaque return type, but the return statements in its body do not have matching underlying types.”
 
That's because we can't return different view types from a body. We handle this with something called `type erasure`.

```swift
return AnyView(HStack {
    // ...
}
.font(.largeTitle))
```

Type erasure masks the underlying view type. It erases or hides it. We don't use it all the time because of performance. But it's there when we need it.



#### CoreData

```swift
@Environment(\.managedObjectContext) var moc
```




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
