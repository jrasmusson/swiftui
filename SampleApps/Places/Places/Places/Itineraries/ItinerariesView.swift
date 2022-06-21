//
//  ItinerariesView.swift
//  Places
//
//  Created by jrasmusson on 2022-06-21.
//

import SwiftUI

struct ItinerariesView: View {
    @EnvironmentObject var modelData: ModelData
    @State var showingAddItinerary = false

    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(modelData.itineraries) { itinerary in
                    NavigationLink(value: itinerary) {
                        ItineraryCard(itinerary: itinerary)
                            .padding()
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showingAddItinerary.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                    .foregroundColor(appColor)
                }
            }
            .navigationTitle("Itineraries")
            .navigationDestination(for: Itinerary.self) { item in
                ItineraryDetail()
            }
            .sheet(isPresented: $showingAddItinerary) {
//                AddBookView().environment(\.managedObjectContext, self.moc)
            }
        }
    }
}

struct ItinerariesView_Previews: PreviewProvider {
    static var previews: some View {
        ItinerariesView()
            .preferredColorScheme(.dark)
            .environmentObject(ModelData())
    }
}
