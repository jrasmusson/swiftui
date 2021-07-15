# Family Pool

## Setting team name

### Data

Define `ObservableObject`. When `teamIndex` changes, update `team1Name`.

```swift
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

class Pool: ObservableObject {
    @Published var name: String = ""
    @Published var player1: Player = Player(name: "Player1")
    @Published var player2: Player = Player(name: "Player2")
    init() {}
}
```

Inject into view.

```swit
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView() {
            IntroView()
            ChooseTeamsView()
            Text("Start your pool!")
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let pool = Pool()
        ContentView()
            .environmentObject(pool)
    }
}
```

### Flow

By binding to 

```swift
Picker("Select team1", selection: $pool.player1.team1Index)
```

We can propogate the index back up to the pool, and update our team name there.

```swift
import SwiftUI

struct ChooseTeamsView: View {
    @EnvironmentObject var pool: Pool
    @State private var selectedTeamIndex = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Player1 team")) {
                    Picker("Select team1", selection: $pool.player1.team1Index) {
                        ForEach(0..<teams.count) {
                            Text(teams[$0])
                        }
                    }
                    ...
                }
            }
        }
    }
}
```

### Links that help

