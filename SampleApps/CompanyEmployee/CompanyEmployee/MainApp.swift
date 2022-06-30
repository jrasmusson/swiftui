import SwiftUI

@main
struct MainApp: App {
    @StateObject private var companies = Companies()

    var body: some Scene {
        WindowGroup {
            ContentView(companies: companies)
        }
    }
}
