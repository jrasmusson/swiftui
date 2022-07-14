//
//  PostView.swift
//  Posts
//
//  Created by jrasmusson on 2022-07-07.
//

import SwiftUI

struct PostView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm: PostViewModel

    @State var showDeleteWarning = false
    @State var isEditting = false
    @State var newTitle = ""
    @State var post: Post

    var body: some View {
        VStack(alignment: .leading) {
            if isEditting {
                EditPost(vm: vm, post: post, isEditting: $isEditting)
            } else {
                ReadPost(post: post)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                editToolbarButton()
                deleteToolbarButton()
            }
        }
        .alert("Delete this post?", isPresented: $showDeleteWarning, presenting: post) { post in
            Button(role: .destructive) {
                deletePost()
                dismiss()
            } label: {
                Text("Delete")
            }
            Button("Cancel", role: .cancel) {}
        } message: { post in
            Text("Deleting this post will permanently remove \(post.title) from our server.")
        }
    }

    private func deletePost() {
        // network
//        let filtered = vm.posts.filter { $0.title != post.title }
//        vm.posts = filtered
//        vm.deletePost(post.id)
        // inmemory
        vm.deleteModel(post.id)
    }
}

// MARK: - Toolbar buttons
extension PostView {
    private func deleteToolbarButton() -> Button<Image> {
        Button(action: {
            showDeleteWarning.toggle()
        }) {
            Image(systemName: "trash")
        }
    }

    private func editToolbarButton() -> Button<Image> {
        return Button(action: {
            isEditting.toggle()
        }) {
            Image(systemName: "pencil")
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PostView(vm: PostViewModel(), post: post1)
        }
        .preferredColorScheme(.dark)
    }
}
