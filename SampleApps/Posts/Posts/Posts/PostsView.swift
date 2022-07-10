import SwiftUI

struct PostsView: View {
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
                PostView(vm: vm, post: post)
            }
            .toolbar { addButton() }
            .sheet(isPresented: $showingAddPost) {
                AddPost(vm: vm, nextId: String(vm.posts.count + 1))
            }
            .alert(vm.errorMessage, isPresented: $vm.showingError) {
                Button("OK", role: .cancel) { }
            }
            .task { await vm.fetchPosts() }
        }
    }

    private func addButton() -> Button<Image> {
        return Button(action: {
            self.showingAddPost.toggle()
        }) {
            Image(systemName: "plus")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView(vm: PostViewModel())
            .preferredColorScheme(.dark)
    }
}
