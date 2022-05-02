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

    private var isGameOver = false
    private var xWon = false
    private var yWon = false
    private var hasWinCondition = false

    mutating func setGameOver(_ isGameOver: Bool) {
        self.isGameOver = isGameOver
    }

    mutating func setXWon(_ xWon: Bool) {
        self.xWon = xWon
    }

    mutating func setYWon(_ yWon: Bool) {
        self.yWon = yWon
    }

    mutating func setHasWinCondition(_ hasWinCondition: Bool) {
        self.hasWinCondition = hasWinCondition
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

enum GameOver: CustomStringConvertible {
    case xWins
    case oWins
    case draw

    var description: String {
        switch self {
        case .xWins:
            return "X wins!"
        case .oWins:
            return "O wins!"
        case .draw:
            return "Draw!"
        }
    }
}


