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
                editButton()
                deleteButton()
            }
        }
        .alert("Delete?", isPresented: $showDeleteWarning) {
            OKButton()
            Button("Cancel") { }
        }

    }
}

// MARK: - Controls
extension PostView {
    private func deleteButton() -> Button<Image> {
        Button(action: {
            showDeleteWarning.toggle()
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

    private func OKButton() -> Button<Text> {
        return Button("OK", role: .cancel) {
            let filtered = vm.posts.filter { $0.title != post.title }
            vm.posts = filtered
            vm.deletePost(post.id)
            dismiss()
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PostView(vm: PostViewModel(), post: post1)
        }
    }
}
