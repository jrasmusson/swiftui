//
//  Model.swift
//  TicTacToe2
//
//  Created by jrasmusson on 2022-05-01.
//

import Foundation

struct Model {
    private var state: [[TileState]] = [
        [TileState.blank(), TileState.blank(), TileState.blank()],
        [TileState.blank(), TileState.blank(), TileState.blank()],
        [TileState.blank(), TileState.blank(), TileState.blank()]
    ]

    private var resetState: [[TileState]] = [
        [TileState.blank(), TileState.blank(), TileState.blank()],
        [TileState.blank(), TileState.blank(), TileState.blank()],
        [TileState.blank(), TileState.blank(), TileState.blank()]
    ]

    mutating func set(_ position: Position, _ tileState: TileState) {
        switch position {
        case .upperLeft:
            state[0][0] = tileState
        case .upperMiddle:
            state[0][1] = tileState
        case .upperRight:
            state[0][2] = tileState
        case .middleLeft:
            state[1][0] = tileState
        case .middleMiddle:
            state[1][1] = tileState
        case .middleRight:
            state[1][2] = tileState
        case .lowerLeft:
            state[2][0] = tileState
        case .lowerMiddle:
            state[2][1] = tileState
        case .lowerRight:
            state[2][2] = tileState
        }
    }

    func get(_ position: Position) -> TileState {
        switch position {
        case .upperLeft:
            return state[0][0]
        case .upperMiddle:
            return state[0][1]
        case .upperRight:
            return state[0][2]
        case .middleLeft:
            return state[1][0]
        case .middleMiddle:
            return state[1][1]
        case .middleRight:
            return state[1][2]
        case .lowerLeft:
            return state[2][0]
        case .lowerMiddle:
            return state[2][1]
        case .lowerRight:
            return state[2][2]
        }
    }

    private var _isXTurn = false

    var isXTurn: Bool {
        _isXTurn
    }

    mutating func toggleTurn() {
        self._isXTurn.toggle()
    }

    var hasWinCondition: Bool {
        valueWins(.x) || valueWins(.o)
    }

    var isDraw: Bool {
        let row0 = state[0]
        let row1 = state[1]
        let row2 = state[2]

        let row0Locked = row0.filter { $0.isLocked }.count == 3
        let row1Locked = row1.filter { $0.isLocked }.count == 3
        let row2Locked = row2.filter { $0.isLocked }.count == 3

        let allRowsLocked = row0Locked && row1Locked && row2Locked

        return !hasWinCondition && allRowsLocked
    }

    private func valueWins(_ v: Value) -> Bool {
        guard v != .b else { return false }

        // rows
        if state[0][0].value == v && state[0][1].value == v && state[0][2].value == v { return true }
        if state[1][0].value == v && state[1][1].value == v && state[1][2].value == v { return true }
        if state[2][0].value == v && state[2][1].value == v && state[2][2].value == v { return true }

        // cols
        if state[0][0].value == v && state[1][0].value == v && state[2][0].value == v { return true }
        if state[0][1].value == v && state[1][1].value == v && state[2][1].value == v { return true }
        if state[0][2].value == v && state[1][2].value == v && state[2][2].value == v { return true }

        // diagonals
        if state[0][0].value == v && state[1][1].value == v && state[2][2].value == v { return true }
        if state[0][2].value == v && state[1][1].value == v && state[0][2].value == v { return true }

        return false
    }

    mutating func reset() {
        state = resetState
    }
}


enum Value: CustomStringConvertible {
    case b, x, o

    var description: String {
        switch self {
        case .b:
            return "-"
        case .x:
            return "X"
        case .o:
            return "O"
        }
    }
}

enum Position {
    case upperLeft
    case upperMiddle
    case upperRight
    case middleLeft
    case middleMiddle
    case middleRight
    case lowerLeft
    case lowerMiddle
    case lowerRight
}

struct TileState {
    var value: Value
    var isLocked: Bool = false
    var isX: Bool { value == .x }

    static func blank() -> TileState {
        TileState(value: .b)
    }
}
