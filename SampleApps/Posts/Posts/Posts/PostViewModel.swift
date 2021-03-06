//
//  PostsViewModel.swift
//  Posts
//
//  Created by jrasmusson on 2022-07-07.
//

import Foundation

let runtime: Runtime = .network

enum Runtime {
    case inmemory
    case network
}

struct Post: Hashable, Identifiable, Codable {
    var id: Int
    let title: String
}

@MainActor
class PostViewModel: ObservableObject {
    @Published var posts = [post1]
    @Published var showingError = false

//    let urlString = "https://fierce-retreat-36855.herokuapp.com/posts" // sinatra
    let urlString = "http://127.0.0.1:3000/posts" // rails
    var errorMessage = ""

    func saveModel(_ newPost: Post) {
        posts.append(newPost)
    }

    func updateModel(_ newPost: Post) {
        let possibleUpdateIndex = posts.firstIndex { $0.id == newPost.id }
        guard let updateIndex = possibleUpdateIndex else { return }
        posts[updateIndex] = newPost
    }

    func deleteModel(_ id: Int) {
        let possibleDeleteIndex = posts.firstIndex { $0.id == id }
        guard let deleteIndex = possibleDeleteIndex else { return }
        posts.remove(at: deleteIndex)
    }

    func showError(_ message: String) {
        self.showingError = true
        self.errorMessage = message
    }
}

// MARK: - Inmemory
let post1 = Post(id: 1, title: "title1")

// MARK: - Networking
enum NetworkError: Error {
    case networkFailed, invalidServerResponse, decodeFailed, encodeFailed
}

extension PostViewModel {

    func fetchPosts() async {
        if runtime == .inmemory { return }

        do {
            posts = try await fetchNetwork()
        } catch NetworkError.invalidServerResponse {
            showError("Invalid HTTP response.")
        } catch NetworkError.decodeFailed {
            showError("Unable to convert posts to text.")
        } catch {
            showError("Unknown error.")
        }
    }

    func fetchNetwork() async throws -> [Post] {
        let url = URL(string: "http://127.0.0.1:3000/posts.json")!
        let (data, response) = try await URLSession.shared.data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.invalidServerResponse
        }

        guard let posts = try? JSONDecoder().decode([Post].self, from: data) else {
            throw NetworkError.decodeFailed
        }

        return posts
    }

    func savePost(_ newPost: Post) async {
        switch runtime {
        case .inmemory:
            saveModel(newPost)
        case .network:
            do {
                try await saveNetwork(newPost)
            } catch NetworkError.invalidServerResponse {
                showError("Invalid HTTP response.")
            } catch NetworkError.encodeFailed {
                showError("Unable to encode post.")
            } catch {
                showError("Unknown error.")
            }
        }
    }

    func saveNetwork(_ post: Post) async throws {
        guard let uploadData = try? JSONEncoder().encode(post) else {
            throw NetworkError.encodeFailed
        }

        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (_, response) = try await URLSession.shared.upload(for: request, from: uploadData)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.invalidServerResponse
        }
    }

    func updatePost(_ post: Post) async {
        switch runtime {
        case .inmemory:
            updateModel(post)
        case .network:
            do {
                try await updateNetwork(post)
            } catch NetworkError.encodeFailed {
                showError("Unable to encode post.")
            } catch {
                // OK - Rails too many HTTP redirects
            }
        }
    }

    func updateNetwork(_ post: Post) async throws {
        guard let uploadData = try? JSONEncoder().encode(post) else {
            throw NetworkError.encodeFailed
        }

        let url = URL(string: "\(urlString)/\(post.id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (_, response) = try await URLSession.shared.upload(for: request, from: uploadData)

        guard (response as? HTTPURLResponse)?.statusCode == 404 else {
            throw NetworkError.invalidServerResponse
        }
    }

    func deletePost(_ id: Int) async {
        switch runtime {
        case .inmemory:
            deleteModel(id)
        case .network:
            do {
                try await deleteNetwork(id)
            } catch NetworkError.invalidServerResponse {
                showError("Invalid HTTP response.")
            } catch {
                showError("Unknown error.")
            }
        }
    }

    func deleteNetwork(_ id: Int) async throws {
        let url = URL(string: "\(urlString)/\(id)")!

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (_, response) = try await URLSession.shared.data(for: request)

        guard (response as? HTTPURLResponse)?.statusCode == 404 else {
            throw NetworkError.invalidServerResponse
        }
    }

    private func printJSON(_ data: Data?, _ response: URLResponse?) {
        guard let response = response as? HTTPURLResponse else { return }
        if let mimeType = response.mimeType,
            mimeType == "application/json",
            let data = data,
            let dataString = String(data: data, encoding: .utf8) {
            print ("got data: \(dataString)")
        }
    }
}
