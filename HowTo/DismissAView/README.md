# Dismiss a View

```swift
private struct SheetContents: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button("Done") {
            dismiss()
        }
    }
}
```

### Links that help

- [DismissAction](https://developer.apple.com/documentation/swiftui/dismissaction)


