# Lankmarks

## Handling user input

![](images/1.png)

In order to add a show favorites toggle, the Apple tutorial says:

![](images/2.png) 

You need to add a `ForEach` to the list in order to combine static and dynamic views. Why is that?

### What happens if we don't add the for each

Here is what happens if we keep the `List` and add the toggle on top:

![](images/demo1.gif)

SwiftUI keeps the `Toogle` and `List` views separate. It treats the static `Toggle` View as a view of its own and embeds the `List` view inside it.

In order to combine dynamic and static views together, we need to do what the tutorial says and transform the landmarks into rows:

![](images/3.png)

which `NavigationView` will then combine into a single view.


### Links that help

- [Handling User Input](https://developer.apple.com/tutorials/swiftui/handling-user-input)
