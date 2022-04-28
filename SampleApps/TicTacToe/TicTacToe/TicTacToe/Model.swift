//
//  Model.swift
//  TicTacToe
//
//  Created by jrasmusson on 2022-04-25.
//

import Foundation

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

struct Model: CustomStringConvertible {
    private var state: [[Value]] = [[.b, .b, .b],
                                    [.b, .b, .b],
                                    [.b, .b, .b]]

    private var resetState: [[Value]] = [[.b, .b, .b],
                                         [.b, .b, .b],
                                         [.b, .b, .b]]

    var description: String {
        return """
            \(state[0][0]) \(state[0][1]) \(state[0][2])
            \(state[1][0]) \(state[1][1]) \(state[1][2])
            \(state[2][0]) \(state[2][1]) \(state[2][2])
        """
    }

    mutating func set(_ position: Position, _ value: Value) {
        switch position {
        case .upperLeft:
            state[0][0] = value
        case .upperMiddle:
            state[0][1] = value
        case .upperRight:
            state[0][2] = value
        case .middleLeft:
            state[1][0] = value
        case .middleMiddle:
            state[1][1] = value
        case .middleRight:
            state[1][2] = value
        case .lowerLeft:
            state[2][0] = value
        case .lowerMiddle:
            state[2][1] = value
        case .lowerRight:
            state[2][2] = value
        }
    }

    mutating func get(_ position: Position) -> Value {
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

    mutating func reset() {
        state = resetState
    }
}
