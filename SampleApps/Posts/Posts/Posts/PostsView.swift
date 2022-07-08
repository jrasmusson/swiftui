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
            .toolbar {
                Button(action: {
                    self.showingAddPost.toggle()
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddPost) {
                AddPost(vm: vm)
            }
            .task {
                await vm.fetchPosts()
            }
            .alert(vm.errorMessage, isPresented: $vm.showingError) {
                Button("OK", role: .cancel) { }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView(vm: PostViewModel())
            .preferredColorScheme(.dark)
    }
}
