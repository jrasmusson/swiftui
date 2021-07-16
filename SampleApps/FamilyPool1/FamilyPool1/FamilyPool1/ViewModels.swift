//
//  Data.swift
//  FamilyPool1
//
//  Created by jrasmusson on 2021-07-14.
//

import Foundation

// MARK: External
struct WinsVM: Codable {
    let team: TeamVM
    let wins: Int
}

// MARK: Internal
struct PlayerVM {
    var team1 = TeamVM.choose
    var team2 = TeamVM.choose

    var team1Index: Int = 0 {
        didSet { team1 = teams[team1Index] }
    }

    var team2Index: Int = 0 {
        didSet { team2 = teams[team2Index] }
    }
}

class PoolVM: ObservableObject {
    @Published var player1: PlayerVM = PlayerVM()
    @Published var player2: PlayerVM = PlayerVM()
    
    @Published var wins: [WinsVM] = []
    
    func playerPoints(forTeam team: TeamVM) -> Int {
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

enum TeamVM: String, CaseIterable, Identifiable, Codable {
    case choose = "Choose team"
    case edmonton = "Edmonton Oilers"
    case calgary = "Calgary Flames"
    case winnipeg = "Winnipeg Jets"
    case montreal = "Montreal Canadians"
    
    var id: String { self.rawValue }
}

var teams = [TeamVM.choose, TeamVM.edmonton, TeamVM.calgary, TeamVM.winnipeg, TeamVM.montreal]

