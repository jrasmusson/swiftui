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
                Text("Title:")
                Text(post.title)
                    .foregroundColor(.gray)
                Spacer()
            }
            Spacer()
        }
        .navigationTitle("Read")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ReadPost_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ReadPost(post: post1)
        }.preferredColorScheme(.dark)
    }
}
