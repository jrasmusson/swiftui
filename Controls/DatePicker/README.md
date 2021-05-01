# DatePicker

```swift
struct ContentView: View {
    
    @State private var wakeUp = Date()
    
    var body: some View {
    
        DatePicker("Please enter a date", selection: $wakeUp)
    }
    
}
```

![](images/1.png)

```swift
Form {
    DatePicker("Please enter a date", selection: $wakeUp)
}
```

![](images/2.png)

```swift
DatePicker("Please enter a date", selection: $wakeUp)
        .labelsHidden()
```

![](images/3.png)

### hourAndMinute

```swift
DatePicker("", selection: $wakeUp, displayedComponents: .hourAndMinute)
```

![](images/4.png)
	
### date

```swift
DatePicker("", selection: $wakeUp, displayedComponents: .date)
```

![](images/5.png)

### range

All the dates in the future, but none in the past.

```swift
DatePicker("Please enter a date", selection: $wakeUp, in: Date()...)
```

![](images/6.png)


### Links that help

- [Selecting dates and times with DatePicker](https://www.hackingwithswift.com/books/ios-swiftui/selecting-dates-and-times-with-datepicker)
