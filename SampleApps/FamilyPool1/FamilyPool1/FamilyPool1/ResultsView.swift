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
                    HStack {
                        Text(pool.player1.team1Name)
                        Spacer()
                        Text("\(pool.player1Points(forTeam: "Edmonton Oilers")) pts")
                    }
                    HStack {
                        Text(pool.player1.team2Name)
                        Spacer()
                        Text("\(pool.player1Points(forTeam: "Calgary Flames")) pts")
                    }
                    HStack {
                        Text("Total")
                        Spacer()
                        let team1Pts = pool.player1Points(forTeam: "Edmonton Oilers")
                        let team2Pts = pool.player1Points(forTeam: "Calgary Flames")
                        Text("\(team1Pts + team2Pts) pts")
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
