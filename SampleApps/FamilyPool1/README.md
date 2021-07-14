# Family Pool

## Data Flow

By defining an `ObservableObject`

```swift
import Foundation

var teams = ["Edmonton Oilers", "Calgary Flames", "Winnipeg Jets", "Montreal Canadians"]

struct Player {
    let name: String
    
    var team1Index: Int = 0
    var team2Index: Int = 0
    
    var team1Name: String { teams[team1Index] }
    var team2Name: String { teams[team2Index] }
}

class Pool: ObservableObject {
    @Published var name: String = ""
    @Published var player1: Player = Player(name: "Player1")
    @Published var player2: Player = Player(name: "Player2")
    init() {}
}
```

And then injecting that into our main view

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

every subview now has access to `Pool`. 

So if we want to change something in `Pool` from down in a subview, we need to bind to it. Like we do here when selecting teams for players.

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

Because picker is bound to an attribute in `Pool`

```swift
Picker("Select team1", selection: $pool.player1.team1Index)
```

When we change the attribute in the picker, that get's propogated back up to pool.



### Links that help

