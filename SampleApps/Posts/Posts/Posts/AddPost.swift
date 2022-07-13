import SwiftUI

struct AddPost: View {
    @Environment(\.dismiss) private var dismiss
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
                ToolbarItem(placement: .navigationBarTrailing) {
                    saveButton()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    cancelButton()
                }
            }
            .alert(vm.errorMessage, isPresented: $vm.showingError) {
                Button("OK", role: .cancel) { }
            }
            .padding()
            .navigationTitle("Create new post")
            .navigationBarTitleDisplayMode(.inline)
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
            dismiss()
        }) {
            Text("Save")
        }
    }

    private func cancelButton() -> Button<Text> {
        return Button("Cancel") {
            dismiss()
        }
    }
}

struct AddPost_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddPost(vm: PostViewModel(), nextId: "")
                .preferredColorScheme(.dark)
        }
    }
}
