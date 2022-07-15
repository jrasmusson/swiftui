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
    @State var isSaving = false

    @Binding var isEditting: Bool

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Title:")
                TextField(post.title, text: $newTitle)
            }
            HStack {
                Button {
                    save()
                } label: {
                    Text("Save")
                        .opacity(isSaving ? 0 : 1)
                        .overlay {
                            if isSaving {
                                ProgressView()
                            }
                        }
                }
                .disabled(isSaving)
                Button("Cancel", action: cancel)
            }
            Spacer()

        }
        .padding()
        .buttonStyle(.bordered)
        .navigationTitle("Edit")
        .navigationBarTitleDisplayMode(.inline)
    }

    func save() {
        if newTitle.isEmpty {
            vm.showError("Title can not be empty")
        } else {
            Task {
                isSaving = true
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                let newPost = Post(id: post.id, title: newTitle)
                await vm.updatePost(newPost)
                isSaving = false
                isEditting = false
                dismiss()
            }
        }
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
