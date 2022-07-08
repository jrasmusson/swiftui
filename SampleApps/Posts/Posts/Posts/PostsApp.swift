//
//  PostsApp.swift
//  Posts
//
//  Created by jrasmusson on 2022-07-07.
//

import SwiftUI

@main
struct PostsApp: App {
    @StateObject private var vm = PostViewModel()

    var body: some Scene {
        WindowGroup {
            PostsView(vm: vm)
        }
    }
}
