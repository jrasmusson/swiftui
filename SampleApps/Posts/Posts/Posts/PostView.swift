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
    let post: Post

    var body: some View {
        VStack(alignment: .leading) {
            Text(post.title)
            Text(post.body)
        }
        .toolbar {
            Button(action: {
                self.showingDeleteWarning.toggle()
            }) {
                Image(systemName: "trash")
            }
        }
        .alert("Delete?", isPresented: $showingDeleteWarning) {
            Button("OK", role: .cancel) {
                let filtered = vm.posts.filter { $0.title != post.title }
                vm.posts = filtered
                // network call
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(vm: PostViewModel(), post: post1)
    }
}
