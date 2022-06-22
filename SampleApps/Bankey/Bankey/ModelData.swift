//
//  ModelData.swift
//  Bankey
//
//  Created by jrasmusson on 2022-06-22.
//

import Foundation

class ModelData: ObservableObject {
    @Published var hasOnboarded = false
    @Published var isLoggedIn = false

     init(hasOnboarded: Bool = false) {
         self.hasOnboarded = hasOnboarded
     }
}
