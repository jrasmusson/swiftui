# Picker

### ForEach

This example uses a `ForEach` to view within a `Picker`. Nice thing about `ForEach` is it isn't hit that 10-view limit that we would of hit had we typed this by hand.


```swift
struct ContentView: View {
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = 0

    var body: some View {
        VStack {
            Picker("Select your student", selection: $selectedStudent) {
                ForEach(0 ..< students.count) {
                    Text(self.students[$0])
                }
            }
            Text("You chose: Student # \(students[selectedStudent])")
        }
    }
}
```

![](images/demo1.gif)


Form with 100 rows.

```swift
Form {
    ForEach(0 ..< 100) { number in
        Text("Row \(number)")
    }
}
```

Or shorthand in a closure like this.

```swift
Form {
    ForEach(0 ..< 100) {
        Text("Row \($0)")
    }
}
```

### Picker inside a form

If you create a picker outside a form you get the spinning wheel. Inside a form however, you get the master details view.

```swift
Form {
    Section {
        TextField("Amount", text: $checkAmount)
            .keyboardType(.decimalPad)
        Picker("Number of people", selection: $numberOfPeople) {
                ForEach(2 ..< 100) {
                    Text("\($0) people")
                }
            }
    }

    Section {
        Text("$\(checkAmount)")
    }
}
```

![](images/insideform.png)

The reason for this, is that in a form, we don't want to take up too much space. Hense the one-liner.

Reason why picker starts with 4 is because initial value was 2, and we started our loop at 2. So the second selection is actually bound to 4.

#### Adding a NavigationBar

To make our picker selectable, we need to embed the form in a NavigationBar.

```swift
NavigationView {
    Form {
        Section {
            TextField("Amount", text: $checkAmount)
                .keyboardType(.decimalPad)
            Picker("Number of people", selection: $numberOfPeople) {
                ForEach(2 ..< 100) {
                    Text("\($0) people")
                }
            }
        }
        
        Section {
            Text("$\(checkAmount)")
        }
    }.navigationBarTitle("WeSplit")
}
```

![](images/insideform.gif)

This will give us the detail view along with it's selected value. This is a good example of *declarative programming*. We say what we want to happen and the framework takes care of it for us. We don't worry about the how, which would be *imperative programming*.

[Creating pickers in a form](https://www.hackingwithswift.com/books/ios-swiftui/creating-pickers-in-a-form)

## Binding to high-level object

Because the picker select is bound to an index, you need to bind that selection to your top level object.

![](images/1.png)

```swift
import SwiftUI

struct Player {
    let name: String
    var team1Index: Int
}

class Pool: ObservableObject {
    @Published var player1: Player = Player(name: "Jonathan", team1Index: 0)
    init() {}
}

struct ContentView: View {
    @EnvironmentObject var pool: Pool
    @State private var selectedTeamIndex = 0
    
    var teams = ["Edmonton Oilers", "Calgary Flames"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select team1", selection: $pool.player1.team1Index) {
                        ForEach(0..<teams.count) {
                            Text(teams[$0])
                        }
                    }
                    Text("You selected:         \(teams[selectedTeamIndex])")
                    Text("Bound to pool:        \(pool.player1.team1Index)")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let pool = Pool()
        ContentView()
            .environmentObject(pool)
    }
}
```

## Segmented control

Special kind of picker showing a handful of options in a horizontal list. Great for when you have only a small selection to choose from.

```swift
Section {
    Picker("Tip percentage", selection: $tipPercentage) {
        ForEach(0 ..< tipPercentages.count) {
            Text("\(self.tipPercentages[$0])%")
        }
    }.pickerStyle(SegmentedPickerStyle())
}
```

![](images/segmented.png)


### Links that help

- [Creating views in a loop](https://www.hackingwithswift.com/books/ios-swiftui/creating-views-in-a-loop)
