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

enum LoadError: Error {
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
            let data: Data

            do {
                (data, _) = try await URLSession.shared.data(from: url)
            } catch {
                throw LoadError.networkFailed
            }

            if let companies = try JSONDecoder().decode([Company].self, from: data) {
                return companies
            } else {
                throw LoadError.decodeFailed
            }

        }

        let result = await fetchTask.result

//        do {
//            self.companies = try result.get()
//            self.showingError = false
//        } catch LoadError.fetchFailed {
            showError("Unable to fetch the quotes.")
//        } catch LoadError.decodeFailed {
//            showError("Unable to convert quotes to text.")
//        } catch {
//            showError("Unknown error.")
//        }
    }

    private func showError(_ message: String) {
        self.showingError = true
        self.errorMessage = message
    }
}


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
