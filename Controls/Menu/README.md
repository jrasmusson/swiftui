# Menu

Hold and press menu. If you long press you get the menu. If you quick tap you get the `justDoIt` action.

```swift
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Menu("Options") {
            Button("Order Now", action: placeOrder)
            Button("Adjust Order", action: adjustOrder)
            Button("Cancel", action: cancelOrder)
        } primaryAction: {
            justDoIt() // quick tap
        }
    }
    
    func justDoIt() {}
    func placeOrder() {}
    func adjustOrder() {}
    func cancelOrder() {}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```

![](images/1.png)
