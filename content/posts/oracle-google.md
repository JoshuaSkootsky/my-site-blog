---
title: 'Oracle & Google'
date: 2020-11-09T14:55:31-05:00
draft: true
---

Explaining Oracle and Google, with code examples.

What is a Java API?

What did Google do?

Why is Oracle mad?

If the court rules for Oracle, will the software industry melt down?

These are all extremely important questions.

Check out [SCOTUS BLog](https://www.scotusblog.com/2020/10/argument-analysis-justices-debate-legality-of-googles-use-of-java-in-android-software-code/), [New York Times](https://www.nytimes.com/2020/10/07/us/supreme-court-google-oracle.html), and the fascinating [Microsoft amicus curie](https://www.supremecourt.gov/DocketPDF/18/18-956/128381/20200113143602407_Microsoft%20-%20Google%20v%20Oracle%20Amicus%20Brief_Efile.pdf).

Let's give a small example.

```javascript
function addUpNumbers(array) {
  let sum = 0;
  for (let i = 0; i < array.length; i++) {
    sum += array[i];
  }
  return sum;
}
```

This function creates a very small API, or promise, that other programmers can rely on. If you use the function addUpNumbers, then it will have this behavior. It takes an array of numbers and adds them all up.

Now, what if you wanted to write your own version of this function? You could do it like this:

```javascript
function addUpNumbers(array) {
  let i = 0;
  let sum = 0;
  while (i < array.length) {
    sum += array[i];
    i++;
  }
  return sum;
}
```

... which does the same thing. But you didn't have to copy the body of my code to do this. You still had to write `function addUpNumbers(array)` to get the basic syntax correct, to write a function with that name that takes one argument, but the logic within the function, you had real options there. You can do it in a slightly different way, as long as it ends up with the same result.

We could call `addUpNumbers` part of the API of a small JavaScript library that I could write, like call it the Advanced Javascript Research Library Standard (AJRLS). I could also merely specify the behavior of the function, without ever writing an implementation. I could say "The function addUpNumbers shall take an array of numbers and return the sum of those numbers." With its cool name, the Advanced Javascript Research Library Standard (AJRLS), people all over the world could write their own versions of `addUpNumbers` and advertise that their programs are AJRLS compliant.

This is pretty similar to the [story here in Ars Technica](https://arstechnica.com/tech-policy/2020/03/before-it-sued-google-for-copying-from-java-oracle-got-rich-copying-ibms-sql/) about Oracle and SQL. IBM specified a standard for how SQL would work, and Oracle, without copying their code, met the same standard. So Oracle could correctly state that its SQL type database met the IBM standard, even though IBM hadn't given them a license to use the copywritten code that the IBM software engineers and computer scientists used.

> Google exactly duplicated the names, argument types, and expected output of those 6,088 Java functions. But it didn't copy the code that actually did the work inside these functions. (Ars Technica)

More advanced functions are built out of smaller functions. Composition of these interlocking and interdependent promises build out the full functionality of any programming language, including Java.

# Declaring Code

A more complicated example, which might explain the merits of Oracle's case, is 'declaring code.'

> Google copied more than 11,000 lines of Oracle’s Java code to build Android. Specifically, it copied the “declaring code,” instructions that describe pre-written programs in Java. There is no dispute as to whether the copying occurred, or that it was infringing—the first jury found that it was—instead, the question is whether it was otherwise excused. [IP Watchdog](https://www.ipwatchdog.com/2020/08/05/google-v-oracle-perspective-googles-android-cheat-code-copy-oracles-code/id=123789/)

> Q. In fact, it is your view that without the Java APIs that Google took, Java programmers would have found it cumbersome to program for the Android platform isn’t that right?

> A. Let me equate that to what I said earlier, which is, in using these API declarations, Android met developer expectations. If they hadn’t, it would have been cumbersome to use. [Page 389, Supreme Court Website, UNITED STATES DISTRICT COURT NORTHERN DISTRICT OF CALIFORNIA before the Honorable William H. Alsup](https://www.supremecourt.gov/DocketPDF/18/18-956/134270/20200226172301090_JA%20Volume%202.pdf)

In other words, if you wanted to use that cute piece of code I wrote earlier, you'd have to write something like

```javascript
const numberAdder = require('addUpNumbers');
```

to use the code that fulfills the promise of adding up all the numbers. Probably that code lives in a library of adding related functions, which itself might be tucked into a larger library of mathematical utilities. You'd have expectations of the names and structure of these functions. Even if the code for the function addUpNumbers was different, the code that composed and organized that code within a library would have to follow the same fundamental design, otherwise the expectations of other developers would be thwarted. The library wouldn't fulfill the promise of being able to find this function here or there.

# Microsoft

Microsoft, [in their amicus curie](https://www.supremecourt.gov/DocketPDF/18/18-956/128381/20200113143602407_Microsoft%20-%20Google%20v%20Oracle%20Amicus%20Brief_Efile.pdf) point out that WINE allows Linux machines to use the Windows API to run Windows programs - without Microsoft's authorization or paying Microsoft a licensing fee. Layers of promises are common in software, and specifying those promises allow for other people to write software that fulfills those promises. I think that's a good definition of an API.

# Some Extra Technical Points and Legal Analysis

One of the key issues is that there is a "standard library" for Java, which is part of the Java SDK. This standard library, its ins and outs, are learned by Java engineers. Google could have made its own SDK, the "Google Standard Library" which could have provided the same functionality or expanded functionality, without needing to copy the structure and layout of the Java SDK, whose intellectual property rights are now owned by Oracle.

It is because of this that Google has a real problem: because they wanted to copy or emulate the same structure of the official Java SDK, necessarily there are many lines of code that are the same. In a copyright case, one of the key criteria is determining the amount of material that was copied over and used. For Google, unfortunately, there's just a lot of code that can be pointed to as copied from the original Java SDK.


