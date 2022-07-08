import SwiftUI

struct AddPost: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm: PostViewModel
    @State var title = ""
    @State var bodyStr = ""

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Title", text: $title)
                TextField("Body", text: $bodyStr)
            }
            .toolbar {
                Button(action: {
                    let post = Post(title: title, body: bodyStr)
                    self.vm.posts.append(post)
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                }
            }
            .padding()
        }
    }
}

struct AddPost_Previews: PreviewProvider {
    static var previews: some View {
        AddPost(vm: PostViewModel())
    }
}
