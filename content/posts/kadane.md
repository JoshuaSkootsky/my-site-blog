---
title: "Kadane's Algorithm"
date: 2020-10-15T19:07:08-04:00
draft: true
---

A short history of Kadane's Algorithm:

Ulf Grenander in 1997 proposes the problem of finding the maximum subarray of an array. If all numbers allowed are positive, the question is trivial - just add them all up! It gets hard if the numbers can be negative. How do?

Grenander improves on the brute force algorithm, which would have been cubic `O^3`, and finds a quadradic `O^2` solution.

Michael Shamos improves this and finds an `O(n log n)` solution, using divide and conquer / binary search.

Michael, feeling very good about himself, presents his algorithm at Carnegie Mellon University (CMU), where a professor of statistics, Jay Kadane, attends the talk, and from the audience, in one minute, devises a linear `O(n)` solution, which bears his name.

How is this possible?

Let's look at Kadane's algorithm and see:

```javascript
/*
 * @param array: number  can be negative
 * @return : number  the sum of the maximum sub array
 */
function maxSubarray(array) {
  if (array.length === 0) return 0;

  let maxSum = array[0];
  let currSum = array[0];

  for (let i = 0; i < array.length; i++) {
    const elem = array[i];
    currSum = Math.max(0, currSum + elem);
    maxSum = Math.max(maxSum, currSum);
  }

  return maxSum;
}
```

Kadane's algorithm uses two variables to store the largest sum of continuous elemetns seen so far in `currSum`, and stores the largest value of `currSum` ever seen in `maxSum`. With this small amount of memory usage, the algorithm's Big O runtime can be brought down from `O (n log n)` to `O (n)`.

This can also be done with a functional approach by defining a reducer function carefully.

```javascript
const maxSubarray = (array) => {
  const findMaxSum = (acc, elem) => ({
    currSum: Math.max(0, acc.currSum + elem),
    maxSum: Math.max(acc.currSum, acc.maxSum),
  });

  return array.reduce(findMaxSum, init).maxSum;
};
```

This is similar to the pattern you would use if you wanted to use reduce to calculate two different values in one pass.
