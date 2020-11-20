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

DIR_NAME="Project Coolio" #note the space, this makes life hard

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

// note: recursive file generation, 
// like fs.mkdir("./Cool Project/mycompany/OSX"
// is not supported on Windows

fs.writeFile("./Cool Project/special.id", "521","utf-8", errorHandler)

```
With fs, it's possible to make directories and write to files. Node can do that natively. Unfortunately, the useful behavior of `mkdir -p` can't be done with vanilla Node.js in Windows.

So, we need to move on.

## Writing an AST and Compiler

It seems like writing a real Bash parser is hard.

Actually making a full AST for shell seems hard.

[https://www.oilshell.org/blog/2019/02/07.html](https://www.oilshell.org/blog/2019/02/07.html)

[https://www.oilshell.org/blog/2017/02/11.html](https://www.oilshell.org/blog/2017/02/11.html)

[https://aosabook.org/en/bash.html](https://aosabook.org/en/bash.html)

[https://mywiki.wooledge.org/BashParser](https://mywiki.wooledge.org/BashParser)

But this could be done. The problem here is that if writing your own vanilla Node version seems difficult, how can your plan be to automatically write a Vanilla Node solution?

## Built In Node Capabilities

child_process is a powerful wrapper on Node.js. 


```javascript
const { exec } = require('child_process');
```
[https://medium.com/stackfame/how-to-run-shell-script-file-or-command-using-nodejs-b9f2455cb6b7](https://stackfame.com/run-shell-script-file-or-command-nodejs)

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

Does this work on Windows? It's important to test ideas out.

I have a virtual Windows machine, running Windows 10, with Git Bash (for Windows) installed. This means some basic shell commands are supported by the default command prompt in Windows. Let's see if this works.

Open up command prompt in Windows, use `dir` instead of `ls`, and `cd` and `mkdir` around the command propmp. `> notepad fileName` to open up and write new files... and my `example.js` file fails.

Why? Because it depends on `sh`, which doesn't exist by in the Windows Command Prompt. You can even see in `example.js` where it calls `sh example.sh`.

Well then. Let us try it Git Bash (for Windows), which is installed on my machine. You might also try the Linux subsystem.

Simplest way is to navigate in Command Prompt to my source code directory, and then there execute the command, "C:\Program Files\Git\bin\sh.exe".

and then I am able to run `example.sh` directly.

So, so far, it's all gone back to the POSIX standard for a shell and shell commands. This is one reason it's important to have standards, and be explicit about what you depend on. It's also a good thing that "the shell" is moving to Windows.

# True Cross Platform Performance

Keeping in the mind the limitations of vanilla Node's mkdir command in Windows, we have the option of writing vanilla Node.js that will run on both Windows and Mac/Linux systems. This is useful because it's really easy to install Node.js onto Windows. So it would be nice to have a solution that 'just worked' if Node.js was installed:

```javascript
// Take two:
// example2.js
// Usage: node vanilla2.js

const fs = require("fs")
const errorHandler = ( err ) => err ? console.log(err) : console.log("Success!")
const DIR_NAME="Project Coolio"

fs.mkdir(`../${DIR_NAME}`, errorHandler);
fs.mkdir(`../${DIR_NAME}/mycompany`, errorHandler);
fs.mkdir(`../${DIR_NAME}/mycompany/OSX`, errorHandler);
fs.mkdir(`../${DIR_NAME}/mycompany/OSX/debug`, errorHandler);
fs.mkdir(`../${DIR_NAME}/mycompany/Windows`, errorHandler);
fs.mkdir(`../${DIR_NAME}/mycompany/Windows/debug`, errorHandler);

fs.writeFile(`../${DIR_NAME}/mycompany/log.id`, "521","utf-8", errorHandler)
```

And this approach in vanilla Node.js works in Windows from the command prompt.

Is this fun, writing everything out and not letting mkdir -p save us a lot of work? No, not at all. It's really no fun at all. But it works.

For a promisified version, see here: [https://github.com/nodejs/help/issues/2093](https://github.com/nodejs/help/issues/2093).


I'd actually look into adapting this approach, for that reason, for constructing more involved file paths: [https://github.com/nodejs/help/issues/1840#issuecomment-478124633](https://github.com/nodejs/help/issues/1840#issuecomment-478124633).

Another possible approach would be to write a small compiler that takes POSIX Shell compliant mkdir commands and translates them into cross platform Node.js commands that work in Windows too. This would specifically address the nested directory problem along with the bulk/cruft that comes from not having the handy Shell shorthand or -p flag.

You can imagine how it would have gotten out of hand if I needed a cross platform Node.js script translation of a shell script that made even more nested directories!








