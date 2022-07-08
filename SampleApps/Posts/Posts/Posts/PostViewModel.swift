//
//  PostsViewModel.swift
//  Posts
//
//  Created by jrasmusson on 2022-07-07.
//

import Foundation

enum NetworkError: Error {
    case networkFailed, invalidResponse, decodeFailed
}

struct Post: Hashable, Identifiable, Codable {
    var id: String { title + body }
    let title: String
    let body: String
}

let post1 = Post(title: "title1", body: "body1")

@MainActor
class PostViewModel: ObservableObject {
    @Published var posts = [post1]
    @Published var showingError = false
    var errorMessage = ""

    func fetchPosts() async {
        let fetchTask = Task { () -> [Post] in
            let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/posts")!
            let data: Data
            let urlResponse: URLResponse

            do {
                (data, urlResponse) = try await URLSession.shared.data(from: url)
                guard let response = urlResponse as? HTTPURLResponse else { return [Post]() }

                if response.statusCode == 200 {
                    if let companies = try JSONDecoder().decode([Post].self, from: data) {
                        return companies
                    } else {
                        throw NetworkError.decodeFailed
                    }
                }
                else {
                    throw NetworkError.invalidResponse
                }
            } catch {
                throw NetworkError.networkFailed
            }
        }

        let result = await fetchTask.result

        do {
            self.posts = try result.get()
            self.showingError = false
        } catch NetworkError.networkFailed {
            showError("Unable to fetch the quotes.")
        } catch NetworkError.decodeFailed {
            showError("Unable to convert quotes to text.")
        } catch NetworkError.invalidResponse {
            showError("Invalid HTTP response.")
        } catch {
            showError("Unknown error.")
        }
    }

    private func showError(_ message: String) {
        self.showingError = true
        self.errorMessage = message
    }
}
