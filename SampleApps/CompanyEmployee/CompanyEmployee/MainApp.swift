import SwiftUI

@main
struct MainApp: App {
    @StateObject private var companyVM = CompanyViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(companyVM: companyVM)
        }
    }
}
