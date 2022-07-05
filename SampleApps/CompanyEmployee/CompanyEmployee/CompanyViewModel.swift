import Foundation

struct Company: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let employees: [Employee]
}

struct Employee: Codable, Identifiable, Hashable {
    let id: String
    let name: String
}

let employee1 = Employee(id: "1", name: "Jobs")
let employee2 = Employee(id: "2", name: "Watson")
let employee3 = Employee(id: "3", name: "Gates")
let employees = [employee1, employee2, employee3]

let company1 = Company(id: "1", name: "Apple", employees: employees)
let company2 = Company(id: "2", name: "IBM", employees: employees)
let company3 = Company(id: "3", name: "Microsoft", employees: employees)

enum CompanyError: Error {
    case networkFailed, decodeFailed
}

@MainActor
class CompanyViewModel: ObservableObject {

    @Published var companies: [Company] = []
    @Published var showingError = false
    var errorMessage = ""

    func fetchCompanies() async {

        let fetchTask = Task { () -> [Company] in
            let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/company")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let companies = try JSONDecoder().decode([Company].self, from: data)
            return companies
        }

        let result = await fetchTask.result

        switch result {
        case .success(let companies):
            self.companies = companies
        case .failure(let error):
            showError("An error occurred: \(error.localizedDescription).")
        }
    }

    private func showError(_ message: String) {
        self.showingError = true
        self.errorMessage = message
    }
}
