//
//  ModelData.swift
//  Bankey
//
//  Created by jrasmusson on 2022-06-22.
//

import Foundation

class ModelData: ObservableObject {
    @Published var hasOnboarded: Bool

     init(hasOnboarded: Bool) {
         self.hasOnboarded = hasOnboarded
     }
}
