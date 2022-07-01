import SwiftUI

struct ContentView: View {
    @StateObject var companies: Companies
    @State var showingAddCompany = false

    var body: some View {
        NavigationStack {
            List(companies.items) { company in
                NavigationLink(value: company) {
                    Text(company.name)
                }
            }
            .navigationTitle("Companies")
            .navigationDestination(for: Company.self) { company in
                CompanyView(company: company)
            }
            .toolbar {
                Button(action: {
                    self.showingAddCompany.toggle()
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddCompany) {
                AddCompany(companies: self.companies)
            }
            .task {
                await companies.fetchCompanies()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(companies: Companies())
            .preferredColorScheme(.dark)
    }
}
