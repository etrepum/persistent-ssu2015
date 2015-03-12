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
* Can I use it in a referentially transparent manner?

# Time Travel

* Is it cheap to make a snapshot?
* Can you safely work with that snapshot?

# Concurrency

* Can this benefit from multiple cores?
* Do I need to worry about race conditions?
* Do I need to use locks?

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
* No more in-place updates

# Mutating an array

```javascript
function incrementFirst(arr) {
  arr[0] = arr[0] + 1;
  return arr;
}
x = [-1, 1, 2, 3, 4];
x1 = incrementFirst(x);
```

* Pros: Constant time and space
* Cons: No persistence (original x is lost)

# Immutable

```javascript
// Linear time + space
function incrementFirst(arr) {
  arr1 = arr.slice(0, x.length);
  arr1[0] = arr[0] + 1;
  return arr1;
}
x = [-1, 1, 2, 3, 4];
x1 = incrementFirst(x);
```

* Pros: Persistence
* Cons: Linear time and space is much worse

# Persistent Data Structures

<blockquote>
a persistent data structure is a data structure that always preserves the previous version of itself when it is modified
<footer>
– <cite>[Wikipedia: Persistent data structure](http://en.wikipedia.org/wiki/Persistent_data_structure)</cite>
</footer>
</blockquote>

*not* related to persistent storage, such as disk, this is a different and unrelated sense of the word "persistent."

# Radix Trees

* Commonly used persistent data structure
* Can be used for Array-like use cases
* Also called: Trie, Radix Trie, Prefix tree
* More specifically we'll look at a Patricia Tree

# Patricia Tree

<blockquote>
Compact representation of a trie in which any node that is an only child
is merged with its parent.
<footer>
– <cite>[DADS: Patricia tree]</cite>
</footer>
</blockquote>

# Radix Trees

```javascript
function RadixTree(size, rootNode) {
  this.size = size;
  this.rootNode = rootNode;
}
function Node(left, right) {
  this.left = left;
  this.right = right;
}
function Leaf(value) {
  this.value = value;
}
```

# Small Trees

```javascript
var zero = new RadixTree(0,
  null);
```

# Small Trees

```javascript
var one = new RadixTree(1,
  new Leaf('a'));
```

# Small Trees

```javascript
var two = new RadixTree(2,
  new Node(
    new Leaf('a'),
    new Leaf('b')));
```

# Bigger Trees

```javascript
var three = new RadixTree(3,
  new Node(
    new Node(
      new Leaf('a'),
      new Leaf('b')),
    new Leaf('c')));
```

# Bigger Trees

```javascript
var four = new RadixTree(4,
  new Node(
    new Node(
      new Leaf('a'),
      new Leaf('b')),
    new Node(
      new Leaf('c'),
      new Leaf('d'))));
```

# Bigger Trees

```javascript
var five = new RadixTree(5,
  new Node(
    new Node(
      new Node(
        new Leaf('a'),
        new Leaf('b')),
      new Node(
        new Leaf('c'),
        new Leaf('d'))),
    new Leaf('e')));
```

# Structural Sharing

* Most of the structure is the same
* Since it is immutable, we do not need to copy
* Let's see that again, without the shared structure

# Small Trees

```javascript
var zero = new RadixTree(0,
  null);
```

# Small Trees

```javascript
var one = new RadixTree(1,
  new Leaf('a'));
```

# Small Trees

```javascript
var two = new RadixTree(2,
  new Node(
    …,
    new Leaf('b')));
```

# Bigger Trees

```javascript
var three = new RadixTree(3,
  new Node(
    …,
    new Leaf('c')));
```

# Bigger Trees

```javascript
var four = new RadixTree(4,
  new Node(
    …,
    new Node(
      …,
      new Leaf('d'))));
```

# Bigger Trees

```javascript
var five = new RadixTree(5,
  new Node(
    …,
    new Leaf('e')));
```

# Tree Demo

# Radix Tree properties

* Logarithmic time indexing (worse)
* Logarithmic time update (better)

# How does that even work?

* Garbage collection can clean up old versions
* Structural sharing saves allocations

# Why isn't this pervasive?

* Multi-core is a relatively new concern
* (Good) Garbage collection is relatively new
* The constant or log factors were more of a concern with older
  generations of hardware

# Practical concerns

* Can use much higher branching factor for near-constant timing
* Efficient to implement with power of 2 branching
* 32 is a common branching factor, much better than 2

# Implementing Undo

* Just keep a list or tree of all past states!
* Structure sharing makes this cheap (logarithmic, not linear)
* No need to write reversible actions, roll back the world

# More Optimizations

* Use object identity to check for differences in constant time
* Haskell ST - strict state-transformer, allows for safe and isolated in-place updates
* Clojure transients - temporary mutable interface to a persistent structure
* Immutable.js - withMutations

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
[DADS: Patricia tree]: http://xlinux.nist.gov/dads/HTML/patriciatree.html
