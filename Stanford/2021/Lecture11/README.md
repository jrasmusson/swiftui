# Lecture 11: Error Handling Persistence

## Error handling

![](images/1.png)

![](images/2.png)

![](images/3.png)

![](images/4.png)

![](images/5.png)

## Persistence

![](images/6.png)

- `iCloud` - data you want to appears on all the users devices
- `CloudKit` - famework for making this happens

![](images/7.png)

![](images/8.png)

![](images/9.png)

![](images/10.png)

### Archiving

![](images/11.png)

- For structs that contain only other codeables, Swift will implement the Codable for you.
- For enums Swift will implement Codable for you unless you have associated data

![](images/12.png)

![](images/13.png)

![](images/14.png)

![](images/15.png)

![](images/16.png)

### UserDefaults

![](images/17.png)

- Things can only be stored in a `Property List`
- This is just an idea or concept.
- Any combination of these things but it has to be a combination of only these things
- The loop whole is that `Data` is one of these types so we can take a `Codable` and store it as `Data` if we which.

![](images/18.png)

The UserDefaults API has a type in it called `Any`. And Any is anti Swift. It means untyped. And Swift being a typed language doen't like. So we just adjust.

![](images/19.png)

![](images/20.png)

`array(forKey)` returns an `Any`. But you need to figure out how to convert. So we convert into an array of something we know using `as ?`.

Can avoid a lot of this if you use `Codable`.

### Links that help

- [Lectures](https://cs193p.sites.stanford.edu/)
- [Lecture 11](https://www.youtube.com/watch?v=pT5yiBu2xbU&ab_channel=Stanford)






