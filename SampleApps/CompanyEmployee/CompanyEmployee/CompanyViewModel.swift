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

///
/// Fake data
///
let employee1 = Employee(id: "1", name: "Jobs")
let employee2 = Employee(id: "2", name: "Watson")
let employee3 = Employee(id: "3", name: "Gates")
let employees = [employee1, employee2, employee3]

let company1 = Company(id: "1", name: "Apple", employees: employees)
let company2 = Company(id: "2", name: "IBM", employees: employees)
let company3 = Company(id: "3", name: "Microsoft", employees: employees)

@MainActor
class CompanyViewModel: ObservableObject {

    /// Fake data
    // @Published var items: [Company] = [company1, company2, company3]
    @Published var companies: [Company] = []
    @Published var showingError = false

    /// Real thing
//    func fetchCompanies() async {
//        guard let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/company") else { fatalError("Missing URL") }
//
//        let urlRequest = URLRequest(url: url)
//
//        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//            if let error = error {
//                print("Request error: ", error)
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse else { return }
//
//            if response.statusCode == 200 {
//                guard let data = data else { return }
//                DispatchQueue.main.async {
//                    do {
//                        let decodedCompanies = try JSONDecoder().decode([Company].self, from: data)
//                        self.items = decodedCompanies
//                    } catch let error {
//                        print("Error decoding: ", error)
//                    }
//                }
//            }
//        }
//
//        dataTask.resume()
//    }

    /// Real thing with `Result`
    func fetchCompanies() async {
        let fetchTask = Task { () -> [Company] in
            let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/company")!
            let (data, _) = try await URLSession.shared.data(from: url) // (data, response)
            let companies = try JSONDecoder().decode([Company].self, from: data)
            return companies
        }

        // TODO: Handle response 200 set networkError

        let result = await fetchTask.result

        switch result {
            case .success(let companies):
            self.companies = companies
            self.showingError = false
            case .failure(let error):
            self.showingError = true
        }
    }
}
