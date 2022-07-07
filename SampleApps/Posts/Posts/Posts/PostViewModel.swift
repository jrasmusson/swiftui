//
//  PostsViewModel.swift
//  Posts
//
//  Created by jrasmusson on 2022-07-07.
//

import Foundation

enum PostError: Error {
    case networkFailed, decodeFailed
}

struct Post: Hashable, Identifiable {
    let id = UUID()
    let title: String
    let body: String
}

let post1 = Post(title: "title1", body: "body1")

class PostViewModel: ObservableObject {
    @Published var posts = [post1]
}


