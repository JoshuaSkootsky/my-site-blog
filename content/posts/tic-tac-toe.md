---
title: 'Tic Tac Toe - Part One'
date: 2020-10-06T10:17:35-04:00
draft: true
---

# Hello

Tic Tac Toe, a game you may fondly remember playing with pen and paper, can also be played or simulated online with a web page. I have created [a site that lets you play tic tac toe](https://TicTacToe.joshuaskootsky.repl.co) online, please check it out.

## Vanilla JS

Although tic tac toe has some rules and some state to manage, I have written the game in 'just' Javascript, CSS, and HTML. I am not done, but I'll explain how I went about doing this, and which directions I'm going to grow this into.

## Functions and State

Let's look at a section of the HTML:

```html
<div id="board"></div>
```

There's nothing here! What is this?? A CENTER FOR ANTS!? How can we expect to play tic tac toe if there's no room for people to make Xs and Os in there? The board needs to be... at least... THREE TIMES BIGGER!

That's absolutely right. What's happening here is that there is a div with a unique id, and with Javascript I'm going to make a board, manage its state, and update the display. The HTML makes no assumptions about the board, just hands off all responsibility to the Javascript.

On the other hand, my CSS has to make assumptions about what HTML my JavaScript will render. I don't see a way around that, for a visual board to work with HTML, the CSS has to know what it is styling.

## Enter the Script

[The REPL is here](https://repl.it/@JoshuaSkootsky/TicTacToe#script.js)

In my script.js file, there is some state, and quite a few functions. Let's go over how that is structured.
