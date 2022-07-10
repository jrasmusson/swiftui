import SwiftUI

struct AddPost: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm: PostViewModel
    @State var title = ""

    var nextId: String

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Title", text: $title)
                Spacer()
            }
            .toolbar {
                saveButton()
            }
            .alert(vm.errorMessage, isPresented: $vm.showingError) {
                Button("OK", role: .cancel) { }
            }
            .padding()
        }
    }
}

// MARK: - Controls
extension AddPost {
    private func saveButton() -> Button<Text> {
        return Button(action: {
            if !title.isEmpty {
                let post = Post(id: nextId, title: title)
                vm.posts.append(post)
                vm.savePost(post)
            } else {
                vm.showError("Title and body can't be empty.")
            }
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Save")
        }
    }
}

struct AddPost_Previews: PreviewProvider {
    static var previews: some View {
        AddPost(vm: PostViewModel(), nextId: "")
    }
}
