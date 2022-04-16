//
//  ContentView.swift
//  ImagePicker
//
//  Created by jrasmusson on 2022-04-16.
//

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
