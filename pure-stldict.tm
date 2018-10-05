<TeXmacs|1.99.7>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-stldict-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-stllib.tm> \|
  <hlink|previous|pure-sockets.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|pure-stldict><label|module-stldict><label|module-hashdict><label|module-orddict><label|module-stldict>

  Version 0.8, April 11, 2018

  Albert Graef \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  This package provides a light-weight, no frills interface to the C++
  dictionary containers <verbatim|map> and <verbatim|unordered_map>. The
  <hlink|<with|font-family|tt|stldict>|#module-stldict> module makes these
  data structures available in Pure land and equips them with a (more or
  less) idiomatic Pure container interface.

  The C++ containers are part of the standard C++ library, see the <hlink|C++
  standard library documentation|http://en.cppreference.com/w/cpp> for
  details. They were originally based on the <hlink|Standard Template
  Library|http://www.sgi.com/tech/stl/>, so they are also sometimes referred
  to as \PSTL containers\Q; hence the name of this package.

  <subsection|Copying><label|copying>

  Copyright (c) 2011 by Albert Graef.

  pure-stldict is free software: you can redistribute it and/or modify it
  under the terms of the GNU Lesser General Public License as published by
  the Free Software Foundation, either version 3 of the License, or (at your
  option) any later version.

  pure-stldict is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License
  for more details.

  You should have received a copy of the GNU Lesser General Public License
  along with this program. If not, see \<less\><hlink|http://www.gnu.org/licenses/|http://www.gnu.org/licenses/>\<gtr\>.

  <subsection|Installation><label|installation>

  Get the latest source from <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-stldict-0.8.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-stldict-0.8.tar.gz>.

  Run <verbatim|make> to compile the modules and <verbatim|make>
  <verbatim|install> (as root) to install them in the Pure library directory.
  This requires GNU make, and of course you need to have Pure (and a C++
  library which includes the STL) installed.

  <verbatim|make> tries to guess your Pure installation directory and
  platform-specific setup. If it gets this wrong, you can set some variables
  manually, please check the Makefile for details.

  <with|font-series|bold|Note:> This module requires Pure 0.50 or later and a
  recent version of the C++ library (GNU libstdc++ v3 has been tested). All
  proper C++11 libraries should work out of the box, while (recent) C++0x
  implementations may require some fiddling with the sources and/or the
  compilation options. Pre C++0x library versions surely require considerably
  more work, especially in the hashdict module.

  <subsection|Usage><label|usage>

  After installation, you can use the operations of this package by placing
  the following import declaration in your Pure programs:

  <\verbatim>
    \;

    using stldict;

    \;
  </verbatim>

  This imports the whole shebang. If you only need either the hashed or the
  ordered dictionaries, you can also import the corresponding modules
  separately, i.e.:

  <\verbatim>
    \;

    using hashdict;

    \;
  </verbatim>

  or:

  <\verbatim>
    \;

    using orddict;

    \;
  </verbatim>

  <subsection|Types><label|types>

  In Pure land, the C++ <verbatim|map> and <verbatim|unordered_map>
  containers and their <verbatim|multimap> variants are made available as a
  collection of four data structures:

  <\description>
    <item*|<em|type> hashdict<label|hashdict/type>>

    <item*|<em|type> hashmdict<label|hashmdict/type>>Hashed (unordered)
    dictionary data structures. These work with arbitrary key (and value)
    types, like the hashed dictionary and set data structures in the standard
    library, and can be found in the <verbatim|hashdict.pure> module.
  </description>

  <\description>
    <item*|<em|type> orddict<label|orddict/type>>

    <item*|<em|type> ordmdict<label|ordmdict/type>>Ordered dictionary data
    structures. These require the keys to be ordered by the standard
    <verbatim|\<> predicate, like the ordered dictionary and set data
    structures in the standard library, and can be found in the
    <verbatim|orddict.pure> module.
  </description>

  Note that <hlink|<with|font-family|tt|hashdict>|#hashdict/type> and
  <hlink|<with|font-family|tt|hashmdict>|#hashmdict/type> differ in that the
  former has exactly one key-value association for each key in the
  dictionary, while the latter is a \Pmultidict\Q which allows multiple
  values to be associated with a key. The same applies to the
  <hlink|<with|font-family|tt|orddict>|#orddict/type> and
  <hlink|<with|font-family|tt|ordmdict>|#ordmdict/type> types.

  In addition, there are various supertypes which correspond to different
  unions of the hashed and ordered dictionary types. These are:

  <\description>
    <item*|<em|type> hashxdict<label|hashxdict/type>>

    <item*|<em|type> ordxdict<label|ordxdict/type>>Denotes any kind of hashed
    or ordered dictionary, respectively.
  </description>

  <\description>
    <item*|<em|type> stldict<label|stldict/type>>

    <item*|<em|type> stlmdict<label|stlmdict/type>>Denotes any kind of
    singled-valued or multi-valued dictionary, respectively.
  </description>

  <\description>
    <item*|<em|type> stlxdict<label|stlxdict/type>>Denotes any kind of
    dictionary.
  </description>

  For instance, you can use <hlink|<with|font-family|tt|hashxdict>|#hashxdict/type>
  to match both <hlink|<with|font-family|tt|hashdict>|#hashdict/type> and
  <hlink|<with|font-family|tt|hashmdict>|#hashmdict/type> values. Likewise,
  <hlink|<with|font-family|tt|stlmdict>|#stlmdict/type> matches both
  <hlink|<with|font-family|tt|hashmdict>|#hashmdict/type> and
  <hlink|<with|font-family|tt|ordmdict>|#ordmdict/type> values. To match any
  kind of dictionary, use the <hlink|<with|font-family|tt|stlxdict>|#stlxdict/type>
  type.

  These data structures are very thin wrappers around the C++ container
  types; in fact, they are just pointers to the C++ containers. Memory
  management of these objects is automatic, and customizable
  <hlink|pretty-printing|#pretty-printing> is provided as well.

  All data structures offer most of the usual Pure container interface (as
  well as some extensions). In contrast to the standard library dictionaries,
  they can be used both as dictionaries (holding key =\<gtr\> value pairs)
  and sets (holding only keys, without associated values), even at the same
  time.

  The other important difference to the standard library containers is that
  the stldict containers are <em|mutable> data structures; inserting and
  deleting members really modifies the underlying C++ containers. (However,
  it is possible to take copies of the containers in situations where it's
  necessary to preserve value semantics.)

  <subsection|Operations><label|operations>

  All types of dictionaries are simply pointers to the corresponding C++
  containers which hold key-value associations where both keys and values may
  be arbitrary Pure expressions. The <hlink|basic
  operations|#basic-operations> described below can be used to create, query
  and modify these objects. <hlink|Comparisons|#comparisons> of dictionaries
  are implemented as well, and the <hlink|set-like
  operations|#set-like-operations> let you combine dictionaries in different
  ways. These operations provide an interface similar to the usual Pure
  container API.

  In addition, the <hlink|<with|font-family|tt|stldict>|#module-stldict>
  module provides some <hlink|list-like operations|#list-like-operations> on
  dictionaries, so that the member data can be processed and aggregated in a
  convenient fashion (including the ability to use dictionaries as generators
  in list and matrix comprehensions), and there's also an interface to C++
  <hlink|iterators|#iterators> which enables you to traverse, inspect and
  modify the containers in a more C++-like way. Some <hlink|low-level
  operations|#low-level-operations> are available to access information about
  the underlying hash table of a hashed dictionary. Last but not least, the
  module also offers some operations to customize the
  <hlink|pretty-printing|#pretty-printing> of dictionary values.

  When working with these data structures, please note the following special
  properties of this implementation:

  <\itemize>
    <item>All dictionary types are <em|mutable>. Inserting and deleting
    members really modifies the underlying C++ data structure as a side
    effect of the operation. If you need value semantics, you should probably
    use one of the dictionary or set data structures from the standard Pure
    library instead. Another possibility is to take a copy of a hashdict
    using the <hlink|<with|font-family|tt|copy>|#copy/stldict> function if
    you need to preserve the original value.

    <item>Keys in a hashed dictionary may be stored in an apparently random
    order (not necessarily in the order in which they were inserted), while
    they are guaranteed to be in ascending order (by key) for ordered
    dictionaries. However, note that even in the latter case, the order of
    different members for the same key in a multi-valued dictionary is not
    specified. This must be taken into account when comparing dictionaries,
    see below. The order of members in a dictionary also matters when listing
    data from a container using, e.g., the
    <hlink|<with|font-family|tt|members>|#members/stldict>,
    <hlink|<with|font-family|tt|keys>|#keys/stldict> and
    <hlink|<with|font-family|tt|vals>|#vals/stldict> operations.

    <item>Two dictionaries are considered syntactically equal iff they
    contain the same elements in exactly the same order, using syntactic
    equality on both the keys and the associated values. This test can always
    be done in linear time, but is of limited usefulness for most kinds of
    dictionaries, since the exact order of members in the dictionary may vary
    depending on how the dictionary was constructed. Semantic equality
    operations are provided which check (albeit at the cost of increased
    running time) whether two containers contain the same members
    irrespective of element order, using semantic equality on the members.
    Various subset comparisons are provided as well, please check the
    <hlink|Comparisons|#comparisons> section for details.

    <item>Values in a dictionary can be omitted, so that a dictionary can
    also be used as a set data structure. This obviates the need for a
    separate set data structure at the cost of some (small) increase in
    memory usage. Also note that you can't really have a hash pair
    <verbatim|x=\>y> as a member of a set, since it always denotes a
    key-value association. As a remedy, you may use ordinary pairs
    <verbatim|(x,y)> instead.
  </itemize>

  <subsubsection|Basic Operations><label|basic-operations>

  <\description>
    <item*|hashdict xs<label|hashdict>>

    <item*|hashmdict xs<label|hashmdict>>

    <item*|orddict xs<label|orddict>>

    <item*|ordmdict xs<label|ordmdict>>Create a dictionary of the
    corresponding type from a list, tuple or vector of its members. Members
    can be specified as hash pairs <verbatim|x=\>y> to denote a key-value
    association. Any other kind of value denotes a singleton key without
    associated value. Note that the ordered dictionaries require that the
    keys be ordered, i.e., the <hlink|<with|font-family|tt|\<less\>>|purelib.tm#\<>
    predicate must be defined on them.

    The same operations can also be used to construct a dictionary from
    another dictionary of any type. If the given dictionary is already of the
    corresponding type, this is a no-op (if you want to copy the dictionary
    instead, use the <hlink|<with|font-family|tt|copy>|#copy/stldict>
    function below). Otherwise the given dictionary is converted to a new
    dictionary of the desired target type.
  </description>

  <\description>
    <item*|mkhashdict y xs<label|mkhashdict>>

    <item*|mkhashmdict y xs<label|mkhashmdict>>

    <item*|mkorddict y xs<label|mkorddict>>

    <item*|mkordmdict y xs<label|mkordmdict>>Create a dictionary from a list
    of keys and a constant value. The resulting dictionary has the given keys
    and <verbatim|y> as the value for each key.
  </description>

  <\description>
    <item*|copy m<label|copy/stldict>>Create a new dictionary with the same
    type and content as <verbatim|m>. This is useful if you want to preserve
    value semantics when using destructive update operations such as
    <hlink|<with|font-family|tt|insert>|#insert/stldict> and
    <hlink|<with|font-family|tt|delete>|#delete/stldict>. In such a case,
    <hlink|<with|font-family|tt|copy>|#copy/stldict> can be used to take a
    copy of the dictionary beforehand, so that the original dictionary
    remains unmodified.

    <with|font-series|bold|Note:> This operation needs linear time with
    respect to the size of the dictionary (i.e., its number of members). If
    logarithmic update times are needed while still preserving value
    semantics, you should use the dictionary and set data structures from the
    standard library instead.
  </description>

  <\description>
    <item*|hashdictp m<label|hashdictp>>

    <item*|hashmdictp m<label|hashmdictp>>

    <item*|orddictp m<label|orddictp>>

    <item*|ordmdictp m<label|ordmdictp>>Check whether the argument is a
    dictionary of the corresponding type.
  </description>

  <\description>
    <item*|hashxdictp m<label|hashxdictp>>

    <item*|ordxdictp m<label|ordxdictp>>

    <item*|stldictp m<label|stldictp>>

    <item*|stlmdictp m<label|stlmdictp>>

    <item*|stlxdictp m<label|stlxdictp>>Check whether the argument is a
    dictionary of the corresponding supertype.
  </description>

  <\description>
    <item*|# m<label|#/stldict>>The size of a dictionary (the number of
    members it contains).
  </description>

  <\description>
    <item*|m ! x<label|!/stldict>>Get the value stored under key <verbatim|x>
    in the dictionary <verbatim|m>. This may be <verbatim|x> itself if
    <verbatim|x> is a member of <verbatim|m> but has no associated value. In
    the case of a multidict this actually returns a list of values (which may
    be empty if <verbatim|m> doesn't contain <verbatim|x>). Otherwise an
    <hlink|<with|font-family|tt|out_of_bounds>|purelib.tm#out-of-bounds>
    exception is thrown if <verbatim|m> doesn't contain <verbatim|x>.
  </description>

  <\description>
    <item*|null m<label|null/stldict>>Test whether <verbatim|m> is empty,
    i.e., has zero members.
  </description>

  <\description>
    <item*|member m x<label|member/stldict>>Test whether <verbatim|m>
    contains a member with key <verbatim|x>.
  </description>

  <\description>
    <item*|members m<label|members/stldict>>

    <item*|list m<label|list/stldict>>Return the list of members of
    <verbatim|m>. The member list will be in an apparently random order in
    the hashed dictionary case, while it is guaranteed to be in ascending
    order (by key) for ordered dictionaries. The same order is also used for
    the other inspection operations below.
  </description>

  <\description>
    <item*|stream m<label|stream/stldict>>Like
    <hlink|<with|font-family|tt|list>|#list/stldict>, but the member list is
    returned as a lazy list (cf. <hlink|<em|Lazy Evaluation and
    Streams>|pure.tm#lazy-evaluation-and-streams>) whose members will be
    computed on the fly as the list is being traversed; cf.
    <hlink|Iterators|#iterators>.
  </description>

  <\description>
    <item*|tuple m<label|tuple/stldict>>

    <item*|vector m<label|vector/stldict>>Return the members as a tuple or
    vector.
  </description>

  <\description>
    <item*|keys m<label|keys/stldict>>Return the list of keys in the
    dictionary.
  </description>

  <\description>
    <item*|vals m<label|vals/stldict>>Return the list of corresponding
    values. In the case of a singleton key <verbatim|x> without associated
    value, <verbatim|x> itself is returned instead.
  </description>

  As already mentioned, the following modification operations are
  destructive, i.e., they actually modify the underlying dictionary data
  structure. If this is not desired, you'll first have to take a copy of the
  target dictionary, see <hlink|<with|font-family|tt|copy>|#copy/stldict>.

  <\description>
    <item*|insert m x<label|insert/stldict>>

    <item*|insert m (x=\<gtr\>y)<label|insert/stldict2>>

    <item*|update m x y<label|update/stldict>>Insert a singleton key
    <verbatim|x> or a key-value pair <verbatim|x=\>y> into <verbatim|m> and
    return the modified dictionary. This always adds a new member in a
    multidict, otherwise it replaces an existing value if there is one.
    <hlink|<with|font-family|tt|update>|#update/stldict> is provided as a
    fully curried version of <hlink|<with|font-family|tt|insert>|#insert/stldict2>,
    so <verbatim|update> <verbatim|m> <verbatim|x> <verbatim|y> behaves
    exactly like <verbatim|insert> <verbatim|m> <verbatim|(x=\>y)>.
  </description>

  <\description>
    <item*|delete m x<label|delete/stldict>>

    <item*|delete m (x=\<gtr\>y)<label|delete/stldict2>>Remove the key
    <verbatim|x> or the specific key-value pair <verbatim|x=\>y> from
    <verbatim|m> (if present) and return the modified dictionary. In the
    multidict case, only the first member with the given key <verbatim|x> or
    key-value pair <verbatim|x=\>y> is removed.
  </description>

  <\description>
    <item*|clear m<label|clear/stldict>>Remove all members from <verbatim|m>,
    making <verbatim|m> an empty dictionary. Returns <verbatim|()>.
  </description>

  <subsubsection|Comparisons><label|comparisons>

  The usual comparison predicates (<hlink|<with|font-family|tt|==>|purelib.tm#==>,
  <hlink|<with|font-family|tt|<math|\<sim\>>=>|purelib.tm#-tilde=>,
  <hlink|<with|font-family|tt|\<less\>=>|purelib.tm#\<=>,
  <hlink|<with|font-family|tt|\<less\>>|purelib.tm#\<> etc.) are defined on
  all dictionary types, where two dictionaries are considered \Pequal\Q
  (<verbatim|m1==m2>) if they both contain the same <verbatim|key=\>value>
  pairs, and <verbatim|m1\<=m2> means that <verbatim|m1> is a sub-dictionary
  of <verbatim|m2>, i.e., all <verbatim|key=\>value> pairs of <verbatim|m1>
  are also contained in <verbatim|m2> (taking into account multiplicities in
  the multidict case). Ordered dictionaries compare keys using equality
  (assuming two keys <verbatim|a> and <verbatim|b> to be equal if neither
  <verbatim|a\<b> nor <verbatim|b\<a> holds), while hashed dictionaries check
  for syntactical equality (using <hlink|<with|font-family|tt|===>|purelib.tm#===>).
  The associated values are compared using the
  <hlink|<with|font-family|tt|==>|purelib.tm#==> predicate if it is defined,
  falling back to syntactic equality otherwise.

  The module also defines syntactic equality on all dictionary types, so that
  two dictionaries of the same type are considered syntactically equal iff
  they contain the same (syntactically equal) members in the same order. This
  is always guaranteed if two dictionaries are \Pidentical\Q (the same C++
  pointer), but generally the member order will depend on how the dictionary
  was constructed. Thus if you need to check that two dictionaries contain
  the same members irrespective of the order in which the members are listed,
  the semantic equality operation <hlink|<with|font-family|tt|==>|purelib.tm#==>
  should be used instead; this will also handle the case of mixed operand
  types.

  Note that if you really need to check whether two dictionaries are the same
  object rather than just syntactically equal, you'll have to cast them to
  generic C pointers before comparing them with
  <hlink|<with|font-family|tt|===>|purelib.tm#===>. This can be done with the
  following little helper function:

  <\verbatim>
    \;

    same_dict x y = pointer_cast "void*" x === pointer_cast "void*" y;

    \;
  </verbatim>

  <subsubsection|Set-Like Operations><label|set-like-operations>

  These operations work with mixed operand types, promoting less general
  types to more general ones (i.e., ordered to hashed, and single-valued to
  multi-valued dictionaries). The result is always a new dictionary, leaving
  the operands unmodified.

  <\description>
    <item*|m1 + m2<label|+/stldict>>Sum: <verbatim|m1+m2> adds the members of
    <verbatim|m2> to <verbatim|m1>.
  </description>

  <\description>
    <item*|m1 - m2<label|-/stldict>>Difference: <verbatim|m1-m2> removes the
    members of <verbatim|m2> from <verbatim|m1>.
  </description>

  <\description>
    <item*|m1 * m2<label|*/stldict>>Intersection: <verbatim|m1*m2> removes
    the members <em|not> in <verbatim|m2> from <verbatim|m1>.
  </description>

  <subsubsection|List-Like Operations><label|list-like-operations>

  The following operations are all overloaded so that they work like their
  list counterparts, treating their dictionary argument as if it was the
  member list of the dictionary:

  <\itemize>
    <item><hlink|<with|font-family|tt|do>|purelib.tm#do>,
    <hlink|<with|font-family|tt|map>|purelib.tm#map>,
    <hlink|<with|font-family|tt|catmap>|purelib.tm#catmap>,
    <hlink|<with|font-family|tt|listmap>|purelib.tm#listmap>,
    <hlink|<with|font-family|tt|rowmap>|purelib.tm#rowmap>,
    <hlink|<with|font-family|tt|rowcatmap>|purelib.tm#rowcatmap>,
    <hlink|<with|font-family|tt|colmap>|purelib.tm#colmap>,
    <hlink|<with|font-family|tt|colcatmap>|purelib.tm#colcatmap>

    <item><hlink|<with|font-family|tt|all>|purelib.tm#all>,
    <hlink|<with|font-family|tt|any>|purelib.tm#any>,
    <hlink|<with|font-family|tt|filter>|purelib.tm#filter>,
    <hlink|<with|font-family|tt|foldl>|purelib.tm#foldl>,
    <hlink|<with|font-family|tt|foldl1>|purelib.tm#foldl1>,
    <hlink|<with|font-family|tt|foldr>|purelib.tm#foldr>,
    <hlink|<with|font-family|tt|foldr1>|purelib.tm#foldr1>,
    <hlink|<with|font-family|tt|scanl>|purelib.tm#scanl>,
    <hlink|<with|font-family|tt|scanl1>|purelib.tm#scanl1>,
    <hlink|<with|font-family|tt|scanr>|purelib.tm#scanr>,
    <hlink|<with|font-family|tt|scanr1>|purelib.tm#scanr1>,
    <hlink|<with|font-family|tt|sort>|purelib.tm#sort>
  </itemize>

  Note that this includes the generic comprehension helpers
  <hlink|<with|font-family|tt|listmap>|purelib.tm#listmap>,
  <hlink|<with|font-family|tt|catmap>|purelib.tm#catmap> et al, so that
  dictionaries can be used as generators in list and matrix comprehensions as
  usual (see below for some <hlink|examples|#examples>).

  <subsubsection|Iterators><label|iterators>

  These operations give direct access to C++ iterators on dictionaries which
  let you query the elements and do basic manipulations of the container. The
  operations are available in the <verbatim|stldict> namespace.

  The iterator concept is somewhat alien to Pure and there are some pitfalls
  (most notably, destructive updates may render iterators invalid), but the
  operations described here are still useful in some situations, especially
  if you need to speed up sequential accesses to large containers or modify
  values stored in a container in a direct way. They are also used internally
  to compute lazy member lists of containers
  (<hlink|<with|font-family|tt|stream>|#stream/stldict> function).

  You should only use these directly if you know what you are doing. In
  particular, make sure to consult the <hlink|C++ standard library
  documentation|http://en.cppreference.com/w/cpp> for further details on C++
  iterator usage.

  The following operations are provided to create an iterator for a given
  dictionary.

  <\description>
    <item*|stldict::begin m<label|stldict::begin>>

    <item*|stldict::end m<label|stldict::end>>Return iterators pointing to
    the beginning and the end of the container. (Note that
    <hlink|<with|font-family|tt|stldict::end>|#stldict::end> <em|must> always
    be specified in qualified form since <verbatim|end> is a keyword in the
    Pure language.)
  </description>

  <\description>
    <item*|stldict::find m x<label|stldict::find>>Locates a key or specific
    key=\<gtr\>value pair <verbatim|x> in the container and returns an
    iterator pointing to the corresponding member (or <verbatim|stldict::end>
    <verbatim|m> if <verbatim|m> doesn't contain <verbatim|x>).
  </description>

  Note that these operations return a new iterator object for each
  invocation. Also, the created iterator object keeps track of the container
  it belongs to, so that the container isn't garbage-collected while the
  iterator is still being used. However, removing a member from the container
  (using either <hlink|<with|font-family|tt|delete>|#delete/stldict> or
  <hlink|<with|font-family|tt|stldict::erase>|#stldict::erase>) invalidates
  all iterators pointing to that member; the result of trying to access such
  an invalidated iterator is undefined (most likely your program will crash).

  Similar caveats also apply to the <hlink|<with|font-family|tt|stream>|#stream/stldict>
  function which, as already mentioned, uses iterators internally to
  implement lazy list traversal of the members of a dictionary. Thus, if you
  delete a member of a dictionary while traversing it using
  <hlink|<with|font-family|tt|stream>|#stream/stldict>, you better make sure
  that this member is not the next stream element remaining to be visited;
  otherwise bad things will happen.

  The following operations on iterators let you query and modify the contents
  of the underlying container:

  <\description>
    <item*|stldict::dict i<label|stldict::dict>>Return the dictionary to
    which <verbatim|i> belongs.
  </description>

  <\description>
    <item*|stldict::endp i<label|stldict::endp>>Check whether the iterator
    <verbatim|i> points to the end of the container (i.e., past the last
    element).
  </description>

  <\description>
    <item*|stldict::next i<label|stldict::next>>Advance the iterator to the
    next element. Note that for convenience, in contrast to the corresponding
    C++ operation this operation is non-destructive. Thus it actually creates
    a <em|new> iterator object, leaving the original iterator <verbatim|i>
    unmodified. The operation fails if <verbatim|i> is already at the end of
    the container.
  </description>

  <\description>
    <item*|stldict::get i<label|stldict::get>>Retrieve the key=\<gtr\>val
    pair stored in the member pointed to by <verbatim|i> (or just the key if
    there is no associated value). The operation fails if <verbatim|i> is at
    the end of the container.
  </description>

  <\description>
    <item*|stldict::put i y<label|stldict::put>>Change the value associated
    with the member pointed to by <verbatim|i> to <verbatim|y>, and return
    the new value <verbatim|y>. The operation fails if <verbatim|i> is at the
    end of the container. Note that <hlink|<with|font-family|tt|stldict::put>|#stldict::put>
    only allows you to set the associated value, <em|not> the key of the
    member.
  </description>

  <\description>
    <item*|stldict::erase i<label|stldict::erase>>Remove the member pointed
    to by <verbatim|i> (this invalidates <verbatim|i> and all other iterators
    pointing to this member). The operation fails if <verbatim|i> is at the
    end of the container.
  </description>

  <\description>
    <item*|i == j<label|==/stldict-iterator>>

    <item*|i <math|\<sim\>>= j<label|-tilde=/stldict-iterator>>Semantic
    equality of iterators. Two iterators are considered equal (<verbatim|i>
    <verbatim|==> <verbatim|j>) if <verbatim|i> and <verbatim|j> point to the
    same element in the same container, and unequal (<verbatim|i>
    <verbatim|~=> <verbatim|j>) if they don't. (In contrast, note that
    iterators are in fact just pointers to a corresponding C++ data
    structure, and thus <em|syntactical> equality (<verbatim|i>
    <verbatim|===> <verbatim|j>) holds only if two iterators are the same
    object.)
  </description>

  <subsubsection|Low-Level Operations><label|low-level-operations>

  The <hlink|<with|font-family|tt|hashdict>|#module-hashdict> module also
  provides a few specialized low-level operations dealing with the layouts of
  buckets and the hash policy of the <hlink|<with|font-family|tt|hashdict>|#hashdict/type>
  and <hlink|<with|font-family|tt|hashmdict>|#hashmdict/type> containers,
  such as <verbatim|bucket_count>, <verbatim|load_factor>, <verbatim|rehash>
  etc. These operations, which are all kept in their own separate
  <verbatim|hashdict> namespace, are useful to obtain performance-related
  information and modify the setup of the underlying hash table. Please check
  the <verbatim|hashdict.pure> module and the <hlink|C++ standard library
  documentation|http://en.cppreference.com/w/cpp> for further details.

  <subsubsection|Pretty-Printing><label|pretty-printing>

  By default, dictionaries are pretty-printed in the format
  <verbatim|somedict> <verbatim|xs>, where <verbatim|somedict> is the actual
  construction function such as <verbatim|hashdict>, <verbatim|orddict>,
  etc., and <verbatim|xs> is the member list of the dictionary. This is
  usually convenient, as the printed expression will evaluate to an equal
  container when reentered as Pure code. However, it is also possible to
  define your own custom pretty-printing with the following function.

  <\description>
    <item*|hashdict_symbol f<label|hashdict-symbol>>

    <item*|hashmdict_symbol f<label|hashmdict-symbol>>

    <item*|orddict_symbol f<label|orddict-symbol>>

    <item*|ordmdict_symbol f<label|ordmdict-symbol>>Makes the pretty-printer
    use the format <verbatim|f> <verbatim|xs> (where <verbatim|xs> is the
    member list) for printing the corresponding type of dictionary.
  </description>

  Note that <verbatim|f> may also be an operator symbol (nonfix and unary
  symbols work best). In the case of an outfix symbol the list brackets
  around the members are removed; this makes it possible to render the
  container in a format similar to Pure's list syntax. For instance:

  <\verbatim>
    \;

    \<gtr\> using stldict;

    \<gtr\> outfix {$ $};

    \<gtr\> orddict_symbol ({$ $});

    ()

    \<gtr\> orddict (1..5);

    {$1,2,3,4,5$}

    \;
  </verbatim>

  See <verbatim|orddict_examp.pure> included in the distribution for a
  complete example which also discusses how to make such a custom print
  representation reparsable.

  <subsection|Examples><label|examples>

  Some basic examples showing <hlink|<with|font-family|tt|hashdict>|#hashdict/type>
  in action:

  <\verbatim>
    \;

    \<gtr\> using stldict;

    \<gtr\> let m = hashdict [foo=\<gtr\>99, bar=\<gtr\>bar 4711L,
    baz=\<gtr\>1..5]; m;

    hashdict [foo=\<gtr\>99,bar=\<gtr\>bar 4711L,baz=\<gtr\>[1,2,3,4,5]]

    \<gtr\> m!bar;

    bar 4711L

    \<gtr\> keys m;

    [foo,bar,baz]

    \<gtr\> vals m;

    [99,bar 4711L,[1,2,3,4,5]]

    \<gtr\> list m;

    [foo=\<gtr\>99,bar=\<gtr\>bar 4711L,baz=\<gtr\>[1,2,3,4,5]]

    \<gtr\> member m foo, member m bar;

    1,1

    \;
  </verbatim>

  Hashed multidicts (<hlink|<with|font-family|tt|hashmdict>|#hashmdict/type>):

  <\verbatim>
    \;

    \<gtr\> let m = hashmdict [foo=\<gtr\>99,baz=\<gtr\>1..5,baz=\<gtr\>bar
    4711L]; m;

    hashmdict [foo=\<gtr\>99,baz=\<gtr\>[1,2,3,4,5],baz=\<gtr\>bar 4711L]

    \<gtr\> m!baz;

    [[1,2,3,4,5],bar 4711L]

    \<gtr\> m!foo;

    [99]

    \;
  </verbatim>

  The following example illustrates how to employ ordered dictionaries
  (<hlink|<with|font-family|tt|orddict>|#orddict/type>) as a set data
  structure:

  <\verbatim>
    \;

    \<gtr\> let m1 = orddict [5,1,3,11,3];

    \<gtr\> let m2 = orddict (3..6);

    \<gtr\> m1;m2;

    orddict [1,3,5,11]

    orddict [3,4,5,6]

    \<gtr\> m1+m2;

    orddict [1,3,4,5,6,11]

    \<gtr\> m1-m2;

    orddict [1,11]

    \<gtr\> m1*m2;

    orddict [3,5]

    \<gtr\> m1*m2 \<less\>= m1, m1*m2 \<less\>= m2;

    1,1

    \<gtr\> m1 \<less\> m1+m2, m2 \<less\> m1+m2;

    1,1

    \;
  </verbatim>

  Of course, the same works with ordered multidicts
  (<hlink|<with|font-family|tt|ordmdict>|#ordmdict/type>):

  <\verbatim>
    \;

    \<gtr\> let m1 = ordmdict [5,1,3,11,3];

    \<gtr\> let m2 = ordmdict (3..6);

    \<gtr\> m1;m2;

    ordmdict [1,3,3,5,11]

    ordmdict [3,4,5,6]

    \<gtr\> m1+m2;

    ordmdict [1,3,3,3,4,5,5,6,11]

    \<gtr\> m1-m2;

    ordmdict [1,3,11]

    \<gtr\> m1*m2;

    ordmdict [3,5]

    \<gtr\> m1*m2 \<less\>= m1, m1*m2 \<less\>= m2;

    1,1

    \<gtr\> m1 \<less\> m1+m2, m2 \<less\> m1+m2;

    1,1

    \;
  </verbatim>

  In fact, the binary operations (comparisons as well as the set operations
  <verbatim|+>, <verbatim|-> and <verbatim|*>) work with any combination of
  dictionary operands:

  <\verbatim>
    \;

    \<gtr\> let m1 = hashdict (1..5);

    \<gtr\> let m2 = ordmdict (3..7);

    \<gtr\> m1+m2;

    hashmdict [1,2,3,3,4,4,5,5,6,7]

    \;
  </verbatim>

  Note that the operands are always promoted to the more general operand
  type, where hashed beats ordered and multi-valued beats single-valued
  dictionaries. If this is not what you want, you can also specify the
  desired conversions explicitly:

  <\verbatim>
    \;

    \<gtr\> m1+orddict m2;

    hashdict [1,2,3,4,5,6,7]

    \<gtr\> orddict m1+m2;

    ordmdict [1,2,3,3,4,4,5,5,6,7]

    \;
  </verbatim>

  Also note that the \Pset\Q operations not only work with proper sets, but
  also with general dictionaries:

  <\verbatim>
    \;

    \<gtr\> hashdict [i=\<gtr\>i+1\|i=1..4]+hashdict [i=\<gtr\>i-1\|i=3..5];

    hashdict [1=\<gtr\>2,2=\<gtr\>3,3=\<gtr\>2,4=\<gtr\>3,5=\<gtr\>4]

    \;
  </verbatim>

  All dictionary containers can be used as generators in list and matrix
  comprehensions:

  <\verbatim>
    \;

    \<gtr\> let m = hashmdict [foo=\<gtr\>99,baz=\<gtr\>1..5,baz=\<gtr\>bar
    4711L];

    \<gtr\> [x y \| x=\<gtr\>y = m];

    [foo 99,baz [1,2,3,4,5],baz (bar 4711L)]

    \<gtr\> {{x;y} \| x=\<gtr\>y = m};

    {foo,baz,baz;99,[1,2,3,4,5],bar 4711L}

    \;
  </verbatim>

  Note that in the current implementation this always computes the full
  member list of the dictionary as an intermediate value, which will need
  considerable extra memory in the case of large dictionaries. As a remedy,
  you can also use the <hlink|<with|font-family|tt|stream>|#stream/stldict>
  function to convert the dictionary to a lazy list instead. This will often
  be slower, but in the case of big dictionaries the tradeoff between memory
  usage and execution speed might be worth considering. For instance:

  <\verbatim>
    \;

    \<gtr\> let m = hashdict [foo i =\<gtr\> i \| i = 1..10000];

    \<gtr\> stream m;

    (foo 1512=\<gtr\>1512):#\<less\>thunk 0x7fa1718350a8\<gtr\>

    \<gtr\> stats -m

    \<gtr\> #list m;

    10000

    0.01s, 40001 cells

    \<gtr\> #stream m;

    10000

    0.1s, 16 cells

    \<gtr\> #[y \| x=\<gtr\>y = m; gcd y 767~=1];

    925

    0.05s, 61853 cells

    \<gtr\> #[y \| x=\<gtr\>y = stream m; gcd y 767~=1];

    925

    0.15s, 10979 cells

    \;
  </verbatim>

  <subsubsection*|<hlink|Table Of Contents|index.tm>><label|pure-stldict-toc>

  <\itemize>
    <item><hlink|pure-stldict|#>

    <\itemize>
      <item><hlink|Copying|#copying>

      <item><hlink|Installation|#installation>

      <item><hlink|Usage|#usage>

      <item><hlink|Types|#types>

      <item><hlink|Operations|#operations>

      <\itemize>
        <item><hlink|Basic Operations|#basic-operations>

        <item><hlink|Comparisons|#comparisons>

        <item><hlink|Set-Like Operations|#set-like-operations>

        <item><hlink|List-Like Operations|#list-like-operations>

        <item><hlink|Iterators|#iterators>

        <item><hlink|Low-Level Operations|#low-level-operations>

        <item><hlink|Pretty-Printing|#pretty-printing>
      </itemize>

      <item><hlink|Examples|#examples>
    </itemize>
  </itemize>

  Previous topic

  <hlink|pure-sockets: Pure Sockets Interface|pure-sockets.tm>

  Next topic

  <hlink|pure-stllib|pure-stllib.tm>

  <hlink|toc|#pure-stldict-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-stllib.tm> \|
  <hlink|previous|pure-sockets.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2018, Albert Gräf et al. Last updated on Oct
  05, 2018. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
