//
//  ModelData.swift
//  Recipe
//
//  Created by jrasmusson on 2022-06-14.
//

import Foundation

struct Recipe: Hashable, Codable, Identifiable {
    let id: Int
    let name: String
    let category: String
    let ingredients: [String]
    let relatedRecipes: [String]
}

enum Category: CaseIterable, Identifiable {
    case dessert, pancake

    var id: Self { self }
    var localizedName: String {
        switch self {
        case .dessert:
            return "Dessert"
        case .pancake:
            return "Pancake"
        }
    }
}

final class ModelData: ObservableObject {
    var recipe: Recipe = load("recipeData.json")
    var recipes: [Recipe] = load("recipesData.json")

    func myRecipes(in category: Category) -> [Recipe] {
        recipes.filter { $0.category == category.localizedName }
    }
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
