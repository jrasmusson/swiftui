//
//  FoodDetailView.swift
//  PartyFood
//
//  Created by jrasmusson on 2022-06-15.
//

import SwiftUI

struct FoodDetailView: View {
    let item: FoodItem

    var body: some View {
        VStack {
            Text(item.title)
                .font(.headline)
            Text(item.description)
                .font(.subheadline)
            Spacer()
        }
    }
}

struct FoodDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let md = ModelData()
        FoodDetailView(item: md.foodItems[0])
    }
}
