# iExpense

## Why @State only works with structs

@State is a property wrapper that monitors changes in our structs. Each time a value inside our struct changes the *whole* struct changes. We get a new struct every time.

There are two important differences between structs and classes:

- structs have unique owners
- classes can have multiple owners

With classes, multiple things can point to the same value. Classes are referenced based. Many have access to it's reference or pointer.

But structs are value based. There can be only one owner.

What that means is that if we have two SwiftUI views and we send them both the same struct to work with, they actually each have a unique copy of that struct; if one changes it, the other won't see that change. On the other hand, if we create an instance of a classes and send that to both views, they *will* share changes.

The reason why `@State` only works with structs is because when we change `@State` in a class, we aren't changing the reference of state. It remains the same.

Yes we are changing the values of state. But everyone gets the same value. No change.

With struct, because they are never shared, we do get a change in state. That's why @State only works in SwiftUI for structs.

If we want to share state change via a classes, we need something else. We need an `@ObservedObject`.

## Sharing state with @ObservedObject

If you want to use a class with your SwiftUI data - which you *will* want to do if that data should be shared across more than one view - then SwiftUI gives us two property wrappers that are useful:

- @ObserveredObject, and
- @EnvironmentObject

Let's now look at @ObservedObject. To make a SwiftUI class observable, we need to declare what is publishable.

```swift
class User {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}
```

`@Published` is more or less half of `@State`. It tells Swift that whenever either of those two properties change, it should send an announcement out to any SwiftUI views that are watching that they should reload.

How do those views know which classes might send out these modifications? That's another property wrapper, `@ObservedObject`. Which is the other half of `@State`. it tells SwiftUI to watch a class for any change annoucements.

```swift
@ObservedObject var user = User()
```

So really to make something observable we go from this:

```swift
struct User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

struct ContentView: View {
    @State private var user = User()
```

To this:

```swift
class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct ContentView: View {
    @ObservedObject var user = User()
```

The end result here is that we can have our state stored in an exeternal object, and we can now use that object in multiple views and have them all point to the same values.

## Showing and hiding views

There are several ways of showing views in SwiftUI, and one of the most basic is a sheet: a new view presented on top of our existing one. On iOS this automatically gives us a card-like presentation where the current view slides away into the distance a little and the new view animates in on top.

Sheets work much like alerts, in that we don’t present them directly with code such as `mySheet.present()` or similar. Instead, we define the conditions under which a sheet should be shown, and when those conditions become true or false the sheet will either be presented or dismissed respectively.

Let’s start with a simple example, which will be showing one view from another using a sheet. First, we create the view we want to show inside a sheet, like this:

```swift
struct SecondView: View {
    var body: some View {
        Text("Second View")
    }
}

struct ContentView: View {
    @State private var showingSheet = false

    var body: some View {
        Button("Show Sheet") {
            self.showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView()
        }
    }
}
```

![](images/1.gif)

First we defined some state to track if the sheet is showing.

```swift
@State private var showingSheet = false
```

Then we toggle that state in the button.

```swift
self.showingSheet.toggle()
```

Then the magic to make the new sheet appear is here.

```swift
.sheet(isPresented: $showingSheet) {
    // contents of the sheet
}
```

This is a two-way binding to our state property. It fires when `$showingSheet` changes.

### Passing data

You can pass information to another view by defining a var in the view.

```swift
struct SecondView: View {
    var name: String

    var body: some View {
        Text("Hello, \(name)!")
    }
}
```

And then passing it to the view when constructed.

```swift
.sheet(isPresented: $showingSheet) {
    SecondView(name: "@twostraws")
}
```

### Dismissing the view

The user can dismiss the view by swiping downwards. But let's look at how to make the view disappear programmatically.

We could use a @State property wrapper. Another is to use an @Environment.

@Environment allows us to provide data to other views externally. We can read our views presentation mode from the environment.

To try it out add this property to the second view.

```swift
@Environment(\.presentationMode) var presentationMode
```

The presentation mode of a view contains only two pieces of data, but both are useful: a property storing whether the view is currently presented on screen, and a method to let us dismiss the view immediately.

```swift
struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var name: String

    var body: some View {
        Button("Dismiss") {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ContentView: View {
    @State private var showingSheet = false

    var body: some View {
        Button("Show Sheet") {
            self.showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "Tron")
        }
    }
}
```

![](images/2.gif)

## Working with Identifiable items in SwiftUI

When we create static views (VStack, TextField, Button) SwiftUI can see exactly which views we have and is able to control and animate them and so on.

When we use `List` and `ForEach` to make dynamic views, SwiftUI needs to know how it can identify each item uniquely. Otherwise it's not able to compare view hierarchies and keep track of what has changed.

That's why we need whatever it is we are adding to our `List` or `ForEach` to by uniquely identifiable. We can do this using the `Identifiable` protocol which simply makes our structs require a property `id`.

```swift
struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}
```

And then use it like this.

```swift
ForEach(expenses.items) { item in
    Text(item.name)
}
```

## Full source

**ContentView.swift**

```swift
//
//  ContentView.swift
//  iExpense
//
//  Created by jrasmusson on 2021-05-02.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }

        self.items = []
    }
}

struct ContentView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    @State private var showingAddExpense = false
    
    @ObservedObject var expenses = Expenses()
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }

                        Spacer()
                        Text("$\(item.amount)")
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingAddExpense = true
                }) {
                    Image(systemName: "plus")
                }
            )
        }.sheet(isPresented: $showingAddExpense) {
            AddView(expenses: self.expenses)
        }
        
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```

**AddView.swift**

```swift
//
//  AddView.swift
//  iExpense
//
//  Created by jrasmusson on 2021-05-04.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""

    @ObservedObject var expenses: Expenses
    
    // No type required here - Swift can figure out
    @Environment(\.presentationMode) var presentationMode
    
    static let types = ["Business", "Personal"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                }
                self.presentationMode.wrappedValue.dismiss()
            }
            )
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
```

![](images/demo.gif)

### Links that help

- [iExpense Intro](https://www.hackingwithswift.com/books/ios-swiftui/iexpense-introduction)
- [Why state only works with structs](https://www.hackingwithswift.com/books/ios-swiftui/why-state-only-works-with-structs)
- [Sharing SwiftUI state with @ObservedObject](https://www.hackingwithswift.com/books/ios-swiftui/sharing-swiftui-state-with-observedobject)
- [Showing and hiding views](https://www.hackingwithswift.com/books/ios-swiftui/showing-and-hiding-views)
- [Working with Identifiable items in SwiftUI](https://www.hackingwithswift.com/books/ios-swiftui/working-with-identifiable-items-in-swiftui)