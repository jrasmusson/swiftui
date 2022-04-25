//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by jrasmusson on 2022-04-25.
//

import SwiftUI

@main
struct TicTacToeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ViewModel())
        }
    }
}
