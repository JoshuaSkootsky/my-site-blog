---
title: 'Rothe Diagrams and Visualization'
date: 2020-10-22T16:33:49-04:00
draft: true
---

# Rothe Diagrams

We can visualize inversions with Rothe diagrams.

Input anything into the field, and I'll make a Rothe diagram visualization for you as a dynamically generated SVG.

### Heinrich August Rothe (1773–1842)

Rothe was a German mathematician who studied and advanced the field of combinatorics.

At 20 years old, in 1793, he wrote on what became the [Rothe-Hagen Identity](https://en.wikipedia.org/wiki/Rothe%E2%80%93Hagen_identity) as part of his thesis.

> In the study of permutations, Rothe was the first to define the inverse of a permutation, in 1800. He developed a technique for visualizing permutations now known as a Rothe diagram, a square table that has a dot in each cell _(i,j)_ for which the permutation maps position _i_ to position _j_ and a cross in each cell _(i,j)_ for which there is a dot later in row i and another dot later in column _j_. [(Wikipedia)](https://en.wikipedia.org/wiki/Heinrich_August_Rothe)

# Inversions

What is the inverse of a permutation?

Okay, so let's say you have the numbers 1, 2, 3, 4, and 5. How many ways are there of arranging those numbers?

Answer: for a set of n elements, there are n! permutations. So here n = 5, and there are 5! or 120 ways of arranging those five numbers.

What would be an inversion?

> An inversion of a permutation σ is a pair _(i,j)_ of positions where the entries of a permutation are in the opposite order: _i < j_ and _σ_i > σ_j_. So a descent is just an inversion at two adjacent positions. For example, the permutation σ = 23154 has three inversions: (1,3), (2,3), (4,5), for the pairs of entries (2,1), (3,1), (5,4). [(Wikipedia)](https://en.wikipedia.org/wiki/Permutation)

So, we can view an ordered list of unique elements as having indicies, and we can think it is funny or interesting when the index of element _i_ is greater than that of the index of element _j_ (i.e. _σ_i > σ_j_ ) but, at the same time, _i < j_.

So if instead of _12345_ , we had _12354_, there would be one inversion, _5 > 4_, five is less than 4, yet in that permutation, the index of 5 was less than the index of 4.

# So What is a Rothe Diagram?

Okay great, hopefully you've played with the visualizer.
