//
//  EditPost.swift
//  Posts
//
//  Created by jrasmusson on 2022-07-10.
//

import SwiftUI

struct EditPost: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm: PostViewModel
    @State var newTitle = ""
    @State var post: Post
    @State var draft = Post.default

    @Binding var isEditting: Bool

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Title:")
                TextField(post.title, text: $newTitle)
            }
            HStack {
                Button("Save", action: update)
                Button("Cancel", action: cancel)
            }
            Spacer()

        }
        .buttonStyle(.bordered)
        .navigationTitle("Edit")
        .navigationBarTitleDisplayMode(.inline)
    }

    func update() {
        let newPost = Post(id: post.id, title: newTitle)
        post = newPost
        vm.updateModel(newPost)
        vm.updatePost(newPost)
        isEditting = false
        dismiss()
    }

    func cancel() {
        isEditting = false
    }
}

struct EditPost_Previews: PreviewProvider {
    @State private var isEditting: Bool = false

    static var previews: some View {
        NavigationStack {
            EditPost(vm: PostViewModel(), post: post1, isEditting: .constant(false))
        }
        .preferredColorScheme(.dark)
    }
}
