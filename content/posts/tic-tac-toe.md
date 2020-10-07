---
title: 'Tic Tac Toe - Part One'
date: 2020-10-06T10:17:35-04:00
draft: false
---

# Hello

Tic Tac Toe, a game you may fondly remember playing with pen and paper, can also be played or simulated online with a web page. I have created [a site that lets you play tic tac toe](https://TicTacToe.joshuaskootsky.repl.co) online, please check it out.

[The REPL is here](https://repl.it/@JoshuaSkootsky/TicTacToe#script.js)

## Enter the Script

In my script.js file, there is some state, and quite a few functions. Let's go over how that is structured.

## Functions and State

Let's look at the HTML for the board:

```html
<div id="board"></div>
```

There's nothing here! What is this?? A CENTER FOR ANTS!? How can we expect to play tic tac toe if there's no room for people to make Xs and Os in there? The board needs to be... at least... THREE TIMES BIGGER!

That's absolutely right. What's happening here is that there is a div with a unique id, and with Javascript I'm going to make a board, manage its state, and update the display. The HTML makes no assumptions about the board, just hands off all responsibility to the Javascript.

On the other hand, my CSS has to make assumptions about what HTML my JavaScript will render. I don't see a way around that, for a visual board to work with HTML, the CSS has to know what it is styling.

In my Javascript, there is a makeBoard function. Within that function, I generate the HTML to represent the board with the game state of Xs and Os. This line then assigns that HTML to the #board div.

```javascript
document.getElementById('board').innerHTML = board;
```

### State

The code depends on a global variable that holds the state of the board. State isn't a bad thing, the question is how to manage the state and use it effectively to coordinate the program.

My state variable is an array of all board states. This single source of truth allows me to 'take a move back' by simply popping off the most recent move, like so:

```javascript
function takeBack(STATE) {
  if (STATE.length > 1) STATE.pop();
  makeBoard(STATE);
}
```

There is a problem with this approach. My STATE variable represents the game state, but does not display the game state. By updating state, I don't update the view being rendered and displayed on the actual web page.

I have separated that concern out to the makeBoard function. makeBoard consumes my STATE as a parameter and as a side effect, makes the necessary changes to the DOM to display the updated board.

This level of abstraction allows two things. One, the correct view to display, as a function of state, can always be updated by simply calling makeBoard. Two, I'm not dependent on showing the Xs and Os as HTML - I could show images instead, or draw an SVG. The game logic, or model, is separate from the display or view logic of my Javascript.

So, to 'reset' the board, I just remove all but the first element in my STATE array, and then remake the board.

```javascript
function reset(state) {
  while (state.length > 1) {
    state.pop();
  }
  makeBoard(state);
}
```

An alternative approach would be to to reassign the global state variable. However, I've chosen to initialize STATE as a constant with const, which prevents reassignment. This makes sense if I only want the state to be changed by either pushing new valid board states or popping old ones off. Since STATE can only be as long as there are turns in a game, there isn't much to worry about calling pop 1 to 9 times to reset a single game. If for some reason STATE could get very long, it would be nice to be able to reassign the variable to the initial state.

## Derived State

Because there is only one global variable, you might wonder how other state is known through the program.

Examples:

- Whose turn is it, X or O?
- Who won?
- Can I make another move?
- If I take back a move or reset, how are those values updated?

To figure out if the next move should be an X or an O, I just measure the length of my state array. I start with an initial length of 1, where it should start with X, and then after that it should alternate. Instead of a boolean variable isXNext, I have a function that calculates this as a function of the state.

```javascript
function isXNext(state) {
  return state.length % 2 === 1;
}
```

This allows arbitrary time travel without confusion about whose turn it is.

Furthermore, I only want to allow moves to be made if no one has won yet. I could have a 'won' variable, and update that if someone wins. But it turned out easier to just put into the code a logical test to see if someone has already won.

```javascript
calculateWinner(getCurrent(STATE)) === false;
```

This allowed me to delete code in other places that managed a global 'won' variable and updated it appropriately. This also is less likely to have bugs, because there is no complicated state that could be stale or not yet updated lying around in my Javascript.

## Componentization of Vanilla JS

Initially, the 3x3 grid was hardcoded as a template literal.

```javascript
const board = `<div class="parent">
  <h2>Tic-Tac-Toe</h2>
  <div class="children">
    <div id="box_0" class="box">${current[0]}</div>
    <div id="box_1" class="box">${current[1]}</div>
    <div id="box_2" class="box">${current[2]}</div>
    // ETC
    // ETC ...
```

If in the future I wanted to make it an NxN board, or allow people to play Connect 4, I'd have to abstract this out. Plus this violates the DRY principle, in addition to being "ugly" according to certain principles of coding aesthetics.

Instead, each little box's HTML can be generated with a componetized boxMaker:

```javascript
function boxMaker(value, id) {
  return `<div id="box_${id}" class="box"> ${value} </div>`;
}
```

This box maker can be composed within another function that makes an array of boxes based on the game state passed in:

```javascript
function boxesHTMLMaker(array) {
  const boxesHTML = array.map((value, id) => boxMaker(value, id)).join('');
  return boxesHTML;
}
```

Note the use of array.map, which returns an array from the passed in array, and the use of .join('') method to join the array into a single string of HTML generated from the boxMaker function.

Here is how all the pieces fit together in makeBoard:

### makeBoard

```javascript
function makeBoard(state) {
  const currentState = getCurrent(state);

  const board = `<div class="parent">
  <h2>Tic-Tac-Toe</h2>
  <div class="children">
    ${boxesHTMLMaker(currentState)}
  </div>
</div>`;

  document.getElementById('board').innerHTML = board;
}
```
