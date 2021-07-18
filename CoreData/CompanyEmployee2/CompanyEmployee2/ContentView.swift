//
//  ContentView.swift
//  CompanyEmployee2
//
//  Created by jrasmusson on 2021-07-18.
//

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
                HStack {
                    TextField("Company name", text: $companyName)
                        .textFieldStyle(.roundedBorder)
                    Button(action: addCompany) {
                        Label("", systemImage: "plus")
                    }
                }
                List {
                    ForEach(companies) { company in
                        NavigationLink(destination: CompanyDetail(company: company)) {
                            Text(company.name ?? "")
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    HStack {
                        EditButton()
                    }
                }
            }
            .navigationTitle("Companies")
        }
    }

    private func addCompany() {
        withAnimation {
            let newCompany = Company(context: viewContext)
            newCompany.name = companyName

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { companies[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
