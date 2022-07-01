# Simple Networking

For simple networking you can fetch your results in your data model object:

**Network**

```swift
import SwiftUI

class Network: ObservableObject {
    @Published var users: [User] = []

    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { fatalError("Missing URL") }
		...
    }
}
```

And then load it in the `View` via `.onAppear`:

**ContentView**

```swift
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var network: Network

    var body: some View {
        ScrollView {
			...
        }
        .onAppear {
            network.getUsers()
        }
    }
}
```

## Full Source

**Network**

```swift
//
//  Network.swift
//  Networking1
//
//  Created by jrasmusson on 2022-07-01.
//

import SwiftUI

class Network: ObservableObject {
    @Published var users: [User] = []

    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedUsers = try JSONDecoder().decode([User].self, from: data)
                        self.users = decodedUsers
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }

        dataTask.resume()
    }
}
```

**ContentView**

```swift
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var network: Network

    var body: some View {
        ScrollView {
            Text("All users")
                .font(.title)
                .bold()

            VStack(alignment: .leading) {
                ForEach(network.users) { user in
                    HStack(alignment:.top) {
                        Text("\(user.id)")

                        VStack(alignment: .leading) {
                            Text(user.name)
                                .bold()

                            Text(user.email.lowercased())

                            Text(user.phone)
                        }
                    }
                    .frame(width: 300, alignment: .leading)
                    .padding()
                    .background(.secondary)
                    .cornerRadius(10)
                }
            }

        }
        .padding(.vertical)
        .onAppear {
            network.getUsers()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Network())
    }
}
```

**User**

```swift
import Foundation

struct User: Identifiable, Decodable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var address: Address
    var phone: String
    var website: String
    var company: Company

    struct Address: Decodable {
        var street: String
        var suite: String
        var city: String
        var zipcode: String
        var geo: Geo

        struct Geo: Decodable {
            var lat: String
            var lng: String
        }
    }

    struct Company: Decodable {
        var name: String
        var catchPhrase: String
        var bs: String
    }
}
```

**App**

```swift
import SwiftUI

@main
struct Networking1App: App {
    var network = Network()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(network)
        }
    }
}
```

![](images/1.png)

### Links that help
- [Example](https://designcode.io/swiftui-advanced-handbook-http-request)