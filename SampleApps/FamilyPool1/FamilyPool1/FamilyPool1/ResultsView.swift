//
//  Results.swift
//  FamilyPool1
//
//  Created by jrasmusson on 2021-07-15.
//

import SwiftUI

enum PlayerType: String {
    case player1 = "Player1"
    case player2 = "Player2"
}

struct ResultsView: View {
    @EnvironmentObject var pool: Pool
    
    var body: some View {
        NavigationView {
            
            Form {
                ResultSection(playerType: .player1)
                ResultSection(playerType: .player2)
            }
            .navigationBarTitle("Results")
        }
        
    }
}

struct ResultSection: View {
    @EnvironmentObject var pool: Pool
    
    let playerType: PlayerType
    
    var body: some View {
        let playerName = playerType.rawValue
        
        let team1: Team
        let team2: Team
        
        switch playerType {
        case .player1:
            team1 = pool.player1.team1Name
            team2 = pool.player1.team2Name
        case .player2:
            team1 = pool.player2.team1Name
            team2 = pool.player2.team2Name
        }
        
        let team1Pts = pool.playerPoints(forTeam: team1)
        let team2Pts = pool.playerPoints(forTeam: team2)

        
        return Section(header: Text("\(playerName) team")) {
            let playerTotal = team1Pts + team2Pts
            
            HStack {
                Text(team1.rawValue)
                Spacer()
                Text("\(team1Pts) pts")
            }
            HStack {
                Text(team2.rawValue)
                Spacer()
                Text("\(team2Pts) pts")
            }
            HStack {
                Text("Total")
                Spacer()
                Text("\(playerTotal) pts")
            }
        }
    }
}

struct Results_Previews: PreviewProvider {
    static var previews: some View {
        let pool = Pool()
        pool.player1.team1Name = Team.edmonton
        pool.player1.team2Name = Team.calgary
        pool.player2.team1Name = Team.winnipeg
        pool.player2.team2Name = Team.montreal
        
        let oilersWins = Wins(team: Team.edmonton.rawValue, wins: 4)
        let calgaryWins = Wins(team: Team.calgary.rawValue, wins: 3)
        let winnipegWins = Wins(team: Team.winnipeg.rawValue, wins: 1)
        let montrealWins = Wins(team: Team.montreal.rawValue, wins: 8)
        
        pool.wins = [oilersWins, calgaryWins, winnipegWins, montrealWins]
        
        return ResultsView()
            .environmentObject(pool)
    }
}
