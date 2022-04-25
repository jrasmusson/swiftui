# TicTacToe

## Initial UI

![](images/1.png)

```swift
struct ContentView: View {
    var button: some View {
        Button(action: {}) {
            Image(systemName: "x.square.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
        }
    }

    var body: some View {
        VStack {
            HStack {
                button
                button
                button
            }
            HStack {
                button
                button
                button
            }
            HStack {
                button
                button
                button
            }
        }
    }
}
```
