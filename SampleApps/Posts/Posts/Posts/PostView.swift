//
//  PostView.swift
//  Posts
//
//  Created by jrasmusson on 2022-07-07.
//

import SwiftUI

struct PostView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm: PostViewModel
    @State var showingDeleteWarning = false
    @State var isEditting = false
    @State var newTitle = ""
    @State var post: Post

    var body: some View {
        VStack(alignment: .leading) {
            if isEditting {
                EditView(vm: vm, post: post, isEditting: $isEditting)
            } else {
                VStack(alignment: .leading) {
                    HStack {
                        Text(post.title)
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                editButton()
                deleteButton()
            }
        }
        .alert("Delete?", isPresented: $showingDeleteWarning) {
            cancelButton()
        }
    }
}

// MARK: - Controls
extension PostView {
    private func deleteButton() -> Button<Image> {
        Button(action: {
            showingDeleteWarning.toggle()
        }) {
            Image(systemName: "trash")
        }
    }

    private func editButton() -> Button<Image> {
        return Button(action: {
            isEditting.toggle()
        }) {
            Image(systemName: "pencil")
        }
    }

    private func cancelButton() -> Button<Text> {
        return Button("OK", role: .cancel) {
            let filtered = vm.posts.filter { $0.title != post.title }
            vm.posts = filtered
            vm.deletePost()
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(vm: PostViewModel(), post: post1)
    }
}

struct EditView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm: PostViewModel
    @State var newTitle = ""
    @State var post: Post

    @Binding var isEditting: Bool
    var body: some View {
        VStack(alignment: .leading) {
            TextField(post.title, text: $newTitle)
            Button("Save", action: update)
                .buttonStyle(.bordered)
            Spacer()
        }
    }

    func update() {
        let newPost = Post(id: post.id, title: newTitle)
        post = newPost
        vm.updateModel(newPost)
        vm.updatePost(newPost)
        isEditting = false
        presentationMode.wrappedValue.dismiss()
    }
}
