# Places Home

![](images/1.png)

**ContentView**

```swift
import SwiftUI

enum Tab {
    case places
    case itineraries
    case profile
}

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    @State var selection: Tab = .places

    var body: some View {
        TabView(selection: $selection) {
            NavigationStack {
                ScrollView {
                    ForEach(modelData.places) { place in
                        NavigationLink(value: place) {
                            PlaceCard(place: place)
                        }
                    }
                }
                .navigationTitle("Places")
                .navigationDestination(for: Place.self) { item in
                    PlaceDetail(place: place)
                }
            }
            .tabItem {
                Label("Places", systemImage: "rectangle.fill.on.rectangle.angled.fill")
            }
            .tag(Tab.places)

            Text("Itineraries")
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
```

![](images/2.png)

**PlaceCard**

```swift
import SwiftUI

struct PlaceCard: View {
    let place: Place

    var body: some View {
        VStack(spacing: 6) {
            HStack {
                Text(place.location)
                    .foregroundColor(.secondary)
                Spacer()
                Menu {
                    Button("Share", action: share)
                    Button("Save as PDF", action: saveAsPDF)
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .tint(.primary)
                }
            }

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(place.title)
                        .font(.title)
                    Spacer()
                }

                HStack {
                    Image(systemName: "map")
                    Text(place.subTitle)
                    Spacer()
                }

                Image(place.imageName)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
            }
            .foregroundColor(.primary)
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(10)
    }

    func share() {  }
    func saveAsPDF() {  }
}

struct PlaceCard_Previews: PreviewProvider {
    static var previews: some View {
        PlaceCard(place: place)
            .preferredColorScheme(.dark)
    }
}
```

![](images/3.png)

**PlaceDetail**

```swift
import SwiftUI

struct PlaceDetail: View {
    let place: Place

    var body: some View {
        VStack {
            header
            title
            noteworthy
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
        .toolbar {
            toolBarItems
        }
        .tint(.primary)
    }

    var header: some View {
        Image("sf-detail")
            .resizable()
            .scaledToFit()
    }

    var title: some View {
        VStack(spacing: 6) {
            HStack {
                Text(place.location)
                    .foregroundColor(.secondary)
                Spacer()
            }

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(place.title)
                        .font(.title)
                    Spacer()
                }

                HStack {
                    Image(systemName: "map")
                    Text(place.subTitle)
                    Spacer()
                }
            }
            .foregroundColor(.primary)
        }
        .padding()
    }

    var noteworthy: some View {
        List(place.noteworthy) { worthy in
            NavigationLink(value: worthy) {
                NoteworthyRow(noteworthy: worthy)
            }
            .navigationDestination(for: Noteworthy.self) { detail in
                NoteworthyDetail(noteworthy: detail)
            }
        }
        .scrollDisabled(true)
    }

    var toolBarItems: ToolbarItemGroup<TupleView<(Button<Image>, Button<Image>)>> {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            Button(action: {
                print("Share")
            }) {
                Image(systemName: "square.and.arrow.up")
            }

            Button(action: {
                print("Like")
            }) {
                Image(systemName: "heart")
            }
        }
    }
}

struct PlaceDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PlaceDetail(place: place)
                .preferredColorScheme(.dark)
        }
    }
}
```

![](images/4.png)

**NoteworthyRow**

```swift
import SwiftUI

struct NoteworthyRow: View {
    let noteworthy: Noteworthy
    let size: CGFloat = 48

    var body: some View {
        HStack {
            Image(systemName: noteworthy.iconName)
                .foregroundColor(appColor)
                .frame(width: size, height: size)
                .background(.ultraThinMaterial)
                .cornerRadius(10)

            VStack(alignment: .leading) {
                Text(noteworthy.title)
                    .font(.headline)
                Text(noteworthy.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .cornerRadius(10)
    }
}

struct NoteworthyRow_Previews: PreviewProvider {
    static var previews: some View {
        NoteworthyRow(noteworthy: noteworthy1)
            .preferredColorScheme(.dark)
    }
}
```

![](images/5.png)

**NoteworthyDetail**

```swift
import SwiftUI

struct NoteworthyDetail: View {
    let noteworthy: Noteworthy
    var body: some View {
        Text("Hello \(noteworthy.title)!")
            .navigationTitle(noteworthy.title)
    }
}

struct NoteworthyDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NoteworthyDetail(noteworthy: noteworthy1)
        }
        .preferredColorScheme(.dark)
    }
}
```

