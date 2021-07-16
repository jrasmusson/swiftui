//
//  Results.swift
//  FamilyPool1
//
//  Created by jrasmusson on 2021-07-15.
//

import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var pool: PoolVM
    
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
    @EnvironmentObject var pool: PoolVM
    
    let playerType: PlayerType
    
    var body: some View {
        let playerName = playerType.rawValue
        
        let team1: TeamVM
        let team2: TeamVM
        
        switch playerType {
        case .player1:
            team1 = pool.player1.team1
            team2 = pool.player1.team2
        case .player2:
            team1 = pool.player2.team1
            team2 = pool.player2.team2
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
        let pool = PoolVM()
        pool.player1.team1 = TeamVM.edmonton
        pool.player1.team2 = TeamVM.calgary
        pool.player2.team1 = TeamVM.winnipeg
        pool.player2.team2 = TeamVM.montreal
        
        let oilersWins = WinsVM(team: TeamVM.edmonton, wins: 4)
        let calgaryWins = WinsVM(team: TeamVM.calgary, wins: 3)
        let winnipegWins = WinsVM(team: TeamVM.winnipeg, wins: 1)
        let montrealWins = WinsVM(team: TeamVM.montreal, wins: 8)
        
        pool.wins = [oilersWins, calgaryWins, winnipegWins, montrealWins]
        
        return ResultsView()
            .environmentObject(pool)
    }
}
