//
//  PostView.swift
//  Posts
//
//  Created by jrasmusson on 2022-07-07.
//

import SwiftUI

struct PostView: View {
    let post: Post
    var body: some View {
        Text(post.title)
        Text(post.body)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post: post1)
    }
}
