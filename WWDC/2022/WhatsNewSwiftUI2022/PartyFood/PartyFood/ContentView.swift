//
//  ContentView.swift
//  PartyFood
//
//  Created by jrasmusson on 2022-06-15.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        NavigationStack {
            List(modelData.foodItems) { item in
                NavigationLink(value: item) {
                    Text(item.title)
                }
            }
            .navigationTitle("Party Food")
            .navigationDestination(for: FoodItem.self) { item in
                FoodDetailView(item: item)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
