# Word Scramble

## Loading resources from your app bundle

```swift
if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
    // we found the file in our bundle!
}
```

```swift
if let fileContents = try? String(contentsOf: fileURL) {
    // we loaded the file into a string!
}
```

- [Resource bundle](https://www.hackingwithswift.com/books/ios-swiftui/loading-resources-from-your-app-bundle)

## Checking for spelling

```swift
let word = "swift"
let checker = UITextChecker()
let range = NSRange(location: 0, length: word.utf16.count)
let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
let allGood = misspelledRange.location == NSNotFound
```


- [Working with Strings](https://www.hackingwithswift.com/books/ios-swiftui/working-with-strings)


### Links that help

- [Word Scramble Intro](https://www.hackingwithswift.com/books/ios-swiftui/word-scramble-introduction)
