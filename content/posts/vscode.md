---
title: 'VC Code Extensions'
date: 2021-01-27T17:13:18-05:00
draft: false
---

# VS Code Extensions for Javascript and Web Development

I've been using VS Code for web development for a year. Along the way, some extensions have been really useful, and I'd like to catalogue that.

Obviously, you might find some other extensions that you think are really useful, especially if you're using other languages or other frameworks. This is a mostly JavaScript list, based on what I've used and had a good experience with.

If you're using Python, then installing an extension that formats and lints your Python code is important. I have thoughts about the Python ecosystem, but I'd be silly to share them right now because most likely things are really different in 2021 than they were the last time I was trying to get things done in Python

## Bracket Pair Colorizer

I have installed [Bracker Pair Colorizer](https://marketplace.visualstudio.com/items?itemName=CoenraadS.bracket-pair-colorizer 'Bracket Pair Colorizer'). I heard that there is also a [Bracket Pair Colorizer 2.0](https://marketplace.visualstudio.com/items?itemName=CoenraadS.bracket-pair-colorizer-2), which presumably is newer and better.

Here is what it does, which makes lining up brackets ({[]}) across multiple lines much easier:

![Example image](/colorized-brackets.png)

## Spellchecker

In the above image, you will see that the function onceify has a little squiggle underneath. It's subtle, but that's produced by a simple spell checker extension I installed into VS Code.

You don't have to make very many bugs due to misspelling things before you start turning to software that can help you make fewer mistakes. In the same way I run a linter and formatter on my code, I also run a spellchecker on it. Check out the extension [here](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker).

## Git Lens and Git History

[Git Lens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens) displays the git history. It's a subtle contextual clue about what is going on, when was this code written, what was the commit message that came along with the code being committed. Another extension is [Git History](https://marketplace.visualstudio.com/items?itemName=donjayamanne.githistory).

## Vetur

[Vetur](https://marketplace.visualstudio.com/items?itemName=octref.vetur) gets a shout out because it really changes how Vue can be used. It's the only framework specific extension I'm putting on this list because you need Vetur if you're writing Vue in VS Code, for syntax highlighting and making sense of the project.

## Prettier

Install [Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode) as an Extension. Then drop a .prettierrc file at the root of your projects to configure the rules for Prettier.

```yaml
// .prettierrc
singleQuote: true
trailingComma: es5
bracketSpacing: true
semi: true
```

You can also turn on an option to run Prettier on save, not just when you want to run it through the Format command.

Go into the JSON Settings of VS Code:

```json
"[javascript]": {
       "editor.defaultFormatter": "esbenp.prettier-vscode"
   },
   "editor.formatOnSave": true,
```

and make sure `"editor.formatOnSave": true,` is there.

and you should be off to the races! Please let me know on LinkedIn or email about extensions that you are using and really like.
