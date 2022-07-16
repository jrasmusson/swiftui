# Examples

## Rotate Label

![](images/demo1.gif)

```swift
struct ContentView: View {
    @State var showDetail = false
    var body: some View {
        VStack {
            Button {
                showDetail.toggle()
            } label: {
                Label("Graph", systemImage: "chevron.right.circle")
                    .labelStyle(.iconOnly)
                    .imageScale(.large)
                    .rotationEffect(.degrees(showDetail ? 90 : 0))
                    .padding()
                    .animation(.easeInOut, value: showDetail)
            }
        }
    }
}
```
