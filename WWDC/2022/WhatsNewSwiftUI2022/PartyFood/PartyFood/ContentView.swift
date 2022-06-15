//
//  ContentView.swift
//  PartyFood
//
//  Created by jrasmusson on 2022-06-15.
//

import SwiftUI

struct FoodItem: Hashable, Codable, Identifiable {
    let id: Int
    let title: String
    let count: Int
    let description: String

    init(id: Int = 1, title: String = "Flan", count: Int = 1, descriptin: String = "What is a flan? That which we call milk...") {
        self.id = id
        self.title = title
        self.count = count
        self.description = descriptin
    }
}

final class ModelData: ObservableObject {
    var foodItems: [FoodItem] = [
        FoodItem(id: 1),
    ]
}

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
