import SwiftUI

struct PostsView: View {
    @StateObject var vm: PostViewModel
    @State var isLoading = false
    @State var showAddPost = false

    var body: some View {
        ZStack {
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
                .fullScreenCover(isPresented: $showAddPost) {
                    AddPost(vm: vm, nextId: vm.posts.count + 1)
                }
                .alert(vm.errorMessage, isPresented: $vm.showingError) {
                    Button("OK", role: .cancel) { }
                }
                .refreshable {
                    Task { await fetch() }
                }
                .task {
                    await fetch()
                }
            }

            if isLoading {
                LoadingView()
            }
        }
    }

    func fetch() async {
        isLoading = true
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        await vm.fetchPosts()
        isLoading = false
    }

    func addButton() -> Button<Image> {
        Button(action: { showAddPost.toggle() }) {
            Image(systemName: "plus")
        }
    }
}

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
                .opacity(0.8)
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(3)
        }
    }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView(vm: PostViewModel())
            .preferredColorScheme(.dark)
    }
}
