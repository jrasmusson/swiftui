//
//  MenuView.swift
//  Places
//
//  Created by jrasmusson on 2022-06-19.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        Menu {
            Button("Open in Preview", action: openInPreview)
            Button("Save as PDF", action: saveAsPDF)
        } label: {
            Label("", systemImage: "doc.fill")
        }
    }

    func openInPreview() {  }
    func saveAsPDF() {  }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
