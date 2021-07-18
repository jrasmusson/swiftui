import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var companyName: String = ""

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Company.timestamp, ascending: true)],
        animation: .default)
    
    private var companies: FetchedResults<Company>

    var body: some View {
        NavigationView {
            VStack {
                TextField("Company name", text: $companyName)
                    .textFieldStyle(.roundedBorder)
                Button("Save") {
                    coreDM.saveMovie(title: movieTitle)
                    populateMovies()
                }
                List {
                    ForEach(companies) { company in
                        NavigationLink(destination: CompanyDetail(item: company)) {
                            Text("\(company.timestamp!)")
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    HStack {
                        EditButton()
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Company(context: viewContext)
            newItem.timestamp = Date()
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
