//
//  Data.swift
//  FamilyPool1
//
//  Created by jrasmusson on 2021-07-14.
//

import Foundation

enum Team: String {
    case choose = "Choose team"
    case edmonton = "Edmonton Oilers"
    case calgary = "Calgary Flames"
    case winnipeg = "Winnipeg Jets"
    case montreal = "Montreal Canadians"
}

var teams = [Team.choose, Team.edmonton, Team.calgary, Team.winnipeg, Team.montreal]

struct Player {
    let name: String
    
    var team1Index: Int = 0 {
        didSet {
            if team1Index != 0 { // Ignore "Choose team"
                team1Name = teams[team1Index].rawValue
            }
        }
    }
    var team2Index: Int = 0
    
    var team1Name = Team.choose.rawValue
    var team2Name = Team.choose.rawValue
}

struct Wins: Codable {
    let team: String
    let wins: Int
}

class Pool: ObservableObject {
    @Published var player1: Player = Player(name: "Player1")
    @Published var player2: Player = Player(name: "Player2")
    
    @Published var wins: [Wins] = []
    
    func player1Points(forTeam team: String) -> Int {
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
