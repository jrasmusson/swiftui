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
                        
                    }
                    Picker("Select team2", selection: $pool.player1.team2Index) {
                        ForEach(0..<teams.count) {
                            Text(teams[$0])
                        }
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
        ResultsView()
            .environmentObject(pool)
    }
}
