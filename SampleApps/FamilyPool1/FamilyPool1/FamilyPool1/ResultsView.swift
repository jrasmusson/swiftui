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
                ResultSection(playerName: "Player1",
                              team1Name: pool.player1.team1Name,
                              team2Name: pool.player1.team2Name,
                              team1Pts: pool.playerPoints(forTeam: pool.player1.team1Name),
                              team2Pts: pool.playerPoints(forTeam: pool.player1.team2Name))
                
                ResultSection(playerName: "Player2",
                              team1Name: pool.player1.team1Name,
                              team2Name: pool.player1.team2Name,
                              team1Pts: pool.playerPoints(forTeam: pool.player2.team1Name),
                              team2Pts: pool.playerPoints(forTeam: pool.player2.team2Name))
            }
            .navigationBarTitle("Results")
        }
        
    }
}

struct ResultSection: View {
    let playerName: String
    let team1Name: String
    let team2Name: String
    
    let team1Pts: Int
    let team2Pts: Int

    var body: some View {
        Section(header: Text("\(playerName) team")) {
            let playerTotal = team1Pts + team2Pts
            
            HStack {
                Text(team1Name)
                Spacer()
                Text("\(team1Pts) pts")
            }
            HStack {
                Text(team2Name)
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
        pool.player1.team1Name = Team.edmonton.rawValue
        pool.player1.team2Name = Team.calgary.rawValue
        
        let oilersWins = Wins(team: "Edmonton Oilers", wins: 4)
        let calgaryWins = Wins(team: "Calgary Flames", wins: 3)
        
        pool.wins = [oilersWins, calgaryWins]
        
        return ResultsView()
            .environmentObject(pool)
    }
}
