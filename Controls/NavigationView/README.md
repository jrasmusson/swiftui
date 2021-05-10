# Navigation Bar

```swift
NavigationView {
            List {
                Text("Hello World")
            }
            .navigationBarTitle(Text("Navigation Title")) // Default to large title style
        }
```

![](images/1.png)

Old style.

```swift
NavigationView {            
    List {
        Text("Hello World")
    }
    .navigationBarTitle(Text("Navigation Title"), displayMode: .inline)
}
```

![](images/2.png)

## UIBarButtonItem

```swift
NavigationView {
    List {
        Text("Hello World")
    }
    .navigationBarItems(trailing:
        Button(action: {
            // Add action
        }, label: {
            Text("Add")
        })
    )
    .navigationBarTitle(Text("Navigation Title"))
}
```

![](images/3.png)






## onAppear

```swift
.onAppear(perform: startGame)
```

### Links that help

- [Navigation Bar](https://www.hackingwithswift.com/books/ios-swiftui/adding-a-navigation-bar)
