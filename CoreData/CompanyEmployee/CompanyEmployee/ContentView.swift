import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var companyName: String = ""

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Company.name, ascending: true)],
        animation: .default)
    
    private var companies: FetchedResults<Company>

    var body: some View {
        NavigationView {
            VStack {
                TextField("Company name", text: $companyName)
                    .textFieldStyle(.roundedBorder)
                Button("Save") {
                    addCompany()
                }
                List {
                    ForEach(companies) { company in
                        NavigationLink(destination: CompanyDetail(company: company)) {
                            Text("\(company.name!)")
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    HStack {
                        EditButton()
                        Button(action: addCompany) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
            }
        }
    }

    private func addCompany() {
        withAnimation {
            let newCompany = Company(context: viewContext)
            newCompany.name = "Pixar"
            PersistenceController.shared.saveContext()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { companies[$0] }.forEach(viewContext.delete)
            PersistenceController.shared.saveContext()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
