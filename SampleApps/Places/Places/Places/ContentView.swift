import SwiftUI

enum Tab {
    case places
    case itineraries
    case profile
}

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    @State var selection: Tab = .itineraries

    var body: some View {
        TabView(selection: $selection) {
            PlacesView()
                .environmentObject(ModelData())
                .tabItem {
                    Label("Places", systemImage: "rectangle.fill.on.rectangle.angled.fill")
                }
            .tag(Tab.places)

            ItinerariesView()
                .environmentObject(ModelData())
                .tabItem {
                    Label("Itineraries", systemImage: "list.bullet")
                }
                .tag(Tab.itineraries)

            Text("Profile")
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(Tab.profile)
        }
        .accentColor(appColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .environmentObject(ModelData())
    }
}
