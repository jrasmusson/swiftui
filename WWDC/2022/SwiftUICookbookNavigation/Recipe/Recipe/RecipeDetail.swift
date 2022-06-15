//
//  RecipeDetail.swift
//  Recipe
//
//  Created by jrasmusson on 2022-06-15.
//

import SwiftUI

struct RecipeDetail: View {
    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(recipe.relatedRecipes) { related in
                NavigationLink(related.name, value: related)
            }
        }
        .navigationTitle(recipe.name)
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = ModelData().recipe
        RecipeDetail(recipe: recipe)
    }
}
