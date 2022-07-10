//
//  ReadPost.swift
//  Posts
//
//  Created by jrasmusson on 2022-07-10.
//

import SwiftUI

struct ReadPost: View {
    let post: Post

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(post.title)
                Spacer()
            }
            Spacer()
        }
    }
}

struct ReadPost_Previews: PreviewProvider {
    static var previews: some View {
        ReadPost(post: post1)
    }
}
