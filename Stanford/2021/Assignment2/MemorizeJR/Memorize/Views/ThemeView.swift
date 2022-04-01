//
//  ThemeView.swift
//  Memorize
//
//  Created by jrasmusson on 2022-04-01.
//

import SwiftUI

struct ThemeView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Halloween")
            }
            .navigationBarItems(leading: Button(action: {
                // Add action
            }, label: {
                Text("+")
            }),
                                trailing: Button(action: {
                // Add action
            }, label: {
                Text("Edit")
            }))
            .navigationBarTitle(Text("Memorize"))
        }
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView()
    }
}
