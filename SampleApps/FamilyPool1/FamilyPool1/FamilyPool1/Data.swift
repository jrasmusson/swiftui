//
//  Data.swift
//  FamilyPool1
//
//  Created by jrasmusson on 2021-07-14.
//

import Foundation

// MARK: External
struct Wins: Codable {
    let team: Team
    let wins: Int
}

// MARK: Internal
struct Player {
    var team1 = Team.choose
    var team2 = Team.choose

    var team1Index: Int = 0 {
        didSet { team1 = teams[team1Index] }
    }

    var team2Index: Int = 0 {
        didSet { team2 = teams[team2Index] }
    }
}

class Pool: ObservableObject {
    @Published var player1: Player = Player()
    @Published var player2: Player = Player()
    
    @Published var wins: [Wins] = []
    
    func playerPoints(forTeam team: Team) -> Int {
        return wins.first(where: { $0.team == team })?.wins ?? 0
    }

    init() {
        wins = Bundle.main.decode("results.json")
    }
}

// MARK: Data
enum PlayerType: String {
    case player1 = "Player1"
    case player2 = "Player2"
}

enum Team: String, CaseIterable, Identifiable, Codable {
    case choose = "Choose team"
    case edmonton = "Edmonton Oilers"
    case calgary = "Calgary Flames"
    case winnipeg = "Winnipeg Jets"
    case montreal = "Montreal Canadians"
    
    var id: String { self.rawValue }
}

var teams = [Team.choose, Team.edmonton, Team.calgary, Team.winnipeg, Team.montreal]

