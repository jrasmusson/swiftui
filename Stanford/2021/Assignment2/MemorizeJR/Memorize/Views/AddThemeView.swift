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
    @State private var emojis = ""
    @State private var colors: [Color] = [.red, .blue, .yellow, .green, .orange]
    @State private var selectedColor: Color?

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Theme name")) {
                    TextField("Name", text: $name)
                }
                Section(header: Text("Add Emoji")) {
                    TextField("Emoji", text: $emojis)
                }
                Section(header: Text("Color")) {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 24))]) {
                        ForEach(colors, id: \.self) { color in
                            ColorView(color: color).aspectRatio(2/3, contentMode: .fit)
                                .onTapGesture {
                                    selectedColor = color
                                }
                        }
                    }
                }
            }
            .navigationBarItems(leading: saveButton, trailing: dismissButton)
            .navigationBarTitle(Text("New Theme"))
        }
//        .keyboardAdaptive()
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
            let emojisArray = emojis.map { String($0) }
            let theme = Theme(name: name, emojis: emojisArray, color: selectedColor ?? .red)
            viewModel.add(theme)
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Save")
        })
    }
}

struct ColorItem {
    let id = UUID()
    let color: Color
}

struct ColorView: View {
    let color: Color
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 20)
        shape.foregroundColor(color)
    }
}

struct AddThemeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ThemeViewModel(themes: themeData)
        AddThemeView(viewModel: viewModel)
    }
}
