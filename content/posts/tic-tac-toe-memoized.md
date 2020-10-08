---
title: 'Tic Tac Toe Memoized'
date: 2020-10-08T13:06:28-04:00
draft: false
---

# Intro to Part 2 - Memoization and Calculation

Hello!

This is Part 2 of a series on building a Tic Tac Toe game in Vanilla Javascript. [Part 1 is here](https://www.joshuaskootsky.com/posts/tic-tac-toe/)

Originally, my tic tac toe game had the winning board positions as a static value. Today I'll walk you through the process of how I calculated those values on the fly, and memoized the results to prevent unnecessary work being done in my code.

# Win Condition

Originally, this project used a precalculated collection of boxes to check if something was a win or not.

On the `win-condition` branch, I'm trying out a simple way of checking for a win that isn't as hard coded, as part of keeping things generic and being able to make it potentially a larger board or Connect Four.

Specifically, to calculate the winner, this is how I examine the state and return the winning value or false:

```javascript
function calculateWinner(squares) {
  const lines = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  for (let i = 0; i < lines.length; i++) {
    const [a, b, c] = lines[i];
    if (
      (squares[a] === 'X' || squares[a] === 'O') &&
      squares[a] === squares[b] &&
      squares[a] === squares[c]
    ) {
      return squares[a];
    }
  }
  return false;
}
```

Originally I was pretty confused about how to do this. I was thinking of using something like [flood fill](https://en.wikipedia.org/wiki/Flood_fill) or [Quick Fill](https://www.codeproject.com/Articles/6017/QuickFill-An-Efficient-Flood-Fill-Algorithm). This kind of more complicated search algorithm might be good for a different kind of game, but not `n x n` Tic Tac Toe.

One way of doing this is to ask, "If I wasn't given the array of arrays `lines`, how would I calculate it?" The plan being to take the knowledge that I'm dealing with an `n x n` box, and to calculate the indicies of the `n` rows, `n` columns, and two diagonals. This calculation can be done just once, and the result of the calculation can be consulted to check the board if there is a winner.

Okay, so `[[0, 1, 2],[3, 4, 5],[6, 7, 8]]` we can get them by going every `n` steps and adding the next `n` elements to the array.

As in:

```javascript
const N = 3;
const indexedArray = new Array(N * N).fill(0).map((e, i) => i);
// [0, 1, 2, 3, 4, 5, 6, 7, 8]

const horizontalLines = horizontalLineGen(N);
```

```javascript
function horizontalLineGen(N) {
  const result = [];
  for (let i = 0; i < N * N; i += N) {
    const line = [];
    for (let j = i; j < i + N; j++) {
      const idx = j; // or indexedArray[j];
      line.push(idx);
    }
    result.push(line);
  }
  return result;
}
```

and hey, that works!

```javascript
> horizontalLineGen(4)
[
  [ 0, 1, 2, 3 ],
  [ 4, 5, 6, 7 ],
  [ 8, 9, 10, 11 ],
  [ 12, 13, 14, 15 ]
]
```

Okay, let's generate the vertical lines

```javascript
function verticalLineGen(N) {
  const result = [];
  for (let i = 0; i < N; i++) {
    const line = [];
    for (let j = i; j < N * N; j += N) {
      line.push(j);
    }
    result.push(line);
  }
  return result;
}

> verticalLineGen(3)
[ [ 0, 3, 6 ], [ 1, 4, 7 ], [ 2, 5, 8 ] ]

> verticalLineGen(4)
[
  [ 0, 4, 8, 12 ],
  [ 1, 5, 9, 13 ],
  [ 2, 6, 10, 14 ],
  [ 3, 7, 11, 15 ]
]
```

Okay that seems about right.

```javascript
function diagonalLineGen(N) {
  const result = [];
  // make left to right diagonal
  const left = []
  for (let i = 0; i < N * N; i += 1 + N) {
    left.push(i);
  }
  // make right to left diagonal
  const right = [];
  for (let i = N - 1; i < N * N - 1; i += N - 1) {
    right.push(i);
  }
  result.push(left, right);
  return result;
}

> diagonalLineGen(3)
[ [ 0, 4, 8 ], [ 2, 4, 6 ] ]

> diagonalLineGen(4)
[ [ 0, 5, 10, 15 ], [ 3, 6, 9, 12 ] ]

```

Okay so now I'll combine those three functions.

```javascript
function lineGen(N) {
  const result = [... diagonalLineGen(N),
                  ... verticalLineGen(N),
                  ... horizontalLineGen(N) ]
  return result;
}

> lineGen(3)
[
  [ 0, 4, 8 ],
  [ 2, 4, 6 ],
  [ 0, 3, 6 ],
  [ 1, 4, 7 ],
  [ 2, 5, 8 ],
  [ 0, 1, 2 ],
  [ 3, 4, 5 ],
  [ 6, 7, 8 ]
]
```

# Putting the Pieces Together

The function `calculateWinner` needs to take the lines from `lineGen` and check to see if any of them all match with an X or an O.

For this, I ended up using the array methods `.forEach` and `.every`.

```javascript
const lines = lineGen(3); // let's say N = 3

/* OLD CODE:

  for (let i = 0; i < lines.length; i++) {
    const [a, b, c] = lines[i];
    if ( (squares[a] === 'X' || squares[a] === 'O')
          && squares[a] === squares[b]
          && squares[a] === squares[c]) {
      return squares[a];
    }
  }
  return false;
*/
  ////////////////
  // NEW CODE:
  // squares in scope
  let winner = false;
  lines.forEach(line =>  {
    if (line.every(e => squares[e] === 'O')) winner = 'O';
    if (line.every(e => squares[e] ===  'X')) winner = 'X';
  }
  return winner;

```

# calculateWinner

So the new calculateWinner will depend on three functions, which are wrapped into `lineGen`, and look like this:

```javascript
function calculateWinner(squares) {
  const lines = lineGen(Math.sqrt(squares.length));

  let winner = false;
  lines.forEach((line) => {
    if (line.every((e) => squares[e] === 'O')) winner = 'O';
    if (line.every((e) => squares[e] === 'X')) winner = 'X';
  });
  return winner;
}
```

This works. However, note something a little interesting - we're recomputing the lines every time we calculate the winner. Since this happens every move, and we aren't changing the size of the board, this isn't necessary. It'd be nice to precompute the lines. I put a console log into lineGen and saw that it was actually calculating the lines twice per move, since the game checks before each move to see if someone has already won, and checks after a move to see if it should display if someone won. So, there's a lot of work to be saved by caching the results.

One way to cache results would be to make my line generator aware of previous work that it did. The most general approach is to write a memoize function that consumes as a callback, `cb`, the unmemoized function, used a closure to store the memoized cache, and returns a new function that is aware of previous times it was calls and remembers what results it returned.

```javascript
function memoize(cb) {
  const memo = {};
  return function memoized(n) {
    if (memo[n] !== undefined) {
      console.log('Reading memo...');
      return memo[n];
    }
    else {
      console.log('recalculating...');
    } return memo[n] = cb(n);
  }
}


//// using my memoize function
function unmemolineGen(N) {
  const result = [... diagonalLineGen(N),
                  ... verticalLineGen(N),
                  ... horizontalLineGen(N) ]
  return result;
}
const lineGen = memoize(unmemolineGen);

>
recalculating...
Reading memo...
Reading memo...
Reading memo...
Reading memo...
Reading memo...
Reading memo...
```

So it works, it isn't repeating work, and it's reading from the memoized cache. Great! The next steps would be using this refactor to actually rewrite the code to play games like 4 x 4 Tic Tac Toe.

In the mean time, taking my code and making the 'results' or winning line combinations get generated from the dimensions of the board gave me the flexibility to adapt to N x N Tic Tac Toe in the future, and ended up be a good application of memoization.
