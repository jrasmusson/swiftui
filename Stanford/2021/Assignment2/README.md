# Assignment II: More Memorize

## Step 1: Navigation Titles

Start by embedding the whole application within a `NavigationView`.

![](images/4.png)

Then to set the nav bar title for when you drill down, you need to go to the subview, add the title there, and even though you won't immediately see it on the subview, you can simulate it by adding it to your preview.

![](images/5.png)

![](images/6.png)


## Step 2: Presenting a view

![](images/demo1.gif)

To present a view we need to change the view's state. So instead of tapping a button and going:

```swift
present(view)
```

we instead update the views state:

```swift
struct ThemeView: View {
    @State private var showingAddScreen = false // 1

    let themes: [Theme]
    var body: some View {
        NavigationView {
            List {
                ForEach(themes) { theme in
                    ThemeCell(theme: theme)
                }
            }
            .navigationBarItems(leading: addButton, trailing: editButton)
            .navigationBarTitle(Text("Memorize"))
        }
        .sheet(isPresented: $showingAddScreen) { // 2
            AddThemeView() // 3
        }
    }

    var addButton: some View {
        Button(action: {
            self.showingAddScreen.toggle() // 4
        }, label: {
            Image(systemName: "plus")
        })
    }
}
```

## Dismissing a view

To dismiss the view programmatically, we need to:

- embed the view in a `NavigationView`
- hook our done button into the `presentationMode` for dismiss

![](images/7.png)

```swift
import SwiftUI

struct AddThemeView: View {
    @Environment(\.presentationMode) var presentationMode // 1
    @State private var name = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
            }
            .navigationBarItems(trailing: doneButton)
            .navigationBarTitle(Text("New Theme"))
        }
    }

    var doneButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss() // 2
        }, label: {
            Text("Done")
        })
    }
}
```


## Step 3: Adding a new theme

To add a new theme we need to:

- pass in the view model we want to update
- bind elements on that page to be used in that themes creation

[Apple docs: Managing User Inteface State](https://developer.apple.com/documentation/swiftui/managing-user-interface-state)




## Step 4: Edit a theme


## Desired output

![](images/1.png)
![](images/3.png)
![](images/2.png)



### Links that help

- [Standford Lectures](https://cs193p.sites.stanford.edu/)
- [Assignment II pdf](https://cs193p.sites.stanford.edu/sites/g/files/sbiybj16636/files/media/file/Assignment%202.pdf)
- [Swift API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/)
- [Managing User Interface State](https://developer.apple.com/documentation/swiftui/managing-user-interface-state)


