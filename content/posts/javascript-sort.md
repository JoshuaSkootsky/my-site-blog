---
title: "Javascript Sort"
date: 2020-11-22T12:07:42-05:00
draft: false
---

# Comparators and Javascript Native Sort - An Introduction

Javascript, like many languages, has a native sort function.


[`Array.prototype.sort()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/sort) sorts the elements of an array in place, i.e. it mutates the array that it is called on.

The default behavior of how, exactly, the resulting array can be considered 'sorted' might not be what you think it is, and the results are so non-intuitive that you should always pass a callback function, specifically a comparator, to the native Javascript `sort` array method.

Let me explain why, along with what a comparator must do and how to write a comparator function.

```javascript
// Welcome to Node.js v15.0.1.
// Type ".help" for more information.
const array = [1, 10, 2, 3, 4, 5];
const strings = ['dog', 'cat', 'bird', 'alligator'];
console.log(array.sort())
// [ 1, 10, 2, 3, 4, 5 ]
console.log(strings.sort())
// [ 'alligator', 'bird', 'cat', 'dog' ]
```

You never want to sort numbers and end up with 1, 10, 2,...

But this is what happens when you sort without providing a comparator.

The default behavior of sort is acceptable when you want to sort strings, or numbers as strings, in ascending, A-Z order. As you can see, that is what happens with the strings of pet species, the pet alligator comes first. But what if you wanted a different order, or what if you wanted to put numbers in ascending order, like you should expect a normal sort function to do?

Let's say you wanted to sort the strings in order of length.

What you should do is define a function, `callback` or `cb` or `comparator` or, I would suggest, most descriptively, given a semantic name, and pass that function as a callback to .sort(), as in `.sort(cb)`.

# What is a comparator?

This function should satisfy the definition of a comparator. When comparing any two things, there are three logical possibilities, and a comparator should define when all three of those possibilities occur:

1. Thing A is larger than Thing B
2. Thing A is equal to Thing B
3. Thing A is less than Thing B

Those are the three logical cases, and you must define all three when writing your comparator function.

Here is an example for a comparator that would sort words by length:

```javascript
function comparator(a, b) {
    // three options
    if (a.length > b.length) return 1;
    if (a.length === b.length) {
        // write new code
        // figure out what to do if length is the same
        // maybe it should be alphabetical order?
        // for now let us consider them to be equal and return 0
        return 0;
    }
    if (a.length < b.length) return -1;
}

console.log(strings.sort(comparator))
// [ 'cat', 'dog', 'bird', 'alligator' ]
```

The same would be true if you wanted to sort numbers in ascending order.

```javascript
function ascending(a, b) {
    if (a > b) return 1;
    if (a === b) return 0;
    if (a < b) return -1;
}

console.log(array.sort(ascending))
// [ 1, 2, 3, 4, 5, 10 ]
```
This `ascending` comparator gives `Array.protoype.sort` the expected behavior.

I recommend always writing comparators with good semantic names, so that people don't have to read your code in detail to understand what it does. You should also test your comparators in sorts to see if they work properly. If your comparator functons are seperate functions, it's relatively easy to export those functions and use them in tests to make sure that they behave properly. This is very similar to my advice for writing semantic reducers for the `Array.prototype.reduce` method, which you can read about [here](https://www.joshuaskootsky.com/posts/case-for-reduce/).

# A Final Note on Comparators

The concept of comparators is key to understanding all sorts that rely on comparison. Merge sort, Quick sort, Bubble sort, Heap sort all rely on comparing the value of two elements at a time. Radix sorts are not comparison based sorts, which is one reason why their time complexity is not bounded by `O(n log n)`.

You will note that the concept of a binary tree depends on comparators, specifically the ability to take two values and determine which is larger than the other.

For a binary tree `n` elements, lookup time is `O (log n)` - you will need to make one of two choices at most `log n` number of times.

To make a rough, intuitive argument, to place all the elements of an array of length n into a binary tree should therefore be `O (n * log n)` - do the work of putting each element into a binary tree, `O ( log n)` work, and to do that `n` times, for "sorting" in `O (n log n)` time.

If you have all the elements of an array in a binary tree, because you then have `O log n` lookup, that can be considered to be the same as having a sorted array, where with binary search you also have `O ( log n)` lookup.

Now, you might say - well wait a second, log base 2 makes sense, but earlier in the article, I told you to write comparators that explicitly handle all three cases! Shouldn't this all be log base 3 then?

Answer: `O (log [base 2] n) * K = O (log [base 3] n)`

As in, for some constant factor `K`, `log [base 3] (n) ` is the same as `log [base 2] (n)`, and for asymptotic big O analysis, we can just say that it's equivalent to some constant factor.

