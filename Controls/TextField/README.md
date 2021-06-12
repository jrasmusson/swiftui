# TextField

```swift
TextField(
        "Search",
         text: $cityName
    ) { isEditing in
        // do something
    } onCommit: {
        // do something
    }
    
TextField(
        "Search",
         text: $cityName,
         onCommit: {
			// do something        
    })

TextField("Search", text: $cityName) 
    .font(.title)
    .padding(8)
    .background(Color(.systemFill))
        .cornerRadius(10)
    .keyboardType(.asciiCapable)
```

```swift
struct ContentView: View {
    @State private var checkAmount = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Amount", text: $checkAmount)
                    .keyboardType(.decimalPad)
            }

            Section {
                Text("$\(checkAmount)")
            }
        }
    }
}
```

![](images/1.png)

## Placeholder text

```swift
TextField("Enter your word", text: $newWord)
```

![](images/2.png)

## TextfieldStyle

### RoundedBorderTextFieldStyle

```swift
.textFieldStyle(RoundedBorderTextFieldStyle())
.padding()
```

![](images/3.png)

### PlainTextFieldStyle

```swift
.textFieldStyle(PlainTextFieldStyle())
```

![](images/4.png)

## Turn off autocapitilization

```swift
.autocapitalization(.none)
```

## Set background color

```swift
TextField("Search", text: $cityName)
    .font(.title)
    .padding(8)
    .background(Color(.systemFill))
        .cornerRadius(10)
    .keyboardType(.asciiCapable)
```

![](images/5.png)

### Links that help

- [Reading text from the user with TextField](https://www.hackingwithswift.com/books/ios-swiftui/reading-text-from-the-user-with-textfield)
