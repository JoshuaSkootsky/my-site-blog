---
title: 'The Case for Reduce'
date: 2020-09-23T15:34:49-04:00
draft: false
---

Let's talk about using the JavaScript Array method reduce instead of a for-loop.

[Reduce](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/reduce) is a standard Array method, `Array.prototype.reduce`, that takes several arguments, only the first being required, a function (also known as a callback) that serves as a reducer.

Reducers can be simple, and giving names to reducer functions can make the concise code even clearer and more human friendly.

Let's do a quick example of using a simple for-loop to get something done. Consider data of the following shape:

```javascript
let items = [
  {
    itemName: 'Effective Programming Habits',
    type: 'book',
    price: 13.99,
    id: 2,
  },
  { itemName: 'MacBook Air', type: 'computer', price: 1000, id: 8 },
  {
    itemName: 'JavaScript: The Good Parts',
    type: 'book',
    price: 34.99,
    id: 64,
  },
];
```

and let us say that you want to find the name of the most expensive element of this list. You do could use a for-loop, and in JavaScript, it would look like this:

```javascript
function mostExpensiveItemName(items) {
  if (items.length < 1) return [];

  let expensive = items[0];
  for (let i = 0; i < items.length; i++) {
    if (items[i].price > expensive.price) {
      expensive = items[i];
    }
  }
  return expensive.itemName;
}
```

This would be fine. But let's see that with reduce, using some of the elements of functional programming in JavaScript:

```javascript
function mostExpensiveItemName(items) {
  if (items.length < 1) return [];
  const expensive = items.reduce((a, b) => (a.price < b.price ? a : b));
  return expensive.itemName;
}
```

This is much more concise. There is also less mental overhead. Every time you read a for-loop, you have to figure out what is going on. Reduce is going to take an array, and return something - usually the value of an element of that array.

But we can actually go farther with reduce.

```javascript
// Reduce with reducer
function mostExpensiveItemName(items) {
  if (items.length < 1) return [];
  const mostExpensive = (a, b) => (a.price > b.price ? a : b);
  const expensive = items.reduce(mostExpensive);
  return expensive.itemName;
}
```

This code explicitly defines a reducer function, giving it a semantically meaningful name. This makes intent much clearer. We can also take this reducer and test it. We could import a reducer from elsewhere in the code, or declare it here and export it so that it could be automatically tested or reused elsewhere in the codebase. It might be that this reducer ends up living in a little library somewhere in the codebase as a utility function.

Reduce takes JavaScript back to its roots as a Lisp. (JavaScript is a language whose syntax is based on Java, Lisp, and Self.) Reduce lets developers write real code that has advantages in terms of clarity, concision, and testability. You can test the logic of what used to be a for loop!

Especially given the rising popularity and understanding of functional programming within the professional software community, there's a strong case that your fellow team members will have an easier time understanding code that uses this 'more advanced' feature of JavaScript.

[Connect with me on LinkedIn!](https://www.linkedin.com/in/joshua-skootsky/)

_This article can also be found [on LinkedIn](https://www.linkedin.com/pulse/case-reduce-joshua-skootsky/)_
