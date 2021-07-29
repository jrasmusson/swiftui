//
//  ContentView.swift
//  CoreDataIntro
//
//  Created by jrasmusson on 2021-07-22.
//

import SwiftUI

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
                }.padding()
                List {
                    ForEach(companies) { company in
                        NavigationLink(destination: CompanyDetail(company: company)) {
                            Text(company.name ?? "")
                        }
                    }.onDelete(perform: deleteCompany)
                }
            }.navigationTitle("Companies")
        }
    }
    
    private func addCompany() {
        withAnimation {
            let newCompany = Company(context: viewContext)
            newCompany.name = companyName
            PersistenceController.shared.saveContext()
        }
    }

    private func deleteCompany(offsets: IndexSet) {
        withAnimation {
            offsets.map { companies[$0] }.forEach(viewContext.delete)
            PersistenceController.shared.saveContext()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext,
                                   PersistenceController.preview.container.viewContext)
    }
}
