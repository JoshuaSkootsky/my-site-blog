---
title: "Scripting in Shell and Node"
date: 2020-11-20T12:18:26-05:00
draft: false
---

# Scripting in Shell and Node

I love what I usually call Bash shell scripting, although I think what I really like are POSIX standard shell scripts, Bash is just a specific version of shell with some extensions.

Here's an example of script that might be useful:

```shell
#/parent/childOne/example.sh
# Usage: sh example.sh

echo "making directories..."

DIR_NAME="Project Coolio" #note: no space

mkdir -p ../"$DIR_NAME"/mycompany/{OSX,Windows}/debug

echo 5221 > ../"$DIR_NAME"/mycompany/log.id
```

Let's say this script lives in /parent/childOne/, at ~/parent/childOne/example.sh. This script makes a sibling directory in ~/parent/Project Coolio/ with subdirectories, and writes to a file in one of those subdirectories.

That can be very useful.

One issue with shell scripts is that they work great in Linux and Mac envrionments, but not so great in Windows.

However, do you know what you might have installed in Windows? Node.js. And if you have Node.js, then you should be able to do anything on any system with Node.js installed.

Off the bat, you've got two options:

1. Write a translation of your shell script (which might already exist as .sh file) into Node.js

2. Write a Shell to Node.js compiler

3. Run your existing Shell script in Node.

Let's do a brief overview of these approaches before detailing #3, which is the easiest and most elegant approach I would like to highlight.

## Translation

```javascript

const fs = require("fs");

const errorHandler = ( err ) => err ? console.log(err) : console.log("Success!")

fs.mkdir("./Cool Project", errorHandler);

// note: recursive file generation, like fs.mkdir("./Cool Project/mycompany/OSX"
// is not supported on Windows

fs.writeFile("./Cool Project/special.id", "521","utf-8", errorHandler)

```
With fs, it's possible to make directories and write to files. Node can do that natively. Unfortunately, the useful behavior of `mkdir -p` can't be done with vanilla Node.js in Windows.

So, we need to move on:

## Writing an AST and Compiler

It seems like writing a real Bash parser is hard.

Actually making a full AST for shell seems hard.

[https://www.oilshell.org/blog/2019/02/07.html]

[https://www.oilshell.org/blog/2017/02/11.html]

[https://aosabook.org/en/bash.html]

[https://mywiki.wooledge.org/BashParser]

But this could be done. The problem here is that if writing your own vanilla Node version seems difficult, how can your plan be to automatically write a Vanilla Node solution?

## Built In Node Capabilities

child_process is a powerful wrapper on Node.js. 



```javascript
const { exec } = require('child_process');
```
[https://medium.com/stackfame/how-to-run-shell-script-file-or-command-using-nodejs-b9f2455cb6b7]
[https://stackfame.com/run-shell-script-file-or-command-nodejs]

child_process is really strong inbuilt Node capability of running shell scripts.

Take a look at this:

```javascript
/*  /parent/childOne/example.js
 *  Usage: node example.js
 *
 * Should have same behavior as example.sh
 * this is a node script
 * https://stackoverflow.com/a/44667294
 * usage: node <nameOfThisFile>
 */
console.log('hello')

const FILE_NAME = 'example.sh'

const { exec } = require('child_process');
exec('sh ' + FILE_NAME, (error, stdout, stderr) => {
         console.log(stdout);
         console.log(stderr);
         if (error !== null) {
             console.log(`exec error: ${error}`);
          }
  });
```
This script will read the shell script next door, and then execute it as a child process with a shell environment.

Does this work on Windows?

I have a virtual Windows machine, running Windows 10, with Bash for Git (for Windows) installed. This means some basic shell commands are supported by the default command prompt in Windows. Let's see if this works:


