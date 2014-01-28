<TeXmacs|1.0.7.20>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-stlvec-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|gnumeric-pure.tm> \|
  <hlink|previous|pure-stlmap.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|pure-stlvec<label|module-stlvec>>

  <label|module-stlvec::algorithms>Version 0.4, January 28, 2014

  Peter Summerland \<less\><hlink|p.summerland@gmail.com|mailto:p.summerland@gmail.com>\<gtr\>

  Pure's interface to C++ vectors, specialized to hold pointers to arbitrary
  Pure expressions, and the C++ Standard Template Library algorithms that act
  on them.

  <subsection|Copying<label|copying>>

  Copyright (c) 2011 by Peter Summerland \<less\><hlink|p.summerland@gmail.com|mailto:p.summerland@gmail.com>\<gtr\>.

  All rights reserved.

  pure-stlvec is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE.

  pure-stlvec is distributed under a BSD-style license, see the COPYING file
  for details.

  <subsection|Installation<label|installation>>

  pure-stlvec-0.4 is included in the ``umbrella'' addon,
  <hlink|<em|pure-stllib>|pure-stllib.tm>, which is available at
  <hlink|http://code.google.com/p/pure-lang/downloads/list|http://code.google.com/p/pure-lang/downloads/list>.
  After you have downloaded and installed
  <hlink|<em|pure-stllib>|pure-stllib.tm>, you will be able to use
  pure-stlvec (and <hlink|<em|pure-stlmap>|pure-stlmap.tm>, as well).

  <subsection|Overview<label|overview>>

  The C++ Standard Template Library (``STL'') is a library of generic
  containers (data structures designed for storing other objects) and a rich
  set of generic algorithms that operate on them. pure-stlvec provides an
  interface to one of its most useful containers, ``vector'', adopted to hold
  pointers to Pure expressions. The interface provides Pure programmers with
  a mutable container ``stlvec'', that, like the STL's vector, holds a
  sequence of objects that can be accessed in constant time according to
  their position in the sequence.

  <subsubsection|Modules<label|modules>>

  The usual operations for creating, accessing and modifying stlvecs are
  provided by the stlvec module. Most of the operations are similar in name
  and function to those provided by the Pure Library for other containers. As
  is the case for their Pure Library counterparts, these operations are in
  the global namespace. There are a few operations that have been placed in
  the stl namespace usually because they do not have Pure Library
  counterparts.

  In addition to the stlvec module, pure-stlvec provides a group of modules,
  stlvec::modifying, stlvec::nonmodifying, stlvec::sort, stlvec::merge,
  stlvec::heap, stlvec::minmax and stlvec::numeric, that are straight
  wrappers the STL algorithms (specialized to work with STL vectors of
  pointers to Pure expressions). This grouping of the STL algorithms follows
  that found at http://www.cplusplus.com/reference/algorithm/. This web page
  contains a table that summarizes of all of the algorithms in one place.

  pure-stlvec provides an ``umbrella'' module,
  <hlink|<with|font-family|tt|stlvec::algorithms>|#module-stlvec::algorithms>,
  that pulls in all of the STL algorithm interface modules in one go. The STL
  algorithm wrapper functions reside in the stl namespace and have the same
  names as their counterparts in the STL.

  <subsubsection|Simple Examples<label|simple-examples>>

  Here are some examples that use the basic operations provided by the stlvec
  module.

  <\verbatim>
    \<gtr\> using stlvec;

    \;

    \<gtr\> let sv1 = stlvec (0..4); members sv1;

    [0,1,2,3,4]

    \;

    \<gtr\> insert (sv1,stl::svend) (5..7); members sv1;

    STLVEC #\<less\>pointer 0xaf4d2c0\<gtr\>

    [0,1,2,3,4,5,6,7]

    \;

    \<gtr\> sv1!3;

    3

    \;

    \<gtr\> sv1!![2,4,6];

    [2,4,6]

    \;

    \<gtr\> replace sv1 3 33; members sv1;

    STLVEC #\<less\>pointer 0xaf4d2c0\<gtr\>

    [0,1,2,33,4,5,6,7]

    \;

    \<gtr\> stl::erase (sv1,2,5); members sv1;

    STLVEC #\<less\>pointer 0xaf4d2c0\<gtr\>

    [0,1,5,6,7]

    \;

    \<gtr\> insert (sv1,2) [2,3,4]; \ members sv1;

    STLVEC #\<less\>pointer 0xaf4d2c0\<gtr\>

    [0,1,2,3,4,5,6,7]

    \;

    \<gtr\> let pure_vector = stl::vector (sv1,1,5); pure_vector;

    {1,2,3,4}

    \;

    \<gtr\> stlvec pure_vector;

    STLVEC #\<less\>pointer 0x9145a38\<gtr\>

    \;

    \<gtr\> members ans;

    [1,2,3,4]

    \;

    \ \<gtr\> map (+10) sv1;

    [10,11,12,13,14,15,16,17]

    \;

    \<gtr\> map (+10) (sv1,2,5);

    [12,13,14]

    \;

    \<gtr\> foldl (+) 0 sv1;

    28

    \;

    \<gtr\> [x+10 \| x = sv1; x mod 2];

    [11,13,15,17]

    \;

    \<gtr\> {x+10 \| x = (sv1,2,6); x mod 2};

    {13,15}
  </verbatim>

  Here are some examples that use STL algorithms.

  <\verbatim>
    \<gtr\> using stlvec::algorithms;

    \;

    \<gtr\> stl::reverse (sv1,2,6); members sv1;

    ()

    [0,1,5,4,3,2,6,7]

    \;

    \<gtr\> stl::stable_sort sv1 (\<gtr\>); members sv1;

    ()

    [7,6,5,4,3,2,1,0]

    \;

    \<gtr\> stl::random_shuffle sv1; members sv1 1;

    ()

    [1,3,5,4,0,7,6,2]

    \;

    \<gtr\> stl::partition sv1 (\<less\>3); members (sv1,0,ans); members sv1;

    3

    [1,2,0]

    [1,2,0,4,5,7,6,3]

    \;

    \<gtr\> stl::transform sv1 (sv1,0) (*2); members sv1;

    -1

    [2,4,0,8,10,14,12,6]

    \;

    \<gtr\> let sv2 = emptystlvec;

    \;

    \<gtr\> stl::transform sv1 (sv2,stl::svback) (div 2); members sv2;

    -1

    [1,2,0,4,5,7,6,3]
  </verbatim>

  Many more examples can be found in the pure-stlvec/ut directory.

  <subsubsection|Members and Sequences of
  Members<label|members-and-sequences-of-members>>

  Throughout the documentation for pure-stlvec, the member of a stlvec that
  is at the nth position in the sequence of expressions stored in the stlvec
  is referred to as its nth member or nth element. The nth member of a
  stlvec, sv, is sometimes denoted by sv!n. The sequence of members of sv
  starting at position i up to but not including j is denoted by sv[i,j).
  There is a ``past-the-end'' symbol, stl::svend, that denotes the position
  after that occupied by the last member contained by a stlvec.

  For example, if sv contains the sequence ``a'', ``b'', ``c'' ``d'' and
  ``e'', sv!0 is ``a'', sv[1,3) is the sequence consisting of ``b'' followed
  by ``c'' and v[3,stl::svend) denotes the sequence consisting of ``d''
  followed by ``e''.

  <subsubsection|STL Iterators and Value Semantics<label|stl-iterators-and-value-semantics>>

  In C++ a programmer accesses a STL container's elements by means of
  ``iterators'', which can be thought of as pointers to the container's
  elements. A single iterator can be used to access a specific element, and a
  pair of iterators can be used to access a ``range'' of elements. By
  convention, such a range includes the member pointed to by the first
  iterator and all succeeding members up to but not including the member
  pointed to by the second iterator. Each container has a past-the-end
  iterator that can be used to specifiy ranges that include the container's
  last member.

  In the case of vectors there is an obvious correspondence between an
  iterator that points to an element and the element's position (starting at
  zero) in the vector. pure-stlvec uses this correspondence to designate a
  stlvec's members in a way that makes it relatively easy to see how
  pure-stlvec's functions are acting on the stlvec's underlying STL vector by
  referencing the STL's documentation. Thus, if sv is a stlvec, and j is an
  int, ``replace sv j x'' uses the STL to replace the element pointed to by
  the iterator for position j of sv's underlying STL vector. If, in addition,
  k is an int, stl::sort (sv,j,k) (\<less\>) uses the STL to sort the
  elements in the range designated by the ``jth'' and ``kth'' iterators for
  sv's underlying STL vector. This range, written as sv[j,k), is the
  subsequence of sv that begins with the element at position j and ends with
  the element at position (k-1).

  Besides iterators, another cornerstone of the STL is its ``value
  semantics'', i.e., all of the STL containers are mutable and if a container
  is copied, all of its elements are copied. pure-stlvec deals with the STL's
  value semantics by introducing mutable and nonmutable stlvecs, and by
  storing smart pointers to objects (which have cheap copies) rather than the
  actual objects.

  <subsubsection|Iterator Tuples<label|iterator-tuples>>

  As mentioned in the previous section, in C++ ranges are specified by a pair
  of STL iterators.

  In pure-stlvec ranges of elements in a stlvec are specified by ``iterator
  tuples'' rather than, say, actual pointers to STL iterators. Iterator
  tuples consist of the name of a stlvec followed by one of more ints that
  indicate positions (starting from zero) of the stlvec's elements.

  To illustrate how iterator tuples are used, consider the STL stable_sort
  function, which sorts objects in the range [first, last) in the order
  imposed by comp. Its C++ signature looks like this:

  <\quote-env>
    void stable_sort ( RandomAccessIterator first, RandomAccessIterator
    last, Compare comp )
  </quote-env>

  The corresponding pure-stlvec function, from the stlvec::sort module, looks
  like this:

  <\quote-env>
    stable_sort (msv, first, last) comp
  </quote-env>

  where msv is a mutable stlvec, and first and last are ints. The first thing
  that the Pure stable_sort does is create a pair of C++ iterators that point
  to the elements in msv's underlying STL vector that occupy the positions
  designated by first and last. Next it wraps the Pure comp function in a C++
  function object that, along with the two iterators, is passed to the C++
  stable_sort function.

  For convenience, (sv,stl::svbeg, stl::svend) can be written simply as sv.
  Thus, if first were stl::svbeg (or 0), and last were stl::svend (or #msv,
  the number of elements in msv), the last Pure call could be written:

  <\quote-env>
    stable_sort msv comp
  </quote-env>

  It should be noted that often the STL library provides a default version of
  its functions, which like stable_sort, use a comparator or other callback
  function provided by the caller. E.g., the C++ stable_sort has a default
  version that assumes the ``\<less\>'' operator can be used on the elements
  held by the container in question:

  <\quote-env>
    void stable_sort ( RandomAccessIterator first, RandomAccessIterator
    last)
  </quote-env>

  The corresponding functions provided by the pure-stlvec modules rarely, if
  ever, supply a default version. A typical example is stlvec::sort's
  stable_sort which must be called with a comparator callback function:

  <\quote-env>
    stable_sort msv (\<less\>);
  </quote-env>

  Note also that the comparator (e.g., (\<less\>)), or other function being
  passed to a pure-stlvec algorithm wrapper is almost always the last
  parameter. This is the opposite of what is required for similar Pure
  functions, but is consistent with the STL calling conventions.

  <subsubsection|Predefined Iterator Tuple
  Indexes<label|predefined-iterator-tuple-indexes>>

  The following integer constants are defined in the stl namespace for use in
  iterator tuples.

  <\description>
    <item*|<em|constant> stl::svbeg = 0<label|stl::svbeg>>

    <item*|<em|constant> stl::svend = -1<label|stl::svend>>

    <item*|<em|constant> stl::svback = -2<label|stl::svback>>
  </description>

  These three symbols are declared as nonfix. <verbatim|svend> corresponds to
  STL's past-end iterator for STL vectors. It makes it possible to specify
  ranges that include the last element of an stlvec. I.e., the iterator tuple
  (sv,stl::svbeg,stl::svend) would specify sv[0,n), where n is the number of
  elements in sv. In order to understand the purpose of <verbatim|svback>, it
  is necessary to understand a bit about STL's ``back insert iterators.''

  <subsubsection|Back Insert Iterators<label|back-insert-iterators>>

  Many of the STL algorithms insert members into a target range designated by
  an iterator that points to the first member of the target range. Consistent
  with raw C usage, it is ok to copy over existing elements the target
  stlvec. E.g.,:

  <\verbatim>
    \<gtr\> using stlvec::modifying;

    \;

    \<gtr\> let v1 = stlvec (0..2);

    \;

    \<gtr\> let v2 = stlvec ("a".."g");

    \;

    \<gtr\> stl::copy v1 (v2,2) $$ members v2;

    ["a","b",0,1,2,"f","g"]
  </verbatim>

  This is great for C++ programmers, but for Pure programmers it is almost
  always preferable to append the copied items to the end of a target stlvec,
  rather than overwriting all or part or part of it. This can be accomplished
  using stl::svback. E.g.,:

  <\verbatim>
    \<gtr\> stl::copy v1 (v2,stl::svback) $$ members v2;

    ["a","b",0,1,2,"f","g",0,1,2]
  </verbatim>

  In short, when a pure-stlvec function detects ``stl::svback'' in a target
  iterator tuple, it constructs a STL ``back inserter iterator'' and passes
  it on to the corresponding wrapped STL function.

  <subsubsection|Data Structure<label|data-structure>>

  Currently, stlvecs are of the form (STLVEC x) or (CONST_STLVEC x), where
  STLVEC AND CONST_STLVEC are defined as nonfix symbols in the global
  namespace and x is a pointer to the underlying STL vector. The stlvec
  module defines corresponding type tags, stlvec and const_stlvec, so the
  programmer never needs to worry about the underlying representaton.

  This representation may change in the future, and must not be relied upon
  by client modules. In particular, one must never attempt to use the
  embedded pointer directly.

  As the names suggest, stlvecs are mutable and const_stlvecs are immutable.
  Functions that modify a stlvec will simply fail unless the stlvec is
  mutable.

  <\verbatim>
    \<gtr\> let v = const_stlvec $ stlvec (0..3); v2;

    CONST_STLVEC #\<less\>pointer 0x8c1dbf0\<gtr\>

    \;

    \<gtr\> replace v 0 100; // fails

    replace (CONST_STLVEC #\<less\>pointer 0x9f07690\<gtr\> 0 100
  </verbatim>

  <subsubsection|Types<label|types>>

  pure-stlvec introduces six type tags, all of which are in the global
  namespace:

  <\description>
    <item*|<em|type> mutable_stlvec<label|mutable-stlvec/type>>The type for a
    mutable stlvec.
  </description>

  <\description>
    <item*|<em|type> const_stlvec<label|const-stlvec/type>>The type for an
    immutable stlvec.
  </description>

  <\description>
    <item*|<em|type> stlvec<label|stlvec/type>>The type for a stlvec, mutable
    or immutable.
  </description>

  <\description>
    <item*|<em|type> mutable_svit<label|mutable-svit/type>>The type for an
    iterator tuple whose underlying stlvec is mutable.
  </description>

  <\description>
    <item*|<em|type> const_svit<label|const-svit/type>>The type for an
    iterator tuple whose underlying stlvec is immutable.
  </description>

  <\description>
    <item*|<em|type> svit<label|svit/type>>The type for an iterator tuple.
    The underlying stlvec can be mutable or immutable.
  </description>

  <subsubsection|Copy-On-Write Semantics<label|copy-on-write-semantics>>

  The pure-stlvec module functions do not implement automatic copy-on-write
  semantics. Functions that modify stlvec parameters will simply fail if they
  are passed a const_stlvec when they expect a mutable_stlvec.

  For those that prefer immutable data structures, stlvecs can be converted
  to const_stlvecs (usually after they have been created and modified within
  a function) by the <verbatim|const_stlvec> function. This function converts
  a mutable stlvec to an immutable stlvec without changing the underlying STL
  vector.

  Typically, a ``pure'' function that ``modifies'' a stlvec passed to it as
  an argument will first copy the input stlvec to a new locally scoped
  (mutable) stlvec using the stlvec function. It will then modify the new
  stlvec and use const_stlvec to make the new stlvec immutable before it is
  returned. It should be noted that several of the STL algorithms have
  ``copy'' versions which place their results directly into a new stlvec,
  which can eliminate the need to copy the input stlvec. E.g.:

  <\verbatim>
    \<gtr\> let sv1 = stlvec ("a".."e");

    \;

    \<gtr\> let sv2 = emptystlvec;

    \;

    \<gtr\> stl::reverse_copy sv1 (sv2,stl::svback) $$ members sv2;

    ["e","d","c","b","a"]
  </verbatim>

  Without reverse_copy, one would have had to copy sv1 into sv2 and then
  reverse sv2.

  If desired, in Pure it is easy to write functions that have automatic
  copy-on-write semantics. E.g.,

  <\verbatim>
    \<gtr\> my_replace csv::const_stlvec i x = my_replace (stlvec csv) i x;

    \<gtr\> my_replace sv::stlvec i x = replace sv i x;
  </verbatim>

  <subsubsection|Documentation<label|documentation>>

  The pure-stllib/doc directory includes a rudimentary cheatsheet,
  pure-stllib-cheatsheet.pdf, that shows the signatures of all of the
  functions provided by pure-stlvec (and by
  <hlink|<em|pure-stlmap>|pure-stlmap.tm> as well).

  The documentation of the functions provided by the stlvec module are
  reasonably complete. In contrast, the descriptions of functions provided by
  the STL algorithm modules are purposely simplified (and may not, therefore,
  be technically accurate). This reflects that fact that the functions
  provided by pure-stlvec have an obvious correspondence to the functions
  provided by the STL, and the STL is extremely well documented. Furthermore,
  using the Pure interpreter, it is very easy to simply play around with with
  any of the pure-stlvec functions if there are doubts, especially with
  respect to ``corner cases.'' Often this leads to a deeper understanding
  compared to reading a precise technical description.

  A good book on the STL is STL Tutorial and Reference Guide, Second Edition,
  by David R. Musser, Gillmer J. Derge and Atul Saini. A summary of all of
  the STL algorithms can be found at <hlink|http://www.cplusplus.com/reference/stl/|http://www.cplusplus.com/reference/stl/>.

  <subsubsection|Parameter Names<label|parameter-names>>

  In the descriptions of functions that follow, parameter names used in
  function descriptions represent specific types of Pure objects:

  <\description>
    <item*|sv>stlvec (mutable or immutable)

    <item*|csv>const (i.e., immutable) stlvec

    <item*|msv>mutable stlvec

    <item*|x>an arbitrary Pure expression

    <item*|xs>a list of arbitrary Pure expressions

    <item*|count, sz, n>whole numbers to indicate a number of elements, size
    of a vector, etc

    <item*|i,j>whole numbers used to designate indexes into a stlvec

    <item*|f,m,l>whole numbers (or stl::beg or stl::svend) designating the
    ``first'', ``middle'' or ``last'' iterators in a stlvec iterator tuple

    <item*|p>a whole number (or other iterator constant such as stl::svend or
    stl::svback) used in a two element iterator tuple (e.g., (sv,p))

    <item*|(sv,p)>an iterator tuple that will be mapped to an iterator that
    points to the pth position of sv's underlying STL vector, v, (or to a
    back iterator on v if p is stl::svback)

    <item*|(sv,f,l)>an iterator tuple that will be mapped to the pair of
    iterators that are designated by (sv,f) and (sv,l)

    <item*|(sv,f,m,l)>an iterator tuple that will be mapped to the iterators
    that are designated by (sv,f), (sv,m) and (sv,l)

    <item*|sv[f,l)>the range of members beginning with that at (sv,f) up to
    but not including that at (con,l)

    <item*|comp>a function that accepts two objects and returns true if the
    first argument is less than the second (in the strict weak ordering
    defined by comp), and false otherwise

    <item*|unary_pred>a function that accepts one object and returns true or
    false

    <item*|bin_pred>a function that accepts two objects and returns true or
    false

    <item*|unary_fun>a function that accepts one objects and returns another

    <item*|bin_fun>a function that accepts two objects and returns another

    <item*|gen_fun>a function of one parameter that produces a sequence of
    objects, one for each call
  </description>

  For readability, and to correspond with the STL documentation, the words
  ``first'', ``middle'', and ``last'', or variants such as ``first1'' are
  often used instead of f,m,l.

  <subsection|Error Handling<label|error-handling>>

  The functions provided this module handle errors by throwing exceptions.

  <subsubsection|Exception Symbols<label|exception-symbols>>

  <\description>
    <item*|<em|constructor> bad_argument<label|bad-argument/stlvec>>This
    exception is thrown when a function is passed an unexpected value. A
    subtle error to watch for is a malformed iterator tuple (e.g., one with
    the wrong number of elements).
  </description>

  <\description>
    <item*|<em|constructor> bad_function<label|bad-function/stlvec>>This
    exception is thrown when a purported Pure call-back function is not even
    callable.
  </description>

  <\description>
    <item*|<em|constructor> failed_cond<label|failed-cond/stlvec>>This
    exception is thrown when a Pure call-back predicate returns a value that
    is not an int.
  </description>

  <\description>
    <item*|<em|constructor> out_of_bounds<label|out-of-bounds/stlvec>>This
    exception is thrown if the specified index is out of bounds.
  </description>

  <\description>
    <item*|<em|constructor> range_overflow<label|range-overflow/stlvec>>This
    exception is thrown by functions that write over part of a target stlvec
    (e.g., copy) when the target range too small to accommodate the result.
  </description>

  <\description>
    <item*|<em|constructor> range_overlap<label|range-overlap/stlvec>>This
    exception is thrown by algorithm functions that write over part of a
    target stlvec when the target and source ranges overlap in a way that is
    not allowed.
  </description>

  In addition, any exception thrown by a Pure callback function passed to a
  pure-stlvec function will be caught and be rethrown by the pure-stlvec
  function.

  <subsubsection|Examples<label|examples>>

  <\verbatim>
    \<gtr\> using stlvec, stlvec::modifying;

    \;

    \<gtr\> let sv1 = stlvec (0..4); members sv1;

    [0,1,2,3,4]

    \;

    \<gtr\> let sv2 = stlvec ("a".."e"); members sv2;

    ["a","b","c","d","e"]

    \;

    \<gtr\> sv1!10;

    \<less\>stdin\<gtr\>, line 25: unhandled exception 'out_of_bounds' ...

    \;

    \<gtr\> stl::copy sv1 (sv2,10);

    \<less\>stdin\<gtr\>, line 26: unhandled exception 'out_of_bounds' ...

    \;

    \<gtr\> stl::copy sv1 (sv2,2,3); // sb (sv2,pos)

    \<less\>stdin\<gtr\>, line 22: unhandled exception 'bad_argument' ...

    \;

    \<gtr\> stl::copy sv1 (sv2,2);

    \<less\>stdin\<gtr\>, line 23: unhandled exception 'range_overflow' ...

    \;

    \<gtr\> stl::copy sv2 (sv2,2);

    \<less\>stdin\<gtr\>, line 24: unhandled exception 'range_overlap' ...

    \;

    \<gtr\> stl::copy (sv1,1,3) (sv2,0); members sv2; // ok

    2

    [1,2,"c","d","e"]

    \;

    \<gtr\> stl::sort sv2 (\<gtr\>); // apples and oranges

    \<less\>stdin\<gtr\>, line 31: unhandled exception 'failed_cond'

    \;

    \<gtr\> listmap (\\x-\<gtr\>throw DOA) sv1; // callback function throws
    exception

    \<less\>stdin\<gtr\>, line 34: unhandled exception 'DOA' ...
  </verbatim>

  <subsection|Operations Included in the stlvec
  Module<label|operations-included-in-the-stlvec-module>>

  The stlvec module provides functions for creating, accessing and modifying
  stlvecs. In general, operations that have the same name as a corresponding
  function in the Pure standard library are in the global namespace. The
  remaining functions, which are usually specific to stlvecs, are in the stl
  namespace.

  Please note that ``stlvec to stlvec'' functions are provided by the
  pure-stl algorithm modules. Thus, for example, the stlvec module does not
  provide a function that maps one stlvec onto a new stlvec. That
  functionality, and more, is provided by stl::transform, which can be found
  in the stlvec::modifying module.

  <subsubsection|Imports<label|imports>>

  To use the operations of this module, add the following import declaration
  to your program:

  <\verbatim>
    using stlvec;
  </verbatim>

  <subsubsection|Operations in the Global
  Namespace<label|operations-in-the-global-namespace>>

  When reading the function descriptions that follow, please bear in mind
  that whenever a function is passed an iterator tuple of the form (sv,first,
  last), first and last can be dropped, leaving (sv), or simply sv. The
  function will treat the ``unary'' iterator tuple (sv) as (sv, stl::svbeg,
  stl::svend).

  <\description>
    <item*|emptystlvec<label|emptystlvec/stlvec>>return an empty stlvec
  </description>

  <\description>
    <item*|stlvec source /stlvec<label|stlvec>>create a new stlvec that
    contains the elements of source; source can be a stlvec, an iterator
    tuple(sv,first,last), a list or a vector (i.e., a matrix consisting of a
    single row or column). The underlying STL vector is always a new STL
    vector. I.e., if source is a stlvec the new stlvec does not share
    source's underlying STL vector.
  </description>

  <\description>
    <item*|mkstlvec x count<label|mkstlvec/stlvec>>create a new stlvec
    consisting of count x's.
  </description>

  <\description>
    <item*|const_stlvec source<label|const-stlvec/stlvec>>create a new
    const_stlvec that contains the elements of source; source can be a
    stlvec, an iterator tuple(sv,first,last), a list or a vector (i.e., a
    matrix consisting of a single row or column). If source is a stlvec
    (mutable or const), the new const_stlvec shares source's underlying STL
    vector.
  </description>

  <\description>
    <item*|# sv<label|#/stlvec>>return the number of elements in sv.
  </description>

  Note that # applied to an iterator tuple like (sv,b,e) will just return the
  number of elements in the tuple. Use stl::bounds if you need to know the
  number of elements in the range denoted by an iterator tuple.

  <\description>
    <item*|sv ! i<label|!/stlvec>>return the ith member of sv
  </description>

  Note that !k applied to an iterator tuple like (sv,b,e) will just return
  the kth element of the tuple. In addition, in stlvec, integers used to
  denote postions (as in !k) or in iterators, <em|always>, are relative to
  the beginning of the underlying vector. So it makes no sense to apply ! to
  an iterator tuple.

  <\description>
    <item*|first sv<label|first/stlvec>>

    <item*|last sv<label|last/stlvec>>first and last member of sv
  </description>

  <\description>
    <item*|members (sv, first, last)<label|members/stlvec>>return a list of
    values stored in sv[first,last)
  </description>

  <\description>
    <item*|replace msv i x<label|replace/stlvec>>replace the ith member of
    msv by x and return x; throws out_of_bounds if i is less than 0 or great
    or equal to the number of elements in msv
  </description>

  <\description>
    <item*|update msv i x<label|update/stlvec>>the same as replace except
    that update returns msv instead of x. This function is DEPRECATED.
  </description>

  <\description>
    <item*|append sv x<label|append/stlvec>>append x to the end of sv
  </description>

  <\description>
    <item*|insert (msv,p) xs<label|insert/stlvec>>

    <item*|insert (msv,p) (sv,first,last)>insert members of the list xs or
    the range sv[first, last) into msv, all preceding the pth member of msv.
    Members are shifted to make room for the inserted members
  </description>

  <\description>
    <item*|rmfirst msv<label|rmfirst/stlvec>>

    <item*|rmlast msv<label|rmlast/stlvec>>remove the first or last member
    from msv
  </description>

  <\description>
    <item*|erase (msv,first,last)<label|erase/stlvec>>

    <item*|erase (msv,p)>

    <item*|erase msv>remove msv[first,last) from msv, remove msv!p from msv,
    or make msv empty. Members are shifted to occupy vacated slots
  </description>

  <\description>
    <item*|sv1 == sv2<label|==/stlvec>>

    <item*|sv1 <math|\<sim\>>= sv2<label|-tilde=/stlvec>>(x == y) is the same
    as stl::allpairs (==) x y and x <math|\<sim\>>= y is simply
    <math|\<sim\>>(allpairs (==) x y)
  </description>

  Note that <verbatim|==> and <verbatim|~==> are not defined for iterator
  tuples (the rules would never be executed because == is defined on tuples
  in the Prelude).

  The stlvec module provides convenience functions that apply map, catmap,
  foldl, etc, to directly access Pure expressions stored in a stlvec.

  <\description>
    <item*|map unary_fun (sv, first, last)<label|map/stlvec>>one pass
    equivalent of map unary_fun $ members (sv, first, last)
  </description>

  <\description>
    <item*|listmap unary_fun (sv, first, last)<label|listmap/stlvec>>same as
    map, used in list comprehensions
  </description>

  <\description>
    <item*|catmap unary_fun (sv, first, last)<label|catmap/stlvec>>one pass
    equivalent of catmap unary_fun $ members (sv, first, last)
  </description>

  <\description>
    <item*|do unary_fun (sv, first, last)<label|do/stlvec>>one pass
    equivalent of do unary_fun $ members (sv, first, last)
  </description>

  <\description>
    <item*|foldl bin_fun x (sv, first, last)<label|foldl/stlvec>>one pass
    equivalent of foldl bin_fun x $ members (sv, first, last)
  </description>

  <\description>
    <item*|foldl1 bin_fun (sv, first, last)<label|foldl1/stlvec>>one pass
    equivalent of foldl1 bin_fun $ members (sv, first, last)
  </description>

  <\description>
    <item*|filter unary_pred (sv, first, last)<label|filter/stlvec>>one pass
    equivalent of filter unary_pred $ members (sv, first, last)
  </description>

  The following four functions map (or catmap) stlvecs onto row and col
  matrixes, primarily for use in matrix comprehensions.

  <\description>
    <item*|rowmap unary_fun (sv, first, last)<label|rowmap/stlvec>>
  </description>

  <\description>
    <item*|rowcatmap unary_fun (sv, first, last)<label|rowcatmap/stlvec>>
  </description>

  <\description>
    <item*|colmap unary_fun (sv, first, last)<label|colmap/stlvec>>
  </description>

  <\description>
    <item*|colcatmap unary_fun (sv, first, last)<label|colcatmap/stlvec>>
  </description>

  <subsubsection|Operations in the stl Namespace<label|operations-in-the-stl-namespace>>

  <\description>
    <item*|stl::empty sv<label|stl::empty/stlvec>>test whether sv is empty
  </description>

  <\description>
    <item*|stl::vector (sv,first,last)<label|stl::vector/stlvec>>create a
    Pure vector that contains the members of sv[first,last)
  </description>

  <\description>
    <item*|stl::allpairs bin_pred (sv1, first1, last1) (sv2, first2,
    last2)<label|stl::allpairs/stlvec>>returns true if bin_pred is true for
    all corresponding members of sv1[first1, last1) and sv2[first2, last2)
  </description>

  <\description>
    <item*|stl::bounds (sv,first,last)<label|stl::bounds/stlvec>>throws
    out-of-bounds if first or last is out of bounds. returns the tuple
    (sv,first,last) except that if first is stl::begin it will be replaced by
    0 and if last is stl::svend it will be replaced by the number of elements
    in sv.
  </description>

  <\description>
    <item*|stl::reserve msv count<label|stl::reserve/stlvec>>modify the
    underlying STL vector to have at least count slots, useful for packing
    data into a fixed size vector and possibly to speed up the addition of
    new members
  </description>

  <\description>
    <item*|stl::capacity sv<label|stl::capacity/stlvec>>return the number of
    slots (as opposed to the number of elements) held by the underlying STL
    vector
  </description>

  <subsubsection|Examples>

  See ut_stlvec.pure and ut_global_stlvec.pure in the pure-stlvec/ut
  directory.

  <subsection|STL Nonmodifying Algorithms<label|stl-nonmodifying-algorithms>>

  The stlvec::nonmodifying module provides an interface to the STL's
  non-modifying sequence operations.

  <subsubsection|Imports>

  To use the operations of this module, add the following import declaration
  to your program:

  <\verbatim>
    using stlvec::nonmodifying;
  </verbatim>

  All of the functions are in the stl namespace.

  <subsubsection|Operations<label|operations>>

  <\description>
    <item*|stl::for_each (sv, first, last)
    unary_fun<label|stl::for-each/stlvec>>applies unary_fun to each of the
    elements in sv[first,last)
  </description>

  <\description>
    <item*|stl::find (sv, first, last) x<label|stl::find/stlvec>>returns the
    position of the first element in sv[first,last) for which (==x) is true
    (or stl::svend if not found)
  </description>

  <\description>
    <item*|stl::find_if (sv, first, last)
    unary_pred<label|stl::find-if/stlvec>>returns the position of the first
    element in sv[first,last) for which unary_pred is true (or stl::svend if
    not found)
  </description>

  <\description>
    <item*|stl::find_first_of (sv1, first1, last1) (sv2, first2, last2)
    bin_pred<label|stl::find-first-of/stlvec>>Returns the position of the
    first element, x, in sv1[first1,last1) for which there exists y in
    sv2[first2,last2) and (bin_pred x y) is true (or stl::svend if no such x
    exists).
  </description>

  <\description>
    <item*|stl::adjacent_find (sv, first, last)
    bin_pred<label|stl::adjacent-find/stlvec>>search sv[first,last) for the
    first occurrence of two consecutive elements (x,y) for which (bin_pred x
    y) is true. Returns the position of x, if found, or stl::svend if not
    found)
  </description>

  <\description>
    <item*|stl::count (sv, first, last) x<label|stl::count/stlvec>>returns
    the number of elements in the range sv[first,last) for which (x==) is
    true
  </description>

  <\description>
    <item*|stl::count_if (sv, first, last)
    unary_pred<label|stl::count-if/stlvec>>returns the number of elements in
    the range sv[first,last) for which unary_pred is true
  </description>

  <\description>
    <item*|stl::mismatch (sv1, first1, last1) (sv2, first2)
    bin_pred<label|stl::mismatch/stlvec>>applies bin_pred pairwise to the
    elements of sv1[first1,last1) and (sv2,first2,first2 + n), with n equal
    to last1-first1 until it finds i and j such that bin_pred (sv1!i) (sv2!j)
    is false and returns (i,j). If bin_pred is true for all of the pairs of
    elements, i will be stl::svend and j will be first2 + n (or stl::svend)
  </description>

  <\description>
    <item*|stl::equal (sv1, first1, last1) (sv2, first2)
    bin_pred<label|stl::equal/stlvec>>applies bin_pred pairwise to the
    elements of sv1[first1,last1) and (sv2,first2,first2 + n), with n equal
    to last1-first1, and returns true if bin_pred is true for each pair
  </description>

  <\description>
    <item*|stl::search (sv1, first1, last1) (sv2, first2)
    bin_pred<label|stl::search/stlvec>>using bin_pred to determine equality
    of the elements, searches sv1[first1,last1) for the first occurrence of
    the sequence defined by sv2[first2,last2), and returns the position in
    sv1 of its first element (or stl::svend if not found)
  </description>

  <\description>
    <item*|stl::search_n (sv, first, last) count x
    bin_pred<label|stl::search-n/stlvec>>using bin_pred to determine equality
    of the elements, searches sv[first,last) for a sequence of count elements
    that equal x. If such a sequence is found, it returns the position of the
    first of its elements, otherwise it returns stl::svend
  </description>

  <\description>
    <item*|stl::find_end (sv1, first1, last1) (sv2, first2, last2)
    bin_pred<label|stl::find-end/stlvec>>using bin_pred to determine equality
    of the elements, searches sv1[first1,last1) for the last occurrence of
    sv2[first2,last2). Returns the position of the first element in sv1 of
    the occurrence (or stl::svend if not found).
  </description>

  <subsubsection|Examples>

  See ut_nonmodifying.pure in the pure-stlvec/ut directory.

  <subsection|STL Modifying Algorithms<label|stl-modifying-algorithms>>

  The stlvec::modifying module provides an interface to the STL's modifying
  algorithms.

  <subsubsection|Imports>

  To use the operations of this module, add the following import declaration
  to your program:

  <\verbatim>
    using stlvec::modifying;
  </verbatim>

  All of the functions are in the stl namespace.

  <subsubsection|Operations>

  <\description>
    <item*|stl::copy (sv, first1, last1) (msv,
    first2)<label|stl::copy/stlvec>>copies the elements in sv[first1,last1)
    into the range whose first element is (msv,first2)
  </description>

  <\description>
    <item*|stl::copy_backward (sv,first1,last1)
    (msv,last2)<label|stl::copy-backward/stlvec>>copies the elements in
    sv[first1,last1), moving backward from (last1), into the range
    msv[first2,last2) where first2 is last2 minus the number of elements in
    sv[first1,last1)
  </description>

  <\description>
    <item*|stl::swap_ranges (sv,first,last) (msv,
    p)<label|stl::swap-ranges/stlvec>>exchanges the elements in sv[first,
    last) with those in msv[p, p+n) where n is last - first
  </description>

  <\description>
    <item*|stl::transform (sv,first,last) (msv, p)
    unary_fun<label|stl::transform/stlvec>>applies unary_fun to the elements
    of sv[first,last) and places the resulting sequence in msv[p, p+n) where
    n is last - first. If sv is mutable, msv and sv can be the same stlvec.
    Returns (msv,p+n)
  </description>

  <\description>
    <item*|stl::transform_2 (sv1,first1,last1) (sv2,first2) (msv, p)
    bin_fun<label|stl::transform-2/stlvec>>applies bin_fun to corresponding
    pairs of elements of sv1[first1,last1) sv2[first2,n) and and places the
    resulting sequence in msv[p, p+n) where n is last1 - first1. Returns
    (msv,p+n)
  </description>

  <\description>
    <item*|stl::replace_if (msv,first,last) unary_pred
    x<label|stl::replace-if/stlvec>>replace the elements of msv[first,last)
    that satistfy unary_pred with x
  </description>

  <\description>
    <item*|stl::replace_copy (sv,first,last) (msv,p) x
    y<label|stl::replace-copy/stlvec>>same as <verbatim|replace>
    (msv,first,last) x y except that the modified sequence is placed in
    msv[p,p+last-first)
  </description>

  <\description>
    <item*|stl::replace_copy_if (sv,first,last) (msv,p) unary_pred
    x<label|stl::replace-copy-if/stlvec>>same as
    <hlink|<with|font-family|tt|replace_if>|#stl::replace-if/stlvec> except
    that the modified sequence is placed in msv[p,p+last-first)
  </description>

  <\description>
    <item*|stl::fill (msv,first,last) x<label|stl::fill/stlvec>>replace all
    elements in msv[first,last) with x
  </description>

  <\description>
    <item*|stl::fill_n (msv,first) n x<label|stl::fill-n/stlvec>>replace the
    elements of msv[first,first+n) with x
  </description>

  <\description>
    <item*|stl::generate (msv,first,last)
    gen_fun<label|stl::generate/stlvec>>replace the elements in
    msv[first,last) with the sequence generated by successive calls to
    gen_fun (), e.g.,

    <\verbatim>
      \<gtr\> let count = ref 0;

      \;

      \<gtr\> g _ = n when n = get count + 1; put count n; end;

      \;

      \<gtr\> let sv = mkstlvec 0 10;

      \;

      \<gtr\> stl::generate sv g $$ members sv;

      [1,2,3,4,5,6,7,8,9,10]
    </verbatim>
  </description>

  <\description>
    <item*|stl::generate_n (msv,first) n gen_fun<label|stl::generate-n/stlvec>>replace
    all elements in msv[first,first+n) with the sequence generated by
    successive calls to gen_fen
  </description>

  <\description>
    <item*|stl::remove (msv,first,last) x<label|stl::remove/stlvec>>same as
    <hlink|<with|font-family|tt|remove_if>|#stl::remove-if/stlvec>
    (msv,first,last) (==x).
  </description>

  <\description>
    <item*|stl::remove_if (msv,first,last)
    unary_pred<label|stl::remove-if/stlvec>>remove elements in
    msv[first,last) that satisfy unary_pred. If n elements do not satisfy
    unary_pred, they are moved to msv[first,first+n), preserving their
    relative order. The content of msv[first+n,svend) is undefined. Returns
    first+n, or stl::svend if first+n is greater than the number of elements
    in msv
  </description>

  <\description>
    <item*|stl::remove_copy (sv,first,last) (msv,first)
    x<label|stl::remove-copy/stlvec>>same as
    <hlink|<with|font-family|tt|remove>|#stl::remove/stlvec> except that the
    purged sequence is copied to (msv,first) and sv[first,last) is not
    changed
  </description>

  <\description>
    <item*|stl::remove_copy_if (sv,first,last) (msv,first)
    unary_pred<label|stl::remove-copy-if/stlvec>>same as
    <hlink|<with|font-family|tt|remove_if>|#stl::remove-if/stlvec> except
    that the purged sequence is copied to (msv,first) and sv[first,last) is
    not changed
  </description>

  <\description>
    <item*|stl::unique (msv,first,last) bin_pred<label|stl::unique/stlvec>>eliminates
    consecutive duplicates from sv[first,last), using bin_pred to test for
    equality. The purged sequence is moved to sv[first,first+n) preserving
    their relative order, where n is the size of the purged sequence. Returns
    first+n or stl::svend if first+n is greater than the number of elements
    in msv
  </description>

  <\description>
    <item*|stl::unique_copy (sv,first,last) (msv,first)
    bin_pred<label|stl::unique-copy/stlvec>>same as
    <hlink|<with|font-family|tt|unique>|#stl::unique/stlvec> except that the
    purged sequence is copied to (msv,first) and sv[first,last) is not
    changed
  </description>

  <\description>
    <item*|stl::reverse (msv,first,last)<label|stl::reverse/stlvec>>Reverses
    the order of the elements in sv[first,last).
  </description>

  <\description>
    <item*|stl::reverse_copy (sv,first,last)
    (msv,first)<label|stl::reverse-copy/stlvec>>same as
    <hlink|<with|font-family|tt|reverse>|#stl::reverse/stlvec> except that
    the reversed sequence is copied to (msv,first) and sv[first,last) is not
    changed.
  </description>

  <\description>
    <item*|stl::rotate (msv,first,middle,last)<label|stl::rotate/stlvec>>rotates
    the elements of msv[first,middle,last] so that middle becomes the first
    element of msv[first,last].
  </description>

  <\description>
    <item*|stl::rotate_copy (msv,first,middle,last)
    (msv,first)<label|stl::rotate-copy/stlvec>>same as rotate except that the
    rotated sequence is copied to (msv,first) and sv[first,last) is not
    changed.
  </description>

  <\description>
    <item*|stl::random_shuffle (msv,first,last)
    int::seed<label|stl::random-shuffle/stlvec>>randomly reorders the
    elements in msv[first,last)
  </description>

  <\description>
    <item*|stl::partition (msv,first,last)
    unary_pred<label|stl::partition/stlvec>>places the elements in
    msv[first,last) that satisfy unary_pred before those that don't. Returns
    middle, where msv [first,middle) contains all of the elements that
    satisfy unary_pre, and msv [middle, last) contains those that do not
  </description>

  <\description>
    <item*|stl::stable_partition (msv,first,last)
    unary_pred<label|stl::stable-partition/stlvec>>same as partition except
    that the relative positions of the elements in each group are preserved
  </description>

  <subsubsection|Examples>

  See ut_modifying.pure in the pure-stlvec/ut directory.

  <subsection|STL Sort Algorithms<label|stl-sort-algorithms>>

  The stlvec::sort module provides an interface to the STL's sorting and
  binary search algorithms.

  <subsubsection|Imports>

  To use the operations of this module, add the following import declaration
  to your program:

  <\verbatim>
    using stlvec::sort;
  </verbatim>

  All of the functions are in the stl namespace.

  <subsubsection|Operations>

  All of the functions in this module require the caller to supply an
  ordering function, comp. The functions (\<less\>) and (\<gtr\>) are
  commonly passed as comp.

  <\description>
    <item*|stl::sort (msv, first, last) comp<label|stl::sort/stlvec>>sorts
    msv[first, last)
  </description>

  <\description>
    <item*|stl::stable_sort (msv, first, last)
    comp<label|stl::stable-sort/stlvec>>sorts msv[first, last), preserving
    the relative order of equal members
  </description>

  <\description>
    <item*|stl::partial_sort (msv, first, middle, last)
    comp<label|stl::partial-sort/stlvec>>fills msv[first, middle) with the
    elements of msv[first,last) that would appear there if msv[first,last)
    were sorted using comp and fills msv[middle,last) with the remaining
    elements in unspecified order
  </description>

  <\description>
    <item*|stl::partial_sort_copy (sv, first1, last1) (msv, first2, last2)
    comp<label|stl::partial-sort-copy/stlvec>>let n be the number of elements
    in sv[first1, last1) and r be the number of elements in msv[first2,
    last2). If r \<less\> n, <hlink|<with|font-family|tt|partial_sort_copy>|#stl::partial-sort-copy/stlvec>
    fills msv[first2, last2) with the first r elements of what sv[first1,
    last1) would be if it had been sorted. If r \<gtr\>= n, it fills
    msv[first2, first2+n) with the elements of sv[first1, last1) in sorted
    order. sv[first1,last1) is unchanged
  </description>

  <\description>
    <item*|stl::nth_element (msv, first, middle, last)
    comp<label|stl::nth-element/stlvec>>rearranges the elements of msv[first,
    last) as follows. Let n be middle - first, and let x be the nth smallest
    element of msv[first, last). After the function is called, sv!middle will
    be x. All of the elements of msv[first, middle) will be less than x and
    all of the elements of msv[middle+1, last) will be greater than x
  </description>

  The next four functions assume that sv[first, last) is ordered by comp.

  <\description>
    <item*|stl::lower_bound (sv, first, last) x
    comp<label|stl::lower-bound/stlvec>>returns an int designating the first
    position into which x can be inserted into sv[first, last) while
    maintaining the sorted ordering
  </description>

  <\description>
    <item*|stl::upper_bound (sv, first, last) x
    comp<label|stl::upper-bound/stlvec>>returns an int designating the last
    position into which x can be inserted into sv[first, last) while
    maintaining the sorted ordering
  </description>

  <\description>
    <item*|stl::equal_range (sv, first, last) x
    comp<label|stl::equal-range/stlvec>>returns a pair of ints, (lower,
    upper) where lower and upper would have been returned by separate calls
    to lower_bound and upper_bound.
  </description>

  <\description>
    <item*|stl::binary_search (sv, first, last) x
    comp<label|stl::binary-search/stlvec>>returns true if x is an element of
    sv[first, last)
  </description>

  <subsubsection|Examples>

  See ut_sort.pure in the pure-stlvec/ut directory.

  <subsection|STL Merge Algorithms<label|stl-merge-algorithms>>

  The stlvec::merge module provides an interface to the STL's merge
  algorithms. These algorithms operate on sorted ranges.

  <subsubsection|Imports>

  To use the operations of this module, add the following import declaration
  to your program:

  <\verbatim>
    using stlvec::merge;
  </verbatim>

  All of the functions are in the stl namespace.

  <subsubsection|Operations>

  All of the functions in this module require the caller to supply an
  ordering function, comp (as for the Pure library sort function). They only
  work properly on input ranges that have been previously sorted using comp.
  The set operations generally do not check for range overflow because it is
  not generally possible to determine the length of the result of a set
  operation until after it is completed. In most cases you will get a nasty
  segmentation fault if the result is bigger than the target range. The best
  way to avoid this possibility it to use a back iterator to specifify the
  target range.

  See parameter naming conventions at ..

  <\description>
    <item*|stl::merge (sv1,first1,last1) (sv2,first2,last2) (msv,p)
    comp<label|stl::merge/stlvec>>merges the two sorted ranges into the
    sorted range msv[p,p+n) where n is the total length of the merged
    sequence
  </description>

  <\description>
    <item*|stl::inplace_merge (msv,first, middle, last)
    comp<label|stl::inplace-merge/stlvec>>merges msv[first,middle) and
    msv[middle,last) into the sorted range msv[first,last)
  </description>

  <\description>
    <item*|stl::includes (sv1,first1,last1) (sv2,first2,last2)
    comp<label|stl::includes/stlvec>>returns true if every element of
    sv2[first2,last2) is an element of sv1[first1,last1)
  </description>

  <\description>
    <item*|stl::set_union (sv1,first1,last1) (sv2,first2,last2) (msv,p)
    comp<label|stl::set-union/stlvec>>places the sorted union of
    sv1[first1,last1) and sv2[first2,last2) into msv[p,p+n) where n is the
    number of elements in the sorted union, and returns the past-the-end
    position of the sorted union
  </description>

  <\description>
    <item*|stl::set_intersection (sv1,first1,last1) (sv2,first2,last2)
    (msv,p) comp<label|stl::set-intersection/stlvec>>places the sorted
    intersection of sv1[first1,last1) and sv2[first2,last2) into msv[p,p+n)
    where n is the number of elements in the sorted intersection, and returns
    p+n (or stl::svend, if applicable)
  </description>

  <\description>
    <item*|stl::set_difference (sv1,first1,last1) (sv2,first2,last2) (msv,p)
    comp<label|stl::set-difference/stlvec>>places the sorted difference of
    sv1[first1,last1) and sv2[first2,last2) into msv[p,p+n) where n is the
    number of elements in the sorted difference, and returns p+n (or
    stl::svend, if applicable)
  </description>

  <\description>
    <item*|stl::set_symmetric_difference (sv1,first1,last1)
    (sv2,first2,last2) (msv,p) comp<label|stl::set-symmetric-difference/stlvec>>places
    the sorted symmetric_difference of sv1[first1,last1) and
    sv2[first2,last2) into msv[p,p+n) where n is the number of elements in
    the sorted symmetric_difference, and returns returns p+n (or stl::svend,
    if applicable)
  </description>

  <subsubsection|Examples>

  See ut_merge.pure in the pure-stlvec/ut directory.

  <subsection|STL Heap Algorithms<label|stl-heap-algorithms>>

  The stlvec::heap module provides an interface to the STL's heap operations.

  <subsubsection|Imports>

  To use the operations of this module, add the following import declaration
  to your program:

  <\verbatim>
    using stlvec::heap;
  </verbatim>

  All of the functions are in the stl namespace.

  <subsubsection|Operations>

  All of the functions in this module require the caller to supply an
  ordering function, comp (as for the Pure library sort function). The
  functions (\<less\>) and (\<gtr\>) are commonly passed as comp.

  <\description>
    <item*|stl::make_heap (msv,first,last)
    comp<label|stl::make-heap/stlvec>>rearranges the elements of
    msv[first,last) so that they are a heap, i.e., after this msv!first will
    be the largest element in msv[first,last), and push_heap and pop_heap
    will work properly
  </description>

  <\description>
    <item*|stl::push_heap (msv,first,last)
    comp<label|stl::push-heap/stlvec>>makes msv[first,last) a heap (assuming
    that msv[first,last-1) was a heap)
  </description>

  <\description>
    <item*|stl::pop_heap (msv,first,last)
    comp<label|stl::pop-heap/stlvec>>swaps msv!first with msv!(last-1), and
    makes msv[first,last-1) a heap (assuming that msv[first,last) was a heap)
  </description>

  <\description>
    <item*|stl::sort_heap (msv,first,last)
    comp<label|stl::sort-heap/stlvec>>sorts the elements in msv[first,last)
  </description>

  <subsubsection|Examples>

  See ut_heap.pure in the pure-stlvec/ut directory.

  <subsection|Min/Max STL Algorithms<label|min-max-stl-algorithms>>

  The stlvec::minmax module provides an interface to a few additional STL
  algorithms.

  <subsubsection|Imports>

  To use the operations of this module, add the following import declaration
  to your program:

  <\verbatim>
    using stlvec::minmax;
  </verbatim>

  All of the functions are in the stl namespace.

  <subsubsection|Operations>

  All of the functions in this module require the caller to supply an
  ordering function, comp (as for the Pure library sort function). The
  functions (\<less\>) and (\<gtr\>) are commonly passed as comp.

  <\description>
    <item*|stl::min_element (sv,first,last)
    comp<label|stl::min-element/stlvec>>returns the position of the minimal
    element of sv[first,last) under the ordering defined by comp
  </description>

  <\description>
    <item*|stl::max_element (sv,first,last)
    comp<label|stl::max-element/stlvec>>returns the position of the maximal
    element of sv[first,last) under the ordering defined by comp
  </description>

  <\description>
    <item*|stl::lexicographical_compare (sv1,first1,last1) (sv2,first2,last2)
    comp<label|stl::lexicographical-compare/stlvec>>compares
    sv1[first1,last1) and sv2[first2,last2) element by element according to
    the ordering defined by comp, and returns true if the first sequence is
    less than the second
  </description>

  Algorithms are provided for stepping through all the permutations the
  elements of a stlvec. For these purposes, the first permutation has the
  elements of msv[first,last) sorted in ascending order and the last has the
  elements sorted in descending order.

  <\description>
    <item*|stl::next_permutation (msv,first,last)
    comp<label|stl::next-permutation/stlvec>>rearranges msv[first,last) to
    produce the next permutation, in the ordering imposed by comp. If the
    elements of the next permutation is ordered (ascending or decending) by
    comp, return false. Otherwise return true.
  </description>

  <\description>
    <item*|stl::prev_permutation (msv,first,last)
    comp<label|stl::prev-permutation/stlvec>>next_permutation in reverse
  </description>

  <subsubsection|Examples>

  See ut_minmax.pure in the pure-stlvec/ut directory.

  <subsection|STL Numeric Algorithms<label|stl-numeric-algorithms>>

  The stlvec::numeric module provides an interface to the STL's numeric
  algorithms.

  <subsubsection|Imports>

  To use the operations of this module, add the following import declaration
  to your program:

  <\verbatim>
    using stlvec::numeric;
  </verbatim>

  All of the functions are in the stl namespace.

  <subsubsection|Operations>

  <\description>
    <item*|stl::accumulate (sv,first,last) x
    bin_fun<label|stl::accumulate/stlvec>>accumulate bin_fun over x and the
    members of sv[first,last), like foldl
  </description>

  <\description>
    <item*|stl::inner_product (sv1,first1,last1) (sv2,first2,last2) x
    bin_fun1 bin_fun2<label|stl::inner-product/stlvec>>initialize ret with x.
    Traverse pairs of elements of sv1[first1,last1) and sv2[first2,last2),
    denoted by (e1, e2), replacing ret with (bin_fun1 ret $ bin_fun2 e1 e2).
    The number pairs traversed is equal to the size of sv1[first1,last1)
  </description>

  <\description>
    <item*|stl::partial_sum (sv,first,last) (msv, p)
    bin_fun<label|stl::partial-sum/stlvec>>accumulate bin_fun f over the
    elements of sv1[first1,last1), placing itermediate results in msv[p,p+n),
    where n is last - first, and returns q where m is q - n and msv[m,q) is
    the intermediate sequence
  </description>

  <\description>
    <item*|stl::adjacent_difference (sv,first,last) (msv, p)
    bin_fun<label|stl::adjacent-difference/stlvec>>produce a sequence of new
    elements by applying bin_fun to adjacent elements of sv[first,last),
    placing the new elements in msv[p,p+n), where n is last - first, with the
    intermediate results, and returns q where m is q - n and msv[m,q) is the
    new sequence
  </description>

  <subsubsection|Examples>

  See ut_numeric.pure in the pure-stlvec/ut directory.

  <subsection|Reference Counting<label|reference-counting>>

  The following function, also in the stl namespace, is available if you want
  to observe how pure-stlvec maintains reference counts for items in its
  containers.

  <\description>
    <item*|stl::refc x<label|stl::refc/stlvec>>returns the x's reference
    count (maintained by the Pure runtime for garbage collection purposes)
  </description>

  <subsection|Backward Compatibilty<label|backward-compatibilty>>

  This section documents changes in pure-stlvec that might have introduced
  backward compatiblity issues.

  <subsubsection|pure-stlvec-0.2<label|pure-stlvec-0-2>>

  Bug fixes.

  <subsubsection|pure-stlvec-0.3<label|pure-stlvec-0-3>>

  Version 0.3 reflects some changes made to make <hlink|<em|pure-stlvec>|>
  consistent with its sister package, <hlink|<em|pure-stlmap>|pure-stlmap.tm>.

  The <hlink|<with|font-family|tt|update>|#update/stlvec> function was
  deprecated. Please use <hlink|<with|font-family|tt|replace>|#replace/stlvec>
  instead.

  The <hlink|<with|font-family|tt|replace>|#replace/stlvec> function was
  added to the stlvec module. This function is the same as
  <hlink|<with|font-family|tt|update>|#update/stlvec> except that
  ``<hlink|<with|font-family|tt|replace>|#replace/stlvec> sv i x'' returns x
  instead of sv.

  The <verbatim|stl::replace> function was removed from the stlvec/modifying
  module. You can use ``<hlink|<with|font-family|tt|stl::replace_if>|#stl::replace-if/stlvec>
  (sv,first,last) (x==) y'' instead of ``<verbatim|stl::replace>
  (sv,first,last) x y'' to replace all instances of x in the specified range.

  The function <verbatim|null> was removed and
  <hlink|<with|font-family|tt|stl::empty>|#stl::empty/stlvec> was added to
  replace it.

  The function <verbatim|list> was removed. You can use
  <hlink|<with|font-family|tt|members>|#members/stlvec> instead.

  The function <hlink|<with|font-family|tt|stl::random_shuffle>|#stl::random-shuffle/stlvec>
  was changed to take a seed as a second parameter.

  All of the tracing functions were removed.

  <subsubsection|pure-stlvec-0.4<label|pure-stlvec-0-4>>

  Fixed (\<gtr\>) predicate operating on plain old data when passed to STL
  algorithms.

  <subsubsection*|<hlink|Table Of Contents|index.tm><label|pure-stlvec-toc>>

  <\itemize>
    <item><hlink|pure-stlvec|#>

    <\itemize>
      <item><hlink|Copying|#copying>

      <item><hlink|Installation|#installation>

      <item><hlink|Overview|#overview>

      <\itemize>
        <item><hlink|Modules|#modules>

        <item><hlink|Simple Examples|#simple-examples>

        <item><hlink|Members and Sequences of
        Members|#members-and-sequences-of-members>

        <item><hlink|STL Iterators and Value
        Semantics|#stl-iterators-and-value-semantics>

        <item><hlink|Iterator Tuples|#iterator-tuples>

        <item><hlink|Predefined Iterator Tuple
        Indexes|#predefined-iterator-tuple-indexes>

        <item><hlink|Back Insert Iterators|#back-insert-iterators>

        <item><hlink|Data Structure|#data-structure>

        <item><hlink|Types|#types>

        <item><hlink|Copy-On-Write Semantics|#copy-on-write-semantics>

        <item><hlink|Documentation|#documentation>

        <item><hlink|Parameter Names|#parameter-names>
      </itemize>

      <item><hlink|Error Handling|#error-handling>

      <\itemize>
        <item><hlink|Exception Symbols|#exception-symbols>

        <item><hlink|Examples|#examples>
      </itemize>

      <item><hlink|Operations Included in the stlvec
      Module|#operations-included-in-the-stlvec-module>

      <\itemize>
        <item><hlink|Imports|#imports>

        <item><hlink|Operations in the Global
        Namespace|#operations-in-the-global-namespace>

        <item><hlink|Operations in the stl
        Namespace|#operations-in-the-stl-namespace>

        <item>Examples
      </itemize>

      <item><hlink|STL Nonmodifying Algorithms|#stl-nonmodifying-algorithms>

      <\itemize>
        <item>Imports

        <item><hlink|Operations|#operations>

        <item>Examples
      </itemize>

      <item><hlink|STL Modifying Algorithms|#stl-modifying-algorithms>

      <\itemize>
        <item>Imports

        <item>Operations

        <item>Examples
      </itemize>

      <item><hlink|STL Sort Algorithms|#stl-sort-algorithms>

      <\itemize>
        <item>Imports

        <item>Operations

        <item>Examples
      </itemize>

      <item><hlink|STL Merge Algorithms|#stl-merge-algorithms>

      <\itemize>
        <item>Imports

        <item>Operations

        <item>Examples
      </itemize>

      <item><hlink|STL Heap Algorithms|#stl-heap-algorithms>

      <\itemize>
        <item>Imports

        <item>Operations

        <item>Examples
      </itemize>

      <item><hlink|Min/Max STL Algorithms|#min-max-stl-algorithms>

      <\itemize>
        <item>Imports

        <item>Operations

        <item>Examples
      </itemize>

      <item><hlink|STL Numeric Algorithms|#stl-numeric-algorithms>

      <\itemize>
        <item>Imports

        <item>Operations

        <item>Examples
      </itemize>

      <item><hlink|Reference Counting|#reference-counting>

      <item><hlink|Backward Compatibilty|#backward-compatibilty>

      <\itemize>
        <item><hlink|pure-stlvec-0.2|#pure-stlvec-0-2>

        <item><hlink|pure-stlvec-0.3|#pure-stlvec-0-3>

        <item><hlink|pure-stlvec-0.4|#pure-stlvec-0-4>
      </itemize>
    </itemize>
  </itemize>

  Previous topic

  <hlink|pure-stlmap|pure-stlmap.tm>

  Next topic

  <hlink|Gnumeric/Pure: A Pure Plugin for Gnumeric|gnumeric-pure.tm>

  <hlink|toc|#pure-stlvec-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|gnumeric-pure.tm> \|
  <hlink|previous|pure-stlmap.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2014, Albert Gräf et al. Last updated on Jan
  28, 2014. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
