# Dismiss a View

```swift
struct ItemDetail: View {
        
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button("Update") {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
```



