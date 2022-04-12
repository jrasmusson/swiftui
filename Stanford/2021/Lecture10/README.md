# Lecture 10: Gestures

![](images/1.png)

![](images/2.png)

## Discrete gestures

Easy to handle.

![](images/3.png)

### Non-discrete gestures

Take a little more work.

![](images/4.png)

You often get back a value.

![](images/5.png)

You also get a chance to do something while the gesture is in flight.

You define some state in a special marked var `@GestureState`.

It can be any type you want. And you get to update it as the gesture is going on (i.e. how far the finger has moved, or where the finger is now).

This var will return to the starting value when the gesture is not happening.

![](images/6.png)

So read only except for a very small window when you get to update.

![](images/7.png)

The `$myGestureState` is actually an `inout` variable. It's value gets copied in and out via a pointer reference.

There is a simpler version of this that only gives you the value.

![](images/8.png)



### Links that help

- [Lectures](https://cs193p.sites.stanford.edu/)
- [Lecture 10](https://www.youtube.com/watch?v=iszjyoo3SYI)






