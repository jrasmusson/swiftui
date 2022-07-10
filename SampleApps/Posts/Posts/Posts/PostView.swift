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

    @State var showingDeleteWarning = false
    @State var isEditting = false
    @State var newTitle = ""
    @State var post: Post

    var body: some View {
        VStack(alignment: .leading) {
            if isEditting {
                EditPost(vm: vm, post: post, isEditting: $isEditting)
            } else {
                ReadPost(post: post)
                    .onTapGesture {
                        isEditting.toggle()
                    }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
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

    private func cancelButton() -> Button<Text> {
        return Button("OK", role: .cancel) {
            let filtered = vm.posts.filter { $0.title != post.title }
            vm.posts = filtered
            vm.deletePost()
            dismiss()
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(vm: PostViewModel(), post: post1)
    }
}
