//
//  ModelData.swift
//  Places
//
//  Created by jrasmusson on 2022-06-18.
//

import Foundation

struct FoodItem: Hashable, Identifiable {
    let id: UUID = UUID()
    let title: String
    let description: String
}

struct Place: Hashable, Identifiable {
    let id: UUID = UUID()
    let title: String
    let description: String
    let location: String
}

final class ModelData: ObservableObject {
    var foodItems: [FoodItem] = [FoodItem(title: "", description: "")]
}
