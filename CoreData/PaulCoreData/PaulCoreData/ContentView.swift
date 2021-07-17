//
//  ContentView.swift
//  PaulCoreData
//
//  Created by jrasmusson on 2021-07-17.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext

//    @FetchRequest(
//        entity: ProgrammingLanguage.entity(),
//        sortDescriptors: [
//            NSSortDescriptor(keyPath: \ProgrammingLanguage.name, ascending: true),
//            NSSortDescriptor(keyPath: \ProgrammingLanguage.creator, ascending: false)
//        ]
//    ) var languages: FetchedResults<ProgrammingLanguage>
    
//    @FetchRequest(
//        entity: ProgrammingLanguage.entity(),
//        sortDescriptors: [
//            NSSortDescriptor(keyPath: \ProgrammingLanguage.name, ascending: true),
//        ],
//        predicate: NSPredicate(format: "name == %@", "Python")
//    ) var languages: FetchedResults<ProgrammingLanguage>
    
    @FetchRequest(
        entity: ProgrammingLanguage.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ProgrammingLanguage.name, ascending: true),
        ]
    ) var languages: FetchedResults<ProgrammingLanguage>
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Insert example language") {
                    let language = ProgrammingLanguage(context: viewContext)
                    language.name = "Python"
                    language.creator = "Guido van Rossum"
                    
                    PersistenceController.shared.saveContext()
                }
                
                List {
                    ForEach(languages, id: \.self) { language in
                        Text("Creator: \(language.creator ?? "Anonymous")")
                    }
                    .onDelete(perform: removeLanguages)
                }
            }
            .toolbar {
                EditButton()
            }
        }
    }
    
    func removeLanguages(at offsets: IndexSet) {
        for index in offsets {
            let language = languages[index]
            viewContext.delete(language)
            PersistenceController.shared.saveContext()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
