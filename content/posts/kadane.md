---
title: "Kadane's Algorithm and A Functional Approach"
date: 2020-10-15T19:07:08-04:00
draft: false;
---

A short history of Kadane's Algorithm:

Ulf Grenander in 1997 proposes the problem of finding the maximum subarray of an array. If all numbers allowed are positive, the question is trivial - just add them all up! It gets hard if the numbers can be negative. How do?

Grenander then improved on the brute force algorithm, which would have been cubic `O^3`, and found a quadradic `O^2` solution.

Later, Michael Shamos found a further refinement, an `O(n log n)` solution, based on divide and conquer / binary search.

Michael (presumably feeling very good about himself) then presented his algorithm at Carnegie Mellon University (CMU), where a professor of statistics, Jay Kadane, attended his talk, andin one minute, from the audience, devised a linear `O(n)` solution, which bears his name. This is THE solution to the subarray sum problem, Kadane's Algorithm.

Let's look at Kadane's algorithm:

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
/*
 * @param array: number
 * @return  the maximum subarray sum of array
 */
const maxSubarray = (array) => {
  const findMaxSum = (acc, elem) => ({
    currSum: Math.max(0, acc.currSum + elem),
    maxSum: Math.max(acc.currSum, acc.maxSum),
  });

  const init = { currSum: 0, maxSum: 0 };
  const maxSum = array.reduce(findMaxSum, init).maxSum;
  return maxSum;
};
```

This is similar to the pattern you would use if you wanted to use reduce to calculate two different values in one pass.
