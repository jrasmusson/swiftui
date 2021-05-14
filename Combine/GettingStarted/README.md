# Getting Started with Combine

## Subscription and Publishers

```swift
import UIKit
import Combine 

extension Notification.Name {
 static let newBlogPost = Notification.Name("new_blog_post")
}

struct BlogPost {
 let title: String
 let url: URL
}

// Create a publisher
let blogPostPublisher = NotificationCenter.Publisher(center: .default, name: .newBlogPost, object: nil)
 .map { (notification) -> String? in
     return (notification.object as? BlogPost)?.title ?? ""
 }

// Create a subscriber
let lastPostLabel = UILabel()
let lastPostLabelSubscriber = Subscribers.Assign(object: lastPostLabel, keyPath: \.text)
blogPostPublisher.subscribe(lastPostLabelSubscriber)

// Post the notification
let blogPost = BlogPost(title: "Getting started with the Combine framework in Swift", url: URL(string: "https://www.avanderlee.com/swift/combine/")!)
NotificationCenter.default.post(name: .newBlogPost, object: blogPost)
print("Last post is: \(lastPostLabel.text!)")
```

## Rules of a subscription

- A subscriber can only have *one* subscription
- *Zero* or *more* values can be published
- At most *one* completion will be called

## @Published

A property wrapper that adds a publisher to any property.

```swift
final class FormViewController: UIViewController {
 
 @Published var isSubmitAllowed: Bool = false
 
 @IBOutlet private weak var acceptTermsSwitch: UISwitch!
 @IBOutlet private weak var submitButton: UIButton!
 
 override func viewDidLoad() {
     super.viewDidLoad()
     $isSubmitAllowed // publisher
         .receive(on: DispatchQueue.main) // operators
         .assign(to: \.isEnabled, on: submitButton) // subscription
 }

 @IBAction func didSwitch(_ sender: UISwitch) {
     isSubmitAllowed = sender.isOn
 }
}
```

> Note: $ binding can only be used on *class* instances. Class is also `final`.

### Memory management

While this works:

```swift
$isSubmitAllowed // publisher
         .receive(on: DispatchQueue.main) // operators
         .assign(to: \.isEnabled, on: submitButton) // subscription
```

It leaks memory and can lead to retain cycles. For this Combine has `AnyCancellable`.

```swift
 final class FormViewController: UIViewController {

     @Published var isSubmitAllowed: Bool = false
     private var switchSubscriber: AnyCancellable?

     @IBOutlet private weak var acceptTermsSwitch: UISwitch!
     @IBOutlet private weak var submitButton: UIButton!

     override func viewDidLoad() {
         super.viewDidLoad()
         
         /// Save the cancellable subscription.
         switchSubscriber = $isSubmitAllowed
             .receive(on: DispatchQueue.main)
             .assign(to: \.isEnabled, on: submitButton)
     }

     @IBAction func didSwitch(_ sender: UISwitch) {
         isSubmitAllowed = sender.isOn
     }
 } 
```

By explicitly tracking the reference to the subscription, `AnyCancellable` will call `cancel()` on deinit and make sure subscriptions terminate early and we avoid any retain cycles.

#### Storing multiple subscriptions

```swift
 final class FormViewController: UIViewController {
 
     @Published var isSubmitAllowed: Bool = false
     private var subscribers: [AnyCancellable] = []
 
     @IBOutlet private weak var acceptTermsSwitch: UISwitch!
     @IBOutlet private weak var submitButton: UIButton!
 
     override func viewDidLoad() {
         super.viewDidLoad()
         
         $isSubmitAllowed
             .receive(on: DispatchQueue.main)
             .assign(to: \.isEnabled, on: submitButton)
             .store(in: &subscribers)
     }
 
     @IBAction func didSwitch(_ sender: UISwitch) {
         isSubmitAllowed = sender.isOn
     }
 } 
```

### Links that help

- [Introducing Combine - WWDC 2019](https://developer.apple.com/videos/play/wwdc2019/722)
- [Combine in Practice - WWDC 2019](https://developer.apple.com/videos/play/wwdc2019/721/)
- [Use Your Loaf - Getting started with Combine](https://useyourloaf.com/blog/getting-started-with-combine/)
- [AvanderLee - Getting started with Combine](https://www.avanderlee.com/swift/combine/)





