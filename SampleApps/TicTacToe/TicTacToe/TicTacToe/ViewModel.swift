//
//  ViewModel.swift
//  TicTacToe
//
//  Created by jrasmusson on 2022-04-25.
//

import Foundation


class ViewModel: ObservableObject {
    @Published private var model = Model()

    func set(_ position: Position, _ value: Value) {
        model.set(position, value)
    }

    func get(_ position: Position) -> Value {
        model.get(position)
    }

    func reset() {
        model.reset()
    }
}
