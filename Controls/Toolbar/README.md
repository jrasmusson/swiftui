# Toolbar

## Single

![](images/demo1.gif)

```swift
import SwiftUI

struct ContentView: View {
    @State var showingAddItinerary = false

    var body: some View {
        NavigationStack {
            List(1..<20) { i in
                NavigationLink("Detail \(i)") {
                    Text("Detail \(i)")
                }
            }
            .navigationTitle("NavigationStack")
            .toolbar {
                Button(action: {
                    self.showingAddItinerary.toggle()
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddItinerary) {
                Text("Add itinerary")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
```

## Multi

![](images/1.png)

```swift
import SwiftUI

struct ContentView: View {
    @State var showingAddItinerary = false

    var body: some View {
        NavigationStack {
            List(1..<20) { i in
                NavigationLink("Detail \(i)") {
                    Text("Detail \(i)")
                }
            }
            .navigationTitle("NavigationStack")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("Share")
                    }) {
                        Image(systemName: "square.and.arrow.up")
                    }

                    Button(action: {
                        print("Like")
                    }) {
                        Image(systemName: "heart")
                    }
                    Button(action: {
                        self.showingAddItinerary.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddItinerary) {
                Text("Add itinerary")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
```