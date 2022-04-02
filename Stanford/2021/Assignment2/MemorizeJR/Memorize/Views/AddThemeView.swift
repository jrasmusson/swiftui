//
//  AddThemeView.swift
//  Memorize
//
//  Created by jrasmusson on 2022-04-01.
//

import SwiftUI

struct AddThemeView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var viewModel: ThemeViewModel
    @State private var name = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
            }
            .navigationBarItems(leading: saveButton, trailing: dismissButton)
            .navigationBarTitle(Text("New Theme"))
        }
    }

    var dismissButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Dismiss")
        })
    }

    var saveButton: some View {
        Button(action: {
            let theme = Theme(name: name, emojis: ["😆", "🤩", "🤓", "🥰"], color: .red)
            viewModel.add(theme)
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Save")
        })
    }
}

struct AddThemeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ThemeViewModel(themes: themeData)
        AddThemeView(viewModel: viewModel)
    }
}
