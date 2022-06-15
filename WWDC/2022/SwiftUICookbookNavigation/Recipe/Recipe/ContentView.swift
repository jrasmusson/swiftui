//
//  ContentView.swift
//  Recipe
//
//  Created by jrasmusson on 2022-06-13.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationStack {
            List(Category.allCases) { category in
                Section(category.localizedName) {
                    ForEach(modelData.myRecipes(in: category)) { recipe in
                        NavigationLink(recipe.name, value: recipe)
                    }
                }
            }
            .navigationTitle("Categories")
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetail(recipe: recipe)
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
