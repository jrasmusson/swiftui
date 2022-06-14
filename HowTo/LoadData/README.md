# Load Data

- Create a new playground.
- Add a new data file to `Resources`.

![](images/1.png)

**Resources/recipeData.json**

```swift
{
    "id": 1
}
```

**ModelData**

```swift
import UIKit

struct Recipe: Hashable, Codable, Identifiable {
    let id: Int
}

final class ModelData: ObservableObject {
    var recipe: Recipe = load("recipeData.json")
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

let md = ModelData()
```



