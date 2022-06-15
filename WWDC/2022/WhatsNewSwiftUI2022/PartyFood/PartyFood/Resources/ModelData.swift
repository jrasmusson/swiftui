//
//  ModelData.swift
//  PartyFood
//
//  Created by jrasmusson on 2022-06-15.
//

import Foundation

struct FoodItem: Hashable, Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
}

final class ModelData: ObservableObject {
    var foodItems: [FoodItem] = load("foodData.json")
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
