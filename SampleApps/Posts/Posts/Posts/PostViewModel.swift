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
    var id: String
    let title: String
}

@MainActor
class PostViewModel: ObservableObject {
    @Published var posts = [post1]
    @Published var showingError = false

    let urlString = "https://fierce-retreat-36855.herokuapp.com/posts"
    var errorMessage = ""

    func saveModel(_ newPost: Post) {
        posts.append(newPost)
    }

    func updateModel(_ newPost: Post) {
        let possibleUpdateIndex = posts.firstIndex { $0.id == newPost.id }
        guard let updateIndex = possibleUpdateIndex else { return }
        posts[updateIndex] = newPost
    }

    func deleteModel(_ id: String) {
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
let post1 = Post(id: "1", title: "title1")

// MARK: - Networking
enum NetworkError: Error {
    case networkFailed, invalidServerResponse, decodeFailed
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
        let url = URL(string: urlString)!
        let (data, response) = try await URLSession.shared.data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200 /* OK */ else {
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
            } catch {
                showError("Unknown error.")
            }
        }
    }

    func saveNetwork(_ post: Post) async throws {
        guard let uploadData = try? JSONEncoder().encode(post) else { return }

        let url = URL(string: urlString)!
        let request = makeRequest(with: url, httpMethod: "POST")

        let (_, response) = try await URLSession.shared.upload(for: request, from: uploadData)

        guard (response as? HTTPURLResponse)?.statusCode == 200 /* or Created 201 */ else {
            throw NetworkError.invalidServerResponse
        }
    }

//    func saveNetwork(_ newPost: Post) async {
//        guard let uploadData = try? JSONEncoder().encode(newPost) else { return }
//
//        let url = URL(string: urlString)!
//        let request = makeRequest(with: url, httpMethod: "POST")
//
//        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
//            DispatchQueue.main.async {
//                if self.hasError(error) || self.hasServerError(response) {
//                    self.showError("Unable to save post.")
//                    return
//                }
//
//                self.printJSON(data, response)
//            }
//        }
//        task.resume()
//    }

    func updatePost(_ post: Post) async {
        switch runtime {
        case .inmemory:
            updateModel(post)
        case .network:
            do {
                try await updateNetwork(post)
            } catch NetworkError.invalidServerResponse {
                showError("Invalid HTTP response.")
            } catch {
                showError("Unknown error.")
            }
        }
    }

    func updateNetwork(_ post: Post) async throws {
        guard let id = Int(post.id) else { return }
        guard let uploadData = try? JSONEncoder().encode(post) else { return }

        let url = URL(string: "\(urlString)/\(id - 1)")!
        let request = makeRequest(with: url, httpMethod: "PUT")

        let (_, response) = try await URLSession.shared.upload(for: request, from: uploadData)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidServerResponse
        }
    }

    func deletePost(_ id: String) {
        switch runtime {
        case .inmemory:
            deleteModel(id)
        case .network:
            deleteNetwork(id)
        }
    }

    func deleteNetwork(_ id: String) {
        guard let id = Int(id) else { return }
        let url = URL(string: "\(urlString)/\(id - 1)")!
        let request = makeRequest(with: url, httpMethod: "DELETE")

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if self.hasError(error) || self.hasServerError(response) {
                    self.showError("Unable to save post.")
                    return
                }

                self.printJSON(data, response)
            }
        }.resume()
    }

    // TODO: Delete me
    private func makeRequest(with url: URL, httpMethod: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return request
    }

    private func hasError(_ error: Error?) -> Bool {
        if let error = error {
            print ("error: \(error)")
            return true
        }
        return false
    }

    private func hasServerError(_ response: URLResponse?) -> Bool {
        guard let response = response as? HTTPURLResponse,
            (200...299).contains(response.statusCode) else {
            print ("server error")
            return true
        }
        return false
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
