# Avoiding Pain with Persistent Data Structures {#title}

<h3>
    Bob Ippolito (<a href="https://twitter.com/etrepum">@etrepum</a>)<br>
    [SSU CS Colloquium]<br>
    March 12, 2015
</h3>
<h4>
[bob.ippoli.to/persistent-ssu2015]
</h4>

# Who am I?

- Self-taught programmer
- Open source contributor (Python, JS, Erlang, Haskell)
- Entrepreneur (past: Mochi Media, Pieceable)
- Current Projects: Mission Bit, Nom Labs

# Mission Bit

* 501c3 non-profit in San Francisco
* Free after-school coding classes
* High school and middle school
* Taught by volunteer tech professionals
* Also: summer internships, company visits, hacker lab, etc.
* [missionbit.com]

# Nom Labs

* Current company, founded a few months ago
* Not quite ready to talk about this yet!

# Data Structures

<blockquote>
In computer science, a data structure is a particular way of
organizing data in a computer so that it can be used efficiently.
<footer>
– <cite>[Wikipedia: Data structure](http://en.wikipedia.org/wiki/Data_structure)</cite>
</footer>
</blockquote>

# Data Structure Examples

* Array (Vector)
* Map (Hash, Associative Array, Dictionary)
* Struct (Record, Tuple)

# Efficiency

<blockquote>
Efficiency is the extent to which time, effort, or cost is well-used
for the intended task or function.
<footer>
– <cite>[Wikipedia: Efficiency](http://en.wikipedia.org/wiki/Efficiency)</cite>
</footer>
</blockquote>

# Algorithmic Efficiency

Primary resource concerns are:

* Space (~RAM)
* Time (~CPU)

# Measurement

* Theory: Big-O (and little o, and Ω…)

<blockquote>
In theory, theory and practice are the same. In practice, they are not.
</blockquote>

* Practice: Benchmarking

<blockquote>
Lies, Damn Lies, and <strike>Statistics</strike> Benchmarks.
</blockquote>

# A little about Big-O

* Commonly used terminology
* Order of magnitude of growth of upper bound
* Constant factors may be very large (or small!)
* Usually worst case, but sometimes average or amortized

# Common Big-O examples

<dl>
<dt>O(1)</dt><dd>Constant (array indexing)</dd>
<dt>O(log n)</dt><dd>Logarithmic (binary search)</dd>
<dt>O(n)</dt><dd>Linear (minimum element of an unsorted array)</dd>
<dt>O(n log n)</dt><dd>Linearithmic (comparison sort)</dd>
<dt>O(n²)</dt><dd>Quadratic (bubble sort)</dd>
</dl>

# Less often measured

* Correctness
* Time travel (undo/redo)
* Concurrency

# Correctness

* Is it easy to use correctly?
* Does it cheaply enforce its invariants?
* Can it be used concurrently without locking?

# Time Travel

* Is it cheap to make a snapshot?
* Can you safely work with that snapshot?

# Concurrency

* Can this benefit from multiple cores?
* Do I need to worry about race conditions?
* Locking?

# Is there a solution?

* Immutability
* Structural Sharing

# Immutability

<blockquote>
In object-oriented and functional programming, an immutable object is an object whose state cannot be modified after it is created.
<footer>
– <cite>[Wikipedia: Immutable object](http://en.wikipedia.org/wiki/Immutable_object)</cite>
</footer>
</blockquote>

# Cons

* Space
* Time

# How does that even work?

* Garbage collection can clean up old versions
* Structural sharing saves allocations

# Mutating an array

```javascript
function zeroFirst(arr) {
  arr[0] = 0;
  return arr;
}
x = [1, 1, 2, 3, 4];
x1 = zeroFirst(x);
```

# Immutable

```javascript
function zeroFirst(arr) {
  arr1 = arr.slice(0, x.length);
  arr1[0] = 0;
  return arr1;
}
x = [1, 1, 2, 3, 4];
x1 = zeroFirst(x);
```

# Persistent Data Structures

<blockquote>
a persistent data structure is a data structure that always preserves the previous version of itself when it is modified
<footer>
– <cite>[Wikipedia: Persistent data structure](http://en.wikipedia.org/wiki/Persistent_data_structure)</cite>
</footer>
</blockquote>

*not* related to persistent storage, such as disk, this is a different and unrelated sense of the word "persistent."

# Optimizations

* Haskell ST
* Clojure transients

# {#other-resources}

## <i class="fa fa-video-camera"></i>&nbsp; Videos {.left}

* [Immutable Data and React]

## <i class="fa fa-book"></i>&nbsp; Books {.left}

* [Algorithms]
* [Introduction to Algorithms]
* [Purely Functional Data Structures]

## <i class="fa fa-code"></i>&nbsp; Code {.left}

* JS Libraries: [Immutable.js], [Mori]
* Languages: [Haskell], [Erlang], [Clojure]

# Thanks!

+-------------+-------------------------------------------------+
| **Slides**  | [bob.ippoli.to/persistent-ssu2015]              |
+-------------+-------------------------------------------------+
| **Source**  | [github.com/etrepum/persistent-ssu2015]         |
+-------------+-------------------------------------------------+
| **Email**   | bob@redivi.com                                  |
+-------------+-------------------------------------------------+
| **Twitter** | [&#64;etrepum](https://twitter.com/etrepum)     |
+-------------+-------------------------------------------------+

[bob.ippoli.to/persistent-ssu2015]: http://bob.ippoli.to/persistent-ssu2015/
[github.com/etrepum/persistent-ssu2015]: https://github.com/etrepum/persistent-ssu2015/
[missionbit.com]: http://www.missionbit.com/
[SSU CS Colloquium]: http://www.cs.sonoma.edu/events/
[Immutable Data and React]: https://www.youtube.com/watch?v=I7IdS-PbEgI
[Purely Functional Data Structures]: http://www.amazon.com/gp/product/0521663504?tag=etrepum-20
[Algorithms]: http://www.amazon.com/gp/product/032157351X?tag=etrepum-20
[Introduction to Algorithms]: http://www.amazon.com/gp/product/0262033844?tag=etrepum-20
[Immutable.js]: http://facebook.github.io/immutable-js/
[Haskell]: https://www.haskell.org/
[Erlang]: http://erlang.org/
[Clojure]: http://clojure.org/
[Mori]: http://swannodette.github.io/mori/