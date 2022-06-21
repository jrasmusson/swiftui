//
//  DateRow.swift
//  Places
//
//  Created by jrasmusson on 2022-06-21.
//

import SwiftUI

struct DateRow: View {
    @State private var date = Date()
    let titleKey: String

    var body: some View {
        DatePicker(
            titleKey,
            selection: $date,
            displayedComponents: [.date]
        )
    }
}

struct DateRow_Previews: PreviewProvider {
    static var previews: some View {
        DateRow(titleKey: "Start Date")
            .preferredColorScheme(.dark)
    }
}
