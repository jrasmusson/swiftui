//
//  ThemeViewModel.swift
//  Memorize
//
//  Created by jrasmusson on 2022-04-01.
//

import SwiftUI

class ThemeViewModel: ObservableObject {
    @Published private var model: ThemeModel

    var themes: [Theme] {
        return model.themes
    }

    init(themes: [Theme]) {
        model = ThemeModel(themes: themes)
    }
}

// MARK: - Intent(s)
extension ThemeViewModel {
    func add(_ theme: Theme) {
        model.add(theme)
    }
}
