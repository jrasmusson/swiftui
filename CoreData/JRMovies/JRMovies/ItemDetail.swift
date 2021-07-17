//
//  ItemDetail.swift
//  JRMovies
//
//  Created by jrasmusson on 2021-07-17.
//

import SwiftUI

struct ItemDetail: View {
    
    let item: Item
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("\(item.timestamp!, formatter: itemFormatter)")
            Button("Update") {
                item.timestamp = Date()
                PersistenceController.shared.saveContext()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let newItem = Item(context: viewContext)
        newItem.timestamp = Date()

        return ItemDetail(item: newItem)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
