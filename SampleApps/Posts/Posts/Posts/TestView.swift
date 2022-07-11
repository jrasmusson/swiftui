//
//  TestView.swift
//  Posts
//
//  Created by jrasmusson on 2022-07-11.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    @State var post: Post

    var body: some View {
        Button("Show Alert") {
            showingAlert = true
        }
        .alert("Delete this post?", isPresented: $showingAlert, presenting: post) { post in
            Button(role: .destructive) {
            } label: {
                Text("Delete")
            }
            Button("Cancel", role: .cancel) {}
        } message: { post in
            Text("Deleting this post will permanently remove \(post.title) from our server.")
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView(post: post1)
        }
    }
}
