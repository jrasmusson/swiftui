//
//  AddThemeView.swift
//  Memorize
//
//  Created by jrasmusson on 2022-04-01.
//

import SwiftUI

struct AddThemeView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
            }
            .navigationBarItems(trailing: doneButton)
            .navigationBarTitle(Text("New Theme"))
        }
    }

    var doneButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Done")
        })
    }
}

struct AddThemeView_Previews: PreviewProvider {
    static var previews: some View {
        AddThemeView()
    }
}
