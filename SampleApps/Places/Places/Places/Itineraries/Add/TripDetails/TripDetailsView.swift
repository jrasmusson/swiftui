//
//  TripDetailsView.swift
//  Places
//
//  Created by jrasmusson on 2022-06-21.
//

import SwiftUI

struct TripDetailsView: View {
    var body: some View {
        List {
            Section(header: Text("Trip Details")) {
                CityRow()
                DateRow(titleKey: "Start Date")
                DateRow(titleKey: "End Date")
            }
            .headerProminence(.increased)
        }
    }
}

struct TripDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TripDetailsView()
            .preferredColorScheme(.dark)
    }
}
