//
//  TicTacToe2App.swift
//  TicTacToe2
//
//  Created by jrasmusson on 2022-05-01.
//

import SwiftUI

@main
struct TicTacToe2App: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = ViewModel()
            ContentView(viewModel: viewModel)
        }
    }
}
