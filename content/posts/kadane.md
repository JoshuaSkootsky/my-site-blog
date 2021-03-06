---
title: "Kadane's Algorithm"
date: 2020-10-15T19:07:08-04:00
draft: false;
---

A short history of Kadane's Algorithm:

Ulf Grenander in 1977 proposed the problem of finding the maximum subarray of an array. Note that if all numbers allowed are positive, the question is trivial - just add them all up! It gets hard if the numbers can be negative. How can this question be solved?

Grenander improved on the brute force algorithm, which would have been cubic `O^3`, and found an algorithm that solves the maximum subarray sum question in quadradic time, an `O^2` solution.

Later, Michael Shamos found a further refinement, an `O(n log n)` solution, based on divide and conquer / binary search.

Michael (presumably feeling very good about himself) then presented his algorithm at Carnegie Mellon University (CMU), where a professor of statistics, Jay Kadane, attended his talk, and in just one minute, from the audience, devised a linear `O(n)` solution, which bears his name. This is THE solution to the subarray sum problem, Kadane's Algorithm.

Let's look at Kadane's algorithm:

```javascript
/*
 * @param array: number  can be negative
 * @return : number  the sum of the maximum sub array
 */
function maxSubarray(array) {
  if (array.length === 0) return 0;

  let maxSum = 0;
  let currSum = 0;

  for (let i = 0; i < array.length; i++) {
    const elem = array[i];
    currSum = Math.max(0, currSum + elem);
    maxSum = Math.max(maxSum, currSum);
  }

  return maxSum;
}
```

Kadane's algorithm uses two variables to store the largest sum of continuous elemetns seen so far in `currSum`, and stores the largest value of `currSum` ever seen in `maxSum`. With this small (constant! `O(1)` time!) amount of memory usage, the algorithm's Big O runtime can be brought down from `O (n log n)` to `O (n)`.

Here is the same approach, but using forEach instead:

```javascript
/*
 * @param array: number
 * @return  the maximum subarray sum of array
 */
const maxSubarray = (array) => {
  let maxSum = 0;
  let currSum = 0;
  arr.forEach((num) => {
    currSum = Math.max(num + currSum, 0);
    maxSum = Math.max(maxSum, currSum);
  });
  return maxSum;
};
```

Interestingly, if you wanted to use reduce for this, you could run into some interesting bugs. One approach that has a subtle bug is the following code, which does not work:

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

This is similar to the pattern you would use if you wanted to use reduce to calculate two different values in one pass. The huge problem is that when currSum updates itself, the maxSum can't update itself, since they are both values nested in an object. This could be worked around, but I think the pitfall is more interesting to point out than the work around.

This, however, would work - but also make your brain hurt. However, it is elegant in the sense that it's a purely functional approach using reduce, despite the pitfall that I described, and the extra level of complexity:

```javascript
/*
 * @param array: number
 * @return  the maximum subarray sum of array
 */
const maxSubarray = (array) => {
  const findMaxSum = (acc, elem) => ({
    currSum: Math.max(0, acc.currSum + elem),
    maxSum: Math.max(acc.currSum + elem, acc.maxSum),
  });

  const init = { currSum: 0, maxSum: 0 };
  const maxSum = array.reduce(findMaxSum, init).maxSum;
  return maxSum;
};
```

For completeness' sake, here is a solution that uses Javascript reduce with less complexity, but due to the use of external state, it's kind of like abuse of reduce:

```javascript
const maxSubarray = (array) => {
  let currSum = 0;
  const reducer = (maxSum, num) => {
    currSum = Math.max(currSum + num, 0);
    return Math.max(currSum, maxSum);
  };

  return array.reduce(reducer, 0);
};
```

We could rewrite that using a closure:

```javascript
const maxSubarray = (array) => {
  const makeReducer = () => {
    let currSum = 0;
    return (maxSum, num) => {
      currSum = Math.max(currSum + num, 0);
      return Math.max(currSum, maxSum);
    };
  };

  return array.reduce(makeReducer(), 0);
};
```

It's pretty cool, but the forEach solution is still more direct than trying to shoehorn reduce into this.
