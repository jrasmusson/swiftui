//
//  Data.swift
//  FamilyPool1
//
//  Created by jrasmusson on 2021-07-14.
//

import Foundation

var teams = ["Choose team", "Edmonton Oilers", "Calgary Flames", "Winnipeg Jets", "Montreal Canadians"]

struct Player {
    let name: String
    
    var team1Index: Int = 0 {
        didSet {
            if team1Index != 0 { // Ignore "Choose team"
                team1Name = teams[team1Index]
            }
        }
    }
    var team2Index: Int = 0
    
    var team1Name = teams[0]
    var team2Name = teams[0]
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
        var total = 0
        for win in wins {
            if win.team == player1.team1Name || win.team == player1.team2Name {
                total += win.wins
            }
        }
        return total
    }
        
    init() {}
}
