import SwiftUI

struct ContentView: View {
    @StateObject var companyVM: CompanyViewModel
    @State private var showingAddCompany = false

    var body: some View {
        NavigationStack {
            List(companyVM.companies) { company in
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
                AddCompany(companyVM: self.companyVM)
            }
            .task {
                await companyVM.fetchCompanies()
            }
            .alert(companyVM.errorMessage, isPresented: $companyVM.showingError) {
                Button("OK", role: .cancel) { }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(companyVM: CompanyViewModel())
            .preferredColorScheme(.dark)
    }
}
