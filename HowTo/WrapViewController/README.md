# Wrapping a UIViewController in a SwiftUI view

SwiftUI kind of blends `UIView` and `UIViewController` into a single `View `protocol, which makes our code much simpler.

The way to wrap an existing `UIViewController` into a SwiftUI view is as follows:

```swift
struct ImagePicker: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    typealias UIViewControllerType = UIImagePickerController
}

struct ImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        ImagePicker()
    }
}
```

This is a valid SwiftUI view. Now we can use it.

```swift
struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()

            Button("Select Image") {
               self.showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker()
        }
    }
}
```

![](images/1.png)

## Using coordinators to manage SwiftUI view controllers

This works but we won't get any callbacks from our SwiftUI. To register ourselves as `delegates` we need to use SwiftUI `coordinators`.

```swift
struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
}
```

### Links that help

- [Wrapping a UIViewController in a SwiftUI view](https://www.hackingwithswift.com/books/ios-swiftui/wrapping-a-uiviewcontroller-in-a-swiftui-view)
- [Using coorindators to manage Swift UI view controllers](https://www.hackingwithswift.com/books/ios-swiftui/using-coordinators-to-manage-swiftui-view-controllers)





