//
//  CityRow.swift
//  Places
//
//  Created by jrasmusson on 2022-06-21.
//

import SwiftUI

struct CityRow: View {
    var body: some View {
        HStack {
            Text("City")
            Spacer()
            Text("San Francisco")
                .foregroundColor(.secondary)
        }
    }
}

struct CityRow_Previews: PreviewProvider {
    static var previews: some View {
        CityRow()
            .preferredColorScheme(.dark)
    }
}
