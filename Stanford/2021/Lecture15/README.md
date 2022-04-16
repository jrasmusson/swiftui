# Lecture 15: UIKit Integration

![](images/1.png)

## UIKit Integration

![](images/2.png)

![](images/3.png)

![](images/4.png)

### Demo

Say we want to integrate a `UIKit` view controller (i.e. `UIImagePickerController` and integrate it on screen in our SwiftUI app.

Instead of making a `View`:

```swift
struct Camera: View { ... }
```

We instead implement `UIViewControllerRepresentable`:

```swift
struct Camera: UIViewControllerRepresentable { ... }
```

First thing it is going to ask us is what type of view controller do you want to represent?

![](images/5.png)

For us it is `UIImagePickerController`:

![](images/6.png)

To become respresentable we need to implement `make` and `update` view controller:

![](images/7.png)

Updating is happening all the time when SwiftUI is invalidating and redrawing itself.

Now in the case of `update`, we are simply popping it up, taking a picture, and dismissing. So there is nothing to do for `update` for us when our `var` body is rebuilding.

In `make` we make and setup our view controller.

![](images/8.png)

## Handling protocol-delegate

In SwiftUI we don't use protocol-delegate. We instead use closures:

```swift
var handlePickedImage: (UIImage?) -> Void
```

But we need a way of handling protocol-delegate communication in SwiftUI:

```swift
struct Camera: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = // ?
        return picker
    }
```

We handle that by creating a delegate for our image picker controller that can receive the messages it sends when image picker takes pictures.

We do that as follows. First we create a class, and then we call it a `coordinator`. It is the thing that is going to implement the image picker protocol delegate protocol. 

Couple of minor complications:

- need to inherit from `NSObject`
- UIImagePicker also implements `UINavigationControlerDelegate` so we need to also implement it here (but we wouldn't otherwise).

![](images/9.png)

Now as soon as you add this conventionally named `Coodinator` Xcode is going to prompt you to implement another function called `makeCoordinator`:

![](images/10.png)

This is where we make our coordinator. 

The coordinator is really the bridge between the `UIKit` and `SwiftUI` world. Because our SwiftUI world is going to be handling camera interactions with a `handlePicker` closure, we need to pass it into the coordinator as a `var` so it can execute that functionality when ever a picture is taken.

So we'll add a `var handlePickedImage` into our `class` and set it via an `init`.

![](images/11.png)

### Setting the delegate

The delegate is going to be passed back to us via the `context.coordinator`.

![](images/12.png)

This `contextCoordinator` is made in `makeCoordinator()` which in turn makes our `class Coordinator` object which then gets set via:

```swift
picker.delegate = context.coordiantor
```

That is how it all gets hooked up.

### Implementing the delgate

So with that all hooked up now we can implement our camera methods in our coordinator:

![](images/13.png)

And that's it! That is how we hook up protocol-delegate to SwiftUI.

```swift
struct Camera: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(handlePickedImage: handlePickedImage)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // nothing to do
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var handlePickedImage: (UIImage?) -> Void

        init(handlePickedImage: @escaping (UIImage?) -> Void) {
            self.handlePickedImage = handlePickedImage
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            handlePickedImage(nil)
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            handlePickedImage((info[.editedImage] ?? info[.originalImage]) as? UIImage)
        }
    }

    typealias UIViewControllerType = UIImagePickerController

    var handlePickedImage: (UIImage?) -> Void

    static var isAvailable: Bool {
        UIImagePickerController.isSourceTypeAvailable(.camera)
    }
}
```

## Presenting the view

You can now use this integrated `UIKit` view controller like this:

```swift
struct ContentView: View {
    @State private var showingSheet = false
    @State private var selectedImage: Image?

    var body: some View {
        Button("Camera", action: camera)
            .sheet(isPresented: $showingSheet) {
                Camera(handlePickedImage: { image in handlePickedImage(image) } )
            }
    }

    func camera() {
        showingSheet.toggle()
    }

    private func handlePickedImage(_ image: UIImage?) {

    }
}
```

You present the new view controller in a `Sheet` via a change of state `showingSheet`.

When you run this you will get an error.

![](images/14.png)

`'NSInvalidArgumentException', reason: 'Source type 1 not available'`

Because the camera is not available on the simulator.

We could hide this button on the simulator with this:

```swift
if Camera.isAvailable {
   // show button
}
```

But to really see it in action we need a real phone. Plugging our phone and selecting some signing capabilities:

![](images/15.png)

We can now run our app and get another error:

`The app's Info.plist must contain an NSCameraUsageDescription key with a string value explaining to the user how the app uses this data.`

Which we can fix by opening our `info.plist` and entering the following:

```swift
Privacy - Camera Usage Description / This app needs your camera.
```

![](images/16.png)

> Note: info.plist doens't create created with Xcode 13 apps anymore. To get it to show up go into project settings and just add an entry on the `info` tab. That will trigger an info.plist to create.

[Xcode info.plist missing](https://useyourloaf.com/blog/xcode-13-missing-info.plist/)

If you try running now you will be asked for permission and then the camera will pop-up.

![](images/17.png)

```swift
import SwiftUI

struct ContentView: View {
    @State private var showingSheet = false
    @State private var selectedImage: Image?

    var body: some View {
        Button("Camera", action: camera)
            .sheet(isPresented: $showingSheet) {
                Camera(handlePickedImage: { image in handlePickedImage(image) } )
            }
    }

    func camera() {
        showingSheet.toggle()
    }

    private func handlePickedImage(_ image: UIImage?) {

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Camera: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    var handlePickedImage: (UIImage?) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(handlePickedImage: handlePickedImage)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // nothing to do
    }

    static var isAvailable: Bool {
        UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var handlePickedImage: (UIImage?) -> Void

        init(handlePickedImage: @escaping (UIImage?) -> Void) {
            self.handlePickedImage = handlePickedImage
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            handlePickedImage(nil)
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            handlePickedImage((info[.editedImage] ?? info[.originalImage]) as? UIImage)
        }
    }
}
```

### Links that help

- [Lecture 15](https://www.youtube.com/watch?v=ba7sJ74vDtA)
- [Stanford 2021](https://cs193p.sites.stanford.edu/)



