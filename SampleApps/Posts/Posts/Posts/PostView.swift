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
    @State var newBody = ""

    let post: Post

    var body: some View {
        VStack(alignment: .leading) {
            if isEditting {
                TextField(post.title, text: $newTitle)
                TextField(post.body, text: $newBody)
                Button("Save", action: save)
                    .buttonStyle(.bordered)
            } else {
                Text(post.title)
                Text(post.body)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    self.showingDeleteWarning.toggle()
                }) {
                    Image(systemName: "trash")
                }
                Button(action: {
                    isEditting.toggle()
                }) {
                    Image(systemName: "pencil")
                }
            }
        }
        .alert("Delete?", isPresented: $showingDeleteWarning) {
            Button("OK", role: .cancel) {
                let filtered = vm.posts.filter { $0.title != post.title }
                vm.posts = filtered
                vm.deleteSecondPost()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }

    func save() {
        // TODO: update model
        // Need to update Post struct in array - see Standford example
        // Add a mutating func in viewModel to update
        vm.updatePost(post: Post(id: post.id, title: newTitle, body: newBody))
        isEditting = false
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(vm: PostViewModel(), post: post1)
    }
}
