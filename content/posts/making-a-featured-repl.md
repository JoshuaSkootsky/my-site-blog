---
title: 'Alien Name Generator: Making a Featured Repl'
date: 2020-11-01T17:25:38-05:00
draft: false
---

# Making a Featured REPL

[REPL.it](https://repl.it/) makes it easy to set up programming environments and share them with other people.

I made a REPL for an [Alien Name Generator](https://repl.it/@JoshuaSkootsky/Reactive-Alien-Name-Generator), which you can see, or just visit the website [here](https://Reactive-Alien-Name-Generator.joshuaskootsky.repl.co).

This REPL was created with the help of the community's feedback. For example, [multiple users](https://repl.it/talk/share/This-is-amazing-You-know-what-would-be/55665/289901) suggested adding the ability to translate [back from "alien" language to English](https://repl.it/talk/share/Screen-Shot-2020-10-01-at-41619-PM/55665/288848). I added that feature in response to user feedback.

For the most part, on LinkedIn and on Repl.it, people were genuinely delighted by typing English into a text field and seeing, reactively, a translation of their name into an alien language. A huge number of the comments were from users sharing "their" alien name.

I believe this is because names are extremely personal, but I also don't think this would have happened if the translation wasn't done reactively. If users had to submit or be redirected to another webpage, that level of friction or just waiting would have reduced the sheer fun of seeing a "live" translation of their personal name.

Having functional Javascript run on every keystroke to update and rewrite the HTML that displays the name gave the project that level of reactivity, which I was able to do in plain vanilla Javascript. I didn't need a framework to build this site or put it in front of users.

Because of the high level of engagement, this REPL was [featured for September 2020](https://repl.it/talk/announcements/Monthly-Repls-September-2020/57347). That's a real honor, to be recognized by the community for creating something significant on a website dedicated to sharing coding projects, and I wear that badge with pride.

The website uses similar Vanilla JS event handling and functional programming principles as my REPl for Tic Tac Toe, which you can read more about [here](https://www.joshuaskootsky.com/posts/tic-tac-toe/) and [here](https://www.joshuaskootsky.com/posts/tic-tac-toe-memoized).

## In the Code

Part of the fun of the alien name generator is that each letter in English corresponds to an array of "alien" language characters. An element of that array is randomly chosen. To do that choosing, I wrote a function `chooseRandom` that itself depended on a function that generated an integer between `0` and `n - 1`, the valid indexes of an array with a length of `n`. I broke this into two functions to make the semantic meaning of the code easier to comprehend and understand.

```javascript
function chooseRandom(array) {
  const max = array.length;
  return array[getRandomInt(max)];
}

function getRandomInt(max) {
  return Math.floor(Math.random() * Math.floor(max));
}
```

The function `alienNameMaker` takes a string and an encoder mapping, and from that generates a 'translation' into alien. This function uses the previously defined `chooseRandom` function.

```javascript
function alienNameMaker(name, encoder) {
  // given a name string
  // encode it into alien name with the encoder mapping
  let alienName = '';
  for (let i = 0; i < name.length; i++) {
    const char = name[i].toLowerCase();

    const alienCharArray = encoder[char];
    // this char array may be undefined. if not truthy, skip it
    if (alienCharArray) {
      const alienChar = chooseRandom(alienCharArray);
      alienName = alienName + alienChar;
    }
  }
  return alienName;
}
```

More complex is the task of translating an alien name back into English. First, I wanted to do this programatically, which is to say, I wanted to generate my decoder from my encoder.

```javascript
const decoder = makeDecoder(encoder);
```

I wanted to make a decoder in a function that accepted an alien name and the encoder. When my encoder changed (and I did make changes), I didn't want to have to edit a separate file to make the two mapping match.

```javascript
function makeDecoderUnMemo(encoding) {
  const decoder = {};
  console.log('Making decoder...');
  for (const letter in encoding) {
    const arr = encoding[letter];
    arr.forEach((alienWord) => {
      decoder[alienWord] = letter;
    });
  }
  return decoder;
}
```

To do this, I made an empty object, the decoder, and then dutifully mapped, for each letter in the encoding, each alien word to its associated letter.

I then had a new problem: this process of making the reverse mapping would run each time I tried to decode a word, and that would be unnecessary, repeated work.

I solved that by using a memoized function:

```javascript
// I can memoize this
const makeDecoder = memoize(makeDecoderUnMemo);

function memoize(cb) {
  const memo = {};
  return function memoized(n) {
    if (memo[n] !== undefined) {
      return memo[n];
    }
    return (memo[n] = cb(n));
  };
}
```

My function memoize can take any cb function that takes one argument n and returns a memoized version of that function. The returned function behaves like the original function cb, except it consults a memo that lives in the closure of the function memoize that was invoked with cb as an argument. This persistant lexical scope reference data (PLSRD) gives the memoized function a private memo that can remember previous results, and instead of running the original function again, work can be saved by simply returned the cached value.

Doing the actual decoding is harder, because alien name tokens, in alien language, can be multiple characters. Therefore, the solution was to build up possible tokens dynamically, and check those possible tokens against the decoding mapping.

```javascript
function alienNameDecoder(alienName, encoder) {
  let humanName = '';
  const decoder = makeDecoder(encoder);
  for (let i = 0; i < alienName.length; i++) {
    // need to fuzz this dynamically
    let alienLetter = alienName[i];
    let humanLetter = decoder[alienLetter];
    if (humanLetter) {
      humanName += humanLetter;
    } else {
      while (!humanLetter && i < alienName.length) {
        alienLetter += alienName[++i];
        if (decoder[alienLetter]) {
          humanLetter = decoder[alienLetter];
          humanName += humanLetter;
        }
      }
    }
  }
  return humanName;
}
```

This might not be the clearest code, but it is a clear reflection of a thought process that solved the problem. The intent is very clear, and I'm still too attached to the code to make it look like I knew what I was doing before I did it.
