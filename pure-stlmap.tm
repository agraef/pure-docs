<TeXmacs|1.0.7.20>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-stlmap-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-stlvec.tm> \|
  <hlink|previous|pure-stllib.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|pure-stlmap<label|module-stlmap>>

  <label|module-stlmmap><label|module-stlhmap>Version 0.4, January 28, 2014

  Peter Summerland \<less\><hlink|p.summerland@gmail.com|mailto:p.summerland@gmail.com>\<gtr\>

  pure-stlmap is a <hlink|Pure|http://purelang.bitbucket.org> interface to
  six associative containers provided by the <hlink|C++ Standard
  Library|http://en.cppreference.com/w/cpp>: map, set, multimap, multiset,
  unordered_map and unordered_set.

  <subsection|Copying<label|copying>>

  Copyright (c) 2012 by Peter Summerland \<less\><hlink|p.summerland@gmail.com|mailto:p.summerland@gmail.com>\<gtr\>.

  All rights reserved.

  pure-stlmap is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE.

  pure-stlmap is distributed under a BSD-style license, see the COPYING file
  for details.

  <subsection|Introduction<label|introduction>>

  This is pure-stlmap-0.1, the first release of pure-stlmap. It is possible
  that some of the functions might be changed slightly or even removed.
  Comments and questions would be especially appreciated at this early stage.

  <subsubsection|Supported Containers<label|supported-containers>>

  The Standard C++ Containers Library, often refered to as the standard
  template library (``STL''), provides templates for generic containers and
  generic algorithms. pure-stlmap provides six mutable containers,
  ``stlmap'', ``stlset'', ``stlmmap'', ``stlmset'', ``stlhmap'' and
  ``stlhset'', that are thin wrappers around the corresponding associative
  containers provided by the STL, map, set, multimap, multiset, unordered_map
  and unordered_set, specialized to hold pure-expressions. pure-stlmap does
  not provide wrappers for unordered_multimap and unordered_multiset.

  <subsubsection|Interface<label|interface>>

  pure-stlmap provides a ``key-based'' interface that can be used to work
  with the supported STL containers in a way that should feel natural to Pure
  programmers. For example, the (!) function can be used to access values
  associated with keys and functions like
  <hlink|<with|font-family|tt|map>|#map/stlmap>,
  <hlink|<with|font-family|tt|foldl>|#foldl/stlmap>,
  <hlink|<with|font-family|tt|filter>|#filter/stlmap> and
  <hlink|<with|font-family|tt|do>|#do/stlmap> can be used to operate on all
  or part of a container's elements without using an explict tail recursive
  loop. In addition, for the ordered containers, stlmap, stlmmap, stlset and
  stlmset, pure-stlmap provides an ``interator-based'' interface that
  corresponds to the C++ interface, mostly on a one-to-one basis.

  The interface for the unordered or ``hash table'' containers, stlhmap and
  stlhset, is limited compared to that provided for the ordered containers.
  In particular iterators, operations on subsequences (ranges) and set
  operations are not supported.

  In some cases, the STL's associative containers have different semantics
  than the the associative containers provided by the Pure standard library.
  Where there is a conflict, pure-stlmap follows the STL.

  Many of the functions provided by pure-stlmap, such as the constructors,
  equivalence and lexicographical comparison operations, insert and erase
  operations, and the set operations are just thin wrappers around the the
  corresponding C++ functions. Users can consult the C++ Library
  documentation to understand the performance characteristics and corner case
  behavior of any pure-stlmap function that has a corresponding function in
  the STL.

  The C++ library is sometimes more complicated than the Pure Standard
  Library. For example many of the applicable C++ functions, including set
  operations and tests for equality, assume that the containers are
  lexicographically ordered. The reward for playing by the rules (which
  occurs automatically for stlmap and stlset) is O(n) time complexity for
  comparison and set operations.

  <subsection|Installation<label|installation>>

  pure-stlmap-0.4 is included in the ``umbrella'' addon,
  <hlink|<em|pure-stllib>|pure-stllib.tm> which is available at
  <hlink|http://code.google.com/p/pure-lang/downloads/list|http://code.google.com/p/pure-lang/downloads/list>.
  After you have downloaded and installed
  <hlink|<em|pure-stllib>|pure-stllib.tm>, you will be able to use
  pure-stlmap (and <hlink|<em|pure-stlvec>|pure-stlvec.tm>, as well).

  <subsection|Examples<label|examples>>

  The pure-stlmap/uts subdirectory contains Pure scripts that are used to
  test pure-stlmap. These scripts contain simple tests, each of which
  consists of a single line of code followed by a comment that contains the
  expected output. E.g.,

  <\verbatim>
    let sm1 = stlmap ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>3,"d"=\<gtr\>4,"e"=\<gtr\>5];

    //- ()

    \;

    sm1!stl::smbeg, sm1!"a", sm1!"d", sm1!"e"

    //- 1,1,4,5

    \;

    catch id $ sm1!"0";

    //- out_of_bounds
  </verbatim>

  You might consider pasting parts of these scripts into a temporary file
  that you can play with if you are curious about how something works.

  Two short example programs, anagrams.pure and poly.pure, can be found in
  the pure-stlmap/examples subdirectory.

  <subsection|Quick Start<label|quick-start>>

  This section introduces the basic functions you need to get up and running
  with pure-stlmap. For a quick look at the other functions provided by
  pure-stlmap, you can refer to pure-stllib-cheatsheet.pdf, which can be
  found in the pure-stllib/doc directory.

  <subsubsection|Example Containers<label|example-containers>>

  The code snippets that appear in the examples that follow assume that six
  containers have been created by entering the following at the prompt.

  <\verbatim>
    $\<gtr\> pure -q

    \<gtr\> using stlmap, stlhmap, stlmmap;

    \<gtr\> using namespace stl;

    \;

    \<gtr\> // Make some maps and sets with default characteristics

    \<gtr\> let sm \ = stlmap \ ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>3,"d"=\<gtr\>4,"e"=\<gtr\>5];

    \<gtr\> let shm = stlhmap ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>3,"d"=\<gtr\>4,"e"=\<gtr\>5];

    \<gtr\> let smm = stlmmap ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>31,"c"=\<gtr\>32,"d"=\<gtr\>4,"e"=\<gtr\>5];

    \<gtr\> let ss \ = stlset \ ["a","b","c","d","e"];

    \<gtr\> let shs = stlhset ["a","b","c","d","e"];

    \<gtr\> let sms = stlmset ["a","b","c","c","d"];
  </verbatim>

  The <verbatim|using> statement imports the three modules provided by
  pure-stlmap: <hlink|<with|font-family|tt|stlmap>|#module-stlmap> provides
  the interface for the stlmap and stlset containers,
  <hlink|<with|font-family|tt|stlmmap>|#module-stlmmap> provides the
  interface the stlmmap and stlmset containers, and
  <hlink|<with|font-family|tt|stlhmap>|#module-stlhmap> provides the
  interface to the stlhmap and stlhset containers. The <verbatim|let>
  statements set up an instance of each of the containers provided by
  pure-stlmap, loaded with some sample elements.

  To save typing you can run readme-data.pure, a file that contains the
  corresponding source code. It can be found in in the pure-stlmap/examples
  directory.

  <subsubsection|Constructors<label|constructors>>

  You can construct empty pure-stlmap containers using the
  <hlink|<with|font-family|tt|emptystlmap>|#emptystlmap/stlmap>,
  <hlink|<with|font-family|tt|emptystlset>|#emptystlset/stlmap>,
  <hlink|<with|font-family|tt|emptystlmmap>|#emptystlmmap/stlmap>,
  <hlink|<with|font-family|tt|emptystlmset>|#emptystlmset/stlmap>,
  <hlink|<with|font-family|tt|emptystlhmap>|#emptystlhmap/stlmap> and
  <hlink|<with|font-family|tt|emptystlhset>|#emptystlhset/stlmap> functions.

  <\verbatim>
    \<gtr\> let sm1 = emptystlmap; \ \ // uses (\<less\>) to order keys
  </verbatim>

  You can construct a pure-stlmap container and fill it with elements all in
  one go using the <hlink|<with|font-family|tt|stlmap>|#stlmap/stlmap>,
  <hlink|<with|font-family|tt|stlset>|#stlset/stlmap>,
  <hlink|<with|font-family|tt|stlmmap>|#stlmmap/stlmap>,
  <hlink|<with|font-family|tt|stlmset>|#stlmset/stlmap>,
  <hlink|<with|font-family|tt|stlhmap>|#stlhmap/stlmap> and
  <hlink|<with|font-family|tt|stlhset>|#stlhset/stlmap> functions.

  <\verbatim>
    \<gtr\> let shm1 = stlhmap ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>3];

    \;

    \<gtr\> members shm1;

    ["c"=\<gtr\>3,"a"=\<gtr\>1,"b"=\<gtr\>2]

    \;

    \<gtr\> smh1!"b";

    2
  </verbatim>

  As opposed to the hashed containers (stlhmap and stlhset), the ordered
  containers (stlmap, stlset, stlmmap and stlmset) keep their elements
  ordered by key.

  <\verbatim>
    \<gtr\> let sm1 = stlmap ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>3];
    members sm1;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>3]
  </verbatim>

  <subsubsection|Ranges<label|ranges>>

  For the ordered containers (stlmap, stlset, stlmmap and stlmset) you can
  work with subsequences, called ``ranges'', of the containers' elements. A
  range is specified by a tuple that consists of a container and two keys. If
  (sm, first_key, last_key) designates a range, the elements of the range are
  all of elements of the container sm whose keys are equivalent to or greater
  than first_key and less than last_key. If first_key and last_key are left
  out of the tuple, the range consists of all of sm's elements.

  <\verbatim>
    \<gtr\> members sm; \ \ \ \ \ \ \ \ \ \ \ \ \ \ // no range keys - the
    whole container

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>3,"d"=\<gtr\>4,"e"=\<gtr\>5]

    \;

    \<gtr\> members (sm,"b","e"); \ \ \ \ // a range from "b" up but not
    including "e"

    ["b"=\<gtr\>2,"c"=\<gtr\>3,"d"=\<gtr\>4]

    \;

    \<gtr\> members (sm,"c1","z"); \ \ \ // keys do not have to be stored

    ["d"=\<gtr\>4,"e"=\<gtr\>5]

    \;

    \<gtr\> members shm; \ \ \ \ \ \ \ \ \ \ \ \ \ // works on a unordered
    set (with no range keys)

    ["c"=\<gtr\>3,"d"=\<gtr\>4,"e"=\<gtr\>5,"a"=\<gtr\>1,"b"=\<gtr\>2]
  </verbatim>

  Two special keys, <hlink|<with|font-family|tt|stl::smbeg>|#stl::smbeg/stlmap>
  and <hlink|<with|font-family|tt|stl::smend>|#stl::smend/stlmap> are
  reserved for use in ranges to designate the first element in a container
  and the imaginary ``past-end'' element.

  <\verbatim>
    \<gtr\> members (sm,smbeg,"d");

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>3]

    \;

    \<gtr\> members (sm,"b",smend);

    ["b"=\<gtr\>2,"c"=\<gtr\>3,"d"=\<gtr\>4,"e"=\<gtr\>5]
  </verbatim>

  Perhaps it should go without saying, but you cannot use either of these
  symbols as the keys of elements stored in a pure-stlmap container.

  <subsubsection|Inserting and Replacing Elements<label|inserting-and-replacing-elements>>

  You can insert elements and, for the maps (stlmap, stlmmap and stlhmap),
  replace the values associated with keys that are already stored in the map,
  using the <hlink|<with|font-family|tt|insert>|#insert/stlmap>,
  <hlink|<with|font-family|tt|replace>|#replace/stlmap> and
  <hlink|<with|font-family|tt|insert_or_replace>|#insert-or-replace/stlmap>
  functions. For the maps, the elements to inserted are specified as
  (key=\<gtr\>value) hash-pairs.

  <\verbatim>
    \<gtr\> let sm1 = emptystlmap;

    \;

    \<gtr\> insert sm1 ("e"=\<gtr\>5); \ \ \ \ \ \ \ \ \ \ \ \ \ // returns
    number of elements inserted

    1

    \<gtr\> members sm1;

    ["e"=\<gtr\>5]

    \;

    \<gtr\> replace sm1 "e" 15; \ \ \ \ \ \ \ \ \ \ \ \ \ \ // returns value

    15

    \<gtr\> members sm1;

    ["e"=\<gtr\>15]

    \;

    \<gtr\> catch id $ replace sm1 "x" 10; \ \ \ // replace never inserts new
    elements

    out_of_bounds

    \;

    \<gtr\> insert sm1 ("e"=\<gtr\>25); \ \ \ \ \ \ \ \ \ \ \ \ // insert
    never changes existing elements

    0

    \<gtr\> members sm1;

    ["e"=\<gtr\>15]

    \;

    \<gtr\> insert_or_replace sm1 ("e"=\<gtr\>25); \ // 1 value changed

    1

    \<gtr\> members sm1;

    ["e"=\<gtr\>25]

    \<gtr\>
  </verbatim>

  The <hlink|<with|font-family|tt|insert>|#insert/stlmap> and
  <hlink|<with|font-family|tt|insert_or_replace>|#insert-or-replace/stlmap>
  functions are overloaded to insert or replace elements specified in a list,
  vector, stlvec or another pure-stlmap container (of the same type). E.g.,

  <\verbatim>
    \<gtr\> let sm2 = emptystlmap;

    \;

    \<gtr\> insert sm2 ["b"=\<gtr\>2,"a"=\<gtr\>1]; \ \ \ \ \ \ // insert
    from a list

    2

    \;

    \<gtr\> insert sm2 (sm,"c","e"); \ \ \ \ \ \ \ \ \ // insert from a range

    2

    \;

    \<gtr\> members sm2;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>3,"d"=\<gtr\>4]

    \;

    \<gtr\> insert_or_replace sm2 {"a"=\<gtr\>11,"e"=\<gtr\>15};

    2

    \;

    \<gtr\> members sm2;

    ["a"=\<gtr\>11,"b"=\<gtr\>2,"c"=\<gtr\>3,"d"=\<gtr\>4,"e"=\<gtr\>15]
  </verbatim>

  <subsubsection|Access<label|access>>

  If you want to see if a key is stored in a container use the
  <hlink|<with|font-family|tt|member>|#member/stlmap> function. (A key, k, is
  considered to be ``stored'' in a container if there is an element in the
  container that is equivalent to k.)

  <\verbatim>
    \<gtr\> member sm "x"; \ // ("x"=\<gtr\>val) is not an element of sm for
    any val

    0

    \;

    \<gtr\> member sm "a"; \ // ("a"=\<gtr\>1) is an element with key
    equivalent to "a"

    1
  </verbatim>

  The value (or values for a multi-key container) associated with a key can
  be accessed using the (!) function.

  <\verbatim>
    \<gtr\> sm!"a"; \ \ // return the value associated with "a"

    1

    \;

    \<gtr\> shm!"b"; \ // try it with a hashed map

    2

    \;

    \<gtr\> smm!"c"; \ // multimap returns a the list of values associated
    with "c"

    [31,32]

    \;

    \<gtr\> ss!"a"; \ \ // with sets, return the key

    "a"

    \;

    \<gtr\> sms!"c"; \ // with multisets, return a list of keys

    ["c","c"]
  </verbatim>

  If the key is not stored in the container, (!) throws an
  <hlink|<with|font-family|tt|out_of_bounds>|purelib.tm#out-of-bounds>
  exception.

  <\verbatim>
    \<gtr\> catch id $ sm!"x"; // "x" is not stored as a key in sm

    out_of_bounds
  </verbatim>

  Please note that all access is strictly by keys. For example you cannot use
  the <hlink|<with|font-family|tt|member>|#member/stlmap> function to
  determine if (``a''=\<gtr\>1) is an element stored in sm; you can only ask
  if the key ``a'' is stored in sm.

  <subsubsection|Erasing Elements<label|erasing-elements>>

  For any pure-stlmap container, you can use the
  <hlink|<with|font-family|tt|erase>|#erase/stlmap> function to remove all
  the elements associated with a given key in the container, all of the
  elements in the container or, unless the container is a stlhmap or stlhset,
  all of the elements in a range defined on the container.

  <\verbatim>
    \<gtr\> let shm1 = stlhmap shm; \ \ \ \ \ \ // make some copies of maps

    \<gtr\> let smm1 = stlmmap smm;

    \<gtr\> let sm1 = stlmap sm;

    \;

    \<gtr\> members smm1; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ // smm1 has
    multiple values for "c"

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>31,"c"=\<gtr\>32,"d"=\<gtr\>4,"e"=\<gtr\>5]

    \;

    \<gtr\> erase (shm1,"c"); \ \ \ \ \ \ \ \ \ \ \ \ // erase "c" keyed
    elements from a stlmmap

    1

    \<gtr\> members shm1; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ // all the "c"
    keyed elements are gone

    ["d"=\<gtr\>4,"e"=\<gtr\>5,"a"=\<gtr\>1,"b"=\<gtr\>2]

    \;

    \<gtr\> erase shm1; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ // erase all
    elements

    4

    \<gtr\> empty shm1;

    1

    \;

    \<gtr\> erase (sm1,"b","d"); \ \ \ \ \ \ \ \ // erase a subsequence

    2

    \<gtr\> members sm1;

    ["a"=\<gtr\>1,"d"=\<gtr\>4,"e"=\<gtr\>5]

    \;

    \<gtr\> erase (sm1,"x"); \ \ \ \ \ \ \ \ \ \ \ \ // attempt to erase
    something not there

    0

    \;

    \<gtr\> erase (smm1,"c"); \ \ \ \ \ \ \ \ \ \ \ // erase all elements
    with key "c"

    2

    \<gtr\> members smm1;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"d"=\<gtr\>4,"e"=\<gtr\>5]
  </verbatim>

  <subsubsection|Conversions<label|conversions>>

  The elements of an associated container be copied into a list, vector or
  stlvec using the <hlink|<with|font-family|tt|members>|#members/stlmap>,
  <hlink|<with|font-family|tt|stl::vector>|#stl::vector/stlmap> and
  <hlink|<with|font-family|tt|stlvec>|#stlvec/stlmap> functions. For ordered
  containers (stlmap, stlset, stlmmap and stlmset) the list, vector or stlvec
  can be built from a range.

  <\verbatim>
    \<gtr\> members ss;

    ["a","b","c","d","e"]

    \;

    \<gtr\> members (ss,"b","d"); // list subsequence from "b" up to but not
    "d"

    ["b","c"]

    \;

    \<gtr\> members (smm,"c","e");

    ["c"=\<gtr\>31,"c"=\<gtr\>32,"d"=\<gtr\>4]

    \;

    \<gtr\> members (shm,"b","d"); // fails - ranges not supported for
    stlhmaps

    stl::members (#\<less\>pointer 0x83b4908\<gtr\>,"b","d")

    \;

    \<gtr\> members shm; \ \ \ \ \ \ \ \ \ // ok - all elements are copied

    ["d"=\<gtr\>4,"e"=\<gtr\>5,"a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>3]

    \;

    \<gtr\> vector (sm,smbeg,"d");

    {"a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>3}

    \;

    \<gtr\> using stlvec;

    \<gtr\> members $ stlvec sm;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>3,"d"=\<gtr\>4,"e"=\<gtr\>5]
  </verbatim>

  You can convert the contents of an ordered container (stlmap, stlset,
  stlmmap or stlmset) or a range defined on one to a stream using the
  <hlink|<with|font-family|tt|stream>|#stream/stlmap> function.

  <\verbatim>
    \<gtr\> let ss1 = stlhset (0..100000);

    \;

    \<gtr\> stats -m

    \;

    \<gtr\> let xx = drop 99998 $ scanl (+) 0 (stream ss);

    0.3s, 18 cells

    \;

    \<gtr\> list xx;

    [704782707,704882705,704982704,705082704]

    0s, 17 cells
  </verbatim>

  <subsubsection|Functional Programming<label|functional-programming>>

  Most of the Pure list operations, including
  <hlink|<with|font-family|tt|map>|#map/stlmap>,
  <hlink|<with|font-family|tt|do>|#do/stlmap>,
  <hlink|<with|font-family|tt|filter>|#filter/stlmap>,
  <hlink|<with|font-family|tt|catmap>|#catmap/stlmap>,
  <hlink|<with|font-family|tt|foldl>|#foldl/stlmap> and
  <hlink|<with|font-family|tt|foldl1>|#foldl1/stlmap> can be applied to any
  of pure-stlmap's associative containers. E.g.,

  <\verbatim>
    \<gtr\> map (\\x-\<gtr\>x-32) shs;

    ["D","E","A","B","C"]

    \;

    \<gtr\> using system;

    \;

    \<gtr\> do (puts . str) (sm,smbeg,"c");

    "a"=\<gtr\>1

    "b"=\<gtr\>2

    ()
  </verbatim>

  List comprehensions also work.

  <\verbatim>
    \<gtr\> [k-32=\<gtr\>v+100 \| (k=\<gtr\>v) = smm; k\<gtr\>"a" &&
    k\<less\>"e"];

    ["B"=\<gtr\>102,"C"=\<gtr\>131,"C"=\<gtr\>132,"D"=\<gtr\>104]

    \;

    \<gtr\> {k-32=\<gtr\>v+100 \| (k=\<gtr\>v) = (smm,"b","e")};

    {"B"=\<gtr\>102,"C"=\<gtr\>131,"C"=\<gtr\>132,"D"=\<gtr\>104}
  </verbatim>

  It is highly recommended that you use the functional programming
  operations, as opposed to recursive loops, whenever possible.

  <subsection|Concepts<label|concepts>>

  This section describes pure-stlmap's containers, iterators, ranges,
  elements, keys, values and how these objects are related to each other. It
  also describes a group of functions associated with containers that help
  define the container's behavior. E.g., each ordered container (stlmap,
  stlset, stlmmap or stlmset) stores a function that it used to order its
  keys and to determine if two keys are equivalent.

  <subsubsection|Containers and Elements<label|containers-and-elements>>

  The six associative containers supported by pure-stlmap can be grouped
  together in terms of certain defining attributes.

  The three ``maps'' provided by pure-stlmap, stlmap, stlmmap and stlhmap,
  associate values with keys. If a value v is associated with a key, k, in an
  map, m, then we say that (k=\<gtr\>v) is an element of m, k is a key stored
  in m and v is a value stored in m.

  The three ``sets'' provided by pure-stlmap, stlset, stlmset and stlhset,
  hold single elements, as opposed to key value pairs. If an element e is
  contained a set, s, we say that e is simultaneously an element, key and
  value stored s. In other words, we sometimes speak of a set as if it were a
  map where each element, key and value are the same object.

  The ``ordered'' containers, stlmap, stlset, stlmmap and stlmset, each have
  a ``key-less-than'' function that they use keep their elements in a
  sequence that is ordered by keys. The default key-less-than function is
  <verbatim|(\<)>, but this can be changed when the container is created. The
  elements stored in a stlmap or stlset have unique keys, i.e., two elements
  stored in the container will never have equivalent keys. For these
  purposes, two keys are ``equivalent'' if neither key is key-less-than the
  other. In contrast, stlmmap and stlmset do not have unique keys. I.e., it
  is possible for different elements stored in a stlmmap or stlmset can have
  equivalent keys.

  The ``hashed'' containers, sthmap and stlhset do not keep their elements in
  a sequence. Instead they store their elments in a hash table using a
  ``key-hash'' function and a ``key-equal'' function. Currently the key-hash
  function is always <hlink|<with|font-family|tt|hash>|purelib.tm#hash> and
  the key-equal function is always (===), both of which are defined in the
  Prelude. The elements stored in a hashed container have unique keys. I.e.,
  two elements stored in the container will never by ``key-equal''. At times
  we say that two keys stored in a hashed container are ``equivalent'' if
  they are key-equal.

  The ``ordered maps'', stlmap and stlmmap, each have a ``value-less-than''
  function and a ``value-equal'' function that is used for lexicographical
  comparisons. The default functions are <verbatim|(\<)> and (==)
  respectively, but these can customized when the container is created.

  As is the case for the underlying C++ functions, set operations (i.e.,
  union, intersection, etc.) and container equivalence for the ordered
  containers are based on lexicographical comparisons. For these purposes one
  element, e1, is less than another, e2, if (a) e1's key is less-than e2's
  key and, (b) if the ordered container is a stlmap or stlmap, e1's value is
  value-less-than e2's value. Finally, for purposes of determining if two
  ordered containers are equal, e1 and e2 are considered to be equal if (a)
  their keys are equivalent and (b), in the case of stlmap or stlmmap, their
  values are value-equal.

  Set operations are not provided for the hashed containers, stlhmap and
  stlhset.

  <subsubsection|Ranges>

  For the ordered containers (stlmap, stlset, stlmmap and stlmset), you can
  work with a subsequence or ``range'' of a container's elements. Given an
  ordered container, oc, and keys f and l, the range (oc,f,l) consists of all
  of the elements in oc starting with the first element that is not less than
  f up to but not including the first element that is greater or equal to l.
  Note that f and l do not have to be stored in oc.

  <\verbatim>
    \<gtr\> members (sm,"b","e");

    ["b"=\<gtr\>2,"c"=\<gtr\>3,"d"=\<gtr\>4]

    \;

    \<gtr\> members (sm,"c1",smend);

    ["d"=\<gtr\>4,"e"=\<gtr\>5]
  </verbatim>

  When a range is passed to a function provided by pure-stlmap, the keys can
  be dropped, in which case the range consists of all of the container's
  elements.

  <\verbatim>
    \<gtr\> members sm;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>3,"d"=\<gtr\>4,"e"=\<gtr\>5]
  </verbatim>

  Please note that support for ranges is not provided for the unordered
  containers (stlhmap and stlhset). Most pure-stlmap functions that act on
  ranges can, however, operate on stlhmaps or stlhsets as well, except that,
  for stlhmaps and stlhsets, they always operate on all of the container's
  elements. Accordingly, whenever the documentation of a function refers to a
  range, and the container in question is a a stlhmap or stlhset, the range
  simply refers to the container itself.

  <subsubsection|Iterators<label|iterators>>

  The native STL interface is based on ``iterators'' that point to elements
  in containers. pure-stlmap provides support for iterators defined on its
  ordered containers (stlmap, stlmmap, stlset and stlmset) but not for its
  unordered containers (stlhmap and stlhset).

  Iterators are most useful when dealing with stlmmaps where elements with
  different values can have equivalent keys. In most cases, it is recommended
  that you avoid using iterators. The functions that operate on or return
  iterators are discussed separately at the end of this document.

  <subsubsection|Selecting Elements Using
  Keys<label|selecting-elements-using-keys>>

  Throughout pure-stlmap, unless you resort to using iterators, you can only
  specify elements and ranges of elements using keys. For example you cannot
  use the <hlink|<with|font-family|tt|member>|#member/stlmap> function to see
  if a specific key, value pair is an element of a stlmap.

  <\verbatim>
    \<gtr\> members sm;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>3,"d"=\<gtr\>4,"e"=\<gtr\>5]

    \;

    \<gtr\> member sm "a";

    1

    \;

    \<gtr\> catch id $ member sm (a=\<gtr\>1);

    bad_argument
  </verbatim>

  In the last line of code, <hlink|<with|font-family|tt|member>|#member/stlmap>
  treats (a=\<gtr\>1) as a key. Because (a=\<gtr\>1) cannot be compared to a
  string using <verbatim|(\<)>, the ersatz key is treated as a bad argument.

  This ``key access only'' approach can be an issue for stlmmaps and because
  multiple elements can have equivalent keys. I.e., given a stlmmap, smm,
  that containes multiple element with keys equivalent to, say, k, which
  element should (!) return? pure-stlmap dodges this issue by returning all
  on them. Thus, for stlmmap and stlmset (!) and
  <hlink|<with|font-family|tt|replace>|#replace/stlmap> work with lists of
  elements associated with a given key rather than, say, the first elment
  with the given key.

  <\verbatim>
    \<gtr\> members smm;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>31,"c"=\<gtr\>32,"d"=\<gtr\>4];

    \;

    \<gtr\> smm!"c";

    "c"=\<gtr\>[31,32]

    \;

    \<gtr\> replace smm "c" [31,32,33]; members smm;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>31,"c"=\<gtr\>32,"c"=\<gtr\>33,"d"=\<gtr\>4]

    \;

    \<gtr\> replace smm "c" []; members smm;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"d"=\<gtr\>4,"e"=\<gtr\>5]
  </verbatim>

  If selecting and replacing lists of elements with the same key is not
  convenient, you can always use iterators to track down and modify any
  specific element.

  <subsubsection|C++ Implementation<label|c-implementation>>

  For those that want to refer to the <hlink|C++ standard library
  documentation|http://en.cppreference.com/w/cpp>, stlmap is (essentially)
  map\<less\>px*,px*\<gtr\>, stlmmap is multimap\<less\>px*,px*\<gtr\> and
  stlhmap is unordered_map\<less\>px*,px*\<gtr\>, where px is defined by
  ``typedef pure_expr px''. I.e., in C++ Containers library speak, key_type
  is px*, mapped_type is px* and value_type is pair\<less\>px*,px*\<gtr\>.
  This might be a bit confusing because pure-stlmap's (key=\<gtr\>value)
  ``elements'' correspond to C++ value_types, a
  pair\<less\>key_type,mapped_type\<gtr\>, and pure-stlmap's values
  correspond to mapped_types. The C++ objects for stlset, stlmset and stlhset
  are the same as stlmap, stmmap and stlhmap except that pure-stlmap ensures
  that the second member of the C++ value_type pair is always NULL.

  <subsection|Modules<label|modules>>

  pure-stlmap provides three separate modules
  <hlink|<with|font-family|tt|stlmap>|#module-stlmap>,
  <hlink|<with|font-family|tt|stlmmap>|#module-stlmmap> and
  <hlink|<with|font-family|tt|stlhmap>|#module-stlhmap>.

  Importing any one of these modules defines the stl namespace as well as two
  important symbols, <hlink|<with|font-family|tt|stl::smbeg>|#stl::smbeg/stlmap>
  and <hlink|<with|font-family|tt|stl::smend>|#stl::smend/stlmap>.

  <\description>
    <item*|<em|constructor> stl::smbeg<label|stl::smbeg/stlmap>>

    <item*|<em|constructor> stl::smend<label|stl::smend/stlmap>>These symbols
    are used to designate the key of the first element in an ordered
    container (stlmap, stlset, stlmmap or stlmset) and the key of an
    imaginary element that would come immediately after the last element of
    in the constainer. They are used to define ranges over the ordered
    containers.
  </description>

  E.g.,

  <\verbatim>
    \<gtr\> members sm;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>3,"d"=\<gtr\>4,"e"=\<gtr\>5]

    \;

    \<gtr\> members (sm,"c",smend);

    ["c"=\<gtr\>3,"d"=\<gtr\>4,"e"=\<gtr\>5]
  </verbatim>

  <subsubsection|The stlhmap Module<label|the-stlhmap-module>>

  If all you want is fast insertion and lookup, you don't care about the
  order of the elements stored in the container, and you do not want to use
  set operations like <hlink|<with|font-family|tt|stl::map_intersection>|#stl::map-intersection/stlmap>,
  then <hlink|<with|font-family|tt|stlhmap>|#module-stlhmap> is probably your
  best choice. The supported containers, stlhmap and stlhset are simpler to
  use and faster than the other containers provided by pure-stlmap.

  The <hlink|<with|font-family|tt|stlhmap>|#module-stlhmap> module defines
  stlhmaps and stlhsets and provides functions for dealing with them. You can
  import it by adding the following <verbatim|using> statement to your code.

  <\verbatim>
    \<gtr\> using stlhmap;
  </verbatim>

  The <hlink|<with|font-family|tt|stlhmap>|#module-stlhmap> module defines
  types two types:

  <\description>
    <item*|<em|type> stlhmap<label|stlhmap/type>>

    <item*|<em|type> stlhset<label|stlhset/type>>
  </description>

  Please note that a stlhset is just a stlhmap where the values associated
  with keys cannot be accessed or modified. I.e., a stlhset is a specialized
  kind of stlhmap.

  <subsubsection|The stlmap Module<label|the-stlmap-module>>

  The <hlink|<with|font-family|tt|stlmap>|#module-stlmap> module provides you
  with stlmaps and stlsets and the functions that operate on them. Consider
  using these containers if you want their elements to be orderd by key, want
  to use ranges or if you are using any set operations
  (<hlink|<with|font-family|tt|stl::map_union>|#stl::map-union/stlmap>,
  <hlink|<with|font-family|tt|stl::map_intersection>|#stl::map-intersection/stlmap>,
  etc).

  You can import the stlmap module by adding the following using statement to
  your code.

  <\verbatim>
    \<gtr\> using stlmap;
  </verbatim>

  Importing the stlmap module introduces types to describe stlmap and stlset,
  their iterators and ranges defined on them.

  <\description>
    <item*|<em|type> stlmap<label|stlmap/type>>

    <item*|<em|type> stlset<label|stlset/type>>
  </description>

  <\description>
    <item*|<em|type> stlmap_iter<label|stlmap-iter/type>>
  </description>

  <\description>
    <item*|<em|type> stlmap_rng<label|stlmap-rng/type>>
  </description>

  Please note that a stlset is just a stlmap where the values associated with
  keys cannot be accessed or modified. I.e., a stlset is a specialized kind
  of stlmap. Accordingly, it is not necessary, for example, to define a
  separate type for iterators on stlsets as opposed to iterators on stlmaps.

  <subsubsection|The stlmmap Module<label|the-stlmmap-module>>

  If you need a multi-keyed container, the
  <hlink|<with|font-family|tt|stlmmap>|#module-stlmmap> module, which
  provides support for stlmaps and stlmsets, is your only choice. Set
  operations and ranges are supported, but the semantics are more complicated
  than is the case for stlmap and stlset. Because the keys stored in
  multi-keyed containers are not unique you might have to resort to using
  iterators when working with them.

  You can import the <hlink|<with|font-family|tt|stlmmap>|#module-stlmmap>
  module by adding the following using statement to your code.

  <\verbatim>
    \<gtr\> using stlmmap;
  </verbatim>

  Importing the stlmmap module introduces types to describe stlmmap and
  stlmset, along with their iterators and ranges defined on them.

  <\description>
    <item*|<em|type> stlmmap<label|stlmmap/type>>

    <item*|<em|type> stlmset<label|stlmset/type>>
  </description>

  <\description>
    <item*|<em|type> stlmmap_iter<label|stlmmap-iter/type>>
  </description>

  <\description>
    <item*|<em|type> stlmmap_rng<label|stlmmap-rng/type>>
  </description>

  Please note that a stlmset is just a stlmmap where the values associated
  with keys cannot be accessed or modified. I.e., a stlmset is a specialized
  kind of stlmmap. Accordingly, it is not necessary, for example, to define a
  separate type for iterators on stlmsets as opposed to iterators on
  stlmmaps.

  <subsection|Container Operations<label|container-operations>>

  Each of the six associative containers supported by pure-stlmap has its own
  set of unique characteristics. Because of this the description of functions
  that operate on more than one type of container can get a little
  complicated. When reading this section it might be helpful to consult
  pure-stllib-cheatsheet.pdf which can be found in the pure-stlib/doc
  directory.

  <subsubsection|Container Construction<label|container-construction>>

  New empty ordered containers (stlmap, stlset, stlmmap and stlmset) can be
  constructed using optional parameters that allow you to specify customized
  key-less-than functions, default values, value-less-than and value-equal
  functions.

  <\description>
    <item*|mkstlmap (klt,dflt,vlt,veq)<label|mkstlmap/stlmap>>

    <item*|mkstlmmap (klt,dflt,vlt,veq)<label|mkstlmmap/stlmap>>Create a new
    stlmap or stlmmap where <verbatim|klt> is the map's key-less-than
    function. dflt is the maps default value (used by replace_with and
    find_with_default). vlt is the map's value-compare function and veq is
    its value-equal function. Only <verbatim|klt> is required, and the
    default values for dflt, vlt, veq are [], (\<less\>) and (==)
    respectively.
  </description>

  <\description>
    <item*|mkstlset klt<label|mkstlset/stlmap>>

    <item*|mkstlmset klt<label|mkstlmset/stlmap>>Create a new stlset or
    stlmset where <verbatim|klt> is the set's key-less-than function.
  </description>

  The internal lookup functions for the ordered containers (stlmap, stlset,
  stlmmap and stlmset) are optimized to avoid callbacks if the container's
  key-less-than function is is <verbatim|(\>)> or <verbatim|(\<)> and the
  keys being compared are a pair of strings, ints, bigints or doubles.

  You can create an empty associative container using default values for
  using <hlink|<with|font-family|tt|emptystlmap>|#emptystlmap/stlmap> and
  friends.

  <\description>
    <item*|emptystlmap<label|emptystlmap/stlmap>>

    <item*|emptystlmmap<label|emptystlmmap/stlmap>>

    <item*|emptystlset<label|emptystlset/stlmap>>

    <item*|emptystlmset<label|emptystlmset/stlmap>>Create a new ordered map
    or set using default values. I.e., emptystlmap is the same as mkstlmap
    <verbatim|(\<)>, and so on.
  </description>

  <\description>
    <item*|emptystlhmap<label|emptystlhmap/stlmap>>

    <item*|emptystlhset<label|emptystlhset/stlmap>>Create a new stlhmap or
    stlhset with default values. The hash-function is hash and the
    value-equal function is (===).
  </description>

  Convenience functions are also provided to construct an empty container and
  insert elements into it in one go. The source of the elements can be a
  list, vector, a stlvec, or a range defined on another container of the same
  type as the new container.

  <\description>
    <item*|stlmap src<label|stlmap/stlmap>>

    <item*|stlmmap src<label|stlmmap/stlmap>>

    <item*|stlset src<label|stlset/stlmap>>

    <item*|stlmset src<label|stlmset/stlmap>>

    <item*|stlhmap src<label|stlhmap/stlmap>>

    <item*|stlhset src<label|stlhset/stlmap>>Create an associative
    constructor using default values and insert elements from copied from
    <verbatim|src>. <verbatim|src> can be a list, vector or stlvec of
    elements or a range defined over a container of the same type as the new
    container. If the new container is a stlmap, stlmmap or stlhmap, the
    elements of src must be (key=\<gtr\>val) pairs. If the new container is a
    stlset, stlmset or stlhset they can be any pure expression that can be
    used as a key (i.e., anything except for
    <hlink|<with|font-family|tt|stl::smbeg>|#stl::smbeg/stlmap> or
    <hlink|<with|font-family|tt|stl::smend>|#stl::smend/stlmap>).
  </description>

  <subsubsection|Information<label|information>>

  This group of functions allows you make inquiries regarding the number of
  elments in a container, the number of instances of a given key held by a
  container, the upper and lower bounds of a range and other information. In
  addition this group includes a function that can be used to change the
  number of slots used by a stlhmap or stlhset.

  <\description>
    <item*|# acon<label|#/stlmap>>Return the number of elements in
    <verbatim|acon>.
  </description>

  <\description>
    <item*|stl::empty acon<label|stl::empty/stlmap>>Return true if
    <verbatim|acon> is empty, else false.
  </description>

  <\description>
    <item*|stl::distance rng<label|stl::distance/stlmap>>Returns the number
    of elements contained in <verbatim|rng> where rng is a range defined on
    an ordered container (stlmap, stlmmap, stlset, stlmset).
  </description>

  <\description>
    <item*|stl::count acon k<label|stl::count/stlmap>>Returns the number of
    elements in an associative container, acon, that have a key that is
    equivalent to <verbatim|k>.
  </description>

  <\description>
    <item*|stl::bounds rng<label|stl::bounds/stlmap>>Return a pair of keys,
    first and last, such that first \<less\>= k \<less\> last for each k,
    where k is the key of an element in <verbatim|rng>. If there is no such
    last, the second member of the returned pair will be
    <hlink|<with|font-family|tt|stl::smend>|#stl::smend/stlmap>. If first is
    the key of the first element of <verbatim|rng's> container, the first
    member of the returned pair will <hlink|<with|font-family|tt|stl::smbeg>|#stl::smbeg/stlmap>.
  </description>

  Here are two examples using the <hlink|<with|font-family|tt|stl::bounds>|#stl::bounds/stlmap>
  function. Notice that bounds returns <hlink|<with|font-family|tt|stl::smbeg>|#stl::smbeg/stlmap>
  instead of ``a'' in the first example.

  <\verbatim>
    \<gtr\> members sm;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>3,"d"=\<gtr\>4,"e"=\<gtr\>5]

    \;

    \<gtr\> bounds sm;

    stl::smbeg,stl::smend

    \;

    \<gtr\> bounds (sm,"a1","e");

    "b","e"
  </verbatim>

  <\description>
    <item*|stl::container_info acon<label|stl::container-info/stlmap>>If
    <verbatim|acon> is a stlmap or stlmmap, returns (0, klt, dflt, vlt, veq)
    where klt is <verbatim|acon>`s key-less-than function, dflt is its
    default value, vlt is its value-less-than function and veq is its
    value_equal function. If <verbatim|acon> is a stlset or stlmset, returns
    (1,klt,_,_,_) where klt is <verbatim|acon>`s key-less-than function. If
    <verbatim|acon> is a stlhmap or stlhset, returns (is_set, bucket_count,
    load_factor, max_load_factor).
  </description>

  <\description>
    <item*|stl::bucket_size hacon n<label|stl::bucket-size/stlmap>>Returns
    the number of elements in <verbatim|hacon>`s nth (zero-based) bucket
    where <verbatim|hacon> is a stlhmap or stlhset.
  </description>

  <\description>
    <item*|stl::hmap_reserve hacon mlf size<label|stl::hmap-reserve/stlmap>>Sets
    <verbatim|hacon>`s max_load_factor to <verbatim|mlf>, sets the number of
    <verbatim|hacon> <verbatim|'s> <verbatim|buckets> <verbatim|to>
    <verbatim|``size>/<verbatim|mlf`> <verbatim|and> <verbatim|rehashes>
    <verbatim|``hacon> where <verbatim|hacon> is a stlhmap or stlhset.
  </description>

  <subsubsection|Modification<label|modification>>

  You can insert new items or, for the maps (stlmap, stlmmap and stlhmap),
  replace values associated with keys using the
  <hlink|<with|font-family|tt|insert>|#insert/stlmap>,
  <hlink|<with|font-family|tt|replace>|#replace/stlmap> or
  <hlink|<with|font-family|tt|insert_or_replace>|#insert-or-replace/stlmap>
  functions.

  Please note that when working with the ordered containers (stlmap, stlset,
  stlmmap and stlmset) the keys of elements passed to these functions must be
  compatible with the container's key-less-than function and keys that are
  already inserted. E.g.,

  <\verbatim>
    \<gtr\> members ss;

    ["a","b","c","d","e"]

    \;

    \<gtr\> catch id $ insert ss 1; \ \ // e.g., 1\<less\>"a" is not defined

    bad_argument
  </verbatim>

  Currently there is no similar restriction for stlhmaps and stlhsets because
  (a) they do not have a key-less-than function and (b) the function they do
  use for testing equality, the key-equal function is always (===), a
  function that can compare any two objects.

  <\verbatim>
    \<gtr\> members shs;

    ["c","d","e","a","b"]

    \;

    \<gtr\> insert shs 1;

    1

    \<gtr\> members shs;

    ["c",1,"d","e","a","b"]
  </verbatim>

  Elements can be inserted into a pure-stlmap container individually or en
  masse from a list, vector, stlvec or another container of the same type. If
  there is a key in the container that is equivalent to the key of the
  element being inserted, the element will not be inserted (unless the
  container is a stlmmap or stlmset, both of which can hold multiple elements
  with equivalent keys).

  <\description>
    <item*|insert acon src<label|insert/stlmap>>Attempts to copy elements
    from <verbatim|src> a valid ``insert source'' into <verbatim|acon> which
    can be any pure-stlmap container. A valid insert source is (a) a single
    element, (b) a list, vector, stlvec of elements or (c), a range over an
    associative container of the same type as <verbatim|acon>. If
    <verbatim|acon> is an associative map (stlmap, stlmmap or stlhmap), the
    <verbatim|src> itself, or all the elements of <verbatim|src>, must be key
    value pairs of the form (k=\<gtr\>v). In contrast, if <verbatim|acon> is
    a stlset, stlmset or stlhset, <verbatim|src> or all of its elements can
    be any pure object (except <hlink|<with|font-family|tt|stl::smbeg>|#stl::smbeg/stlmap>
    or <hlink|<with|font-family|tt|stl::smend>|#stl::smend/stlmap>). If
    <verbatim|acon> is a stlmap, stlset, stlhmap or stlhset, the element will
    not be inserted if its key is already stored in the target container.
    Returns the number of elements inserted, if any.
  </description>

  If you are dealing with a stlmap or stlhmap and want to override the values
  of elements have keys that equivalent to the keys of the items you wan to
  insert you can use the <hlink|<with|font-family|tt|insert_or_replace>|#insert-or-replace/stlmap>
  function.

  <\description>
    <item*|insert_or_replace acon src<label|insert-or-replace/stlmap>>The
    same as <hlink|<with|font-family|tt|insert>|#insert/stlmap> except that
    (a) <verbatim|acon> must be a stlmap or a stlhmap and (b) if an element
    (key=\<gtr\>newval) is about to be inserted and the container already
    contains an element (key=\<gtr\>oldval) the element in the container will
    be changed to (key=\<gtr\>newval). Returns the number of elements
    inserted or updated.
  </description>

  <\description>
    <item*|replace map key x<label|replace/stlmap>><verbatim|map> must be a
    stlmap, stlmmap or stlhmap. If <verbatim|key> is not stored in
    <verbatim|map> this function throws <hlink|<with|font-family|tt|out_of_bounds>|purelib.tm#out-of-bounds>.
    If <verbatim|map> is a stlmap or stlhmap and (oldkey=\<gtr\>oldval) is an
    element of <verbatim|map>, where oldkey is equivalent to <verbatim|key>,
    change the element to (oldkey=\<gtr\>``x``). If <verbatim|map> is a
    stlmmap and <verbatim|key> is stored in <verbatim|map>, change the values
    of elements with key eqivalent to <verbatim|key>, one by one, to the
    elements of <verbatim|x>. Add or delete elements as necessary so that,
    when the smoke clears, the values of <verbatim|map>!``key`` are copies of
    the elements of <verbatim|x>. In all cases, if <verbatim|key> is stored
    in <verbatim|map> returns <verbatim|x>.
  </description>

  Here are some examples using <hlink|<with|font-family|tt|replace>|#replace/stlmap>.

  <\verbatim>
    \<gtr\> members sm1;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>3,"d"=\<gtr\>4,"e"=\<gtr\>5]

    \;

    \<gtr\> replace sm1 "e" 50;

    50

    \;

    \<gtr\> members sm1;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>3,"d"=\<gtr\>4,"e"=\<gtr\>50]

    \;

    \<gtr\> members smm1;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>31,"c"=\<gtr\>32,"d"=\<gtr\>4,"e"=\<gtr\>5]

    \;

    \<gtr\> replace smm1 "c" [31,33,35,36] $$ smm1!"c";

    [31,33,35,36]

    \;

    \<gtr\> replace smm1 "c" [] $$ smm1!"c";

    []

    \;

    \<gtr\> members smm1;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"d"=\<gtr\>4,"e"=\<gtr\>5]
  </verbatim>

  <\description>
    <item*|replace_with fun map (k=\<gtr\>v)<label|replace-with/stlmap>><verbatim|map>
    must be a stlmap. The effect of this function is as follows: (a) if
    <math|\<sim\>> <hlink|<with|font-family|tt|member>|#member/stlmap>
    <verbatim|map> <verbatim|k> then <hlink|<with|font-family|tt|insert>|#insert/stlmap>
    <verbatim|map> (<verbatim|k``=\>dflt)> <verbatim|else> <verbatim|(),>
    <verbatim|where> <verbatim|dflt> <verbatim|is> <verbatim|``map>`s dflt
    value, (b) <hlink|<with|font-family|tt|replace>|#replace/stlmap>
    <verbatim|map> <verbatim|k> nv when nv = <verbatim|fun> <verbatim|v>
    (<verbatim|map>!``k``) end. Returns <verbatim|map>.
  </description>

  Here is an example using <hlink|<with|font-family|tt|replace_with>|#replace-with/stlmap>
  in which a stlmmap is converted to a stlmap.

  <\verbatim>
    \<gtr\> let sm1 = emptystlmap;

    \;

    \<gtr\> members smm;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>31,"c"=\<gtr\>32,"d"=\<gtr\>4,"e"=\<gtr\>5]

    \;

    \<gtr\> do (replace_with (:) sm1) smm;

    ()

    \;

    \<gtr\> members sm1;

    ["a"=\<gtr\>[1],"b"=\<gtr\>[2],"c"=\<gtr\>[32,31],"d"=\<gtr\>[4],"e"=\<gtr\>[5]]
  </verbatim>

  Here is another example in which items are counted.

  <\verbatim>
    \<gtr\> let sm1 = mkstlmap ( (\<less\>), 0 );

    \;

    \<gtr\> members sms;

    ["a","b","c","c","d"]

    \;

    \<gtr\> do (\\x-\<gtr\>replace_with (+) sm1 (x=\<gtr\>1)) sms;

    ()

    \;

    \<gtr\> members sm1;

    ["a"=\<gtr\>1,"b"=\<gtr\>1,"c"=\<gtr\>2,"d"=\<gtr\>1]
  </verbatim>

  You can remove all the elements in a container, remove all the elements
  equivalent to a given key or a remove a range of elements using the
  <hlink|<with|font-family|tt|erase>|#erase/stlmap> function.

  <\description>
    <item*|erase acon<label|erase/stlmap>>

    <item*|erase (acon,k)>

    <item*|erase (acon,k1,k2)>The first form erases all elements in
    <verbatim|acon> which can be any container provided by pure-stlmap. The
    second erases all elements in <verbatim|acon> with key equivalent to
    <verbatim|k>. The third erases the elements in the range
    (<verbatim|acon>,``k1``,``k2``). The third form only applys to the
    ordered containers (stlmap, stlmmap, stlset and stlmset), not stlhmap or
    stlhset (because ranges are not defined for stlhmaps or stlhsets).
    Returns the number of elements removed from the container.
  </description>

  Here are some examples using <hlink|<with|font-family|tt|erase>|#erase/stlmap>.

  <\verbatim>
    \<gtr\> members smm;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>31,"c"=\<gtr\>32,"d"=\<gtr\>4,"e"=\<gtr\>5]

    \;

    \<gtr\> erase (sm,"z");

    0

    \;

    \<gtr\> erase (smm,"c");

    2

    \;

    \<gtr\> members smm;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"d"=\<gtr\>4,"e"=\<gtr\>5]

    \;

    \<gtr\> erase (smm,"b","e");

    2

    \;

    \<gtr\> members smm;;

    ["a"=\<gtr\>1,"e"=\<gtr\>5]
  </verbatim>

  <\description>
    <item*|stl::swap acon1 acon2<label|stl::swap/stlmap>>Swaps the elements
    of the two containers, <verbatim|acon1> and <verbatim|acon2> where
    <verbatim|acon1> and <verbatim|acon2> are the same type of container
    (E.g., both are stlmaps or both are stlmsets).
  </description>

  <subsubsection|Accessing Elements<label|accessing-elements>>

  You can test if a key is stored in a container and access the value
  associated with a key using the familiar
  <hlink|<with|font-family|tt|member>|#member/stlmap> and (!) functions.

  <\description>
    <item*|member acon k<label|member/stlmap>>Returns true if
    <verbatim|acon>, any container provided by pure-stlmap, contains an
    element that has a key that is equivalent to <verbatim|k>.
  </description>

  <\description>
    <item*|acon ! k<label|!/stlmap>>If <verbatim|acon> is not a stlmmap then
    (a) if <verbatim|acon> has an element with key equivalent to <verbatim|k>
    return its value, otherwise (b) throw an
    <hlink|<with|font-family|tt|out_of_bounds>|purelib.tm#out-of-bounds>
    exception. If <verbatim|acon> is a stlmmap then (a) if acon has as least
    one element with key equivalent to <verbatim|k> return a list of values
    of all the elements with key equivalent to <verbatim|k>, otherwise (b)
    return an null list.
  </description>

  E.g.:

  <\verbatim>
    \<gtr\> sm!"c";

    3

    \;

    \<gtr\> catch id $ sm!"f"; \ \ \ // "f" is not stored in sm

    out_of_bounds

    \;

    \<gtr\> catch id $ sm!100; \ \ \ // 100 cannot be compared to strings
    using (\<less\>)

    bad_argument

    \;

    \<gtr\> smm!"c"; \ \ \ \ \ \ \ \ \ \ \ \ \ // for stlmmap, return list of
    values

    [31,32]

    \;

    \<gtr\> smm!"f"; \ \ \ \ \ \ \ \ \ \ \ \ \ // stlmmap returns null list
    if key is not stored

    []
  </verbatim>

  You can access a sequence of elements in an ordered container (stlmap,
  stlset, stlmmap or stlmset) without resorting to iterators using the
  next_key and prev_key functions.

  <\description>
    <item*|stl::next_key acon k<label|stl::next-key/stlmap>>

    <item*|stl::prev_key acon k<label|stl::prev-key/stlmap>><verbatim|acon>
    must be a stlmap, stlset, stlmmap or stlmmap. Also if <verbatim|k> is not
    <hlink|<with|font-family|tt|stl::smbeg>|#stl::smbeg/stlmap>,
    <hlink|<with|font-family|tt|stl::smend>|#stl::smend/stlmap> or an element
    of acon an <verbatim|out_of_bounds> exception will be throw.
    <hlink|<with|font-family|tt|next_key>|#stl::next-key/stlmap> returns the
    key of the first element in acon that has a key that is greater than
    <verbatim|k>. If no such element exists or if <verbatim|k> is
    <hlink|<with|font-family|tt|stl::smend>|#stl::smend/stlmap>, returns
    <hlink|<with|font-family|tt|stl::smend>|#stl::smend/stlmap>.
    <hlink|<with|font-family|tt|prev_key>|#stl::prev-key/stlmap> returns the
    last element in acon that has a key that is less that <verbatim|k>, or,
    if no such element exists, throws an <verbatim|out_of_bounds> exception.
  </description>

  For various reasons, it is very common to see a call to (!) or
  <hlink|<with|font-family|tt|replace>|#replace/stlmap> preceded by a call to
  <hlink|<with|font-family|tt|member>|#member/stlmap> with the same container
  and key. E.g.,

  <\verbatim>
    \<gtr\> bump_wc sm w = if member sm w then replace sm w (sm!w + 1)

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ else insert sm (w=\<gtr\>1);
  </verbatim>

  In general, this function would require two lookups to add a new word and
  three lookups to bump the count for an existing word. For the ordered
  containers, lookups have O(log N) complexity which can be relatively slow
  for large containers.

  To speed things up, each stlmap or stlset maintains a small cache of (key,
  C++ iterator) pairs for recently accessed keys. During lookup, the cache is
  checked for a matching key, and if the key is found, the element pointed to
  by the C++ iterator is used immediately. Thus, when applied to a stlmap or
  stlset bump_wc will use only one O(log N) search, rather than two or three.
  For these purposes, a key matches a key in the cache only if it is the same
  Pure object (i.e., the test is C++ pointer equality, not Pure's (===) or
  (==) functions). For example, the following will result in two O(log N)
  lookups.

  <\verbatim>
    \<gtr\> if member sm "a" then sm!"a" else insert sm ("a"=\<gtr\>10);
  </verbatim>

  Here each ``a'' is a distinct Pure object. The two ``a''s satisfy (==) and
  even (===) but they are not the same internally and the caching mechanism
  will not help.

  Almost any pure-stlmap function that accepts a stlmap or stlset as an
  argument will check the container's cache before doing an O(log N) lookup.
  Currently the cache is limited to hold only the most recently used key.

  Here are some examples produced by compiling pure-stlmap with a trace
  function that shows caching in action.

  <\verbatim>
    \<gtr\> let a_key = "a";

    \;

    \<gtr\> members sm;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>3,"d"=\<gtr\>4,"e"=\<gtr\>5]

    \;

    \<gtr\> member sm a_key; \ \ \ \ \ \ \ \ \ \ // a_key is not yet in the
    cache

    1

    \;

    \<gtr\> sm!a_key; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ // a_key is found in
    the cache

    found iterator for: "a"

    1

    \;

    \<gtr\> replace sm a_key 10;

    found iterator for: "a"

    10

    \;

    \<gtr\> sm!"a"; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ // "a" is a new
    key, not same C++ pointer as k or a_key

    1

    \;

    \<gtr\> let k = next_key sm a_key; // now k is in the cache, in front of
    a_key

    found iterator for: "a"

    \;

    \<gtr\> let k1 = next_key sm k; \ \ \ // now k1 is at the head of the
    queue

    found iterator for: "b"

    \;

    \<gtr\> replace sm k1 30;

    found iterator for: "c"

    30

    \;

    \<gtr\> members sm;

    ["a"=\<gtr\>10,"b"=\<gtr\>2,"c"=\<gtr\>30,"d"=\<gtr\>4,"e"=\<gtr\>5]
  </verbatim>

  These examples show that caching can be effective wnen visiting elements of
  a stlmap or stlset in order using <verbatim|next_key> or
  <verbatim|prev_key>.

  <subsubsection|Conversions>

  The contents of a pure-stlmap container can be copied to a list, vector,
  stlvec. For stlmaps, stlsets, stlmmaps and stlmsets, these operations act
  on ranges as well as on the entire container.

  <\description>
    <item*|members rng<label|members/stlmap>>Returns a list of the elments in
    the range, <verbatim|rng>.
  </description>

  <\description>
    <item*|keys rng<label|keys/stlmap>>

    <item*|vals rng<label|vals/stlmap>>Return the keys and vals of the
    range's elements.
  </description>

  Here are some examples using the <hlink|<with|font-family|tt|members>|#members/stlmap>,
  <hlink|<with|font-family|tt|keys>|#keys/stlmap> and
  <hlink|<with|font-family|tt|vals>|#vals/stlmap> functions.

  <\verbatim>
    \ \<gtr\> members shm; \ \ // must do all of shm elements because shm is
    a stlhmap

    ["d"=\<gtr\>4,"e"=\<gtr\>5,"a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>3]

    \;

    \<gtr\> keys (sm,"b","e"); // can ask for a range - sm is an ordered
    container

    ["b","c","d"]

    \;

    \<gtr\> vals (sm,"b","e");

    [2,3,4]
  </verbatim>

  <\description>
    <item*|stl::vector rng<label|stl::vector/stlmap>>Return a vector
    containing the elments of in the range, rng.
  </description>

  <\description>
    <item*|stlvec rng<label|stlvec/stlmap>>returns a stlvec containing the
    elments of in the range, rng.
  </description>

  You can also convert an ordered container (stlmap, stlset, stlmmap or
  stlmset) into a stream of elements.

  <\description>
    <item*|stream rng<label|stream/stlmap>>Returns a stream consisting of the
    range's elements.
  </description>

  Here is an example using the stream function on a stlmmap.

  <\verbatim>
    \<gtr\> members smm;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>31,"c"=\<gtr\>32,"d"=\<gtr\>4,"e"=\<gtr\>5]

    \;

    \<gtr\> take 3 $ stream smm;

    ("a"=\<gtr\>1):#\<less\>thunk 0xb70f438c\<gtr\>

    \;

    \<gtr\> list ans;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>31]
  </verbatim>

  <subsubsection|Functional Programming>

  pure-stlmap provides the most commonly used functional programming
  operations, implemented to act on ranges as if they were lists.

  <\description>
    <item*|do fun rng<label|do/stlmap>>

    <item*|map fun rng<label|map/stlmap>>

    <item*|filter pred rng<label|filter/stlmap>>

    <item*|foldl fun x rng<label|foldl/stlmap>>

    <item*|foldl1 fun rng<label|foldl1/stlmap>>

    <item*|foldr fun x rng<label|foldr/stlmap>>

    <item*|foldr1 fun rng<label|foldr1/stlmap>>These functions are the same
    as the corresponding functions provided in the Prelude for lists.
    <verbatim|rng> is a rng defined on a stlmap, stlset, stlmmap or stlmset
    or <verbatim|rng> is simply a stlhmap or stlhset.
    <hlink|<with|font-family|tt|foldr>|#foldr/stlmap> and
    <hlink|<with|font-family|tt|foldr1>|#foldr1/stlmap> are not defined for
    stlhmaps or stlhsets.
  </description>

  Here are some examples.

  <\verbatim>
    \<gtr\> members sm;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>3,"d"=\<gtr\>4,"e"=\<gtr\>5]

    \;

    \<gtr\> map (\\(k=\<gtr\>v)-\<gtr\>k+str v) (sm,"b","e");

    ["b2","c3","d4"]

    \;

    \<gtr\> foldr1 (\\(k=\<gtr\>v) (ks=\<gtr\>sum)-\<gtr\>
    (k+ks=\<gtr\>v+sum)) (sm,"b","e");

    "bcd"=\<gtr\>9

    \;

    \<gtr\> filter (\\(k=\<gtr\>v)-\<gtr\>v mod 2) sm;

    ["a"=\<gtr\>1,"c"=\<gtr\>3,"e"=\<gtr\>5]
  </verbatim>

  <\description>
    <item*|listmap fun rng<label|listmap/stlmap>>

    <item*|catmap fun rng<label|catmap/stlmap>>

    <item*|rowmap fun rng<label|rowmap/stlmap>>

    <item*|rowcatmap fun rng<label|rowcatmap/stlmap>>

    <item*|colmap fun rng<label|colmap/stlmap>>

    <item*|colcatmap fun rng<label|colcatmap/stlmap>>These functions are the
    same as the corresponding functions provided in the Prelude for lists.
    <verbatim|rng> is a rng defined on a stlmap, stlset, stlmmap or stlmset
    or simply a stlhmap or stlhset.
  </description>

  These functions are provided primarily to enable the use of list and matrix
  comprehensions over pure-stlmap's containers. E.g.,

  <\verbatim>
    \<gtr\> [ k + str v \| (k=\<gtr\>v) = (sm,"b","e")];

    ["b2","c3","d4"]

    \;

    \<gtr\> [ k=\<gtr\>v \| (k=\<gtr\>v) = sm; v mod 2];

    ["a"=\<gtr\>1,"c"=\<gtr\>3,"e"=\<gtr\>5]

    \;

    \<gtr\> { {k;v} \| \ (k=\<gtr\>v) = sm; v mod 2};

    {"a","c","e";1,3,5}
  </verbatim>

  The functional programming operations work directly on the underlying data
  structure.

  <\verbatim>
    \<gtr\> let ints = 0..10000;

    \;

    stats -m

    \<gtr\> filter (==99) ints;

    [99]

    0s, 6 cells
  </verbatim>

  <subsubsection|Comparison<label|comparison>>

  Two associative containers of the same type are considered to be equal if
  they contain the same number of elements and if each pair of their
  corresponding elements are equal. Two elements are equal if their keys are
  equivalent and, if the container is a stlmap, stlmap or stlhmap, the values
  associated with equal keys are equal (using the container's value-equal
  function).

  <\description>
    <item*|stl::map_equal rng1 rng2<label|stl::map-equal/stlmap>>
  </description>

  <\description>
    <item*|rng1 == rng2<label|==/stlmap>>

    <item*|rng1 <math|\<sim\>>= rng2<label|-tilde=/stlmap>>Test
    <verbatim|rng1> and <verbatim|rng2> for equality or nonequality where
    <verbatim|rng1> and <verbatim|rng2> are ranges defined over containers of
    the same type.
  </description>

  You need to be careful when using these operators. E.g.,

  <\verbatim>
    \<gtr\> members ss;

    ["a","b","c","d","e"]

    \;

    \<gtr\> let xx = stlset ss;

    \;

    \<gtr\> xx == ss;

    1

    \;

    \<gtr\> (xx,"a","c") == (ss,"a","c"); \ // oops!

    0
  </verbatim>

  The second comparison was intended to compare identical ranges and return
  true. It failed to do so because (==) is defined in the Prelude to compare
  tuples element by element, long before it is defined in the stlmap module
  to compare ranges. The tuple operation take precedence and determines that
  the tuples are not equal because <verbatim|xx> and <verbatim|ss> are
  different (pointers) for purposes of this comparison. To avoid this issue
  when using ranges, you can use the <hlink|<with|font-family|tt|stl::map_equal>|#stl::map-equal/stlmap>
  function.

  <\quote-env>
    \<gtr\> map_equal (xx,''a'',''c'') (ss,''a'',''c''); 1
  </quote-env>

  The other comparison operators <verbatim|(\<)>, <verbatim|(\<=)>,
  <verbatim|(\>)> and <verbatim|(\>=)> are provided only for the ordered
  containers (stlmap, stlset, stlmmap and stlmset). These operators reflect
  lexicographical comparisons of keys and, then if the keys are equal,
  lexicographical comparisons of values. I.e., this is not set inclusion -
  order matters. Accordingly, these comparison operators are not defined for
  a stlhmap or stlhset.

  <\description>
    <item*|rng1 \<less\> rng2<label|\<less\>/stlmap>>Traverse the ranges
    comparing pairs of elements e1 and e2. If e1 is less than e2, stop and
    return true; if e2 is less than e1 then stop and return false. If rng1 is
    exhausted but rng2 is not, return true, else return false. The two ranges
    must be defined on ordered associative containers of the same type.
  </description>

  <\description>
    <item*|rng1 \<gtr\> rng2<label|\<gtr\>/stlmap>>

    <item*|rng1 \<less\>= rng2<label|\<less\>=/stlmap>>

    <item*|rng1 \<gtr\>= rng2<label|\<gtr\>=/stlmap>>The these three
    operators are the same as <verbatim|rng2> \<less\> <verbatim|rng1>,
    <math|\<sim\>>(<verbatim|rng1>\<gtr\>``rng2`) and
    <math|\<sim\>>(<verbatim|rng1``\<``rng2>) respectively.
  </description>

  You also have to be careful when using equivalence and comparison operators
  with stlmmaps because elements with the same key and different values are
  not necessarily ordered by values.

  <\verbatim>
    \<gtr\> let smm2 = stlmmap ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>32,"c"=\<gtr\>31,"d"=\<gtr\>4];

    \;

    \<gtr\> members smm;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>31,"c"=\<gtr\>32,"d"=\<gtr\>4]

    \;

    \<gtr\> members smm2;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>32,"c"=\<gtr\>31,"d"=\<gtr\>4]

    \;

    \<gtr\> smm == smm2; // probably not what you want

    0
  </verbatim>

  These operations do not make much sense for a stlmmap unless elements with
  equivalent keys are stored by value, in the order enforced by the stlmmap's
  value-comp function. In this regard it is worth noting that, depending on
  your implementation, the <hlink|<with|font-family|tt|insert>|#insert/stlmap>
  function may or may not preserve the order of insertion of elements with
  equivalent keys (C++11 does preserve the order).

  <subsubsection|Set Algorithms<label|set-algorithms>>

  pure-stlmap provides wrappers for the STL set algorithms that apply to
  ranges defined on the four ordered associative containers (stlmap, stlset,
  stlmmap and stlmset). These algorithms are very efficient, with linear time
  complexity, but they do require that the elements of the two ranges be
  ordered. Accordingly, the set algorithms are not applicable to stlhmap or
  stlhset. Also, when dealing with stlmmaps, care must be taken to ensure
  that items with the equivalent keys are ordered by their values.

  <\description>
    <item*|stl::map_merge rng1 rng2<label|stl::map-merge/stlmap>>Constructs a
    new ordered container from <verbatim|rng1> and then insert the elments of
    <verbatim|rng2> into the new container and return it. <verbatim|rng1> and
    <verbatim|rng2> must be defined on the same type of ordered container.
  </description>

  <\description>
    <item*|stl::map_union rng1 rng2<label|stl::map-union/stlmap>>

    <item*|stl::map_difference rng1 rng2<label|stl::map-difference/stlmap>>

    <item*|stl::map_intersection rng1 rng2<label|stl::map-intersection/stlmap>>

    <item*|stl::map_symmetric_difference rng1
    rng2<label|stl::map-symmetric-difference/stlmap>>

    <item*|stl::map_includes rng1 rng2<label|stl::map-includes/stlmap>>Returns
    a new ordered associative container of the same type as the ordered
    containers underlying <verbatim|rng1> and <verbatim|rng2>. If the ranges
    are defined over a stlmap or stlmmap elements of <verbatim|rng1> have
    priority over the elments of <verbatim|rng2>. Uses <verbatim|rng1>`s
    key-less-than, value-less-than and value-equal functions.
  </description>

  pure-stlmap's set functions do not necessarily produce the same results as
  their Pure standard library counterparts. In particular, when applied to
  multi-keyed contaners, <hlink|<with|font-family|tt|stl::map_union>|#stl::map-union/stlmap>
  Produces the multiset union of its arguments while (+) in the Pure standard
  library produces the multiset sum. If you want the multiset sum of a
  stlmmap or stlhmap, use <hlink|<with|font-family|tt|stl::map_merge>|#stl::map-merge/stlmap>.
  Also, in pure-stlmap, as in the STL, the left hand map or set has priority
  of elements while in the Pure standard library the right hand set has
  priority of elements. This can make a difference when applying set
  operations to a pair of stlmaps or stlmmaps. E.g.,

  <\verbatim>
    \<gtr\> let smm1 = stlmmap ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>31,"c"=\<gtr\>32];

    \<gtr\> let smm2 = stlmmap ["c"=\<gtr\>32,"c"=\<gtr\>32,"c"=\<gtr\>33,"d"=\<gtr\>4,"e"=\<gtr\>5];

    \;

    \<gtr\> members $ map_merge smm1 smm2; // three "c"=\<gtr\>32

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>31,"c"=\<gtr\>32,"c"=\<gtr\>32,"c"=\<gtr\>32,"c"=\<gtr\>33,"d"=\<gtr\>4,"e"=\<gtr\>5]

    \;

    \<gtr\> members $ map_union smm1 smm2; \ // two "c"=\<gtr\>32

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>31,"c"=\<gtr\>32,"c"=\<gtr\>32,"c"=\<gtr\>33,"d"=\<gtr\>4,"e"=\<gtr\>5]

    \;

    \<gtr\> let sm1 = stlmap ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>31];

    \<gtr\> let sm2 = stlmap ["c"=\<gtr\>32,"d"=\<gtr\>4,"e"=\<gtr\>5];

    \;

    \<gtr\> members $ map_union sm1 sm2; // "c"=\<gtr\>31 from sm1, not
    "c"=\<gtr\>32 from sm2

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>31,"d"=\<gtr\>4,"e"=\<gtr\>5]

    \;

    \<gtr\> members $ map_intersection sm1 sm2; // "c"=\<gtr\>31 from sm1

    ["c"=\<gtr\>31]
  </verbatim>

  <subsubsection|Direct C Calls<label|direct-c-calls>>

  It is common to encounter code that (a) tests if a key is stored in a
  container using <hlink|<with|font-family|tt|member>|#member/stlmap> and (b)
  in the case of maps, retreives the value or values associated with the key
  using (!) and/or (c) changes the value or values using
  <hlink|<with|font-family|tt|replace>|#replace/stlmap>. Depending on what
  modules have been loaded, these functions may be heavily overloaded which
  can cause a small delay when the functions are called. To avoid this,
  pure-stlmap exposes the corresponding C functions so that they can be
  called directly. The C functions have the same name as the overloaded
  functions except for a prefix. E.g.,

  <\description>
    <item*|stl::sm_member sm key<label|stl::sm-member/stlmap>>

    <item*|stl::sm_get sm key<label|stl::sm-get/stlmap>>

    <item*|stl::sm_put sm key val<label|stl::sm-put/stlmap>>The first two
    functions are the direct C call equivalents of
    (<hlink|<with|font-family|tt|::member>|#member/stlmap> <verbatim|sm>
    <verbatim|key>) and (<verbatim|sm!key>). The third is like
    (<hlink|<with|font-family|tt|::replace>|#replace/stlmap> <verbatim|sm>
    <verbatim|key> <verbatim|val>) except that it will insert
    (key=\<gtr\>val) if key is not already stored in <verbatim|sm>. Here,
    <verbatim|sm> is a stlmap or a stlset (except that sm_put is not defined
    for stlsets).
  </description>

  <\description>
    <item*|stl::shm_member shm key<label|stl::shm-member/stlmap>>

    <item*|stl::shm_get shm key<label|stl::shm-get/stlmap>>

    <item*|stl::shm_put shm key val<label|stl::shm-put/stlmap>>The first two
    functions are the direct C call equivalents of
    (<hlink|<with|font-family|tt|::member>|#member/stlmap> <verbatim|shm>
    <verbatim|key>) and (<verbatim|shm!key>). The third is like
    (<hlink|<with|font-family|tt|::replace>|#replace/stlmap> <verbatim|shm>
    <verbatim|key> <verbatim|val>) except that it will insert
    (key=\<gtr\>val) if key is not already stored in <verbatim|shm>. Here,
    <verbatim|shm> is a stlhmap or a stlhset (except that shm_put is not
    defined for stlhsets).
  </description>

  <\description>
    <item*|stl::smm_member smm key<label|stl::smm-member/stlmap>>

    <item*|stl::smm_get smm key<label|stl::smm-get/stlmap>>

    <item*|stl::smm_put smm key vals<label|stl::smm-put/stlmap>>The first two
    functions are the direct C call equivalents of
    (<hlink|<with|font-family|tt|::member>|#member/stlmap> <verbatim|smm>
    <verbatim|key>) and (<verbatim|smm!key>). The third is like
    (<hlink|<with|font-family|tt|::replace>|#replace/stlmap> <verbatim|smm>
    <verbatim|key> <verbatim|val>) except that it will insert
    (key=\<gtr\>val1, key=\<gtr\>val2, ...) if key is not already stored in
    <verbatim|smm>. Here, <verbatim|smm> is a stlmmap or a stlmset (except
    that smm_put is not defined for stlmsets).
  </description>

  <subsection|Iterators>

  This section provides a quick overview of pure-stlmap's ``iterator-based''
  interface.

  <subsubsection|Concepts>

  Given a valid iterator you can access, modify or erase the element it
  points to.

  <\verbatim>
    \<gtr\> let sm1 = stlmap sm; members sm1;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>3,"d"=\<gtr\>4,"e"=\<gtr\>5];

    \;

    \<gtr\> let i = find sm1 "b"; \ \ // use find to get an iterator - like
    C++

    \;

    \<gtr\> get_elm i;

    "b"=\<gtr\>2

    \;

    \<gtr\> get_val i;

    2

    \;

    \<gtr\> put_val i 20;

    20

    \;

    \<gtr\> members sm1;

    ["a"=\<gtr\>1,"b"=\<gtr\>20,"c"=\<gtr\>3,"d"=\<gtr\>4,"e"=\<gtr\>5]
  </verbatim>

  Please note that you can never modify an element's key, only its value. If
  you want to change both key and value, you have to erase the element and
  insert a new element.

  <\verbatim>
    \<gtr\> erase (sm1,i) $$ insert sm1 ("b1"=\<gtr\>21);

    1

    \;

    \<gtr\> members sm1;

    ["a"=\<gtr\>1,"b1"=\<gtr\>21,"c"=\<gtr\>3,"d"=\<gtr\>4,"e"=\<gtr\>5]
  </verbatim>

  Given two iterators, i and j, pointing into a ordered container oc, the
  range (i,j), denotes oc's elements starting with ``oc[i]'', the element
  pointed to by i, up to but not including oc[j]. In pure-stlmap, this range
  is denoted by the tuple (i,j).

  <\verbatim>
    \<gtr\> members sm;

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>3,"d"=\<gtr\>4,"e"=\<gtr\>5]

    \;

    \<gtr\> let i = stl::find sm1 "b"; // get the iterator

    \;

    \<gtr\> let j = stl::find sm1 "e";

    \;

    \<gtr\> members (i,j); \ \ \ \ \ \ \ \ \ \ \ \ // get the elements in the
    range

    ["b"=\<gtr\>2,"c"=\<gtr\>3,"d"=\<gtr\>4]
  </verbatim>

  Perhaps it is worth mentioning that functions that act on ranges do not
  care if the range is specified by a pair of iterators or by keys.

  <\verbatim>
    \<gtr\> members ss;

    ["a","b","c","d","e"]

    \;

    \<gtr\> map (+21) (ss,"c",smend);

    ["x","y","z"]

    \;

    \<gtr\> let i = find ss "c";

    \<gtr\> let j = pastend ss;

    \<gtr\> map (+21) (i,j);

    ["x","y","z"]
  </verbatim>

  <subsubsection|Exceptions<label|exceptions>>

  In pure-stlmap functions that accept iterators throw a
  <verbatim|bad_argument> exception if called with an invalid iterator. An
  iterator remains valid until the element it was pointing to has been
  erased. These functions also attempt to throw bad argument exceptions for
  invalid usage that would otherwise result in undefined behavior. An example
  of an invalid use would be a range specified by iterators from different
  containers. Here are some examples of iterator errors.

  <\verbatim>
    \<gtr\> let i,j = find sm "a", find sm "d";

    \;

    \<gtr\> get_elm i, get_elm j;

    "a"=\<gtr\>1,"d"=\<gtr\>4

    \;

    \<gtr\> members (i,j);

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>3]

    \;

    \<gtr\> catch id $ members (j,i); // j and i transposed, C++ would
    segfault

    bad_argument

    \;

    \<gtr\> erase (sm,"b"); \ // erase "b"=\<gtr\>2, leaving i and j valid

    1

    \;

    \<gtr\> get_elm i; // still valid

    "a"=\<gtr\>1

    \;

    \<gtr\> erase (sm,"a"); \ // erase "a"=\<gtr\>1 - invalidating i

    1

    \;

    \<gtr\> catch id $ get_elm i; // bad iterator exception

    bad_argument
  </verbatim>

  <subsubsection|Functions<label|functions>>

  In this section ``acon'' always denotes one of the containers that supports
  interators (stlmap, stlset, stlmmap and stlmset).

  <\description>
    <item*|stl::iterator i<label|stl::iterator/stlmap>>Returns a new iterator
    that points to the same element as <verbatim|i>.
  </description>

  <\description>
    <item*|stl::begin acon<label|stl::begin/stlmap>>

    <item*|stl::pastend acon<label|stl::pastend/stlmap>>Returns
    <verbatim|acon>`s begin or past-end iterator.
  </description>

  <\description>
    <item*|stl::find acon k<label|stl::find/stlmap>>Creates a new iterator
    that points to an element in <verbatim|acon> with key equivalent to
    <verbatim|k> (if any) or <verbatim|acon>`s past-end iterator if no such
    element exists.
  </description>

  <\description>
    <item*|stl::find_with_default map k<label|stl::find-with-default/stlmap>>Returns
    an iterator pointing to the element in <verbatim|map>, a stlmap, with key
    equivalent to <verbatim|k>. If no such element existed before the call,
    one is created and inserted using <verbatim|k> and <verbatim|map>`s
    default value. This function is pure-stlmap's version of C++'s []
    operator for associative containers.
  </description>

  <\description>
    <item*|stl::insert_elm acon elm<label|stl::insert-elm/stlmap>>Attempts to
    insert <verbatim|elm> into <verbatim|acon>. (If <verbatim|acon> is a
    stlmap or stlmmap, then elm must be a key value pair, (k=\<gtr\>v)). If
    acon is a stlmap or stlset (i.e., with unique keys)
    <hlink|<with|font-family|tt|insert_elm>|#stl::insert-elm/stlmap> returns
    a pair, the first of which is an iterator pointing to the element with
    key k that was just inserted (or the pre-existing element that blocked
    the insertion). The second element in the pair is a boolean value that is
    true if a new element was inserted. In contrast, if <verbatim|acon> is a
    multi-keyed container (stlmmap or stlmset) the insert will always be
    successful and <hlink|<with|font-family|tt|insert_elm>|#stl::insert-elm/stlmap>
    returns an iterator pointing to the element with key k that was just
    inserted, instead of an (iterator, boolean) tuple.
  </description>

  <\description>
    <item*|stl::insert_elm acon (elm,i)>This is the same as the previous
    function except that (a) <verbatim|i> is passed in as a hint to where the
    new element should be inserted and (b) a single iterator is returned
    rather than a iterator,boolean pair. If the new element is inserted just
    after <verbatim|i>, the insertion can have constant time complexity.
  </description>

  <\description>
    <item*|stl::l_bound acon k<label|stl::l-bound/stlmap>>Return a new
    iterator that points to the first element in <verbatim|acon>, a stlmap,
    stlset, stlmmap or stlmset, that is not less than <verbatim|k>, or
    <verbatim|acon>`s past-end iterator if none exists.
  </description>

  <\description>
    <item*|stl::u_bound acon k<label|stl::u-bound/stlmap>>Return a new
    iterator that points to the first element in <verbatim|acon>, a stlmap,
    stlset, stlmmap or stlmset, that is greater than <verbatim|k>, or
    <verbatim|acon>`s past-end iterator if none exists.
  </description>

  <\description>
    <item*|stl::lu_bounds acon k<label|stl::lu-bounds/stlmap>>Return the pair
    l_bound <verbatim|acon> <verbatim|k>, u_bound <verbatim|acon>
    <verbatim|k>.
  </description>

  E.g.,

  <\verbatim>
    \<gtr\> let ok, smx, f, l = stl::range_info (sm1,"b","e");

    \;

    \<gtr\> ok, smx === sm1, stl::members (f,l);

    1,1,["b"=\<gtr\>2,"c"=\<gtr\>3,"d"=\<gtr\>4]
  </verbatim>

  <\description>
    <item*|stl::inc i<label|stl::inc/stlmap>>

    <item*|stl::dec i<label|stl::dec/stlmap>>

    <item*|stl::move i n::int<label|stl::move/stlmap>>Move the iterator
    <verbatim|i> forward one, back one or forward <verbatim|n> elements
    respectively, where n can be negative. The iterator is mutated by these
    operations, provided the move is successful. An attempt to move to a
    position before the first element's position causes an
    <verbatim|out_of_bounds> exception. Moves past the last element return
    the past-end iterator for the container that <verbatim|i> is defined on.
  </description>

  <\description>
    <item*|stl::get_elm i<label|stl::get-elm/stlmap>>

    <item*|stl::get_key i<label|stl::get-key/stlmap>>

    <item*|stl::get_val i<label|stl::get-val/stlmap>>Return the element
    pointed to by the iterator <verbatim|i>, or the element's key or value.
    For maps the element is returned as a key=\<gtr\>value hash rocket pair.
    For sets, get_elem, get_key and get_val all return the element (which is
    the same as its key).
  </description>

  <\description>
    <item*|stl::put_val i newvalue<label|stl::put-val>>Change the value of
    the element pointed to by the iterator <verbatim|i> to
    <verbatim|newvalue>. The element's key cannot be changed. The iterator
    must point into a stlmap or stlmmap.
  </description>

  <\description>
    <item*|stl::beginp i<label|stl::beginp/stlmap>>

    <item*|stl::pastendp i<label|stl::pastendp/stlmap>>Returns true if the
    iterator <verbatim|i> is the begin iterator or pastend iterator of the
    container it is defined on.
  </description>

  <\description>
    <item*|stl::get_info i<label|stl::get-info/stlmap>>Returns a tuple
    (is_valid,acon,key,val) where is_valid is true if the iterator
    <verbatim|i> is valid or false if not, acon is the container that i is
    defined on, and key, val are the key and value of the element
    <verbatim|i> points to, if any. If <verbatim|i> is the past-end iterator,
    key and val are set to <hlink|<with|font-family|tt|stl::smend>|#stl::smend/stlmap>
    and <verbatim|[]>, respectively.
  </description>

  <\description>
    <item*|i == j>Returns true if the iterators <verbatim|i> and <verbatim|j>
    point to the same element.
  </description>

  <\description>
    <item*|erase (acon,i)>

    <item*|erase (acon,i,j)>Erases the element pointed to by <verbatim|i> or
    the elements in the range (<verbatim|i>, <verbatim|j>). Both <verbatim|i>
    and <verbatim|j> must be iterators defined on <verbatim|acon> (or a
    <verbatim|bad_argument> exception will be thrown).
  </description>

  <subsubsection|Examples>

  Here are some examples using iterators.

  <\verbatim>
    \<gtr\> let b,e = begin smm, pastend smm;

    \;

    \<gtr\> members (b,e);

    ["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>31,"c"=\<gtr\>32,"d"=\<gtr\>4,"e"=\<gtr\>5]

    \;

    \<gtr\> let i,j = lu_bounds smm "c";

    \;

    \<gtr\> members (b,i);

    ["a"=\<gtr\>1,"b"=\<gtr\>2]

    \;

    \<gtr\> members (i,j);

    ["c"=\<gtr\>31,"c"=\<gtr\>32]

    \;

    \<gtr\> members (j,e);

    ["d"=\<gtr\>4,"e"=\<gtr\>5]

    \;

    \<gtr\> get_elm i;

    "c"=\<gtr\>31

    \;

    \<gtr\> get_elm (inc i);

    "c"=\<gtr\>32

    \;

    \<gtr\> put_val i 132;

    132

    \;

    \<gtr\> map (\\(k=\<gtr\>_)-\<gtr\>k=\<gtr\>ord k) (b,i);

    ["a"=\<gtr\>97,"b"=\<gtr\>98,"c"=\<gtr\>99]

    \;

    \<gtr\> let is_set, smm1, k, v = get_info i; is_set, members smm1, k, v;

    1,["a"=\<gtr\>1,"b"=\<gtr\>2,"c"=\<gtr\>31,"c"=\<gtr\>132,"d"=\<gtr\>4,"e"=\<gtr\>5],"c",132

    \;

    \<gtr\> get_elm (dec j);

    "c"=\<gtr\>132

    \;

    \<gtr\> inc j $$ inc j $$ get_elm j;

    "e"=\<gtr\>5

    \;

    \<gtr\> inc j $$ endp j;

    1
  </verbatim>

  <subsection|Backward Compatibilty<label|backward-compatibilty>>

  This section documents changes in pure-stlmap.

  <subsubsection|pure-stlmap-0.2<label|pure-stlmap-0-2>>

  Optimized common predicates, such as (\<less\>) and (\<gtr\>)

  <subsubsection|pure-stlmap-0.3<label|pure-stlmap-0-3>>

  Fixed (\<gtr\>) comparisons on plain old data.

  <subsubsection*|<hlink|Table Of Contents|index.tm><label|pure-stlmap-toc>>

  <\itemize>
    <item><hlink|pure-stlmap|#>

    <\itemize>
      <item><hlink|Copying|#copying>

      <item><hlink|Introduction|#introduction>

      <\itemize>
        <item><hlink|Supported Containers|#supported-containers>

        <item><hlink|Interface|#interface>
      </itemize>

      <item><hlink|Installation|#installation>

      <item><hlink|Examples|#examples>

      <item><hlink|Quick Start|#quick-start>

      <\itemize>
        <item><hlink|Example Containers|#example-containers>

        <item><hlink|Constructors|#constructors>

        <item><hlink|Ranges|#ranges>

        <item><hlink|Inserting and Replacing
        Elements|#inserting-and-replacing-elements>

        <item><hlink|Access|#access>

        <item><hlink|Erasing Elements|#erasing-elements>

        <item><hlink|Conversions|#conversions>

        <item><hlink|Functional Programming|#functional-programming>
      </itemize>

      <item><hlink|Concepts|#concepts>

      <\itemize>
        <item><hlink|Containers and Elements|#containers-and-elements>

        <item>Ranges

        <item><hlink|Iterators|#iterators>

        <item><hlink|Selecting Elements Using
        Keys|#selecting-elements-using-keys>

        <item><hlink|C++ Implementation|#c-implementation>
      </itemize>

      <item><hlink|Modules|#modules>

      <\itemize>
        <item><hlink|The stlhmap Module|#the-stlhmap-module>

        <item><hlink|The stlmap Module|#the-stlmap-module>

        <item><hlink|The stlmmap Module|#the-stlmmap-module>
      </itemize>

      <item><hlink|Container Operations|#container-operations>

      <\itemize>
        <item><hlink|Container Construction|#container-construction>

        <item><hlink|Information|#information>

        <item><hlink|Modification|#modification>

        <item><hlink|Accessing Elements|#accessing-elements>

        <item>Conversions

        <item>Functional Programming

        <item><hlink|Comparison|#comparison>

        <item><hlink|Set Algorithms|#set-algorithms>

        <item><hlink|Direct C Calls|#direct-c-calls>
      </itemize>

      <item>Iterators

      <\itemize>
        <item>Concepts

        <item><hlink|Exceptions|#exceptions>

        <item><hlink|Functions|#functions>

        <item>Examples
      </itemize>

      <item><hlink|Backward Compatibilty|#backward-compatibilty>

      <\itemize>
        <item><hlink|pure-stlmap-0.2|#pure-stlmap-0-2>

        <item><hlink|pure-stlmap-0.3|#pure-stlmap-0-3>
      </itemize>
    </itemize>
  </itemize>

  Previous topic

  <hlink|pure-stllib|pure-stllib.tm>

  Next topic

  <hlink|pure-stlvec|pure-stlvec.tm>

  <hlink|toc|#pure-stlmap-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-stlvec.tm> \|
  <hlink|previous|pure-stllib.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2014, Albert Gräf et al. Last updated on Jan
  28, 2014. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
