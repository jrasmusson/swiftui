import SwiftUI

struct ContentView: View {
    @StateObject var vm: PostViewModel
    @State var showingAddPost = false

    var body: some View {
        NavigationStack {
            List(vm.posts) { post in
                NavigationLink(value: post) {
                    Text(post.title)
                }
            }
            .navigationTitle("Posts")
            .navigationDestination(for: Post.self) { post in
                PostView(post: post)
            }
            .toolbar {
                Button(action: {
                    self.showingAddPost.toggle()
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddPost) {
                Text("Add Post")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: PostViewModel())
            .preferredColorScheme(.dark)
    }
}
