# Wrapping a UIViewController in a SwiftUI view

- import `SwiftUI`
- make class `final`

SwiftUI kind of blends `UIView` and `UIViewController` into a single `View `protocol, which makes our code much simpler.

```swift
//
//  ViewController.swift
//  Test
//
//  Created by jrasmusson on 2021-04-26.
//

import UIKit
import SwiftUI

final class ViewController: UIViewController {

    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Button", for: .normal)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

extension ViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}

@available(iOS 13.0, *)
struct ViewControllerPreviews: PreviewProvider {
  static var previews: some View {
    ViewController()
  }
}
#endif
```

![](images/vc.png)

## Dark Mode

```swift
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
```

- [Dark Mode](https://www.hackingwithswift.com/quick-start/swiftui/how-to-preview-your-layout-in-light-and-dark-mode)


## Different devices

```swift
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")

        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
            .previewDisplayName("iPhone 12 Pro Max")
    }
}
```

- [How to preview your layout in different devices](https://www.hackingwithswift.com/quick-start/swiftui/how-to-preview-your-layout-in-different-devices)

## Nibs

### View Controller

Exact same. Can instantiate view controller programmatically.

```swift
import UIKit

final class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
}

#if DEBUG
import SwiftUI

extension ViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}
import SwiftUI
struct ViewControllerPreviews: PreviewProvider {
  static var previews: some View {
    ViewController()
  }
}
#endif
```

![](images/nibvc.png)

### Links that help

- [Wrapping a UIViewController in a SwiftUI view](README.md)





