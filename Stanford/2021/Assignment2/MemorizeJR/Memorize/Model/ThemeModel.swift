//
//  ThemeModel.swift
//  Memorize
//
//  Created by jrasmusson on 2022-04-01.
//

import Foundation

struct ThemeModel {
    var themes: [Theme]
}

extension ThemeModel {
    func add(_ theme: Theme) {
        print("Add theme")
    }
}
