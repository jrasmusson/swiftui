//
//  Data.swift
//  FamilyPool1
//
//  Created by jrasmusson on 2021-07-14.
//

import Foundation

enum Team: String, CaseIterable, Identifiable, Codable {
    case choose = "Choose team"
    case edmonton = "Edmonton Oilers"
    case calgary = "Calgary Flames"
    case winnipeg = "Winnipeg Jets"
    case montreal = "Montreal Canadians"
    
    var id: String { self.rawValue }
}

var teams = [Team.choose, Team.edmonton, Team.calgary, Team.winnipeg, Team.montreal]

struct Player {
    let name: String
    
    var team1Index: Int = 0 {
        didSet {
            if team1Index != 0 { // Ignore .choose
                team1 = teams[team1Index]
            }
        }
    }

    var team2Index: Int = 0 {
        didSet {
            if team2Index != 0 { // Ignore .choose
                team2 = teams[team2Index]
            }
        }
    }

    var team1 = Team.choose
    var team2 = Team.choose
}

struct Wins: Codable {
    let team: Team
    let wins: Int
}

class Pool: ObservableObject {
    @Published var player1: Player = Player(name: "Player1")
    @Published var player2: Player = Player(name: "Player2")
    
    @Published var wins: [Wins] = []
    
    func playerPoints(forTeam team: Team) -> Int {
        for win in wins {
            if win.team == team {
                return win.wins
            }
        }
        return 0
    }
        
    init() {
        load()
    }
    
    func load() {
        wins = Bundle.main.decode("results.json")
    }
}
