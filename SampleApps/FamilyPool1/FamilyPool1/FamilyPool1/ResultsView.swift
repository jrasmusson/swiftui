//
//  Results.swift
//  FamilyPool1
//
//  Created by jrasmusson on 2021-07-15.
//

import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var pool: Pool
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Player1 team")) {
                    let team1 = pool.player1.team1Name
                    let team1Pts = pool.playerPoints(forTeam: team1)

                    let team2 = pool.player1.team2Name
                    let team2Pts = pool.playerPoints(forTeam: team2)

                    let player1Total = team1Pts + team2Pts

                    HStack {
                        Text(team1)
                        Spacer()
                        Text("\(team1Pts) pts")
                    }
                    HStack {
                        Text(team2)
                        Spacer()
                        Text("\(team2Pts) pts")
                    }
                    HStack {
                        Text("Total")
                        Spacer()
                        Text("\(player1Total) pts")
                    }
                }
            }
            .navigationBarTitle("Results")
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
