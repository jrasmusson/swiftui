import SwiftUI

struct AddPost: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm: PostViewModel
    @State var title = ""

    // Errors
    @State var showingError = false
    @State var errorMessage = ""

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
            .alert(errorMessage, isPresented: $showingError) {
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
            if title.isEmpty {
                showError("Title can't be empty.")
            } else {
                let post = Post(id: nextId, title: title)
                vm.savePost(post)
                dismiss()
            }
        }) {
            Text("Save")
        }
    }

    private func cancelButton() -> Button<Text> {
        return Button("Cancel") {
            dismiss()
        }
    }

    func showError(_ message: String) {
        showingError = true
        errorMessage = message
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
