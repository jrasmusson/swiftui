import SwiftUI

@main
struct MainApp: App {
    @StateObject private var companies = CompanyViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(companies: companies)
        }
    }
}
