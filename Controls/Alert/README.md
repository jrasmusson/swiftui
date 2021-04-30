# Alert

*When* should an alert be shown and *how*? Views are a function of our program state, and alerts aren’t an exception to that. So, rather than saying “show the alert”, we instead create our alert and set the conditions under which it should be shown.

We don’t assign the alert to a variable then write something like `myAlert.show()`, because that would be back the old “series of events” way of thinking.

Instead, we create some state that tracks whether our alert is showing, like this.

```swift
struct ContentView: View {
    @State private var showingAlert = false

    var body: some View {
        Button("Show Alert") {
            self.showingAlert = true
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Hello SwiftUI!"), message: Text("This is some detail message"), dismissButton: .default(Text("OK")))
        }
    }
}
```

![](images/1.png)

### Links that help

- [Alert](https://www.hackingwithswift.com/books/ios-swiftui/showing-alert-messages)
