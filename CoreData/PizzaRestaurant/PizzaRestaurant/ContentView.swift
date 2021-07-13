//
//  ContentView.swift
//  PizzaRestaurant
//
//  Created by jrasmusson on 2021-07-13.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var showOrderSheet = false
    
    var body: some View {
        NavigationView {
            List {
                Text("Sample order")
            }
            .navigationTitle("My Orders")
            .navigationBarItems(trailing: Button(action: {
                showOrderSheet = true
            }, label: {
                Image(systemName: "plus.circle")
                    .imageScale(.large)
            }))
            .sheet(isPresented: $showOrderSheet) {
                OrderSheet()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
