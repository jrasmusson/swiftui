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

struct Series {
    let name: String
    let team1Wins: Int
    let team2Wins: Int
}

class Pool: ObservableObject {
    @Published var name: String = ""
    @Published var player1: Player = Player(name: "Player1")
    @Published var player2: Player = Player(name: "Player2")
    @Published var results: [Series] = []
    
    init() {}
}
