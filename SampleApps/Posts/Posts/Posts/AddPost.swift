import SwiftUI

struct AddPost: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm: PostViewModel
    @State var title = ""
    @State var bodyStr = ""

    var nextId: String

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Title", text: $title)
                TextField("Body", text: $bodyStr)
            }
            .toolbar {
                Button(action: {
                    if !title.isEmpty && !bodyStr.isEmpty {
                        let post = Post(id: nextId, title: title, body: bodyStr)
                        self.vm.posts.append(post)
                        vm.savePost(post: post)
                    } else {
                        vm.showError("Title and body can't be empty.")
                    }
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                }
            }
            .alert(vm.errorMessage, isPresented: $vm.showingError) {
                Button("OK", role: .cancel) { }
            }
            .padding()
        }
    }
}

struct AddPost_Previews: PreviewProvider {
    static var previews: some View {
        AddPost(vm: PostViewModel(), nextId: "")
    }
}
