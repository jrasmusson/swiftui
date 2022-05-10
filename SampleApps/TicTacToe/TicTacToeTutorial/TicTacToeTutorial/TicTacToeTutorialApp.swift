//
//  TicTacToeTutorialApp.swift
//  TicTacToeTutorial
//
//  Created by jrasmusson on 2022-05-07.
//

import SwiftUI

@main
struct TicTacToeTutorialApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ViewModel())
        }
    }
}
