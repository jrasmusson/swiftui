//
//  Results.swift
//  FamilyPool1
//
//  Created by jrasmusson on 2021-07-15.
//

import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var pool: Pool
    
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
                    }

                }
                Section(header: Text("Player2 team")) {
                    Picker("Select team1", selection: $pool.player2.team1Index) {
                        ForEach(0..<teams.count) {
                            Text(teams[$0])
                        }
                    }
                    Picker("Select team2", selection: $pool.player2.team2Index) {
                        ForEach(0..<teams.count) {
                            Text(teams[$0])
                        }
                    }
                }
                Text(pool.player1.team1Name)
            }
            .navigationBarTitle("Results")
        }
    }
}

struct Results_Previews: PreviewProvider {
    static var previews: some View {
        let pool = Pool()
        pool.player1.team1Name = "Edmonton Oilers"
        pool.player2.team2Name = "Calgary Flames"
        
        let oilersWins = Wins(team: "Edmonton Oilers", wins: 4)
        let calgaryWins = Wins(team: "Calgary Flames", wins: 3)
        
        pool.wins = [oilersWins, calgaryWins]
        
        return ResultsView()
            .environmentObject(pool)
    }
}
