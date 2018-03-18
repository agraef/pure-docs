<TeXmacs|1.99.5>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#purelib-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-avahi.tm> \|
  <hlink|previous|pure.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|Pure Library Manual><label|pure-library-manual>

  Version 0.67, March 18, 2018

  Albert Gräf \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  Copyright (c) 2009-2017 by Albert Gräf. This document is available under
  the <hlink|GNU Free Documentation License|http://www.gnu.org/copyleft/fdl.html>.

  This manual describes the operations in the standard Pure library,
  including the prelude and the other library modules which come bundled with
  the interpreter.

  There is a companion to this manual, <hlink|<em|The Pure Manual>|pure.tm>
  which describes the Pure language and the operation of the Pure
  interpreter.

  <subsection|Prelude><label|prelude>

  The prelude defines the basic operations of the Pure language. This
  includes the basic arithmetic and logical operations, string, list and
  matrix functions, as well as the support operations required to implement
  list and matrix comprehensions. The string, matrix and record operations
  are in separate modules strings.pure, matrices.pure and records.pure, the
  primitive arithmetic and logical operations can be found in
  primitives.pure. Note that since the prelude module gets imported
  automatically (unless the interpreter is invoked with the
  <verbatim|--no-prelude> option), all operations discussed in this section
  are normally available in Pure programs without requiring any explicit
  import declarations, unless explicitly noted otherwise.

  <subsubsection|Constants and Operators><label|constants-and-operators>

  The prelude also declares a signature of commonly used constant and
  operator symbols. This includes the truth values <verbatim|true> and
  <verbatim|false>.

  <\description>
    <item*|<em|constant> true = 1<label|true>>

    <item*|<em|constant> false = 0<label|false>>These are actually just
    integers in Pure, but sometimes it's convenient to refer to them using
    these symbolic constants.
  </description>

  In addition, the following special exception symbols are provided:

  <\description>
    <item*|<em|constructor> failed_cond<label|failed-cond>>

    <item*|<em|constructor> failed_match<label|failed-match>>

    <item*|<em|constructor> stack_fault<label|stack-fault>>

    <item*|<em|constructor> malloc_error<label|malloc-error>>These are the
    built-in exception values. <verbatim|failed_cond> denotes a failed
    conditional in guard or if-then-else; <verbatim|failed_match> signals a
    failed pattern match in lambda, <verbatim|case> expression, etc.;
    <verbatim|stack_fault> means not enough stack space
    (<verbatim|PURE_STACK> limit exceeded); and <verbatim|malloc_error>
    indicates a memory allocation error.
  </description>

  <\description>
    <item*|<em|constructor> bad_list_value x<label|bad-list-value>>

    <item*|<em|constructor> bad_tuple_value x<label|bad-tuple-value>>

    <item*|<em|constructor> bad_string_value x<label|bad-string-value>>

    <item*|<em|constructor> bad_matrix_value x<label|bad-matrix-value>>These
    denote value mismatches a.k.a. dynamic typing errors. They are thrown by
    some operations when they fail to find an expected value of the
    corresponding type.
  </description>

  <\description>
    <item*|<em|constructor> out_of_bounds<label|out-of-bounds>>This exception
    is thrown by the index operator <verbatim|!> if a list, tuple or matrix
    index is out of bounds.
  </description>

  <label|operators>

  Here's the list of predefined operator symbols. Note that the parser will
  automagically give unary minus the same precedence level as the
  corresponding binary operator.

  <\verbatim>
    \;

    infixl \ 1000 \ \ $$ ; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ // sequence operator

    infixr \ 1100 \ \ $ ; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ //
    right-associative application

    infixr \ 1200 \ \ , ; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ // pair (tuple)

    infix \ \ 1300 \ \ =\<gtr\> ; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ //
    key=\<gtr\>value pairs ("hash rocket")

    infix \ \ 1400 \ \ .. ; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ // arithmetic
    sequences

    infixr \ 1500 \ \ \|\| ; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ // logical or
    (short-circuit)

    infixr \ 1600 \ \ && ; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ // logical and
    (short-circuit)

    prefix \ 1700 \ \ ~ ; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ // logical negation

    infix \ \ 1800 \ \ \<less\> \<gtr\> \<less\>= \<gtr\>= == ~= ; \ \ //
    relations

    infix \ \ 1800 \ \ === ~== ; \ \ \ \ \ \ \ \ \ \ // syntactic equality

    infixr \ 1900 \ \ : ; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ // list cons

    infix \ \ 2000 \ \ +: \<less\>: ; \ \ \ \ \ \ \ \ \ \ \ \ // complex
    numbers (cf. math.pure)

    infixl \ 2100 \ \ \<less\>\<less\> \<gtr\>\<gtr\> ;
    \ \ \ \ \ \ \ \ \ \ \ \ // bit shifts

    infixl \ 2200 \ \ + - or ; \ \ \ \ \ \ \ \ \ \ \ // addition, bitwise or

    infixl \ 2300 \ \ * / div mod and ; \ \ // multiplication, bitwise and

    infixl \ 2300 \ \ % ; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ // exact division
    (cf. math.pure)

    prefix \ 2400 \ \ not ; \ \ \ \ \ \ \ \ \ \ \ \ \ \ // bitwise not

    infixr \ 2500 \ \ ^ ; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ // exponentiation

    prefix \ 2600 \ \ # ; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ // size operator

    infixl \ 2700 \ \ ! !! ; \ \ \ \ \ \ \ \ \ \ \ \ \ // indexing, slicing

    infixr \ 2800 \ \ . ; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ // function
    composition

    prefix \ 2900 \ \ ' ; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ // quote

    postfix 3000 \ \ & ; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ // thunk

    \;
  </verbatim>

  <subsubsection|Prelude Types><label|prelude-types>

  Some additional type symbols are provided which can be used as type tags on
  the left-hand side of equations, see <hlink|<em|Type
  Tags>|pure.tm#type-tags> in the Pure Manual.

  <\description>
    <item*|<em|type> number<label|number/type>>

    <item*|<em|type> complex<label|complex/type>>

    <item*|<em|type> real<label|real/type>>

    <item*|<em|type> rational<label|rational/type>>

    <item*|<em|type> integer<label|integer/type>>

    <item*|<em|type> bool<label|bool/type>>Additional number types.
  </description>

  These types are defined in a purely syntactic way, by checking the
  builtin-type or the constructor symbol of a number. Some semantic number
  types can be found in the <hlink|<with|font-family|tt|math>|#module-math>
  module, see <hlink|Semantic Number Predicates and
  Types|#semantic-number-predicates-and-types>.

  <hlink|<with|font-family|tt|integer>|#integer/type> is the union of Pure's
  built-in integer types, i.e., it comprises all
  <hlink|<with|font-family|tt|int>|pure.tm#int/type> and
  <hlink|<with|font-family|tt|bigint>|pure.tm#bigint/type> values.
  <hlink|<with|font-family|tt|bool>|#bool/type> is a subtype of
  <hlink|<with|font-family|tt|int>|pure.tm#int/type> which denotes just the
  normalized truth values <verbatim|0> and <verbatim|1> (a.k.a.
  <hlink|<with|font-family|tt|false>|#false> and
  <hlink|<with|font-family|tt|true>|#true>).

  <hlink|<with|font-family|tt|rational>|#rational/type> and
  <hlink|<with|font-family|tt|complex>|#complex/type> are the rational and
  complex types, while <hlink|<with|font-family|tt|real>|#real/type> is the
  union of the <hlink|<with|font-family|tt|double>|pure.tm#double/type>,
  <hlink|<with|font-family|tt|integer>|#integer/type> and
  <hlink|<with|font-family|tt|rational>|#rational/type> types (i.e., anything
  that can represent a real number and be used for the real and imaginary
  parts of a <hlink|<with|font-family|tt|complex>|#complex/type> number).
  Finally, <hlink|<with|font-family|tt|number>|#number/type> is the union of
  all numeric types, i.e., this type can be used to match any kind of number.

  Note that the operations of the <hlink|<with|font-family|tt|rational>|#rational/type>
  and <hlink|<with|font-family|tt|complex>|#complex/type> types are actually
  defined in the <hlink|<with|font-family|tt|math>|#module-math> module which
  isn't part of the prelude, so you have to import this module in order to do
  computations with these types of values. However, the type tags and
  constructors for these types are defined in the prelude so that these kinds
  of values can be parsed and recognized without having the
  <hlink|<with|font-family|tt|math>|#module-math> module loaded.

  The prelude also provides a subtype of the built-in
  <hlink|<with|font-family|tt|string>|pure.tm#string/type> type which
  represents single-character strings:

  <\description>
    <item*|<em|type> char<label|char/type>>A single character string. This
    matches any string value of length 1.
  </description>

  <hlink|Lists and tuples|#lists-and-tuples> can be matched with the
  following types:

  <\description>
    <item*|<em|type> list<label|list/type>>

    <item*|<em|type> rlist<label|rlist/type>>The list and \Pproper\Q (or
    \Precursive\Q) list types. Note that the former comprises both the empty
    list <verbatim|[]> and all list nodes of the form <verbatim|x:xs> (no
    matter whether the tail <verbatim|xs> is a proper list value or not),
    whereas the latter only matches proper list values of the form
    <verbatim|x1:...:xn:[]>. Thus the <hlink|<with|font-family|tt|list>|#list/type>
    type can be checked in O(1) time, while the
    <hlink|<with|font-family|tt|rlist>|#rlist/type> type is defined
    recursively and requires linear time (with respect to the size of the
    list) to be checked. This should be considered when deciding whether to
    use one or the other in a given situation; see <hlink|<em|Type
    Rules>|pure.tm#type-rules> for further explanation.
  </description>

  <\description>
    <item*|<em|type> tuple<label|tuple/type>>The type of all tuples,
    comprises the empty tuple <verbatim|()> and all tuples <verbatim|(x,xs)>
    with at least two members. This is analogous to the
    <hlink|<with|font-family|tt|list>|#list/type> type above, but no
    \Pproper\Q tuple type is needed here since any tuple of this form is
    always a proper tuple.
  </description>

  There are some other, more specialized types representing various kinds of
  applications, function objects and other named entities. These are useful,
  in particular, for the definition of higher-order functions and for
  performing symbolic manipulations on unevaluated symbolic terms.

  <\description>
    <item*|<em|type> appl<label|appl/type>>This type represents all
    unevaluated function or constructor applications of the form <verbatim|x>
    <verbatim|y>. This comprises constructor terms and quoted or partial
    function applications.
  </description>

  <\description>
    <item*|<em|type> function<label|function/type>>This type represents any
    term which may be called as a function. This may be a closure (global or
    local function, or a lambda function) which takes at least one argument,
    or a partial application of a closure to some arguments which is still
    \Punsaturated\Q, i.e., expects some further arguments to be \Pready to
    go\Q.
  </description>

  <\description>
    <item*|<em|type> fun<label|fun/type>>A named function object (global or
    local function, but not a partial application).
  </description>

  <\description>
    <item*|<em|type> lambda<label|lambda/type>>An anonymous (lambda)
    function.
  </description>

  <\description>
    <item*|<em|type> closure<label|closure/type>>Any kind of function object
    (named function or lambda). This is the union of the
    <hlink|<with|font-family|tt|fun>|#fun/type> and
    <hlink|<with|font-family|tt|lambda>|#lambda/type> types.
  </description>

  <\description>
    <item*|<em|type> thunk<label|thunk/type>>This is a special kind of
    unevaluated parameterless function object used in lazy evaluation. See
    <hlink|<em|Lazy Evaluation and Streams>|pure.tm#lazy-evaluation-and-streams>
    in the Pure Manual.
  </description>

  <\description>
    <item*|<em|type> var<label|var/type>>A free variable. This can be any
    kind of symbol that could in principle be bound to a value (excluding
    operator and nonfix symbols).
  </description>

  <\description>
    <item*|<em|type> symbol<label|symbol/type>>Any kind of symbol (this also
    includes operator and nonfix symbols).
  </description>

  Corresponding type predicates are provided for all of the above, see
  <hlink|Predicates|#predicates>. Some further types and predicates for
  matrices and records can be found under <hlink|Matrix Inspection and
  Manipulation|#matrix-inspection-and-manipulation> and <hlink|Record
  Functions|#record-functions>.

  <subsubsection|Basic Combinators><label|basic-combinators><label|index-1><label|basic-combinators>

  The prelude implements the following important function combinators.

  <\description>
    <item*|f $ g<label|-dollar>>

    <item*|f . g<label|.>>Like in Haskell, these denote right-associative
    application and function composition. They are also defined as macros so
    that saturated calls of them are eliminated automatically. Examples:

    <\verbatim>
      \;

      \<gtr\> foo $ bar 99;

      foo (bar 99)

      \<gtr\> (foo.bar) 99;

      foo (bar 99)

      \;
    </verbatim>
  </description>

  <\description>
    <item*|id x<label|id>>

    <item*|cst x y<label|cst>>These are the customary identity and constant
    combinators from the combinatorial calculus:

    <\verbatim>
      \;

      \<gtr\> map id (1..5);

      [1,2,3,4,5]

      \<gtr\> map (cst 0) (1..5);

      [0,0,0,0,0]

      \;
    </verbatim>
  </description>

  <\description>
    <item*|void x<label|void>>This combinator is basically equivalent to
    <verbatim|cst> <verbatim|()>, but with the special twist that it is also
    defined as a macro optimizing the case of \Pthrowaway\Q list and matrix
    comprehensions. This is useful if a comprehension is evaluated solely for
    its side effects. E.g.:

    <\verbatim>
      \;

      \<gtr\> using system;

      \<gtr\> extern int rand();

      \<gtr\> foo = void [printf "%d\\n" rand \| _ = 1..3];

      \<gtr\> show foo

      foo = do (\\_ -\<gtr\> printf "%d\\n" rand) (1..3);

      \<gtr\> foo;

      1714636915

      1957747793

      424238335

      ()

      \;
    </verbatim>

    Note that the above list comprehension is actually implemented using
    <hlink|<with|font-family|tt|do>|#do> (instead of
    <hlink|<with|font-family|tt|map>|#map>, which would normally be the
    case), so that the intermediate list value of the comprehension is never
    constructed. This is described in more detail in section
    <hlink|<em|Optimization Rules>|pure.tm#optimization-rules> of the Pure
    Manual.
  </description>

  In addition, the prelude also provides the following combinators adopted
  from Haskell:

  <\description>
    <item*|flip f<label|flip>>Swaps arguments of a binary function
    <verbatim|f>, e.g.:

    <\verbatim>
      \;

      \<gtr\> map (flip (/) 2) (1..3);

      [0.5,1.0,1.5]

      \;
    </verbatim>

    This combinator is also used by the compiler to implement right operator
    sections, which allows you to write the above simply as:

    <\verbatim>
      \;

      \<gtr\> map (/2) (1..3);

      [0.5,1.0,1.5]

      \;
    </verbatim>
  </description>

  <\description>
    <item*|curry f<label|curry>>Turns a function <verbatim|f> expecting a
    pair of values into a curried function of two arguments:

    <\verbatim>
      \;

      \<gtr\> using system;

      \<gtr\> dowith (curry (printf "%d: %g\\n")) (0..2) [0.0,2.718,3.14];

      0: 0

      1: 2.718

      2: 3.14

      ()

      \;
    </verbatim>
  </description>

  <\description>
    <item*|uncurry f<label|uncurry>>The inverse of
    <hlink|<with|font-family|tt|curry>|#curry>. Turns a curried function
    <verbatim|f> expecting two arguments into a function processing a single
    pair argument:

    <\verbatim>
      \;

      \<gtr\> map (uncurry (*)) [(2,3),(4,5),(6,7)];

      [6,20,42]

      \;
    </verbatim>
  </description>

  <\description>
    <item*|curry3 f<label|curry3>>

    <item*|uncurry3 f<label|uncurry3>>These work analogously, but are used to
    convert between ternary curried functions and functions operating on
    triples.
  </description>

  <\description>
    <item*|fix f<label|fix>>This is the (normal order) fixed point combinator
    which allows you to create recursive anonymous functions. It takes
    another function <verbatim|f> as its argument and applies <verbatim|f> to
    <verbatim|fix> <verbatim|f> itself:

    <\verbatim>
      \;

      \<gtr\> let fact = fix (\\f n -\<gtr\> if n\<less\>=0 then 1 else n*f
      (n-1));

      \<gtr\> map fact (1..5);

      [1,2,6,24,120]

      \;
    </verbatim>

    See <hlink|Fixed point combinator|http://en.wikipedia.org/wiki/Fixed-point-combinator>
    at Wikipedia for an explanation of how this magic works. Just like in
    Haskell, <hlink|<with|font-family|tt|fix>|#fix> can be used to produce
    least fixed points of arbitrary functions. For instance:

    <\verbatim>
      \;

      \<gtr\> fix (cst bar);

      bar

      \<gtr\> let xs = fix (1:);

      \<gtr\> xs;

      1:#\<less\>thunk 0x7fe537fe2f90\<gtr\>

      \<gtr\> xs!!(0..10);

      [1,1,1,1,1,1,1,1,1,1,1]

      \;
    </verbatim>
  </description>

  <subsubsection|Lists and Tuples><label|lists-and-tuples><label|index-3><label|lists-and-tuples>

  The prelude defines the list and tuple constructors, as well as equality
  and inequality on these structures. It also provides a number of other
  useful basic operations on lists and tuples. These are all described below.

  <\description>
    <item*|<em|constructor> []<hlink|]|#{[>}>

    <item*|<em|constructor> ()<label|()>>Empty list and tuple.
  </description>

  <\description>
    <item*|<em|constructor> x : y<label|:>>

    <item*|<em|constructor> x , y<label|,>>List and tuple constructors. These
    are right-associative in Pure.
  </description>

  Lists are the usual right-recursive aggregates of the form <verbatim|x:xs>,
  where <verbatim|x> denotes the <with|font-series|bold|head> and
  <verbatim|xs> the <with|font-series|bold|tail> of the list, pretty much the
  same as in Lisp or Prolog except that they use a Haskell-like syntax. In
  contrast to Haskell, list concatenation is denoted
  `<hlink|<with|font-family|tt|+>|#+/list>` (see below), and lists may
  contain an arbitrary mixture of arguments, i.e., they are fully
  polymorphic:

  <\verbatim>
    \;

    \<gtr\> 1:2:3:[];

    [1,2,3]

    \<gtr\> [1,2,3]+[u,v,w]+[3.14];

    [1,2,3,u,v,w,3.14]

    \;
  </verbatim>

  Lists are <with|font-series|bold|eager> in Pure by default, but they can
  also be made <with|font-series|bold|lazy> (in the latter case they are also
  called <with|font-series|bold|streams>). This is accomplished by turning
  the tail of a list into a \Pthunk\Q (a.k.a. \Pfuture\Q) which defers
  evaluation until the list tail is actually needed, see section
  <hlink|<em|Lazy Evaluation and Streams>|pure.tm#lazy-evaluation-and-streams>
  in the Pure Manual. For instance, an infinite arithmetic sequence (see
  below) will always produce a list with a thunked tail:

  <\verbatim>
    \;

    \<gtr\> 1:3..inf;

    1:#\<less\>thunk 0x7f696cd2dbd8\<gtr\>

    \;
  </verbatim>

  Pure also distinguishes <with|font-series|bold|proper> and
  <with|font-series|bold|improper> lists. The former are always terminated by
  an empty list in the final tail and can thus be written using the
  conventional <verbatim|[x1,x2,...,xn]> syntax:

  <\verbatim>
    \;

    \<gtr\> 1:2:3:[];

    [1,2,3]

    \;
  </verbatim>

  In contrast, improper lists are terminated with a non-list value and can
  only be represented using the `<hlink|<with|font-family|tt|:>|#:>`
  operator:

  <\verbatim>
    \;

    \<gtr\> 1:2:3;

    1:2:3

    \;
  </verbatim>

  These aren't of much use as ordinary list values, but are frequently
  encountered as patterns on the left-hand side of an equation, where the
  final tail is usually a variable. Also note that technically, a lazy list
  is also an improper list (although it may expand to a proper list value as
  it is traversed).

  Tuples work in a similar fashion, but with the special twist that the
  pairing constructor `<hlink|<with|font-family|tt|,>|#,>` is associative (it
  always produces right-recursive pairs) and
  `<hlink|<with|font-family|tt|()>|#()>` acts as a neutral element on these
  constructs, so that `<hlink|<with|font-family|tt|,>|#,>` and
  `<hlink|<with|font-family|tt|()>|#()>` define a complete monoid structure.
  Note that this means that `<hlink|<with|font-family|tt|,>|#,>` is actually
  a \Pconstructor with equations\Q since it obeys the laws <verbatim|(x,y),z>
  <verbatim|==> <verbatim|x,(y,z)> and <verbatim|(),x> <verbatim|==>
  <verbatim|x,()> <verbatim|==> <verbatim|x>. Also note that there isn't a
  separate operation for concatenating tuples, since the pairing operator
  already does this:

  <\verbatim>
    \;

    \<gtr\> (1,2,3),(10,9,8);

    1,2,3,10,9,8

    \<gtr\> (),(a,b,c);

    a,b,c

    \<gtr\> (a,b,c),();

    a,b,c

    \;
  </verbatim>

  This also implies that tuples are always flat in Pure and can't be nested;
  if you need this, you should use lists instead. Also, tuples are always
  eager in Pure.

  Some important basic operations on lists and tuples are listed below.

  <\description>
    <item*|x + y<label|+/list>><label|index-4>List concatenation. This
    non-destructively appends the elements of <verbatim|y> to <verbatim|x>.

    <\verbatim>
      \;

      \<gtr\> [1,2,3]+[u,v,w];

      [1,2,3,u,v,w]

      \;
    </verbatim>

    Note that this operation in fact just recurses into <verbatim|x> and
    replaces the empty list marking the \Pend\Q of <verbatim|x> with
    <verbatim|y>, as if defined by the following equations (however, the
    prelude actually defines this operation in a tail-recursive fashion):

    <\verbatim>
      \;

      [] + ys = ys;

      (x:xs) + ys = x : xs+ys;

      \;
    </verbatim>

    To make this work, both operands should be proper lists, otherwise you
    may get somewhat surprising (but correct) improper list results like the
    following:

    <\verbatim>
      \;

      \<gtr\> [1,2,3]+99;

      1:2:3:99

      \<gtr\> (1:2:3)+33;

      1:2:36

      \;
    </verbatim>

    This happens because Pure is dynamically typed and places no limits on ad
    hoc polymorphism. Note that the latter result is due to the fact that
    `<hlink|<with|font-family|tt|+>|#+>` also denotes the addition of
    numbers, and the improper tail of the first operand is a number in this
    case, as is the second operand. Otherwise you might have got an unreduced
    instance of the `<hlink|<with|font-family|tt|+>|#+>` operator instead.
  </description>

  <\description>
    <item*|x == y<label|==/list>>

    <item*|x <math|\<sim\>>= y<label|-tilde=/list>><label|index-5><label|index-6>Equality
    and inequality of lists and tuples. These compare two lists or tuples by
    recursively comparing their members, so
    `<hlink|<with|font-family|tt|==>|#==>` must be defined on the list or
    tuple members if you want to use these operations. Also note that these
    operations are inherently eager, so applying them to two infinite lists
    may take an infinite amount of time.

    <\verbatim>
      \;

      \<gtr\> reverse [a,b,c] == [c,b,a];

      1

      \<gtr\> (a,b,c) == ();

      0

      \;
    </verbatim>
  </description>

  <\description>
    <item*|# x<label|#>><label|index-7><label|index-8>List and tuple size.
    This operation counts the number of elements in a list or tuple:

    <\verbatim>
      \;

      \<gtr\> #[a,b,c];

      3

      \<gtr\> #(a,b,c);

      3

      \;
    </verbatim>

    Please note that for obvious reasons this operation is inherently eager,
    so trying to compute the size of an infinite list will take forever.
  </description>

  <\description>
    <item*|x ! i<label|!>><label|index-9><label|index-10>Indexing of lists
    and tuples is always zero-based (i.e., indices run from <verbatim|0> to
    <verbatim|#x-1>), and an exception will be raised if the index is out of
    bounds:

    <\verbatim>
      \;

      \<gtr\> [1,2,3]!2;

      3

      \<gtr\> [1,2,3]!4;

      \<less\>stdin\<gtr\>, line 34: unhandled exception 'out_of_bounds'
      while evaluating

      '[1,2,3]!4'

      \;
    </verbatim>
  </description>

  <\description>
    <item*|x !! is<label|!!>><label|index-11><label|index-12>The slicing
    operation takes a list or tuple and a list of indices and returns the
    list or tuple of the corresponding elements, respectively. Indices which
    are out of the valid range are silently ignored:

    <\verbatim>
      \;

      \<gtr\> (1..5)!!(3..10);

      [4,5]

      \<gtr\> (1,2,3,4,5)!!(3..10);

      4,5

      \;
    </verbatim>

    The case of contiguous index ranges, as shown above, is optimized so that
    it always works in linear time, see <hlink|Slicing|#slicing> below for
    details. But indices can actually be specified in any order, so that you
    can retrieve any permutation of the members, also with duplicates. E.g.:

    <\verbatim>
      \;

      \<gtr\> (1..5)!![2,4,4,1];

      [3,5,5,2]

      \;
    </verbatim>

    This is less efficient than the case of contiguous index ranges, because
    it requires repeated traversals of the list for each index. For larger
    lists you should hence use vectors or matrices instead, to avoid the
    quadratic complexity.
  </description>

  <\description>
    <item*|x .. y<label|..>><label|index-13>Arithmetic sequences. Note that
    the Pure syntax differs from Haskell in that there are no brackets around
    the construct and a step width is indicated by specifying the first two
    elements as <verbatim|x:y> instead of <verbatim|x,y>.

    <\verbatim>
      \;

      \<gtr\> 1..5;

      [1,2,3,4,5]

      \<gtr\> 1:3..11;

      [1,3,5,7,9,11]

      \;
    </verbatim>

    To prevent unwanted artifacts due to rounding errors, the upper bound in
    a floating point sequence is always rounded to the nearest grid point:

    <\verbatim>
      \;

      \<gtr\> 0.0:0.1..0.29;

      [0.0,0.1,0.2,0.3]

      \<gtr\> 0.0:0.1..0.31;

      [0.0,0.1,0.2,0.3]

      \;
    </verbatim>

    Last but not least, you can specify infinite sequences with an infinite
    upper bound (<verbatim|inf> or <verbatim|-inf>):

    <\verbatim>
      \;

      \<gtr\> 1:3..inf;

      1:#\<less\>thunk 0x7f696cd2dbd8\<gtr\>

      \<gtr\> -1:-3..-inf;

      -1:#\<less\>thunk 0x7f696cd2fde8\<gtr\>

      \;
    </verbatim>

    The lower bounds of an arithmetic sequence must always be finite.
  </description>

  <\description>
    <item*|null x<label|null>>Test for the empty list and tuple.

    <\verbatim>
      \;

      \<gtr\> null [];

      1

      \<gtr\> null (a,b,c);

      0

      \;
    </verbatim>
  </description>

  <\description>
    <item*|reverse x<label|reverse>>Reverse a list or tuple.

    <\verbatim>
      \;

      \<gtr\> reverse (1..5);

      [5,4,3,2,1]

      \<gtr\> reverse (a,b,c);

      (c,b,a)

      \;
    </verbatim>
  </description>

  In addition, the prelude provides the following conversion operations.

  <\description>
    <item*|list x<label|list>>

    <item*|tuple x<label|tuple>>Convert between (finite) lists and tuples.

    <\verbatim>
      \;

      \<gtr\> tuple (1..5);

      1,2,3,4,5

      \<gtr\> list (a,b,c);

      [a,b,c]

      \;
    </verbatim>

    The <verbatim|list> function can be used to turn a finite lazy list into
    an eager one:

    <\verbatim>
      \;

      \<gtr\> list $ take 10 (-1:-3..-inf);

      [-1,-3,-5,-7,-9,-11,-13,-15,-17,-19]

      \;
    </verbatim>

    You can also achieve the same effect somewhat more conveniently by
    slicing a finite part from a stream:

    <\verbatim>
      \;

      \<gtr\> (-1:-3..-inf)!!(0..9);

      [-1,-3,-5,-7,-9,-11,-13,-15,-17,-19]

      \;
    </verbatim>
  </description>

  Conversely, it is also possible to convert an (eager) list to a lazy one (a
  stream).

  <\description>
    <item*|stream x<label|stream>>Convert a list to a stream.

    <\verbatim>
      \;

      \<gtr\> stream (1..10);

      1:#\<less\>thunk 0x7fe537fe2b58\<gtr\>

      \;
    </verbatim>
  </description>

  This might appear a bit useless at first sight, since all elements of the
  stream are in fact already known. However, this operation then allows you
  to apply other functions to the list and have them evaluated in a lazy
  fashion.

  <subsubsection|Slicing><label|slicing>

  Indexing and slicing are actually fairly general operations in Pure which
  are used not only in the context of lists and tuples, but for any type of
  container data structure which can be \Pindexed\Q in some way. Other
  examples in the standard library are the
  <hlink|<with|font-family|tt|array>|#module-array> and
  <hlink|<with|font-family|tt|dict>|#module-dict> containers.

  The prelude therefore implements slicing in a generic way, so that it works
  with any kind of container data structure which defines
  `<hlink|<with|font-family|tt|!>|#!>` in such a manner that it throws an
  exception when the index is out of bounds. It also works with any kind of
  index container that implements the <hlink|<with|font-family|tt|catmap>|#catmap>
  operation.

  The prelude also optimizes the case of contiguous integer ranges so that
  slices like <verbatim|xs!!(i..j)> are computed in linear time if possible.
  This works, in particular, with lists, strings and matrices.

  Moreover, the prelude includes some optimization rules and corresponding
  helper functions to optimize the most common cases at compile time, so that
  the index range is never actually constructed. To these ends, the slicing
  expression <verbatim|xs!!(i..j)> is translated to a call <verbatim|subseq>
  <verbatim|xs> <verbatim|i> <verbatim|j> of the special
  <hlink|<with|font-family|tt|subseq>|#subseq> function:

  <\description>
    <item*|subseq x i j<label|subseq>>If <verbatim|x> is a list, matrix or
    string, and <verbatim|i> and <verbatim|j> are int values, compute the
    slice <verbatim|xs!!(i..j)> in the most efficient manner possible. This
    generally avoids constructing the index list <verbatim|i..j>. Otherwise
    <verbatim|i..j> is computed and <hlink|<with|font-family|tt|subseq>|#subseq>
    falls back to the <hlink|<with|font-family|tt|slice>|#slice> function
    below to compute the slice in the usual way.
  </description>

  <\description>
    <item*|slice x ys<label|slice>>Compute the slice <verbatim|x!!ys> using
    the standard slicing operation, without any special compile time tricks.
    (Runtime optimizations are still applied if possible.)
  </description>

  You can readily see the effects of this optimization by running the slicing
  operator against <hlink|<with|font-family|tt|slice>|#slice>:

  <\verbatim>
    \;

    \<gtr\> let xs = 1..1000000;

    \<gtr\> stats -m

    \<gtr\> #slice xs (100000..299990);

    199991

    0.34s, 999957 cells

    \<gtr\> #xs!!(100000..299990);

    199991

    0.14s, 399984 cells

    \;
  </verbatim>

  Even more drastic improvements in both running time and memory usage can be
  seen in the case of matrix slices:

  <\verbatim>
    \;

    \<gtr\> let x = rowvector xs;

    \<gtr\> #slice x (100000..299990);

    199991

    0.19s, 599990 cells

    \<gtr\> #x!!(100000..299990);

    199991

    0s, 10 cells

    \;
  </verbatim>

  <subsubsection|Hash Pairs><label|hash-pairs><label|index-14><label|hash-pairs>

  The prelude provides another special kind of pairs called \Phash pairs\Q,
  which take the form <verbatim|key=\>value>. These are used in various
  contexts to denote key-value associations. The only operations on hash
  pairs provided by the prelude are equality testing (which recursively
  compares the components) and the functions
  <hlink|<with|font-family|tt|key>|#key> and
  <hlink|<with|font-family|tt|val>|#val>:

  <\description>
    <item*|<em|constructor> x =\<gtr\> y<label|=\<gtr\>>>The hash pair
    constructor, also known as the \Phash rocket\Q.
  </description>

  <\description>
    <item*|x == y<label|==/hashpair>>

    <item*|x <math|\<sim\>>= y<label|-tilde=/hashpair>>Equality and
    inequality of hash pairs.

    <\verbatim>
      \;

      \<gtr\> ("foo"=\<gtr\>99) == ("bar"=\<gtr\>99);

      0

      \;
    </verbatim>
  </description>

  <\description>
    <item*|key (x=\<gtr\>y)<label|key>>

    <item*|val (x=\<gtr\>y)<label|val>>Extract the components of a hash pair.

    <\verbatim>
      \;

      \<gtr\> key ("foo"=\<gtr\>99), val ("foo"=\<gtr\>99);

      "foo",99

      \;
    </verbatim>
  </description>

  Note that in difference to the tuple operator
  `<hlink|<with|font-family|tt|,>|#,>`, the hash rocket
  `<hlink|<with|font-family|tt|=\<gtr\>>|#=\>>` is non-associative, so nested
  applications <em|must> be parenthesized, and <verbatim|(x=\>y)=\>z> is
  generally <em|not> the same as <verbatim|x=\>(y=\>z)>. Also note that
  `<hlink|<with|font-family|tt|,>|#,>` has lower precedence than
  `<hlink|<with|font-family|tt|=\<gtr\>>|#=\>>`, so to include a tuple as key
  or value in a hash pair, the tuple must be parenthesized, as in
  <verbatim|"foo"=\>(1,2)> (whereas <verbatim|"foo"=\>1,2> denotes a tuple
  whose first element happens to be a hash pair).

  <subsubsection|List Functions><label|list-functions>

  This mostly comes straight from the Q prelude which in turn was based on
  the first edition of the Bird/Wadler book, and is very similar to what you
  can find in the Haskell prelude. Some functions have slightly different
  names, though, and of course everything is typed dynamically.

  <paragraph|Common List Functions><label|common-list-functions>

  <\description>
    <item*|any p xs<label|any>>test whether the predicate <verbatim|p> holds
    for any of the members of <verbatim|xs>
  </description>

  <\description>
    <item*|all p xs<label|all>>test whether the predicate <verbatim|p> holds
    for all of the members of <verbatim|xs>
  </description>

  <\description>
    <item*|cat xs<label|cat>>concatenate a list of lists
  </description>

  <\description>
    <item*|catmap f xs<label|catmap>>convenience function which combines
    <hlink|<with|font-family|tt|cat>|#cat> and
    <hlink|<with|font-family|tt|map>|#map>; this is also used to implement
    list comprehensions
  </description>

  <\description>
    <item*|do f xs<label|do>>apply <verbatim|f> to all members of
    <verbatim|xs>, like <hlink|<with|font-family|tt|map>|#map>, but throw
    away all intermediate results and return <verbatim|()>
  </description>

  <\description>
    <item*|drop n xs<label|drop>>remove <verbatim|n> elements from the front
    of <verbatim|xs>
  </description>

  <\description>
    <item*|dropwhile p xs<label|dropwhile>>remove elements from the front of
    <verbatim|xs> while the predicate <verbatim|p> is satisfied
  </description>

  <\description>
    <item*|filter p xs<label|filter>>return the list of all members of
    <verbatim|xs> satisfying the predicate <verbatim|p>
  </description>

  <\description>
    <item*|foldl f a xs<label|foldl>>accumulate the binary function
    <verbatim|f> over all members of <verbatim|xs>, starting from the initial
    value <verbatim|a> and working from the front of the list towards its end
  </description>

  <\description>
    <item*|foldl1 f xs<label|foldl1>>accumulate the binary function
    <verbatim|f> over all members of <verbatim|xs>, starting from the value
    <verbatim|head> <verbatim|xs> and working from the front of the list
    towards its end; <verbatim|xs> must be nonempty
  </description>

  <\description>
    <item*|foldr f a xs<label|foldr>>accumulate the binary function
    <verbatim|f> over all members of <verbatim|xs>, starting from the initial
    value <verbatim|a> and working from the end of the list towards its front
  </description>

  <\description>
    <item*|foldr1 f xs<label|foldr1>>accumulate the binary function
    <verbatim|f> over all members of <verbatim|xs>, starting from the value
    <verbatim|last> <verbatim|xs> and working from the end of the list
    towards its front; <verbatim|xs> must be nonempty
  </description>

  <\description>
    <item*|head xs<label|head>>return the first element of <verbatim|xs>;
    <verbatim|xs> must be nonempty
  </description>

  <\description>
    <item*|index xs x<label|index>>search for an occurrence of <verbatim|x>
    in <verbatim|xs> and return the index of the first occurrence, if any,
    <verbatim|-1> otherwise

    Note: This uses equality <hlink|<with|font-family|tt|==>|#==> to decide
    whether a member of <verbatim|xs> is an occurrence of <verbatim|x>, so
    <hlink|<with|font-family|tt|==>|#==> must have an appropriate definition
    on the list members.
  </description>

  <\description>
    <item*|init xs<label|init>>return all but the last element of
    <verbatim|xs>; <verbatim|xs> must be nonempty
  </description>

  <\description>
    <item*|last xs<label|last>>return the last element of <verbatim|xs>;
    <verbatim|xs> must be nonempty
  </description>

  <\description>
    <item*|listmap f xs<label|listmap>>convenience function which works like
    <hlink|<with|font-family|tt|map>|#map>, but also deals with matrix and
    string arguments while ensuring that the result is always a list; this is
    primarily used to implement list comprehensions
  </description>

  <\description>
    <item*|map f xs<label|map>>apply <verbatim|f> to each member of
    <verbatim|xs>
  </description>

  <\description>
    <item*|scanl f a xs<label|scanl>>accumulate the binary function
    <verbatim|f> over all members of <verbatim|xs>, as with
    <hlink|<with|font-family|tt|foldl>|#foldl>, but return all intermediate
    results as a list
  </description>

  <\description>
    <item*|scanl1 f xs<label|scanl1>>accumulate the binary function
    <verbatim|f> over all members of <verbatim|xs>, as with
    <hlink|<with|font-family|tt|foldl1>|#foldl1>, but return all intermediate
    results as a list
  </description>

  <\description>
    <item*|scanr f a xs<label|scanr>>accumulate the binary function
    <verbatim|f> over all members of <verbatim|xs>, as with
    <hlink|<with|font-family|tt|foldr>|#foldr>, but return all intermediate
    results as a list
  </description>

  <\description>
    <item*|scanr1 f xs<label|scanr1>>accumulate the binary function
    <verbatim|f> over all members of <verbatim|xs>, as with
    <hlink|<with|font-family|tt|foldr1>|#foldr1>, but return all intermediate
    results as a list
  </description>

  <\description>
    <item*|sort p xs<label|sort>>Sorts the elements of the list <verbatim|xs>
    in ascending order according to the given predicate <verbatim|p>, using
    the C <verbatim|qsort> function. The predicate <verbatim|p> is invoked
    with two arguments and should return a truth value indicating whether the
    first argument is \Pless than\Q the second. (An exception is raised if
    the result of a comparison is not a machine integer.)

    <\verbatim>
      \;

      \<gtr\> sort (\<gtr\>) (1..10);

      [10,9,8,7,6,5,4,3,2,1]

      \<gtr\> sort (\<less\>) ans;

      [1,2,3,4,5,6,7,8,9,10]

      \;
    </verbatim>
  </description>

  <\description>
    <item*|tail xs<label|tail>>return all but the first element of
    <verbatim|xs>; <verbatim|xs> must be nonempty
  </description>

  <\description>
    <item*|take n xs<label|take>>take <verbatim|n> elements from the front of
    <verbatim|xs>
  </description>

  <\description>
    <item*|takewhile p xs<label|takewhile>>take elements from the front of
    <verbatim|xs> while the predicate <verbatim|p> is satisfied
  </description>

  <paragraph|List Generators><label|list-generators>

  Some useful (infinite) list generators, as well as some finite (and eager)
  variations of these. The latter work like a combination of
  <hlink|<with|font-family|tt|take>|#take> or
  <hlink|<with|font-family|tt|takewhile>|#takewhile> and the former, but are
  implemented directly for better efficiency.

  <\description>
    <item*|cycle xs<label|cycle>>cycles through the elements of the nonempty
    list <verbatim|xs>, ad infinitum
  </description>

  <\description>
    <item*|cyclen n xs<label|cyclen>>eager version of
    <hlink|<with|font-family|tt|cycle>|#cycle>, returns the first
    <verbatim|n> elements of <verbatim|cycle> <verbatim|xs>
  </description>

  <\description>
    <item*|iterate f x<label|iterate>>returns the stream containing
    <verbatim|x>, <verbatim|f> <verbatim|x>, <verbatim|f> <verbatim|(f>
    <verbatim|x)>, etc., ad infinitum
  </description>

  <\description>
    <item*|iteraten n f x<label|iteraten>>eager version of
    <hlink|<with|font-family|tt|iterate>|#iterate>, returns the first
    <verbatim|n> elements of <verbatim|iterate> <verbatim|f> <verbatim|x>
  </description>

  <\description>
    <item*|iterwhile p f x<label|iterwhile>>another eager version of
    <hlink|<with|font-family|tt|iterate>|#iterate>, returns the list of all
    elements from the front of <verbatim|iterate> <verbatim|f> <verbatim|x>
    for which the predicate <verbatim|p> holds
  </description>

  <\description>
    <item*|repeat x<label|repeat>>returns an infinite stream of <verbatim|x>s
  </description>

  <\description>
    <item*|repeatn n x<label|repeatn>>eager version of
    <hlink|<with|font-family|tt|repeat>|#repeat>, returns a list with
    <verbatim|n> <verbatim|x>s
  </description>

  <paragraph|Zip and Friends><label|zip-and-friends>

  <\description>
    <item*|unzip xys<label|unzip>>takes a list of pairs to a pair of lists of
    corresponding elements
  </description>

  <\description>
    <item*|unzip3 xyzs<label|unzip3>><hlink|<with|font-family|tt|unzip>|#unzip>
    with triples
  </description>

  <\description>
    <item*|zip xs ys<label|zip>>return the list of corresponding pairs
    <verbatim|(x,y)> where <verbatim|x> runs through the elements of
    <verbatim|xs> and <verbatim|y> runs through the elements of <verbatim|ys>
  </description>

  <\description>
    <item*|zip3 xs ys zs<label|zip3>><hlink|<with|font-family|tt|zip>|#zip>
    with three lists, returns a list of triples
  </description>

  <\description>
    <item*|zipwith f xs ys<label|zipwith>>apply the binary function
    <verbatim|f> to corresponding elements of <verbatim|xs> and <verbatim|ys>
  </description>

  <\description>
    <item*|zipwith3 f xs ys zs<label|zipwith3>>apply the ternary function
    <verbatim|f> to corresponding elements of <verbatim|xs>, <verbatim|ys>
    and <verbatim|zs>
  </description>

  Pure also has the following variations of
  <hlink|<with|font-family|tt|zipwith>|#zipwith> and
  <hlink|<with|font-family|tt|zipwith3>|#zipwith3> which throw away all
  intermediate results and return the empty tuple <verbatim|()>. That is,
  these work like <hlink|<with|font-family|tt|do>|#do> but pull arguments
  from two or three lists, respectively:

  <\description>
    <item*|dowith f xs ys<label|dowith>>apply the binary function
    <verbatim|f> to corresponding elements of <verbatim|xs> and
    <verbatim|ys>, return <verbatim|()>
  </description>

  <\description>
    <item*|dowith3 f xs ys zs<label|dowith3>>apply the ternary function
    <verbatim|f> to corresponding elements of <verbatim|xs>, <verbatim|ys>
    and <verbatim|zs>, return <verbatim|()>
  </description>

  <subsubsection|String Functions><label|string-functions><label|index-15><label|string-functions>

  Pure strings are null-terminated character strings encoded in UTF-8, see
  the Pure Manual for details. The prelude provides various operations on
  strings, including a complete set of list-like operations, so that strings
  can be used mostly as if they were lists, although they are really
  implemented as C character arrays for reasons of efficiency. Pure also has
  some powerful operations to convert between Pure expressions and their
  string representation, see <hlink|Eval and Friends|#eval-and-friends> for
  those.

  <paragraph|Basic String Functions><label|basic-string-functions>

  <\description>
    <item*|s + t<label|+/string>>

    <item*|s ! i<label|!/string>>

    <item*|s !! is<label|!!/string>><label|index-16><label|index-17><label|index-18>String
    concatenation, indexing and slicing works just like with lists:

    <\verbatim>
      \;

      \<gtr\> "abc"+"xyz";

      "abcxyz"

      \<gtr\> let s = "The quick brown fox jumps over the lazy dog.";

      \<gtr\> s!5;

      "u"

      \<gtr\> s!!(20..24);

      "jumps"

      \;
    </verbatim>
  </description>

  <\description>
    <item*|null s<label|null/string>>

    <item*|# s<label|#/string>><label|index-19>Checking for empty strings and
    determining the size of a string also works as expected:

    <\verbatim>
      \;

      \<gtr\> null "";

      1

      \<gtr\> null s;

      0

      \<gtr\> #s;

      44

      \;
    </verbatim>
  </description>

  <\description>
    <item*|s == t<label|==/string>>

    <item*|s <math|\<sim\>>= t<label|-tilde=/string>>

    <item*|s \<less\>= t<label|\<less\>=/string>>

    <item*|s \<gtr\>= t<label|\<gtr\>=/string>>

    <item*|s \<less\> t<label|\<less\>/string>>

    <item*|s \<gtr\> t<label|\<gtr\>/string>><label|index-20>String equality
    and comparisons. This employs the usual lexicographic order based on the
    (UTF-8) character codes.

    <\verbatim>
      \;

      \<gtr\> "awe"\<gtr\>"awesome";

      0

      \<gtr\> "foo"\<gtr\>="bar";

      1

      \<gtr\> "foo"=="bar";

      0

      \;
    </verbatim>
  </description>

  You can search for the location of a substring in a string, and extract a
  substring of a given length:

  <\description>
    <item*|index s u<label|index/string>>Returns the (zero-based) index of
    the first occurrence of the substring <verbatim|u> in <verbatim|s>, or -1
    if <verbatim|u> is not found in <verbatim|s>.
  </description>

  <\description>
    <item*|substr s i n<label|substr>>Extracts a substring of (at most)
    <verbatim|n> characters at position <verbatim|i> in <verbatim|s>. This
    takes care of all corner cases, adjusting index and number of characters
    so that the index range stays confined to the source string.
  </description>

  Example:

  <\verbatim>
    \;

    \<gtr\> index s "jumps";

    20

    \<gtr\> substr s 20 10;

    "jumps over"

    \;
  </verbatim>

  Note that Pure doesn't have a separate type for individual characters.
  Instead, these are represented as strings <verbatim|c> containing exactly
  one (UTF-8) character (i.e., <verbatim|#c==1>). It is possible to convert
  such single character strings to the corresponding integer character codes,
  and vice versa:

  <\description>
    <item*|ord c<label|ord>>Ordinal number of a single character string
    <verbatim|c>. This is the character's code point in the Unicode character
    set.
  </description>

  <\description>
    <item*|chr n<label|chr>>Converts an integer back to the character with
    the corresponding code point.
  </description>

  <label|index-21>

  In addition, the usual character arithmetic works, including arithmetic
  sequences of characters, so that you can write stuff like the following:

  <\verbatim>
    \;

    \<gtr\> "a"-"A";

    32

    \<gtr\> "u"-32;

    "U"

    \<gtr\> "a".."k";

    ["a","b","c","d","e","f","g","h","i","j","k"]

    \;
  </verbatim>

  For convenience, the prelude provides the following functions to convert
  between strings and lists (or other aggregates) of characters.

  <\description>
    <item*|chars s<label|chars>>

    <item*|list s<label|list/string>>Convert a string <verbatim|s> to a list
    of characters.
  </description>

  <\description>
    <item*|tuple s<label|tuple/string>>

    <item*|matrix s<label|matrix/string>>Convert a string <verbatim|s> to a
    tuple or (symbolic) matrix of characters, respectively.
  </description>

  <\description>
    <item*|strcat xs<label|strcat>>Concatenate a list <verbatim|xs> of
    strings (in particular, this converts a list of characters back to a
    string).
  </description>

  <\description>
    <item*|string xs<label|string>>Convert a list, tuple or (symbolic) matrix
    of strings to a string. In the case of a list, this is synonymous with
    <hlink|<with|font-family|tt|strcat>|#strcat>, but it also works with the
    other types of aggregates.
  </description>

  For instance:

  <\verbatim>
    \;

    \<gtr\> list "abc";

    ["a","b","c"]

    \<gtr\> string ("a".."z");

    "abcdefghijklmnopqrstuvwxyz"

    \;
  </verbatim>

  The following functions are provided to deal with strings of \Ptokens\Q
  separated by a given delimiter string.

  <\description>
    <item*|split delim s<label|split>>Splits <verbatim|s> into a list of
    substrings delimited by <verbatim|delim>.
  </description>

  <\description>
    <item*|join delim xs<label|join>>Joins the list of strings <verbatim|xs>
    to a single string, interpolating the given <verbatim|delim> string.
  </description>

  Example:

  <\verbatim>
    \;

    \<gtr\> let xs = split " " s; xs;

    ["The","quick","brown","fox","jumps","over","the","lazy","dog."]

    \<gtr\> join ":" xs;

    "The:quick:brown:fox:jumps:over:the:lazy:dog."

    \;
  </verbatim>

  We mention in passing here that more elaborate string matching, splitting
  and replacement operations based on regular expressions are provided by the
  system module, see <hlink|Regex Matching|#regex-matching>.

  If that isn't enough already, most generic list operations carry over to
  strings in the obvious way, treating the string like a list of characters.
  (Polymorphic operations such as <hlink|<with|font-family|tt|map>|#map>,
  which aren't guaranteed to yield string results under all circumstances,
  will actually return lists in that case, so you might have to apply
  <hlink|<with|font-family|tt|string>|#string> explicitly to convert these
  back to a string.) For instance:

  <\verbatim>
    \;

    \<gtr\> filter (\<gtr\>="k") s;

    "qukrownoxumpsovrtlzyo"

    \<gtr\> string $ map pred "ibm";

    "hal"

    \;
  </verbatim>

  List comprehensions can draw values from strings, too:

  <\verbatim>
    \;

    \<gtr\> string [x+1 \| x="HAL"];

    "IBM"

    \;
  </verbatim>

  <paragraph|Low-Level Operations><label|low-level-operations>

  The following routines are provided by the runtime to turn raw C
  <verbatim|char*> pointers (also called <with|font-series|bold|byte strings>
  in Pure parlance, to distinguish them from Pure's \Pcooked\Q UTF-8 string
  values) into corresponding Pure strings. Normally you don't have to worry
  about this, because the C interface already takes care of the necessary
  marshalling, but in some low-level code these operations are useful. Also
  note that here and in the following, the
  <hlink|<with|font-family|tt|cstring>|#cstring> routines also convert the
  string between the system encoding and Pure's internal UTF-8
  representation.

  <\description>
    <item*|string s<label|string/pointer>>

    <item*|cstring s<label|cstring>>Convert a pointer <verbatim|s> to a Pure
    string. <verbatim|s> must point to a null-terminated C string. These
    routines take ownership of the original string value, assuming it to be
    malloced, so you should only use these for C strings which are
    specifically intended to be freed by the user.
  </description>

  <\description>
    <item*|string_dup s<label|string-dup>>

    <item*|cstring_dup s<label|cstring-dup>>Convert a pointer <verbatim|s> to
    a Pure string. Like above, but these functions take a copy of the string,
    leaving the original C string untouched.
  </description>

  The reverse transformations are also provided. These take a Pure string to
  a byte string (raw <verbatim|char*>).

  <\description>
    <item*|byte_string s<label|byte-string>>

    <item*|byte_cstring s<label|byte-cstring>>Construct a byte string from a
    Pure string <verbatim|s>. The result is a raw pointer object pointing to
    the converted string. The original Pure string is always copied (and, in
    the case of <hlink|<with|font-family|tt|byte_cstring>|#byte-cstring>,
    converted to the system encoding). The resulting byte string is a
    malloced pointer which can be used like a C <verbatim|char*>, and has to
    be freed explicitly by the caller when no longer needed.
  </description>

  It is also possible to convert Pure string lists or symbolic vectors of
  strings to byte string vectors and vice versa. These are useful if you need
  to pass an <verbatim|argv>-like string vector (i.e., a <verbatim|char**> or
  <verbatim|char*[]>) to C routines. The computed C vectors are malloced
  pointers which have an extra <hlink|<with|font-family|tt|NULL>|#NULL>
  pointer as the last entry, and should thus be usable for almost any purpose
  which requires such a string vector in C. They also take care of
  garbage-collecting themselves. The original string data is always copied.
  As usual, the <hlink|<with|font-family|tt|cstring>|#cstring> variants do
  automatic conversions to the system encoding.

  <\description>
    <item*|byte_string_pointer xs<label|byte-string-pointer>>

    <item*|byte_cstring_pointer xs<label|byte-cstring-pointer>>Convert a list
    or vector of Pure strings to a C <verbatim|char**>.
  </description>

  <\description>
    <item*|string_list n p<label|string-list>>

    <item*|cstring_list n p<label|cstring-list>>Convert a C <verbatim|char**>
    to a list of Pure strings.
  </description>

  <\description>
    <item*|string_vector n p<label|string-vector>>

    <item*|cstring_vector n p<label|cstring-vector>>Convert a C
    <verbatim|char**> to a symbolic vector of Pure strings.
  </description>

  Note that the back conversions take an additional first argument which
  denotes the number of strings to retrieve. If you know that the vector is
  <hlink|<with|font-family|tt|NULL>|#NULL>-terminated then this can also be
  an infinite value (<verbatim|inf>) in which case the number of elements
  will be figured out automatically. Processing always stops at the first
  <hlink|<with|font-family|tt|NULL>|#NULL> pointer encountered.

  Also note that, as of version 0.45, Pure has built-in support for passing
  <verbatim|argv>-style vectors as arguments by means of the
  <verbatim|char**> and <verbatim|void**> pointer types. However, the
  operations provided here are more general in that they allow you to both
  encode and decode such values in an explicit fashion. This is useful, e.g.,
  for operations like <verbatim|getopt> which may mutate the given
  <verbatim|char**> vector.

  If you have <verbatim|getopt> in your C library, you can try the following
  example. First enter these definitions:

  <\verbatim>
    \;

    extern int getopt(int argc, char **argv, char *optstring);

    optind = get_int $ addr "optind";

    optarg = cstring_dup $ get_pointer $ addr "optarg";

    \;
  </verbatim>

  Now let's run <verbatim|getopt> on a byte string vector constructed from an
  argument vector (which includes the \Pprogram name\Q in the first element):

  <\verbatim>
    \;

    \<gtr\> let args = byte_cstring_pointer
    {"progname","boo","-n","-tfoo","bar"};

    \<gtr\> getopt 5 args "nt:", optarg;

    110,#\<less\>pointer 0x0\<gtr\>

    \<gtr\> getopt 5 args "nt:", optarg;

    116,"foo"

    \<gtr\> getopt 5 args "nt:", optarg;

    -1,#\<less\>pointer 0x0\<gtr\>

    \;
  </verbatim>

  Note that 110 and 116 are the character codes of the option characters
  <verbatim|n> and <verbatim|t>, where the latter option takes an argument,
  as returned by <verbatim|optarg>. Finally, <verbatim|getopt> returns -1 to
  indicate that there are no more options, and we can retrieve the current
  <verbatim|optindex> value and the mutated argument vector to see which
  non-option arguments remain to be processed, as follows:

  <\verbatim>
    \;

    \<gtr\> optind, cstring_vector 5 args;

    3,{"progname","-n","-tfoo","boo","bar"}

    \;
  </verbatim>

  It is now an easy exercise to design your own high-level wrapper around
  <verbatim|getopt> to process command line arguments in Pure. However, this
  isn't really necessary since the Pure library already offers such an
  operation which doesn't rely on any special system functions, see
  <hlink|Option Parsing|#option-parsing> in the <hlink|System
  Interface|#system-interface> section.

  <subsubsection|Matrix Functions><label|matrix-functions>

  Matrices are provided as an alternative to the list and tuple aggregates
  which provide contant time access to their members and are tailored for use
  in numeric computations.

  <\description>
    <item*|# x<label|#/matrix>>

    <item*|dim x<label|dim>><label|index-22><label|index-23>Determine the
    size of a matrix (number of elements) and its dimensions (number of rows
    and columns).

    <\verbatim>
      \;

      \<gtr\> let x = {1,2,3;4,5,6}; #x;

      6

      \<gtr\> dim x;

      2,3

      \;
    </verbatim>
  </description>

  <\description>
    <item*|null<label|null/matrix>>Check for empty matrices. Note that there
    are various kinds of these, as a matrix may have zero rows or columns, or
    both.
  </description>

  <\description>
    <item*|x == y<label|==/matrix>>

    <item*|x <math|\<sim\>>= y<label|-tilde=/matrix>>Matrix equality and
    inequality. These check the dimensions and the matrix elements for
    equality:

    <\verbatim>
      \;

      \<gtr\> x == transpose x;

      0

      \;
    </verbatim>
  </description>

  <\description>
    <item*|x ! i<label|!/matrix>>

    <item*|x !! is<label|!!/matrix>>Indexing and slicing.
  </description>

  Indexing and slicing employ the standard Pure operators
  `<hlink|<with|font-family|tt|!>|#!>` and
  `<hlink|<with|font-family|tt|!!>|#!!>`. They work pretty much like in
  MATLAB and Octave, but note that Pure matrices are in row-major order and
  the indices are zero-based. It is possible to access elements with a
  one-dimensional index (in row-major oder):

  <\verbatim>
    \;

    \<gtr\> x!3;

    4

    \;
  </verbatim>

  Or you can specify a pair of row and column index:

  <\verbatim>
    \;

    \<gtr\> x!(1,0);

    4

    \;
  </verbatim>

  Slicing works accordingly. You can either specify a list of (one- or
  two-dimensional) indices, in which case the result is always a row vector:

  <\verbatim>
    \;

    \<gtr\> x!!(2..5);

    {3,4,5,6}

    \;
  </verbatim>

  Or you can specify a pair of row and column index lists:

  <\verbatim>
    \;

    \<gtr\> x!!(0..1,1..2);

    {2,3;5,6}

    \;
  </verbatim>

  The following abbreviations are provided to grab a slice from a row or
  column:

  <\verbatim>
    \;

    \<gtr\> x!!(1,1..2);

    {5,6}

    \<gtr\> x!!(0..1,1);

    {2;5}

    \;
  </verbatim>

  As in the case of lists, matrix slices are optimized to handle cases with
  contiguous index ranges in an efficient manner, see
  <hlink|Slicing|#slicing> for details. To these ends, the helper functions
  <hlink|<with|font-family|tt|subseq>|#subseq/matrix> and
  <hlink|<with|font-family|tt|subseq2>|#subseq2/matrix> are defined to handle
  the necessary compile time optimizations.

  Most of the generic list operations are implemented on matrices as well,
  see <hlink|Common List Functions|#common-list-functions>. Hence operations
  like <hlink|<with|font-family|tt|map>|#map> and
  <hlink|<with|font-family|tt|zipwith>|#zipwith> work as expected:

  <\verbatim>
    \;

    \<gtr\> map succ {1,2,3;4,5,6};

    {2,3,4;5,6,7}

    \<gtr\> zipwith (+) {1,2,3;4,5,6} {1,0,1;0,2,0};

    {2,2,4;4,7,6}

    \;
  </verbatim>

  The matrix module also provides a bunch of other specialized matrix
  operations, including all the necessary operations for matrix
  comprehensions. We briefly summarize the most important operations below;
  please refer to matrices.pure for all the gory details. Also make sure you
  check <hlink|<em|Matrices and Vectors>|pure.tm#matrices-and-vectors> in the
  Pure Manual for some more examples, and the <hlink|Record
  Functions|#record-functions> section for an implementation of records using
  symbolic vectors.

  <paragraph|Matrix Construction and Conversions><label|matrix-construction-and-conversions>

  <\description>
    <item*|matrix xs<label|matrix>>This function converts a list or tuple to
    a corresponding matrix. <hlink|<with|font-family|tt|matrix>|#matrix> also
    turns a list of lists or matrices specifying the rows of the matrix to
    the corresponding rectangular matrix; otherwise, the result is a row
    vector. (In the former case, <hlink|<with|font-family|tt|matrix>|#matrix>
    may throw a <hlink|<with|font-family|tt|bad_matrix_value>|#bad-matrix-value>
    exception in case of dimension mismatch, with the offending submatrix as
    argument.)

    <\verbatim>
      \;

      \<gtr\> matrix [1,2,3];

      {1,2,3}

      \<gtr\> matrix [[1,2,3],[4,5,6]];

      {1,2,3;4,5,6}

      \;
    </verbatim>
  </description>

  <\description>
    <item*|rowvector xs<label|rowvector>>

    <item*|colvector xs<label|colvector>>

    <item*|vector xs<label|vector>>The <hlink|<with|font-family|tt|rowvector>|#rowvector>
    and <hlink|<with|font-family|tt|colvector>|#colvector> functions work in
    a similar fashion, but expect a list, tuple or matrix of elements and
    always return a row or column vector, respectively (i.e., a
    <puredoc-image|_images/math/d27c43e5796d05a1f8593a5c9307fc0fc5ef1e7d.png|66%|66%||>
    or <puredoc-image|_images/math/74745a97c0fc5faec3f205a2c39ff354206b0f3c.png|66%|66%||>
    matrix, where <puredoc-image|_images/math/174fadd07fd54c9afe288e96558c92e0c1da733a.png|66%|66%||>
    is the size of the converted aggregate). Also, the
    <hlink|<with|font-family|tt|vector>|#vector> function is a synonym for
    <hlink|<with|font-family|tt|rowvector>|#rowvector>. These functions can
    also be used to create recursive (symbolic) matrix structures of
    arbitrary depth, which provide a nested array data structure with
    efficient (constant time) element access.

    <\verbatim>
      \;

      \<gtr\> rowvector [1,2,3];

      {1,2,3}

      \<gtr\> colvector [1,2,3];

      {1;2;3}

      \<gtr\> vector [rowvector [1,2,3],colvector [4,5,6]];

      {{1,2,3},{4;5;6}}

      \;
    </verbatim>

    Note that for convenience, there's also an alternative syntax for
    entering nested vectors more easily, see the description of the
    <hlink|<em|non-splicing vector brackets>|#non-splicing> below for
    details.
  </description>

  <\description>
    <item*|rowvectorseq x y step<label|rowvectorseq>>

    <item*|colvectorseq x y step<label|colvectorseq>>

    <item*|vectorseq x y step<label|vectorseq>>With these functions you can
    create a row or column vector from an arithmetic sequence. Again,
    <hlink|<with|font-family|tt|vectorseq>|#vectorseq> is provided as a
    synonym for <hlink|<with|font-family|tt|rowvectorseq>|#rowvectorseq>.
    These operations are optimized for the case of int and double ranges.

    <\verbatim>
      \;

      \<gtr\> rowvectorseq 0 10 1;

      {0,1,2,3,4,5,6,7,8,9,10}

      \<gtr\> colvectorseq 0 10 1;

      {0;1;2;3;4;5;6;7;8;9;10}

      \<gtr\> vectorseq 0.0 0.9 0.1;

      {0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9}

      \;
    </verbatim>

    The prelude also contains some optimization rules which translate calls
    to <hlink|<with|font-family|tt|vector>|#vector> et al on arithmetic
    sequences to the corresponding calls to
    <hlink|<with|font-family|tt|vectorseq>|#vectorseq> et al, such as:

    <\verbatim>
      \;

      def vector (n1:n2..m) = vectorseq n1 m (n2-n1);

      def vector (n..m) = vectorseq n m 1;

      \;
    </verbatim>

    Example:

    <\verbatim>
      \;

      \<gtr\> foo = vector (1..10);

      \<gtr\> bar = vector (0.0:0.1..0.9);

      \<gtr\> show foo bar

      bar = vectorseq 0.0 0.9 0.1;

      foo = vectorseq 1 10 1;

      \<gtr\> foo; bar;

      {1,2,3,4,5,6,7,8,9,10}

      {0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9}

      \;
    </verbatim>

    Please note that these optimization rules assume that basic arithmetic
    works with the involved elements, which may give you trouble if you try
    to use <hlink|<with|font-family|tt|vector>|#vector> et al with exotic
    kinds of user-defined arithmetic sequences. To disable them, simply run
    the interpreter with the option <verbatim|--disable>
    <verbatim|vectorseq-opt>.
  </description>

  <\description>
    <item*|dmatrix xs<label|dmatrix>>

    <item*|cmatrix xs<label|cmatrix>>

    <item*|imatrix xs<label|imatrix>>

    <item*|smatrix xs<label|smatrix>>These functions convert a list or matrix
    to a matrix of the corresponding type (integer, double, complex or
    symbolic). If the input is a list, the result is always a row vector;
    this is usually faster than the <hlink|<with|font-family|tt|matrix>|#matrix>
    and <hlink|<with|font-family|tt|vector>|#vector> operations, but requires
    that the elements already are of the appropriate type.

    <\verbatim>
      \;

      \<gtr\> imatrix [1,2,3];

      {1,2,3}

      \<gtr\> dmatrix {1,2,3;4,5,6};

      {1.0,2.0,3.0;4.0,5.0,6.0}

      \;
    </verbatim>

    In addition, these functions can also be invoked with either an int
    <verbatim|n> or a pair <verbatim|(n,m)> of ints as argument, in which
    case they construct a zero rowvector or matrix with the corresponding
    dimensions.

    <\verbatim>
      \;

      \<gtr\> imatrix 3;

      {0,0,0}

      \<gtr\> imatrix (2,3);

      {0,0,0;0,0,0}

      \;
    </verbatim>
  </description>

  <\description>
    <item*|list x<label|list/matrix>>

    <item*|list2 x<label|list2/matrix>>

    <item*|tuple x<label|tuple/matrix>>These convert a matrix back to a flat
    list or tuple. The <verbatim|list2> function converts a matrix to a list
    of lists (one sublist for each row of the matrix).

    <\verbatim>
      \;

      \<gtr\> tuple {1,2,3;4,5,6};

      1,2,3,4,5,6

      \<gtr\> list {1,2,3;4,5,6};

      [1,2,3,4,5,6]

      \<gtr\> list2 {1,2,3;4,5,6};

      [[1,2,3],[4,5,6]]

      \<gtr\> list2 {1,2,3};

      [[1,2,3]]

      \;
    </verbatim>
  </description>

  <label|non-splicing>

  In addition, the following special syntax is provided as a shorthand
  notation for nested vector structures:

  <\description>
    <item*|<em|macro> {\| x, y, z, ... \|}<label|?7B\|>>Non-splicing vector
    brackets. These work like <verbatim|{x,y,z,...}>, but unlike these they
    will <em|not> splice submatrices in the arguments <verbatim|x,y,z,...> So
    they work a bit like quoted vectors <verbatim|'{x,y,z,...}>, but the
    arguments <verbatim|x,y,z,...> will be evaluated as usual.
  </description>

  The non-splicing vector brackets provide a convenient shorthand to enter
  symbolic vector values which may contain other vectors or matrices as
  components. For instance, note how the ordinary matrix brackets combine the
  column subvectors in the first example below to a 3x2 matrix, while the
  non-splicing brackets in the second example create a 1x2 row vector with
  the column vectors as members instead:

  <\verbatim>
    \;

    \<gtr\> {{1;2;3},{4;5;6}};

    {1,4;2,5;3,6}

    \<gtr\> {\|{1;2;3},{4;5;6}\|};

    {{1;2;3},{4;5;6}}

    \;
  </verbatim>

  The second example works like a quoted matrix expression such as
  <verbatim|'{{1;2;3},{4;5;6}}>, but the non-splicing brackets also evaluate
  their arguments:

  <\verbatim>
    \;

    \<gtr\> '{vector (1..3),vector (4..6)};

    {vector (1..3),vector (4..6)}

    \<gtr\> {\|vector (1..3),vector (4..6)\|};

    {{1,2,3},{4,5,6}}

    \;
  </verbatim>

  The <verbatim|{\|> <verbatim|\|}> brackets can be nested. Examples:

  <\verbatim>
    \;

    \<gtr\> {\|1,{\|vector (1..5),2*3\|},{}\|};

    {1,{{1,2,3,4,5},6},{}}

    \<gtr\> {\|{\|{1,2}\|},{\|{3,4}\|}\|};

    {{{1,2}},{{3,4}}}

    \;
  </verbatim>

  Also note that the <verbatim|{\|> <verbatim|\|}> brackets only produce row
  vectors, but you can just transpose the result if you need a column vector
  instead:

  <\verbatim>
    \;

    \<gtr\> transpose {\|{1;2;3},{4;5;6}\|};

    {{1;2;3};{4;5;6}}

    \;
  </verbatim>

  Finally, note that the notation <verbatim|{\|> <verbatim|\|}> without any
  arguments is not supported, simply write <verbatim|{}> for the empty vector
  instead.

  <paragraph|Matrix Inspection and Manipulation><label|matrix-inspection-and-manipulation>

  <\description>
    <item*|<em|type> dmatrix>

    <item*|<em|type> cmatrix>

    <item*|<em|type> imatrix>

    <item*|<em|type> smatrix>

    <item*|<em|type> nmatrix<label|nmatrix>>Convenience types for the
    different subtypes of matrices (double, complex, int, symbolic and
    numeric, i.e., non-symbolic). These can be used as type tags on the
    left-hand side of equations to match specific types of matrices.
  </description>

  <\description>
    <item*|dmatrixp x<label|dmatrixp>>

    <item*|cmatrixp x<label|cmatrixp>>

    <item*|imatrixp x<label|imatrixp>>

    <item*|smatrixp x<label|smatrixp>>

    <item*|nmatrixp x<label|nmatrixp>>Corresponding predicates to check for
    different kinds of matrices.
  </description>

  <\description>
    <item*|vectorp x<label|vectorp>>

    <item*|rowvectorp x<label|rowvectorp>>

    <item*|colvectorp x<label|colvectorp>>Check for different kinds of
    vectors (these are just matrices with one row or column).
  </description>

  <\description>
    <item*|stride x<label|stride>>The stride of a matrix denotes the real row
    size of the underlying C array, see the description of the
    <hlink|<with|font-family|tt|pack>|#pack> function below for further
    details. There's little use for this value in Pure, but it may be needed
    when interfacing to C.
  </description>

  <\description>
    <item*|subseq x i j<label|subseq/matrix>>

    <item*|subseq2 x i j k l<label|subseq2/matrix>>Helper functions to
    optimize matrix slices, see <hlink|Slicing|#slicing> for details.
    <hlink|<with|font-family|tt|subseq2>|#subseq2/matrix> is a special
    version of <hlink|<with|font-family|tt|subseq>|#subseq/matrix> which is
    used to optimize the case of 2-dimensional matrix slices
    <verbatim|xs!!(i..j,k..l)>.
  </description>

  <\description>
    <item*|row x i<label|row>>

    <item*|col x i<label|col>>Extract the <verbatim|i>th row or column of a
    matrix.
  </description>

  <\description>
    <item*|rows x<label|rows>>

    <item*|cols x<label|cols>>Return the list of all rows or columns of a
    matrix.
  </description>

  <\description>
    <item*|diag x<label|diag>>

    <item*|subdiag x k<label|subdiag>>

    <item*|supdiag x k<label|supdiag>>Extract (sub-,super-) diagonals from a
    matrix. Sub- and super-diagonals for <verbatim|k=0> return the main
    diagonal. Indices for sub- and super-diagonals can also be negative, in
    which case the corresponding super- or sub-diagonal is returned instead.
    In each case the result is a row vector.
  </description>

  <\description>
    <item*|submat x (i,j) (n,m)<label|submat>>Extract a submatrix of a given
    size at a given offset. The result shares the underlying storage with the
    input matrix (i.e., matrix elements are <em|not> copied) and so this is a
    comparatively cheap operation.
  </description>

  <\description>
    <item*|rowcat xs<label|rowcat>>

    <item*|colcat xs<label|colcat>>Construct matrices from lists of rows and
    columns. These take either scalars or submatrices as inputs;
    corresponding dimensions must match. <hlink|<with|font-family|tt|rowcat>|#rowcat>
    combines submatrices vertically, like <verbatim|{x;y}>;
    <hlink|<with|font-family|tt|colcat>|#colcat> combines them horizontally,
    like <verbatim|{x,y}>. Note: Like the built-in matrix constructs, these
    operations may throw a <hlink|<with|font-family|tt|bad_matrix_value>|#bad-matrix-value>
    exception in case of dimension mismatch.
  </description>

  <\description>
    <item*|matcat xs<label|matcat>>Construct a matrix from a (symbolic)
    matrix of other matrices and/or scalars. This works like a combination of
    <hlink|<with|font-family|tt|rowcat>|#rowcat> and
    <hlink|<with|font-family|tt|colcat>|#colcat>, but draws its input from a
    matrix instead of a list of matrices, and preserves the overall layout of
    the \Phost\Q matrix. The net effect is that the host matrix is flattened
    out. If all elements of the input matrix are scalars already, the input
    matrix is returned unchanged.
  </description>

  <\description>
    <item*|rowcatmap f xs<label|rowcatmap>>

    <item*|colcatmap f xs<label|colcatmap>>

    <item*|rowmap f xs<label|rowmap>>

    <item*|colmap f xs<label|colmap>>Various combinations of
    <hlink|<with|font-family|tt|rowcat>|#rowcat>,
    <hlink|<with|font-family|tt|colcat>|#colcat> and
    <hlink|<with|font-family|tt|map>|#map>. These are used, in particular,
    for implementing matrix comprehensions.
  </description>

  <\description>
    <item*|diagmat x<label|diagmat>>

    <item*|subdiagmat x k<label|subdiagmat>>

    <item*|supdiagmat x k<label|supdiagmat>>Create a (sub-,super-) diagonal
    matrix from a row vector <verbatim|x> of size <verbatim|n>. The result is
    always a square matrix with dimension <verbatim|(n+k,n+k)>, which is of
    the same matrix type (double, complex, int, symbolic) as the input and
    has the elements of the vector on its <verbatim|k>th sub- or
    super-diagonal, with all other elements zero. A negative value for
    <verbatim|k> turns a sub- into a super-diagonal matrix and vice versa.
  </description>

  <\description>
    <item*|re x<label|re/matrix>>

    <item*|im x<label|im/matrix>>

    <item*|conj x<label|conj/matrix>>Extract the real and imaginary parts and
    compute the conjugate of a numeric matrix.
  </description>

  <\description>
    <item*|pack x<label|pack>>

    <item*|packed x<label|packed>>Pack a matrix. This creates a copy of the
    matrix which has the data in contiguous storage. It also frees up extra
    memory if the matrix was created as a slice from a bigger matrix (see
    <hlink|<with|font-family|tt|submat>|#submat> above) which has since gone
    the way of the dodo. The <hlink|<with|font-family|tt|packed>|#packed>
    predicate can be used to verify whether a matrix is already packed. Note
    that even if a matrix is already packed,
    <hlink|<with|font-family|tt|pack>|#pack> will make a copy of it anyway,
    so <hlink|<with|font-family|tt|pack>|#pack> also provides a quick way to
    copy a matrix, e.g., if you want to pass it as an input/output parameter
    to a GSL routine.
  </description>

  <\description>
    <item*|redim (n,m) x<label|redim>>

    <item*|redim n x>Change the dimensions of a matrix without changing its
    size. The total number of elements must match that of the input matrix.
    Reuses the underlying storage of the input matrix if possible (i.e., if
    the matrix is <hlink|<with|font-family|tt|packed>|#packed>). You can also
    redim a matrix to a given row size <verbatim|n>. In this case the row
    size must divide the total size of the matrix.
  </description>

  <\description>
    <item*|sort p x<label|sort/matrix>>Sorts the elements of a matrix
    (non-destructively, i.e., without changing the original matrix) according
    to the given predicate, using the C <verbatim|qsort> function. This works
    exactly the same as with lists (see <hlink|Common List
    Functions|#common-list-functions>), except that it takes and returns a
    matrix instead of a list. Note that the function sorts <em|all> elements
    of the matrix in one go (regardless of the dimensions), as if the matrix
    was a single big vector. The result matrix has the same dimensions as the
    input matrix. Example:

    <\verbatim>
      \;

      \<gtr\> sort (\<less\>) {10,9;8,7;6,5};

      {5,6;7,8;9,10}

      \;
    </verbatim>

    If you'd like to sort the individual rows instead, you can do that as
    follows:

    <\verbatim>
      \;

      \<gtr\> sort_rows p = rowcat . map (sort p) . rows;

      \<gtr\> sort_rows (\<less\>) {10,9;8,7;6,5};

      {9,10;7,8;5,6}

      \;
    </verbatim>

    Likewise, to sort the columns of a matrix:

    <\verbatim>
      \;

      \<gtr\> sort_cols p = colcat . map (sort p) . cols;

      \<gtr\> sort_cols (\<less\>) {10,9;8,7;6,5};

      {6,5;8,7;10,9}

      \;
    </verbatim>

    Also note that the pure-gsl module provides an interface to the GSL
    routines for sorting numeric (int and double) vectors using the standard
    order. These will usually be much faster than
    <hlink|<with|font-family|tt|sort>|#sort/matrix>, whereas
    <hlink|<with|font-family|tt|sort>|#sort/matrix> is more flexible in that
    it also allows you to sort symbolic matrices and to choose the order
    predicate.
  </description>

  <\description>
    <item*|transpose x<label|transpose/matrix>>Transpose a matrix. Example:

    <\verbatim>
      \;

      \<gtr\> transpose {1,2,3;4,5,6};

      {1,4;2,5;3,6}

      \;
    </verbatim>
  </description>

  <\description>
    <item*|rowrev x<label|rowrev>>

    <item*|colrev x<label|colrev>>

    <item*|reverse x<label|reverse/matrix>>Reverse a matrix.
    <hlink|<with|font-family|tt|rowrev>|#rowrev> reverses the rows,
    <hlink|<with|font-family|tt|colrev>|#colrev> the columns,
    <hlink|<with|font-family|tt|reverse>|#reverse> both dimensions.
  </description>

  <paragraph|Pointers and Matrices><label|pointers-and-matrices>

  Last but not least, the matrix module also offers a bunch of low-level
  operations for converting between matrices and raw pointers. These are
  typically used to shovel around massive amounts of numeric data between
  Pure and external C routines, when performance and throughput is an
  important consideration (e.g., graphics, video and audio applications). The
  usual caveats concerning direct pointer manipulations apply.

  <\description>
    <item*|pointer x<label|pointer/matrix>>Get a pointer to the underlying C
    array of a matrix. The data is <em|not> copied. Hence you have to be
    careful when passing such a pointer to C functions if the underlying data
    is non-contiguous; when in doubt, first use the
    <hlink|<with|font-family|tt|pack>|#pack> function to place the data in
    contiguous storage, or use one of the matrix-pointer conversion routines
    below.
  </description>

  <\description>
    <item*|double_pointer p x<label|double-pointer>>

    <item*|float_pointer p x<label|float-pointer>>

    <item*|complex_pointer p x<label|complex-pointer>>

    <item*|complex_float_pointer p x<label|complex-float-pointer>>

    <item*|int64_pointer p x<label|int64-pointer>>

    <item*|int_pointer p x<label|int-pointer>>

    <item*|short_pointer p x<label|short-pointer>>

    <item*|byte_pointer p x<label|byte-pointer>>These operations copy the
    contents of a matrix to a given pointer and return that pointer,
    converting to the target data type on the fly if necessary. The given
    pointer may also be <hlink|<with|font-family|tt|NULL>|#NULL>, in which
    case suitable memory is malloced and returned; otherwise the caller must
    ensure that the memory pointed to by <verbatim|p> is big enough for the
    contents of the given matrix. The source matrix <verbatim|x> may be an
    arbitrary numeric matrix. In the case of
    <hlink|<with|font-family|tt|int64_pointer>|#int64-pointer>, <verbatim|x>
    may also be a symbolic matrix holding bigint values which are converted
    to 64 bit machine integers.
  </description>

  <\description>
    <item*|double_matrix (n,m) p<label|double-matrix>>

    <item*|float_matrix (n,m) p<label|float-matrix>>

    <item*|complex_matrix (n,m) p<label|complex-matrix>>

    <item*|complex_float_matrix (n,m) p<label|complex-float-matrix>>

    <item*|int64_matrix (n,m) p<label|int64-matrix>>

    <item*|int_matrix (n,m) p<label|int-matrix>>

    <item*|short_matrix (n,m) p<label|short-matrix>>

    <item*|byte_matrix (n,m) p<label|byte-matrix>>These functions allow you
    to create a matrix from a pointer, copying the data and converting it
    from the source type on the fly if necessary. The result will be a
    numeric matrix of the appropriate type, except in the case of
    <hlink|<with|font-family|tt|int64_matrix>|#int64-matrix> where the result
    is a symbolic matrix consisting of bigint values. The source pointer
    <verbatim|p> may also be <hlink|<with|font-family|tt|NULL>|#NULL>, in
    which case the new matrix is filled with zeros instead. Otherwise the
    caller must ensure that the pointer points to properly initialized memory
    big enough for the requested dimensions. The given dimension may also be
    just an integer <verbatim|n> if a row vector is to be created.
  </description>

  <\description>
    <item*|double_matrix_view (n,m) p<label|double-matrix-view>>

    <item*|complex_matrix_view (n,m) p<label|complex-matrix-view>>

    <item*|int_matrix_view (n,m) p<label|int-matrix-view>>These operations
    can be used to create a numeric matrix view of existing data, without
    copying the data. The data must be double, complex or int, the pointer
    must not be <hlink|<with|font-family|tt|NULL>|#NULL> and the caller must
    also ensure that the memory persists for the entire lifetime of the
    matrix object. The given dimension may also be just an integer
    <verbatim|n> if a row vector view is to be created.
  </description>

  <subsubsection|Record Functions><label|record-functions>

  As of Pure 0.41, the prelude also provides a basic record data structure,
  implemented as symbolic vectors of <verbatim|key=\>value> pairs which
  support a few dictionary-like operations such as
  <hlink|<with|font-family|tt|member>|#member/record>,
  <hlink|<with|font-family|tt|insert>|#insert/record> and indexing. Records
  may be represented as row, column or empty vectors (i.e., the number of
  rows or columns must be zero or one). They must be symbolic matrices
  consisting only of \Phash pairs\Q <verbatim|key=\>value>, where the keys
  can be either symbols or strings. The values can be any kind of Pure data;
  in particular, they may themselves be records, so records can be nested.

  The following operations are provided. Please note that all updates of
  record members are non-destructive and thus involve copying, which takes
  linear time (and space) and thus might be slow for large record values; if
  this is a problem then you should use dictionaries instead (cf.
  <hlink|Dictionaries|#dictionaries>). Or you can create mutable records by
  using expression references (cf. <hlink|Expression
  References|#expression-references>) as values, which allow you to modify
  the data in-place. Element lookup (indexing) uses binary search on an
  internal index data structure and thus takes logarithmic time once the
  index has been constructed (which is done automatically when needed, or
  when calling <verbatim|recordp> on a fresh record value).

  Also note that records with duplicate keys are permitted; in such a case
  the following operations will always operate on the <em|last> entry for a
  given key.

  <\description>
    <item*|<em|type> record<label|record/type>>The record type. This is
    functionally equivalent to <hlink|<with|font-family|tt|recordp>|#recordp>,
    but can be used as a type tag on the left-hand side of equations.
  </description>

  <\description>
    <item*|recordp x<label|recordp>>Check for record values.
  </description>

  <\description>
    <item*|record x<label|record>>Normalizes a record. This removes duplicate
    keys and orders the record by keys (using an apparently random but
    well-defined order of the key values), so that normalized records are
    syntactically equal (<hlink|<with|font-family|tt|===>|#===>) if and only
    if they contain the same hash pairs. For convenience, this function can
    also be used directly on lists and tuples of hash pairs to convert them
    to a normalized record value.
  </description>

  <\description>
    <item*|# x<label|#/record>>The size of a record (number of entries it
    contains). Duplicate entries are counted. (This is in fact just the
    standard matrix size operation.)
  </description>

  <\description>
    <item*|member x y<label|member/record>>Check whether <verbatim|x>
    contains the key <verbatim|y>.
  </description>

  <\description>
    <item*|x ! y<label|!/record>>Retrieves the (last) value associated with
    the key <verbatim|y> in <verbatim|x>, if any, otherwise throws an
    <hlink|<with|font-family|tt|out_of_bounds>|#out-of-bounds> exception.
  </description>

  <\description>
    <item*|x !! ys<label|!!/record>>Slicing also works as expected, by virtue
    of the generic definition of slicing provided by the matrix data
    structure.
  </description>

  <\description>
    <item*|insert x (y=\<gtr\>z)<label|insert/record>>

    <item*|update x y z<label|update/record>>Associate the key <verbatim|y>
    with the value <verbatim|z> in <verbatim|x>. If <verbatim|x> already
    contains the key <verbatim|y> then the corresponding value is updated
    (the last such value if <verbatim|x> contains more than one association
    for <verbatim|y>), otherwise a new member is inserted at the end of the
    record.
  </description>

  <\description>
    <item*|delete x y<label|delete/record>>Delete the key <verbatim|y> (and
    its associated value) from <verbatim|x>. If <verbatim|x> contains more
    than one entry for <verbatim|y> then the last such entry is removed.
  </description>

  <\description>
    <item*|keys x<label|keys/record>>

    <item*|vals x<label|vals/record>>List the keys and associated values of
    <verbatim|x>. If the record contains duplicate keys, they are all listed
    in the order in which they are stored in the record.
  </description>

  Here are a few basic examples:

  <\verbatim>
    \;

    \<gtr\> let r = {x=\<gtr\>5, y=\<gtr\>12};

    \<gtr\> r!y; r!![y,x]; \ \ \ \ \ \ \ \ \ \ \ \ \ // indexing and slicing

    12

    {12,5}

    \<gtr\> keys r; vals r; \ \ \ \ \ \ \ \ \ \ \ \ // keys and values of a
    record

    {x,y}

    {5,12}

    \<gtr\> insert r (x=\<gtr\>99); \ \ \ \ \ \ \ \ \ \ // update an existing
    entry

    {x=\<gtr\>99,y=\<gtr\>12}

    \<gtr\> insert ans (z=\<gtr\>77); \ \ \ \ \ \ \ \ // add a new entry

    {x=\<gtr\>99,y=\<gtr\>12,z=\<gtr\>77}

    \<gtr\> delete ans z; \ \ \ \ \ \ \ \ \ \ \ \ \ \ // delete an existing
    entry

    {x=\<gtr\>99,y=\<gtr\>12}

    \<gtr\> let r = {r,x=\<gtr\>7,z=\<gtr\>3}; r; \ \ // duplicate key x

    {x=\<gtr\>5,y=\<gtr\>12,x=\<gtr\>7,z=\<gtr\>3}

    \<gtr\> r!x, r!z; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ // indexing returns
    the last value of x

    7,3

    \<gtr\> delete r x; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ // delete removes the
    last entry for x

    {x=\<gtr\>5,y=\<gtr\>12,z=\<gtr\>3}

    \<gtr\> record r; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ // normalize
    (remove dups and sort)

    {x=\<gtr\>7,y=\<gtr\>12,z=\<gtr\>3}

    \<gtr\> record [x=\<gtr\>5, x=\<gtr\>7, y=\<gtr\>12]; // construct a
    normalized record from a list

    {x=\<gtr\>7,y=\<gtr\>12}

    \<gtr\> record (x=\<gtr\>5, x=\<gtr\>7, y=\<gtr\>12); // ... or a tuple

    {x=\<gtr\>7,y=\<gtr\>12}

    \;
  </verbatim>

  More examples can be found in the <hlink|<em|Record
  Data>|pure.tm#record-data> section in the Pure Manual.

  <subsubsection|Primitives><label|primitives>

  This prelude module is a collection of various lowlevel operations, which
  are implemented either directly by machine instructions or by C functions
  provided in the runtime. In particular, this module defines the basic
  arithmetic and logic operations on machine integers, bigints and floating
  point numbers, as well as various type checking predicates and conversions
  between different types. Some basic pointer operations are also provided,
  as well as \Psentries\Q (Pure's flavour of object finalizers) and
  \Preferences\Q (mutable expression pointers).

  <paragraph|Special Constants><label|special-constants>

  <\description>
    <item*|<em|constant> inf<label|inf>>

    <item*|<em|constant> nan<label|nan>>IEEE floating point infinities and
    NaNs. You can test for these using the
    <hlink|<with|font-family|tt|infp>|#infp> and
    <hlink|<with|font-family|tt|nanp>|#nanp> predicates, see
    <hlink|Predicates|#predicates> below.
  </description>

  <\description>
    <item*|<em|constant> NULL = pointer 0<label|NULL>>Generic null pointer.
    (This is actually a built-in constant.) You can also check for null
    pointers with the <hlink|<with|font-family|tt|null>|#null/pointer>
    predicate, see <hlink|Predicates|#predicates>.
  </description>

  <paragraph|Arithmetic><label|arithmetic>

  The basic arithmetic and logic operations provided by this module are
  summarized in the following table:

  <tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|l>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|l>|<cwith|1|-1|3|3|cell-halign|l>|<cwith|1|-1|3|3|cell-rborder|0ln>|<cwith|1|-1|1|-1|cell-valign|c>|<cwith|1|1|1|-1|cell-bborder|1ln>|<table|<row|<cell|Kind>|<cell|Operator>|<cell|Meaning>>|<row|<cell|Arithmetic>|<cell|<verbatim|+>
  <verbatim|->>|<cell|addition, subtraction (also unary
  minus)>>|<row|<cell|>|<cell|<verbatim|*>
  <verbatim|/>>|<cell|multiplication, division
  (inexact)>>|<row|<cell|>|<cell|<verbatim|div> <verbatim|mod>>|<cell|exact
  int/bigint division/modulus>>|<row|<cell|>|<cell|<verbatim|^>>|<cell|exponentiation
  (inexact)>>|<row|<cell|Comparisons>|<cell|<verbatim|==>
  <verbatim|~=>>|<cell|equality, inequality>>|<row|<cell|>|<cell|<verbatim|\<>
  <verbatim|\>>>|<cell|less than, greater
  than>>|<row|<cell|>|<cell|<verbatim|\<=> <verbatim|\>=>>|<cell|less than or
  equal, greater than or equal>>|<row|<cell|Logic>|<cell|<verbatim|~>>|<cell|logical
  not>>|<row|<cell|>|<cell|<verbatim|&&> <verbatim|\|\|>>|<cell|and, or
  (short-circuit)>>|<row|<cell|Bitwise>|<cell|<verbatim|not>>|<cell|bitwise
  not>>|<row|<cell|>|<cell|<verbatim|and> <verbatim|or>>|<cell|and,
  or>>|<row|<cell|>|<cell|<verbatim|\<\<> <verbatim|\>\>>>|<cell|bit
  shifts>>>>>

  Precedence and and associativity of the operators can be found in the
  <hlink|<em|operators>|#operators> table at the beginning of this section.

  The names of some operations are at odds with C. Note, in particular, that
  logical negation is denoted <verbatim|~> instead of <verbatim|!> (and,
  consequently, <verbatim|~=> denotes inequality, rather than <verbatim|!=>),
  and the bitwise operations are named differently. This is necessary because
  Pure uses <verbatim|!>, <verbatim|<line-sep>> and <verbatim|\|> for other
  purposes. Also, <verbatim|/> always denotes inexact (double) division in
  Pure, whereas the integer division operators are called <verbatim|div> and
  <verbatim|mod>. (<verbatim|%>, which is not defined by this module, also
  has a different meaning in Pure; it's the exact division operator, see
  <hlink|Rational Numbers|#rational-numbers>.)

  The above operations are implemented for int, bigint and, where
  appropriate, double operands. (Pointer arithmetic and comparisons are
  provided in a separate module, see <hlink|Pointer
  Arithmetic|#pointer-arithmetic>.) The math module (see <hlink|Mathematical
  Functions|#mathematical-functions>) also provides implementations of the
  arithmetic and comparison operators for rational, complex and complex
  rational numbers.

  Note that the logical operations are actually implemented as special forms
  in order to provide for short-circuit evaluation. This needs special
  support from the compiler to work. The primitives module still provides
  definitions for these, as well as other special forms like <verbatim|quote>
  and the thunking operator <verbatim|<line-sep>> so that they may be used as
  function values and in partial applications, but when used in this manner
  they lose all their special call-by-name properties; see <hlink|<em|Special
  Forms>|pure.tm#special-forms> in the Pure Manual for details. The rules for
  the logical connectives are actually slightly more general than the
  built-in rules so that an expression of the form <verbatim|x&&y> or
  <verbatim|x\|\|y> will always be simplified in a sensible way if at least
  one of the operands is a machine int; e.g., both <verbatim|x&&1> and
  <verbatim|1&&x> will reduce to just <verbatim|x> if <verbatim|x> is not a
  machine int.

  A detailed listing of the basic arithmetic and logical operations follows
  below.

  <\description>
    <item*|x + y<label|+>>

    <item*|x - y<label|->>

    <item*|x * y<label|*>>

    <item*|x / y<label|/>>

    <item*|x ^ y<label|?5E>>Addition, subtraction, multiplication, division
    and exponentiation. The latter two are inexact and will yield double
    results.
  </description>

  <\description>
    <item*|- x<label|-/unary>>Unary minus. This has the same precedence as
    binary `<hlink|<with|font-family|tt|->|#->` above.
  </description>

  <\description>
    <item*|x div y<label|div>>

    <item*|x mod y<label|mod>>Exact int and bigint division and modulus.
  </description>

  <\description>
    <item*|x == y<label|==>>

    <item*|x <math|\<sim\>>= y<label|-tilde=>>Equality and inequality.
  </description>

  <\description>
    <item*|x \<less\>= y<label|\<less\>=>>

    <item*|x \<gtr\>= y<label|\<gtr\>=>>

    <item*|x \<gtr\> y<label|\<gtr\>>>

    <item*|x \<less\> y<label|\<less\>>>Comparisons.
  </description>

  <\description>
    <item*|<math|\<sim\>> x<label|-tilde>>

    <item*|x && y<label|-amp-amp>>

    <item*|x \|\| y<label|\|\|>>Logical negation, conjunction and
    disjunction. These work with machine ints only and are evaluated in
    short-circuit mode, unless they are invoked as higher-order functions or
    with operands which aren't machine ints. See the explanations above.
  </description>

  <\description>
    <item*|not x<label|not>>

    <item*|x and y<label|and>>

    <item*|x or y<label|or>>Bitwise negation, conjunction and disjunction.
    These work with both machine ints and bigints.
  </description>

  <\description>
    <item*|x \<less\>\<less\> k<label|\<less\>\<less\>>>

    <item*|x \<gtr\>\<gtr\> k<label|\<gtr\>\<gtr\>>>Arithmetic bit shifts.
    The left operand <verbatim|x> may be a machine int or a bigint. The right
    operand <verbatim|k> must be a machine int and denotes the (nonnegative)
    number of bits to shift.

    <with|font-series|bold|Note:> This operation may expand to a single
    machine instruction in the right circumstances, thus the condition that
    <verbatim|k> be nonnegative isn't always checked. This may lead to
    surprising results if you do specify a negative value for <verbatim|k>.
    However, in the current implementation bigint shifts do check the sign of
    <verbatim|k> and handle it in the appropriate way, by turning a left
    shift into a corresponding right shift and vice versa.
  </description>

  In addition, the following arithmetic and numeric functions are provided:

  <\description>
    <item*|abs x<label|abs>>

    <item*|sgn x<label|sgn>>Absolute value and sign of a number.
  </description>

  <\description>
    <item*|min x y<label|min>>

    <item*|max x y<label|max>>Minimum and maximum of two values. This works
    with any kind of values which have the ordering relations defined on
    them.
  </description>

  <\description>
    <item*|succ x<label|succ>>

    <item*|pred x<label|pred>>Successor (<verbatim|+1>) and predecessor
    (<verbatim|-1>) functions.
  </description>

  <\description>
    <item*|gcd x y<label|gcd>>

    <item*|lcd x y<label|lcd>>The greatest common divisor and least common
    multiple functions from the GMP library. These return a bigint if at
    least one of the arguments is a bigint, a machine int otherwise.
  </description>

  <\description>
    <item*|pow x y<label|pow>>Computes exact powers of ints and bigints. The
    result is always a bigint. Note that <verbatim|y> must always be
    nonnegative here, but see the math module (<hlink|Mathematical
    Functions|#mathematical-functions>) which deals with the case
    <verbatim|y\<0> using rational numbers.
  </description>

  <paragraph|Conversions><label|conversions>

  These operations convert between various types of Pure values.

  <\description>
    <item*|hash x<label|hash>>Compute a 32 bit hash code of a Pure
    expression.
  </description>

  <\description>
    <item*|bool x<label|bool>>Convert a machine integer to a normalized truth
    value (<verbatim|0> or <verbatim|1>).
  </description>

  <\description>
    <item*|int x<label|int>>

    <item*|bigint x<label|bigint>>

    <item*|double x<label|double>>Conversions between the different numeric
    types.
  </description>

  <\description>
    <item*|pointer x<label|pointer>>Convert a string, int or bigint to a
    pointer value. Converting a string returns a pointer to the underlying
    UTF8-encoded C string so that it can be passed to the appropriate C
    functions. Converting an integer gives a pointer with the given numeric
    address. This may be used to construct special pointer values such as the
    null pointer (<verbatim|pointer> <verbatim|0>).
  </description>

  <\description>
    <item*|ubyte x<label|ubyte>>

    <item*|ushort x<label|ushort>>

    <item*|uint x<label|uint>>

    <item*|uint64 x<label|uint64>>

    <item*|ulong x<label|ulong>>Convert signed (8/16/32/64) bit integers to
    the corresponding unsigned quantities. These functions behave as if the
    value was \Pcast\Q to the corresponding unsigned C type, and are most
    useful for dealing with unsigned integers returned by external C
    routines. The routines always use the smallest Pure int type capable of
    holding the result: <verbatim|int> for
    <hlink|<with|font-family|tt|ubyte>|#ubyte> and
    <hlink|<with|font-family|tt|ushort>|#ushort>, <verbatim|bigint> for
    <hlink|<with|font-family|tt|uint>|#uint>,
    <hlink|<with|font-family|tt|uint64>|#uint64> and
    <hlink|<with|font-family|tt|ulong>|#ulong>. All routines take int
    parameters. In the case of <hlink|<with|font-family|tt|uint64>|#uint64>,
    a bigint parameter is also permitted (which is what the C interface
    returns for 64 bit values). Also note that
    <hlink|<with|font-family|tt|ulong>|#ulong> reduces to either
    <hlink|<with|font-family|tt|uint>|#uint> or
    <hlink|<with|font-family|tt|uint64>|#uint64>, depending on the size of
    <verbatim|long> for the host architecture.
  </description>

  The following<label|rounding-functions>rounding functions work with all
  kinds of numbers:

  <\description>
    <item*|floor x<label|floor>>

    <item*|ceil x<label|ceil>>Floor and ceil.
  </description>

  <\description>
    <item*|round x<label|round>>

    <item*|trunc x<label|trunc>>Round or truncate to an integer.
  </description>

  <\description>
    <item*|frac x<label|frac>>Fractional part (<verbatim|x-trunc>
    <verbatim|x>).
  </description>

  Note that all these functions return double values for double arguments, so
  if you need an integer result then you'll have to apply a suitable
  conversion, as in <verbatim|int> <verbatim|(floor> <verbatim|x)>.

  <paragraph|Predicates><label|predicates>

  A syntactic equality test is provided, as well as various type checking
  predicates. Note that type definitions are provided for most of the type
  checking predicates which don't denote built-in types; see <hlink|Prelude
  Types|#prelude-types> for details.

  <\description>
    <item*|same x y<label|same>>

    <item*|x === y<label|===>>

    <item*|x <math|\<sim\>>== y<label|-tilde==>>Syntactic equality. In
    contrast to <hlink|<with|font-family|tt|==>|#==> and
    <hlink|<with|font-family|tt|<math|\<sim\>>=>|#-tilde=>, this is defined
    on all Pure expressions. Basically, two expressions are syntactically
    equal if they print out the same in the interpreter. In the special case
    of pointer objects and closures, which do not always have a syntactic
    representation in Pure, <verbatim|x> and <verbatim|y> must be the same
    object (same pointer value or function).
  </description>

  <\description>
    <item*|typep ty x<label|typep>>Generic type checking predicate. This
    checks whether <verbatim|x> is of type <verbatim|ty>, where <verbatim|ty>
    is a symbol denoting any of the built-in types
    (<hlink|<with|font-family|tt|int>|pure.tm#int/type>,
    <hlink|<with|font-family|tt|bigint>|pure.tm#bigint/type> etc.) or any
    type defined in a <hlink|<with|font-family|tt|type>|pure.tm#type>
    definition. (Note that you may have to quote <verbatim|ty> if it happens
    to be defined as a variable or parameterless function.)
  </description>

  <\description>
    <item*|intp x<label|intp>>

    <item*|bigintp x<label|bigintp>>

    <item*|doublep x<label|doublep>>

    <item*|stringp x<label|stringp>>

    <item*|pointerp x<label|pointerp>>

    <item*|matrixp x<label|matrixp>>Predicates to check for the built-in
    types.
  </description>

  <\description>
    <item*|boolp x<label|boolp>>Predicate to check for normalized truth
    values (<verbatim|0> and <verbatim|1>).
  </description>

  <\description>
    <item*|charp x<label|charp>>Predicate to check for single character
    strings.
  </description>

  <\description>
    <item*|numberp x<label|numberp>>

    <item*|complexp x<label|complexp>>

    <item*|realp x<label|realp>>

    <item*|rationalp x<label|rationalp>>

    <item*|integerp x<label|integerp>>Additional number predicates. Note some
    further \Psemantic\Q number predicates are defined in the
    <hlink|<with|font-family|tt|math>|#module-math> module, see
    <hlink|Semantic Number Predicates and
    Types|#semantic-number-predicates-and-types>.
  </description>

  <\description>
    <item*|exactp x<label|exactp>>

    <item*|inexactp x<label|inexactp>>Check whether a number is exact (i.e.,
    doesn't contain any double components).
  </description>

  <\description>
    <item*|infp x<label|infp>>

    <item*|nanp x<label|nanp>>Check for <hlink|<with|font-family|tt|inf>|#inf>
    and <hlink|<with|font-family|tt|nan>|#nan> values.
  </description>

  <\description>
    <item*|null p<label|null/pointer>>Check for null pointers.
  </description>

  <\description>
    <item*|applp x<label|applp>>

    <item*|listp x<label|listp>>

    <item*|rlistp x<label|rlistp>>

    <item*|tuplep x<label|tuplep>>Predicates to check for function
    applications, lists, proper lists and tuples. Note that
    <hlink|<with|font-family|tt|listp>|#listp> only checks for a toplevel
    list constructor, whereas <hlink|<with|font-family|tt|rlistp>|#rlistp>
    also recursively checks the tails of the list; the latter may need time
    proportional to the list size. The <hlink|<with|font-family|tt|applp>|#applp>
    and <hlink|<with|font-family|tt|tuplep>|#tuplep> predicates look for an
    application or tuple constructor at the toplevel only, which can always
    be done in constant time.
  </description>

  <\description>
    <item*|funp x<label|funp>>

    <item*|lambdap x<label|lambdap>>

    <item*|thunkp x<label|thunkp>>

    <item*|closurep x<label|closurep>>Predicates to check for various kinds
    of function objects (named, anonymous or thunk).
    <hlink|<with|font-family|tt|closurep>|#closurep> checks for any kind of
    \Pnormal\Q closure (i.e., named functions and lambdas, but not thunks).
  </description>

  <\description>
    <item*|functionp x<label|functionp>>Convenience function to check for
    \Pcallable\Q functions. This includes any kind of closure with a nonzero
    argument count as well as partial (unsaturated) applications of these.
  </description>

  <\description>
    <item*|symbolp x<label|symbolp>>

    <item*|varp x<label|varp>>Predicates to check for any kind of symbol
    (this also includes operator and nonfix symbols) and for free variable
    symbols, respectively. Note that varp returns true for any symbol which
    is not an operator or nonfix symbol (i.e., for any symbol that could in
    principle be bound to a value, either globally or locally). This holds
    even if the symbol is currently bound to a function, macro or constant.
  </description>

  <paragraph|Inspection><label|inspection>

  The following operations let you peek at various internal information that
  the interpreter provides to Pure programs either for convenience or for
  metaprogramming purposes. They are complemented by the evaluation
  primitives discussed below, see <hlink|Eval and Friends|#eval-and-friends>.

  <\description>
    <item*|ans<label|ans>>Retrieve the most recently printed result of a
    toplevel expression evaluated in the read-eval-print loop. This is just a
    convenience for interactive usage. Note that the
    <hlink|<with|font-family|tt|ans>|#ans> value will stick around until a
    new expression is computed. (It is possible to clear the
    <hlink|<with|font-family|tt|ans>|#ans> value with the interactive command
    <verbatim|clear> <verbatim|ans>, however.) Example:

    <\verbatim>
      \;

      \<gtr\> 1/3;

      0.333333333333333

      \<gtr\> ans/2;

      0.166666666666667

      \;
    </verbatim>
  </description>

  <\description>
    <item*|__func__<label|--func-->>Returns the (lexically) innermost
    function at the point of the call. This can be either a global function,
    a local (named) function introduced in a
    <hlink|<with|font-family|tt|with>|pure.tm#with> clause or an anonymous
    function (a lambda). Fails (returning just the literal symbol
    <hlink|<with|font-family|tt|__func__>|#--func--> by default) if there is
    no such function (i.e., if the call is at the toplevel). Note that in
    contrast to the C99 variable of the same name, this really returns the
    function value itself in Pure; the <hlink|<with|font-family|tt|str>|#str>
    function can be used if you need the print name of the function.
    Examples:

    <\verbatim>
      \;

      \<gtr\> foo x = if x\<gtr\>0 then x else throw __func__;

      \<gtr\> foo (-99);

      \<less\>stdin\<gtr\>, line 2: unhandled exception 'foo' while
      evaluating 'foo (-99)'

      \<gtr\> (\\x-\<gtr\>x+": "+str __func__) "test";

      "test: #\<less\>closure 0x7f4a2411db30\<gtr\>"

      \;
    </verbatim>

    If you want, you can add a default rule for
    <hlink|<with|font-family|tt|__func__>|#--func--> which specifies the
    behaviour when <hlink|<with|font-family|tt|__func__>|#--func--> gets
    called at the global level. E.g.:

    <\verbatim>
      \;

      \<gtr\> __func__ = throw "__func__ called at global level";

      \<gtr\> __func__;

      \<less\>stdin\<gtr\>, line 5: unhandled exception '"__func__ called at
      global level"' while

      evaluating '__func__'

      \;
    </verbatim>
  </description>

  <\description>
    <item*|<em|macro> __namespace__<label|--namespace-->>Returns the current
    namespace at the point of the call. This is implemented as a built-in
    macro which expands to a string. The empty string is returned in the
    default namespace. Example:

    <\verbatim>
      \;

      \<gtr\> namespace foo;

      \<gtr\> foo = __namespace__;

      \<gtr\> namespace;

      \<gtr\> show foo::foo

      foo::foo = "foo";

      \<gtr\> foo::foo;

      "foo"

      \;
    </verbatim>
  </description>

  <\description>
    <item*|<em|macro> __dir__<label|--dir-->>

    <item*|<em|macro> __file__<label|--file-->>Returns the directory and
    absolute filename of the current script, using the canonicalized pathname
    of the script, as explained in <hlink|<em|Modules and
    Imports>|pure.tm#modules-and-imports>. The directory name is always
    terminated with a trailing slash. These macros are useful, e.g., for
    debugging purposes or if a script needs to locate other files relative to
    the script file. Like <hlink|<with|font-family|tt|__namespace__>|#--namespace-->,
    these are built-in macros which expand to string values.

    The script name is resolved at compile time, so these macros are most
    useful if a script is run through the interpreter. Also note that both
    macros return the empty string if the code containing the call is not in
    a script (i.e., if it is executed directly at the interactive command
    line or through <hlink|<with|font-family|tt|eval>|#eval>). For instance,
    assume that the following code is stored in the file
    /home/user/test.pure:

    <\verbatim>
      \;

      foo = __file__,__dir__;

      bar = eval "__file__,__dir__";

      \;
    </verbatim>

    Then running this script interactively you'll get the following:

    <\verbatim>
      \;

      \<gtr\> foo;

      "/home/user/test.pure","/home/user/"

      \<gtr\> bar;

      "",""

      \;
    </verbatim>
  </description>

  <\description>
    <item*|<em|macro> __list__<label|--list-->>This expands a (literal) tuple
    to a list, preserving embedded tuples in the same way that list values
    are parsed in the Pure language, cf. <hlink|<em|Primary
    Expressions>|pure.tm#primary-expressions>. This is provided for the
    benefit of custom aggregate notations (usually implemented as outfix
    operators) which are supposed to be parsed like the built-in list and
    matrix brackets. Example:

    <\verbatim>
      \;

      \<gtr\> outfix (: :);

      \<gtr\> def (:x:) = __list__ x;

      \<gtr\> (:(1,2),(3,4):);

      [(1,2),(3,4)]

      \;
    </verbatim>

    Note that this macro uses internal information from the parser not
    available to Pure programs. Thus there's no way to actually define this
    macro in Pure, which is why it is provided as a builtin instead.

    Another rather obscure point that deserves mentioning here is that the
    special processing of parenthesized expressions happens also if the macro
    is applied in prefix form. This should rarely be a problem in practice,
    but if it is then you can use <hlink|<with|font-family|tt|$>|#-dollar> to
    pass arguments without adding an (undesired) extra level of parentheses:

    <\verbatim>
      \;

      \<gtr\> ((::)) ((1,2),(3,4));

      [(1,2,3,4)]

      \<gtr\> ((::)) $ (1,2),(3,4);

      [(1,2),(3,4)]

      \;
    </verbatim>

    Note that the first expression is really equivalent to
    <verbatim|(:((1,2),(3,4)):)>, <em|not> <verbatim|(:(1,2),(3,4):)> which
    can be specified in prefix form using
    <hlink|<with|font-family|tt|$>|#-dollar> as shown in the second
    expression. (Remember that <hlink|<with|font-family|tt|$>|#-dollar> is
    also implemented as a macro and so is substituted away at macro expansion
    time in the example above.) The same trick works if for some reason you
    want to apply <hlink|<with|font-family|tt|__list__>|#--list--> in a
    direct fashion:

    <\verbatim>
      \;

      \<gtr\> __list__ ((1,2),(3,4));

      [(1,2,3,4)]

      \<gtr\> __list__ $ (1,2),(3,4);

      [(1,2),(3,4)]

      \;
    </verbatim>
  </description>

  <\description>
    <item*|<em|macro> __locals__<label|--locals-->>Built-in macro which
    expands to a list with the local function bindings
    (<hlink|<with|font-family|tt|with>|pure.tm#with> clauses) visible at this
    point in the program. The return value is a list of hash pairs
    <verbatim|x=\>f> where <verbatim|x> is the global symbol denoting the
    function (the symbol is always quoted) and <verbatim|f> is the function
    value itself. Example:

    <\verbatim>
      \;

      \<gtr\> __locals__ with foo x = x+1; x = a+b end;

      [x=\<gtr\>a+b,foo=\<gtr\>foo]

      \<gtr\> f 99 when _=\<gtr\>f = ans!1 end;

      100

      \;
    </verbatim>
  </description>

  The <hlink|<with|font-family|tt|__locals__>|#--locals--> macro is useful
  for debugging purposes, as well as to implement dynamic environments. It is
  also used internally to implement the <hlink|<with|font-family|tt|reduce>|#reduce>
  macro, see <hlink|Eval and Friends|#eval-and-friends>. Here are some things
  that you should keep in mind when working with this macro:

  <\itemize>
    <item><hlink|<with|font-family|tt|__locals__>|#--locals--> always
    evaluates parameterless functions and returns the resulting value instead
    of a closure (as can be seen in the binding <verbatim|x=\>a+b> in the
    example above). Normally this is what you want, but it can be a problem
    with parameterless functions involving side effects. In such a case, if
    you want to evaluate the function at a later time, you'll either have to
    use a thunk or massage the local function so that it takes a dummy
    argument such as <verbatim|()>.

    <item>If the call to <hlink|<with|font-family|tt|__locals__>|#--locals-->
    is inside a local function then that local function will itself be
    <em|excluded> from the constructed environment. This is done in order to
    prevent infinite recursion if the calling function does not have any
    parameters (which is a common idiom, especially in applications of the
    <hlink|<with|font-family|tt|reduce>|#reduce> macro). If you really want
    the calling function to be in the environment, you'll have to add it to
    the result of <hlink|<with|font-family|tt|__locals__>|#--locals-->
    yourself. Using the <hlink|<with|font-family|tt|__func__>|#--func-->
    primitive from above, we can implement this as a macro:

    <\verbatim>
      \;

      def __mylocals__ = [val (str __func__)=\<gtr\>__func__]+__locals__;

      \;
    </verbatim>

    You can then use <verbatim|__mylocals__> instead of <verbatim|__locals__>
    whenever you want the calling function to be included in the computed
    environment.

    <item><hlink|<with|font-family|tt|__locals__>|#--locals--> will use as
    keys in the resulting list whatever global symbols are in scope at the
    point of the call. By default, i.e., if no global symbol with the same
    print name as the local is visible at the point of the call, a symbol in
    the default namespace is used, as we've seen above. Otherwise the result
    may be also be a qualified symbol if such a symbol has already been
    declared or defined at the point of the call. For instance:

    <\verbatim>
      \;

      \<gtr\> namespace foo;

      \<gtr\> public foo;

      \<gtr\> __locals__ with foo x = x+1 end;

      [foo::foo=\<gtr\>foo]

      \;
    </verbatim>

    This behaviour may be a bit surprising at first sight, but is consistent
    with the way the interpreter performs its symbol lookup, see
    <hlink|<em|Symbol Lookup and Creation>|pure.tm#symbol-lookup-and-creation>
    for details.
  </itemize>

  The following functions allow you to inspect or modify the function, type,
  macro, constant and variable definitions of the running program. This uses
  a special meta representation for rewriting rules and definitions. Please
  see the <hlink|<em|Macros>|pure.tm#macros> section in the Pure manual for
  details. Also note that these operations are subject to some limitations,
  please check the remarks concerning <hlink|<with|font-family|tt|eval>|#eval>
  and <hlink|<with|font-family|tt|evalcmd>|#evalcmd> in the following
  subsection for details.

  <\description>
    <item*|get_fundef sym<label|get-fundef>>

    <item*|get_typedef sym<label|get-typedef>>

    <item*|get_macdef sym<label|get-macdef>>If the given symbol is defined as
    a function, type or macro, return the corresponding list of rewriting
    rules. Otherwise return the empty list.
  </description>

  <\description>
    <item*|get_interface sym<label|get-interface>>

    <item*|get_interface_typedef sym<label|get-interface-typedef>>If the
    given symbol is defined as an interface type, return its definition;
    otherwise return the empty list. <hlink|<with|font-family|tt|get_interface>|#get-interface>
    returns the list of patterns used to declare the type, while
    <hlink|<with|font-family|tt|get_interface_typedef>|#get-interface-typedef>
    returns the actual list of type rules, in the same format as with
    <hlink|<with|font-family|tt|get_typedef>|#get-typedef>. Note that the
    latter may be empty even if the type is defined, meaning that the type
    hasn't been instantiated yet, see <hlink|<em|Interface
    Types>|pure.tm#interface-types> for details. Also note that Pure allows
    you to have <em|both> an interface and a regular (concrete) definition of
    a type, in which case <hlink|<with|font-family|tt|get_typedef>|#get-typedef>
    and <hlink|<with|font-family|tt|get_interface_typedef>|#get-interface-typedef>
    may both return nonempty (and usually different) results.
  </description>

  <\description>
    <item*|get_vardef sym<label|get-vardef>>

    <item*|get_constdef sym<label|get-constdef>>If the given symbol is
    defined as a variable or constant, return the corresponding definition as
    a singleton list of the form <verbatim|[sym> <verbatim|--\>>
    <verbatim|value]>. Otherwise return the empty list.
  </description>

  The following functions may fail in case of error, in which case
  <hlink|<with|font-family|tt|lasterr>|#lasterr> is set accordingly (see
  <hlink|Eval and Friends|#eval-and-friends> below).

  <\description>
    <item*|add_fundef rules<label|add-fundef>>

    <item*|add_typedef rules<label|add-typedef>>

    <item*|add_macdef rules<label|add-macdef>>Add the given rewriting rules
    (given in the same format as returned by the
    <hlink|<with|font-family|tt|get_fundef>|#get-fundef>,
    <hlink|<with|font-family|tt|get_typedef>|#get-typedef> and
    <hlink|<with|font-family|tt|get_macdef>|#get-macdef> functions above) to
    the running program.
  </description>

  <\description>
    <item*|add_fundef_at r rules<label|add-fundef-at>>

    <item*|add_typedef_at r rules<label|add-typedef-at>>

    <item*|add_macdef_at r rules<label|add-macdef-at>>Same as above, but add
    the given rewriting rules at (i.e., before) the given rule <verbatim|r>
    (which must already exist, otherwise the call fails). Note that all added
    rules must have the same head symbol on the left-hand side, which matches
    the head symbol on the left-hand side of <verbatim|r>.
  </description>

  <\description>
    <item*|add_interface sym patterns<label|add-interface>>Add the given
    patterns to the interface type <verbatim|sym> (given as a symbol). If the
    interface type doesn't exist yet, it will be created.
  </description>

  <\description>
    <item*|add_interface_at sym p patterns<label|add-interface-at>>Same as
    above, but add the given patterns at (i.e., before) the given pattern
    <verbatim|p> (the given interface type must already exist and contain the
    given pattern, otherwise the call fails).
  </description>

  <\description>
    <item*|add_vardef rules<label|add-vardef>>

    <item*|add_constdef rules<label|add-constdef>>Define variables and
    constants. Each rule must take the form <verbatim|sym> <verbatim|--\>>
    <verbatim|value> with a symbol on the left-hand side (no pattern matching
    is performed by these functions).
  </description>

  The following functions may be used to delete individual rewriting rules,
  interface type patterns or variable and constant symbols.

  <\description>
    <item*|del_fundef rule<label|del-fundef>>

    <item*|del_typedef rule<label|del-typedef>>

    <item*|del_macdef rule<label|del-macdef>>Delete the given rewriting rule
    (given in the same format as returned by the
    <hlink|<with|font-family|tt|get_fundef>|#get-fundef>,
    <hlink|<with|font-family|tt|get_typedef>|#get-typedef> and
    <hlink|<with|font-family|tt|get_macdef>|#get-macdef> functions) from the
    running program. Returns <verbatim|()> if successful, fails otherwise.
  </description>

  <\description>
    <item*|del_interface sym pattern<label|del-interface>>Delete the given
    pattern from the given interface type. Returns <verbatim|()> if
    successful, fails otherwise.
  </description>

  <\description>
    <item*|del_vardef sym<label|del-vardef>>

    <item*|del_constdef sym<label|del-constdef>>Delete variables and
    constants, given by their (quoted) symbols. Returns <verbatim|()> if
    successful, or fails if the symbol isn't defined (or defined as a
    different kind of symbol).
  </description>

  The prelude also provides some functions to retrieve various attributes of
  a function symbol which determine how the operation is applied to its
  operands or arguments. These functions all take a single argument, the
  symbol or function object to be inspected, and return an integer value.

  <\description>
    <item*|nargs x<label|nargs>>Get the argument count of a function object,
    i.e., the number of arguments it expects. Returns 0 for thunks and
    saturated applications, -1 for over-saturated applications and
    non-functions.
  </description>

  <\description>
    <item*|arity x<label|arity>>Determine the arity of an operator symbol.
    The returned value is 0, 1 or 2 for nullary, unary and binary symbols,
    respectively, -1 for symbols without a fixity declaration or other kinds
    of objects.
  </description>

  <\description>
    <item*|fixity f<label|fixity>>Determine the fixity of an operator symbol.
    The fixity is encoded as an integer <verbatim|10*n+m> where <verbatim|n>
    is the precedence level (ranging from <verbatim|0> to
    <verbatim|PREC_MAX>, where <verbatim|PREC_MAX> denotes the precedence of
    primary expressions, 16777216 in the current implementation) and
    <verbatim|m> indicates the actual fixity at each level, in the order of
    increasing precedence (0 = infix, 1 = infixl, 2 = infixr, 3 = prefix, 4 =
    postfix). The fixity value of nonfix and outfix symbols, as well as
    symbols without a fixity declaration, is always given as
    <verbatim|10*PREC_MAX>, and the same value is also reported for
    non-symbol objects. Infix, prefix and postfix symbols always have a
    <hlink|<with|font-family|tt|fixity>|#fixity> value less than
    <verbatim|10*PREC_MAX>. (<verbatim|PREC_MAX> isn't actually defined as a
    constant anywhere, but you can easily do that yourself by setting
    <verbatim|PREC_MAX> to the fixity value of any nonfix symbol or
    non-symbol value, e.g.: <verbatim|const> <verbatim|PREC_MAX> <verbatim|=>
    <verbatim|fixity> <verbatim|[];>)
  </description>

  Note that only closures (i.e., named and anonymous functions and thunks)
  have a defined argument count in Pure, otherwise
  <hlink|<with|font-family|tt|nargs>|#nargs> returns -1 indicating an unknown
  argument count. Partial applications of closures return the number of
  remaining arguments, which may be zero to indicate a
  <with|font-series|bold|saturated> (but unevaluated) application, or -1 for
  <with|font-series|bold|over-saturated> and constructor applications. (Note
  that in Pure a saturated application may also remain unevaluated because
  there is no definition for the given combination of arguments and thus the
  expression is in normal form, or because the application was quoted. If
  such a normal form application is then applied to some \Pextra\Q arguments
  it becomes over-saturated.)

  The value returned by <hlink|<with|font-family|tt|nargs>|#nargs> always
  denotes the actual argument count of the given function, regardless of the
  declared arity if the function also happens to be an operator symbol. Often
  these will coincide (as, e.g., in the case of
  <hlink|<with|font-family|tt|+>|#+> which is a binary operator and also
  expects two arguments). But this is not necessarily the case, as shown in
  the following example of a binary operator which actually takes <em|three>
  arguments:

  <\verbatim>
    \;

    \<gtr\> infix 0 oops;

    \<gtr\> (oops) x y z = x*z+y;

    \<gtr\> arity (oops);

    2

    \<gtr\> nargs (oops);

    3

    \<gtr\> nargs (5 oops 8);

    1

    \<gtr\> map (5 oops 8) (1..5);

    [13,18,23,28,33]

    \;
  </verbatim>

  <paragraph|Eval and Friends><label|eval-and-friends>

  Pure provides some rather powerful operations to convert between Pure
  expressions and their string representation, and to evaluate quoted
  expressions (<verbatim|'x>). The string conversions
  <hlink|<with|font-family|tt|str>|#str>,
  <hlink|<with|font-family|tt|val>|#val> and
  <hlink|<with|font-family|tt|eval>|#eval> also provide a convenient means to
  serialize Pure expressions, e.g., when terms are to be transferred to/from
  persistent storage. (Note, however, that this has its limitations.
  Specifically, some objects like pointers and anonymous functions do not
  have a parsable string representation. Also see the <hlink|Expression
  Serialization|#expression-serialization> section for some dedicated
  serialization operations which provide a more compact binary serialization
  format.)

  <\description>
    <item*|str x<label|str>>Yields the print representation of an expression
    in Pure syntax, as a string.
  </description>

  <\description>
    <item*|val s<label|val/string>>Parses a single simple expression,
    specified as a string in Pure syntax, and returns the result as is,
    without evaluating it. Note that this is much more limited than the
    <hlink|<with|font-family|tt|eval>|#eval> operation below, as the
    expression must not contain any of the special constructs (conditional
    expressions, <hlink|<with|font-family|tt|when>|pure.tm#when>,
    <hlink|<with|font-family|tt|with>|pure.tm#with>, etc.), unless they are
    quoted.
  </description>

  <\description>
    <item*|eval x<label|eval>>Parses any expression, specified as a string in
    Pure syntax, and returns its value. In fact,
    <hlink|<with|font-family|tt|eval>|#eval> can also parse and execute
    arbitrary Pure code. In that case it will return the last computed
    expression, if any. Alternatively, <hlink|<with|font-family|tt|eval>|#eval>
    can also be invoked on a (quoted) Pure expression, which is recompiled
    and then evaluated. Exceptions during evaluation are reported back to the
    caller.

    <with|font-series|bold|Note:> The use of
    <hlink|<with|font-family|tt|eval>|#eval> and
    <hlink|<with|font-family|tt|evalcmd>|#evalcmd> (as well as
    <hlink|<with|font-family|tt|add_fundef>|#add-fundef>,
    <hlink|<with|font-family|tt|add_typedef>|#add-typedef> etc. from the
    preceding subsection) to modify a running program breaks referential
    transparency and hence these functions should be used with care. Also,
    none of the inspection and mutation capabilities provided by these
    operations will work in batch-compiled programs, please check the
    <hlink|<em|Batch Compilation>|pure.tm#batch-compilation> section in the
    Pure manual for details. Moreover, using these operations to modify or
    delete a function which is currently being executed results in undefined
    behaviour.
  </description>

  <\description>
    <item*|evalcmd x<label|evalcmd>>Like <hlink|<with|font-family|tt|eval>|#eval>,
    but allows execution of interactive commands and returns their captured
    output as a string. No other results are returned, so this operation is
    most useful for executing Pure definitions and interactive commands for
    their side-effects. (At this time, only the regular output of a few
    commands can be captured, most notably <verbatim|bt>, <verbatim|clear>,
    <verbatim|mem>, <verbatim|save> and <verbatim|show>; otherwise the result
    string will be empty.)
  </description>

  <\description>
    <item*|lasterr<label|lasterr>>Reports errors in
    <hlink|<with|font-family|tt|val>|#val>,
    <hlink|<with|font-family|tt|eval>|#eval> and
    <hlink|<with|font-family|tt|evalcmd>|#evalcmd> (as well as in
    <hlink|<with|font-family|tt|add_fundef>|#add-fundef> et al, described in
    the previous subsection). This string value will be nonempty iff a
    compilation or execution error was encountered during the most recent
    invocation of these functions. In that case each reported error message
    is terminated with a newline character.
  </description>

  <\description>
    <item*|lasterrpos<label|lasterrpos>>Gives more detailed error
    information. This returns a list of the individual error messages in
    <hlink|<with|font-family|tt|lasterr>|#lasterr>, along with the position
    of each error (if available). Each list item is either just a string (the
    error message, with any trailing newline stripped off) if no error
    position is available, or a tuple of the form
    <verbatim|msg,file,l1,c1,l2,c2> where <verbatim|msg> is the error
    message, <verbatim|file> the name of the file containing the error (which
    will usually be <verbatim|"\<stdin\>"> indicating that the error is in
    the source string, but may also be a proper filename of a module imported
    in the evaluated code), <verbatim|l1,c1> denotes the beginning of the
    range with the errorneous construct (given as line and column indices)
    and <verbatim|l2,c2> its end (or rather the character position following
    it). For convenience, both line and column indices are zero-based, in
    order to facilitate extraction of the text from the actual source string.

    <with|font-series|bold|Note:> The indicated error positions are only
    approximate, and may in many cases span an entire syntactic construct
    (such as a subexpression or even an entire function definition)
    containing the error. Also, the end of the range may sometimes point one
    token past the actual end of the construct. (These limitations are due to
    technical restrictions in the parser; don't expect them to go away
    anytime soon.)
  </description>

  Examples:

  <\verbatim>
    \;

    \<gtr\> str (1/3);

    "0.333333333333333"

    \<gtr\> val "1/3";

    1/3

    \<gtr\> eval "1/3";

    0.333333333333333

    \<gtr\> eval ('(1/3));

    0.333333333333333

    \<gtr\> evalcmd "show evalcmd";

    "extern expr* evalcmd(expr*);\\n"

    \<gtr\> eval "1/3)";

    eval "1/3)"

    \<gtr\> lasterr;

    "\<less\>stdin\<gtr\>, line 1: syntax error, unexpected ')', expecting
    '=' or '\|'\\n"

    \<gtr\> lasterrpos;

    [("\<less\>stdin\<gtr\>, line 1: syntax error, unexpected ')', expecting
    '=' or '\|'",

    "\<less\>stdin\<gtr\>",0,3,0,4)]

    \;
  </verbatim>

  In addition to <hlink|<with|font-family|tt|str>|#str>, the prelude also
  provides the following function for pretty-printing the internal
  representation used to denote quoted specials. This is commonly used in
  conjunction with the <hlink|<with|font-family|tt|__show__>|pure.tm#--show-->
  function, please see the <hlink|<em|Macros>|pure.tm#macros> section in the
  Pure manual for details.

  <\description>
    <item*|__str__ x<label|--str-->>Pretty-prints special expressions.
  </description>

  Example:

  <\verbatim>
    \;

    \<gtr\> __str__ ('__lambda__ [x __type__ int] (x+1));

    "\\\\x::int -\<gtr\> x+1"

    \;
  </verbatim>

  The <hlink|<with|font-family|tt|evalcmd>|#evalcmd> function is commonly
  used to invoke the <verbatim|show> and <verbatim|clear> commands for
  metaprogramming purposes. The prelude provides the following two
  convenience functions to make this easy:

  <\description>
    <item*|globsym pat level<label|globsym>>This uses
    <hlink|<with|font-family|tt|evalcmd>|#evalcmd> with the <verbatim|show>
    command to list all defined symbols matching the given glob pattern. A
    definition level may be specified to restrict the context in which the
    symbol is defined; a level of 0 indicates that all symbols are eligible
    (see the description of the <verbatim|show> command in the Pure manual
    for details). The result is the list of all matching (quoted) symbols.
  </description>

  <\description>
    <item*|clearsym sym level<label|clearsym>>This uses
    <hlink|<with|font-family|tt|evalcmd>|#evalcmd> with the <verbatim|clear>
    command to delete the definition of the given symbol at the given
    definition level. No glob patterns are permitted here. The <verbatim|sym>
    argument may either be a string or a literal (quoted) symbol.
  </description>

  Example:

  <\verbatim>
    \;

    \<gtr\> let x,y = 77,99;

    \<gtr\> let syms = globsym "[a-z]" 0; syms;

    [x,y]

    \<gtr\> map eval syms;

    [77,99]

    \<gtr\> do (flip clearsym 0) syms;

    ()

    \<gtr\> globsym "[a-z]" 0;

    []

    \<gtr\> x,y;

    x,y

    \;
  </verbatim>

  The following functions are useful for doing symbolic expression
  simplification.

  <\description>
    <item*|<em|macro> reduce x<label|reduce>>Reevaluates an expression in a
    local environment. This dynamically rebinds function symbols in the given
    expression to whatever local function definitions are in effect at the
    point of the <hlink|<with|font-family|tt|reduce>|#reduce> call. Note that
    <hlink|<with|font-family|tt|reduce>|#reduce> is actually implemented as a
    macro which expands to the <hlink|<with|font-family|tt|reduce_with>|#reduce-with>
    primitive (see below), using the <hlink|<with|font-family|tt|__locals__>|#--locals-->
    builtin to enumerate the bindings which are in effect at the call site.
  </description>

  <\description>
    <item*|reduce_with env x<label|reduce-with>>Like
    <hlink|<with|font-family|tt|reduce>|#reduce> above, but takes a list of
    replacements (given as hash pairs <verbatim|u=\>v>) as the first
    argument. The <hlink|<with|font-family|tt|reduce>|#reduce> macro expands
    to <verbatim|reduce_with> <verbatim|__locals__>.
  </description>

  The <hlink|<with|font-family|tt|reduce>|#reduce> macro provides a
  restricted form of dynamic binding which is useful to implement local
  rewriting rules. It is invoked without parameters and expands to the
  curried call <verbatim|reduce_with> <verbatim|__locals__> of the
  <hlink|<with|font-family|tt|reduce_with>|#reduce-with> primitive, which
  takes one additional argument, the expression to be rewritten. The
  following example shows how to expand or factorize an expression using
  local rules for the laws of distributivity:

  <\verbatim>
    \;

    expand = reduce with

    \ \ (a+b)*c = a*c+b*c;

    \ \ a*(b+c) = a*b+a*c;

    end;

    \;

    factor = reduce with

    \ \ a*c+b*c = (a+b)*c;

    \ \ a*b+a*c = a*(b+c);

    end;

    \;

    expand ((a+b)*2); // yields a*2+b*2

    factor (a*2+b*2); // yields (a+b)*2

    \;
  </verbatim>

  Note that instances of locally bound functions are substituted back in the
  computed result, thus the instances of <verbatim|*> and <verbatim|+> in the
  results <verbatim|a*2+b*2> and <verbatim|(a+b)*2> shown above denote the
  corresponding globals, not the local incarnations of <verbatim|*> and
  <verbatim|+> defined in <verbatim|expand> and <verbatim|factor>,
  respectively.

  <hlink|<with|font-family|tt|reduce>|#reduce> also adjusts to quoted
  arguments. In this case, the local rules are applied as usual, but
  back-substituted globals are <em|not> evaluated in the result:

  <\verbatim>
    \;

    \<gtr\> expand ((a+1)*2);

    a*2+2

    \<gtr\> expand ('((a+1)*2));

    a*2+1*2

    \;
  </verbatim>

  Note that <hlink|<with|font-family|tt|reduce>|#reduce> only takes into
  account local <em|function> bindings from
  <hlink|<with|font-family|tt|with>|pure.tm#with> clauses, local
  <em|variable> bindings do not affect its operation in any way:

  <\verbatim>
    \;

    \<gtr\> let y = [x,x^2,x^3];

    \<gtr\> reduce y when x = u+v end;

    [x,x^2,x^3]

    \;
  </verbatim>

  However, in such cases you can perform the desired substitution by turning
  the <hlink|<with|font-family|tt|when>|pure.tm#when> into a
  <hlink|<with|font-family|tt|with>|pure.tm#with> clause:

  <\verbatim>
    \;

    \<gtr\> reduce y with x = u+v end;

    [u+v,(u+v)^2,(u+v)^3]

    \;
  </verbatim>

  Or you can just invoke the underlying <hlink|<with|font-family|tt|reduce_with>|#reduce-with>
  builtin directly, with the desired substitutions given as hash pairs in the
  first argument:

  <\verbatim>
    \;

    \<gtr\> reduce_with [x=\<gtr\>u+v] y;

    [u+v,(u+v)^2,(u+v)^3]

    \;
  </verbatim>

  It is always a good idea to confine calls to
  <hlink|<with|font-family|tt|reduce>|#reduce> to global functions if
  possible, since this gives you better control over which local functions
  are in scope at the point of the call. Otherwise it might be necessary to
  call <hlink|<with|font-family|tt|__locals__>|#--locals--> manually and
  filter the resulting list before submitting it to the
  <hlink|<with|font-family|tt|reduce_with>|#reduce-with> function.

  <paragraph|Expression Serialization><label|expression-serialization>

  Like <hlink|<with|font-family|tt|str>|#str> and
  <hlink|<with|font-family|tt|eval>|#eval>, the following
  <hlink|<with|font-family|tt|blob>|#blob> and
  <hlink|<with|font-family|tt|val>|#val> operations can be used to safely
  transfer expression data to/from persistent storage and between different
  processes (using, e.g., POSIX shared memory, pipes or sockets). However,
  <hlink|<with|font-family|tt|blob>|#blob> and
  <hlink|<with|font-family|tt|val>|#val> use a binary format which is usually
  much more compact and gets processed much faster than the string
  representations used by <hlink|<with|font-family|tt|str>|#str> and
  <hlink|<with|font-family|tt|eval>|#eval>. Also,
  <hlink|<with|font-family|tt|val>|#val> offers some additional protection
  against transmission errors through a crc check. (The advantage of the
  string representation, however, is that it's readable plain text in Pure
  syntax.)

  <\description>
    <item*|blob x<label|blob>>Stores the contents of the given expression as
    a binary object. The return value is a cooked pointer which frees itself
    when garbage-collected.
  </description>

  <\description>
    <item*|val p<label|val/blob>>Reconstructs a serialized expression from
    the result of a previous invocation of the
    <hlink|<with|font-family|tt|blob>|#blob> function.
  </description>

  <\description>
    <item*|blobp p<label|blobp>>Checks for a valid
    <hlink|<with|font-family|tt|blob>|#blob> object. (Note that
    <hlink|<with|font-family|tt|val>|#val> may fail even if
    <hlink|<with|font-family|tt|blobp>|#blobp> returns <verbatim|true>,
    because for performance reasons <hlink|<with|font-family|tt|blobp>|#blobp>
    only does a quick plausibility check on the header information of the
    blob, whereas <hlink|<with|font-family|tt|val>|#val> also performs a crc
    check and verifies data integrity.)
  </description>

  <\description>
    <item*|# p<label|#/blob>>

    <item*|blob_size p<label|blob-size>>

    <item*|blob_crc p<label|blob-crc>>Determines the size (in bytes) and crc
    checksum of a blob, respectively. <hlink|<with|font-family|tt|blob_size>|#blob-size>
    always returns a bigint, <hlink|<with|font-family|tt|blob_crc>|#blob-crc>
    a machine int (use <hlink|<with|font-family|tt|uint>|#uint> on the latter
    to get a proper unsigned 32 bit value). For convenience, <verbatim|#p> is
    defined as an alias for <verbatim|blob_size> <verbatim|p> on
    <hlink|<with|font-family|tt|blob>|#blob> pointers.
  </description>

  Example:

  <\verbatim>
    \;

    \<gtr\> let b = blob {"Hello, world!", 1/3, 4711, NULL};

    \<gtr\> b; #b; uint $ blob_crc b;

    #\<less\>pointer 0x141dca0\<gtr\>

    148L

    3249898239L

    \<gtr\> val b;

    {"Hello, world!",0.333333333333333,4711,#\<less\>pointer 0x0\<gtr\>}

    \;
  </verbatim>

  Please note that the current implementation has some limitations:

  <\itemize>
    <item>Just as with <hlink|<with|font-family|tt|str>|#str> and
    <hlink|<with|font-family|tt|eval>|#eval>, runtime data (local closures
    and pointers other than the <hlink|<with|font-family|tt|NULL>|#NULL>
    pointer) can't be serialized, causing
    <hlink|<with|font-family|tt|blob>|#blob> to fail. However, it <em|is>
    possible to transfer a global function, provided that the function exists
    (and is the same) in both the sending and the receiving process. (This
    condition can't be verified by <hlink|<with|font-family|tt|val>|#val> and
    thus is at the programmer's responsibilty.)

    <item>Sharing of subexpressions will in general be preserved, but sharing
    of list and tuple <em|tails> will be lost (unless the entire list or
    tuple is shared).

    <item>The <hlink|<with|font-family|tt|val>|#val> function may fail to
    reconstruct the serialized expression even for valid blobs, if there is a
    conflict in symbol fixities between the symbol tables of the sending and
    the receiving process. To avoid this, make sure that symbol declarations
    in the sending and the receiving script match up.
  </itemize>

  <paragraph|Other Special Primitives><label|other-special-primitives>

  <\description>
    <item*|exit status<label|exit>>Terminate the program with the given
    status code.
  </description>

  <\description>
    <item*|throw x<label|throw>>Throw an exception, cf. <hlink|<em|Exception
    Handling>|pure.tm#exception-handling>.
  </description>

  <\description>
    <item*|__break__<label|--break-->>

    <item*|__trace__<label|--trace-->>Trigger the debugger from a Pure
    program, cf. <hlink|<em|Debugging>|pure.tm#debugging>. Note that these
    routines only have an effect if the interpreter is run in debugging mode,
    otherwise they are no-ops. The debugger will be invoked at the next
    opportunity (usually when a function is called or a reduction is
    completed).
  </description>

  <\description>
    <item*|force x<label|force>>Force a thunk (<verbatim|x&>), cf.
    <hlink|<em|Special Forms>|pure.tm#special-forms>. This usually happens
    automagically when the value of a thunk is needed.
  </description>

  <paragraph|Pointer Operations><label|pointer-operations>

  The prelude provides a few basic operations on pointers which make it easy
  to interface to external C functions. For more advanced uses, the library
  also includes the <hlink|<with|font-family|tt|pointers>|#module-pointers>
  module which can be imported explicitly if needed, see <hlink|Pointer
  Arithmetic|#pointer-arithmetic> below.

  <\description>
    <item*|addr symbol<label|addr>>Get the address of a C symbol (given as a
    string) at runtime. The library containing the symbol must already be
    loaded. Note that this can in fact be any kind of externally visible C
    symbol, so it's also possible to get the addresses of global variables.
    The result is returned as a pointer. The function fails if the symbol was
    not found.
  </description>

  <\description>
    <item*|calloc nmembers size<label|calloc>>

    <item*|malloc size<label|malloc>>

    <item*|realloc ptr size<label|realloc>>

    <item*|free ptr<label|free>>Interface to <verbatim|malloc>,
    <verbatim|free> and friends. These let you allocate dynamic buffers
    (represented as Pure pointer values) for various purposes.
  </description>

  The following functions perform direct memory accesses through pointers.
  Their primary use is to interface to certain C library functions which take
  or return data through pointers. It goes without saying that these
  operations should be used with utmost care. No checking is done on the
  pointer types, so it is the programmer's responsibility to ensure that the
  pointers actually refer to the corresponding type of data.

  <\description>
    <item*|get_byte ptr<label|get-byte>>

    <item*|get_short ptr<label|get-short>>

    <item*|get_int ptr<label|get-int>>

    <item*|get_int64 ptr<label|get-int64>>

    <item*|get_long ptr<label|get-long>>

    <item*|get_float ptr<label|get-float>>

    <item*|get_double ptr<label|get-double>>

    <item*|get_string ptr<label|get-string>>

    <item*|get_pointer ptr<label|get-pointer>>Return the integer, floating
    point, string or generic pointer value at the memory location indicated
    by <verbatim|ptr>.
  </description>

  <\description>
    <item*|put_byte ptr x<label|put-byte>>

    <item*|put_short ptr x<label|put-short>>

    <item*|put_int ptr x<label|put-int>>

    <item*|put_int64 ptr x<label|put-int64>>

    <item*|put_long ptr x<label|put-long>>

    <item*|put_float ptr x<label|put-float>>

    <item*|put_double ptr x<label|put-double>>

    <item*|put_string ptr x<label|put-string>>

    <item*|put_pointer ptr x<label|put-pointer>>Change the integer, floating
    point, string or generic pointer value at the memory location indicated
    by <verbatim|ptr> to the given value <verbatim|x>.
  </description>

  <paragraph|Sentries><label|sentries>

  Sentries are Pure's flavour of object <with|font-series|bold|finalizers>. A
  sentry is simply an object (usually a function) which gets applied to the
  target expression when it is garbage-collected. This is useful to perform
  automatic cleanup actions on objects with internal state, such as files.
  Pure's sentries are <em|much> more useful than finalizers in other
  garbage-collected languages, since it is guaranteed that they are called as
  soon as an object \Pgoes out of scope\Q, i.e., becomes inaccessible.

  <\description>
    <item*|sentry f x<label|sentry>>Places a sentry <verbatim|f> at an
    expression <verbatim|x> and returns the modified expression.
  </description>

  <\description>
    <item*|clear_sentry x<label|clear-sentry>>Removes the sentry from an
    expression <verbatim|x>.
  </description>

  <\description>
    <item*|get_sentry x<label|get-sentry>>Returns the sentry of an expression
    <verbatim|x> (if any, fails otherwise).
  </description>

  As of Pure 0.45, sentries can be placed on any Pure expression. The sentry
  itself can also be any type of object (but usually it's a function).
  Example:

  <\verbatim>
    \;

    \<gtr\> using system;

    \<gtr\> sentry (\\_-\<gtr\>puts "I'm done for!") (1..3);

    [1,2,3]

    \<gtr\> clear ans

    I'm done for!

    \;
  </verbatim>

  Note that setting a finalizer on a global symbol won't usually be of much
  use since such values are cached by the interpreter. (However, the sentry
  <em|will> be invoked if the symbol gets recompiled because its definition
  has changed. This may be useful for some purposes.)

  In Pure parlance, we call an expression <with|font-series|bold|cooked> if a
  sentry has been attached to it. The following predicate can be used to
  check for this condition. Also, there is a convenience function to create
  cooked pointers which take care of freeing themselves when they are no
  longer needed.

  <\description>
    <item*|cookedp x<label|cookedp>>Check whether a given object has a sentry
    set on it.
  </description>

  <\description>
    <item*|cooked ptr<label|cooked>>Create a pointer which disposes itself
    after use. This is just a shorthand for <verbatim|sentry>
    <verbatim|free>. The given pointer <verbatim|ptr> must be
    <hlink|<with|font-family|tt|malloc>|#malloc>ed to make this work.
  </description>

  Example:

  <\verbatim>
    \;

    \<gtr\> using system;

    \<gtr\> let p = cooked (malloc 1024);

    \<gtr\> cookedp p;

    1

    \<gtr\> get_sentry p;

    free

    \<gtr\> clear p

    \;
  </verbatim>

  Besides their use as finalizers, sentries can also be handy in other
  circumstances, when you need to associate an expression with another,
  \Pinvisible\Q value. In this case the sentry is usually some kind of data
  structure instead of a function to be executed at finalization time. For
  instance, here's how we can employ sentries to implement hashing of
  function values:

  <\verbatim>
    \;

    using dict;

    hashed f x = case get_sentry f of

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ h::hdict = h!x if member h x;

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ _ = y when y = f x; sentry (update h x y) f

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ when h = case get_sentry f
    of

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ h::hdict
    = h; _ = emptyhdict

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ end;

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ end;

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ end;

    \ \ \ \ \ \ \ \ \ \ \ \ \ end;

    \;
  </verbatim>

  E.g., consider the naive recursive definition of the Fibonacci function:

  <\verbatim>
    \;

    fib n::int = if n\<less\>=1 then 1 else fib (n-1)+fib (n-2);

    \;
  </verbatim>

  A hashed version of the Fibonacci function can be defined as follows:

  <\verbatim>
    \;

    let hfib = hashed f with

    \ \ f n::int = if n\<less\>=1 then 1 else hfib (n-1)+hfib (n-2)

    end;

    \;
  </verbatim>

  This turns the naive definition of the Fibonacci function (which has
  exponential time complexity) into a linear time operation:

  <\verbatim>
    \;

    \<gtr\> stats

    \<gtr\> fib 35;

    14930352

    4.53s

    \<gtr\> hfib 35;

    14930352

    0.25s

    \;
  </verbatim>

  Finally, note that there can be only one sentry per expression but,
  building on the operations provided here, it's easy to design a scheme
  where sentries are chained. For instance:

  <\verbatim>
    \;

    chain_sentry f x = sentry (h (get_sentry x)) x with

    \ \ h g x = g x $$ f x;

    end;

    \;
  </verbatim>

  This invokes the original sentry before the chained one:

  <\verbatim>
    \;

    \<gtr\> using system;

    \<gtr\> f _ = puts "sentry#1"; g _ = puts "sentry#2";

    \<gtr\> let p = chain_sentry g $ sentry f $ malloc 10;

    \<gtr\> clear p

    sentry#1

    sentry#2

    \;
  </verbatim>

  You can chain any number of sentries that way. This scheme should work in
  most cases in which sentries are used just as finalizers. However, there
  are other uses, like the \Phashed function\Q example above, where you'd
  like the original sentry to stay intact. This can be achieved by placing
  the new sentry as a sentry on the <em|original sentry> rather than the
  expression itself:

  <\verbatim>
    \;

    attach_sentry f x = sentry (sentry f (get_sentry x)) x;

    \;
  </verbatim>

  This requires that the sentry will actually be garbage-collected when its
  hosting expression gets freed, so it will <em|not> work if the original
  sentry is a global:

  <\verbatim>
    \;

    \<gtr\> let p = attach_sentry g $ sentry f $ malloc 10;

    \<gtr\> clear p

    sentry#1

    \;
  </verbatim>

  However, the attached sentry will work ok if you can ensure that the
  original sentry is a (partial or constructor) application. E.g.:

  <\verbatim>
    \;

    \<gtr\> let p = attach_sentry g $ sentry (f$) $ malloc 10;

    \<gtr\> clear p

    sentry#1

    sentry#2

    \;
  </verbatim>

  <paragraph|Tagged Pointers><label|tagged-pointers>

  As of Pure 0.45, the C interface now fully checks pointer parameter types
  at runtime (see the <hlink|<em|C Types>|pure.tm#c-types> section in the
  Pure Manual for details). To these ends, pointer values are internally
  tagged to keep track of the pointer types. The operations described in this
  section give you access to these tags in Pure programs. At the lowest
  level, a pointer tag is simply a machine int associated with a pointer
  value. The default tag is 0, which denotes a generic pointer value, i.e.,
  <verbatim|void*> in C. The following operations are provided to create such
  tags, and set, get or verify the tag of a pointer value.

  <\description>
    <item*|ptrtag t x<label|ptrtag>>Places an integer tag <verbatim|t> at an
    expression <verbatim|x> and returns the modified expression. <verbatim|x>
    must be a pointer value.
  </description>

  <\description>
    <item*|get_ptrtag x<label|get-ptrtag>>Retrieves the tag associated with
    <verbatim|x>.
  </description>

  <\description>
    <item*|check_ptrtag t x<label|check-ptrtag>>Compares the tag associated
    with <verbatim|x> against <verbatim|t> and returns true iff the tags
    match. If <verbatim|x> is a pointer value, this is equivalent to
    <verbatim|get_ptrtag> <verbatim|x==t> <verbatim|\|\|> <verbatim|null>
    <verbatim|x> <verbatim|&&> <verbatim|get_ptrtag> <verbatim|x==0>.
  </description>

  <\description>
    <item*|make_ptrtag<label|make-ptrtag>>Returns a new, unique tag each time
    it is invoked.
  </description>

  Examples:

  <\verbatim>
    \;

    \<gtr\> let p = malloc 10;

    \<gtr\> get_ptrtag p; // zero by default

    0

    \<gtr\> let t = make_ptrtag; t;

    12

    \<gtr\> ptrtag t p;

    #\<less\>pointer 0xc42da0\<gtr\>

    \<gtr\> get_ptrtag p;

    12

    \<gtr\> check_ptrtag t p;

    1

    \<gtr\> check_ptrtag 0 p;

    0

    \;
  </verbatim>

  Note that in the case of a non-<hlink|<with|font-family|tt|NULL>|#NULL>
  pointer, <hlink|<with|font-family|tt|check_ptrtag>|#check-ptrtag> just
  tests the tags for equality. On the other hand, a generic
  <hlink|<with|font-family|tt|NULL>|#NULL> pointer, like in C, is considered
  compatible with all pointer types:

  <\verbatim>
    \;

    \<gtr\> let t1 = make_ptrtag; t1;

    13

    \<gtr\> check_ptrtag t1 p;

    0

    \<gtr\> check_ptrtag t1 NULL;

    1

    \<gtr\> get_ptrtag NULL;

    0

    \;
  </verbatim>

  The operations above are provided so that you can design your own, more
  elaborate type systems for pointer values if the need arises. However,
  you'll rarely have to deal with pointer tags at this level yourself. For
  most applications, it's enough to inspect the type of a Pure pointer and
  maybe modify it by \Pcasting\Q it to a new target type. The following
  high-level operations provide these capabilities.

  <\description>
    <item*|pointer_tag ty<label|pointer-tag>>

    <item*|pointer_tag x>Returns the pointer tag for the given type
    <verbatim|ty>, denoted as a string, or the given pointer value
    <verbatim|x>. In the former case, the type should be specified in the
    C-like syntax used in <hlink|<with|font-family|tt|extern>|pure.tm#extern>
    declarations; a new tag will be created using
    <hlink|<with|font-family|tt|make_ptrtag>|#make-ptrtag> if needed. In the
    latter case, <hlink|<with|font-family|tt|pointer_tag>|#pointer-tag>
    simply acts as a frontend for <hlink|<with|font-family|tt|get_ptrtag>|#get-ptrtag>
    above.
  </description>

  <\description>
    <item*|pointer_type tag<label|pointer-type>>

    <item*|pointer_type x>Returns the type name associated with the given int
    value <verbatim|tag> or pointer value <verbatim|x>. Please note that this
    may be <hlink|<with|font-family|tt|NULL>|#NULL> in the case of an
    \Panonymous\Q tag, which may have been created with
    <hlink|<with|font-family|tt|make_ptrtag>|#make-ptrtag> above, or if the
    tag is simply unknown because it hasn't been created yet.
  </description>

  <\description>
    <item*|pointer_cast tag x<label|pointer-cast>>

    <item*|pointer_cast ty x>Casts <verbatim|x> (which must be a pointer
    value) to the given pointer type, which may be specified either as a tag
    or a string denoting the type name. This returns a new pointer value with
    the appropriate type tag on it (the tag on the original pointer value
    <verbatim|x> isn't affected by this operation).
  </description>

  Example:

  <\verbatim>
    \;

    \<gtr\> let p = malloc 10;

    \<gtr\> let q = pointer_cast "char*" p;

    \<gtr\> map pointer_type [p,q];

    ["void*","char*"]

    \<gtr\> map pointer_tag [p,q];

    [0,1]

    \<gtr\> map pointer_type (0..make_ptrtag-1);

    ["void*","char*","void**","char**","short*","short**","int*","int**",

    "float*","float**","double*","double**"]

    \;
  </verbatim>

  (The last command shows a quick and dirty way to retrieve the currently
  defined type tags in the interpreter. This won't work in batch-compiled
  scripts, however, since in this case the range of type tags is in general
  non-contiguous.)

  If you have to do many casts to a given type, you can avoid the overhead of
  repeatedly looking up the type name by assigning the tag to a variable,
  which can then be passed to <hlink|<with|font-family|tt|pointer_cast>|#pointer-cast>
  instead:

  <\verbatim>
    \;

    \<gtr\> let ty = pointer_tag "long*";

    \<gtr\> pointer_cast ty p, pointer_cast ty q;

    \;
  </verbatim>

  Note that you have to be careful when casting a cooked pointer, because
  <hlink|<with|font-family|tt|pointer_cast>|#pointer-cast> may have to create
  a copy of the original pointer value in order not to clobber the original
  type tag. The sentry will then still be with the original cooked pointer
  value, thus you have to ensure that this value survives its type-cast
  duplicate. It's usually best to apply the cast right at the spot where the
  pointer gets passed to an external function, e.g.:

  <\verbatim>
    \;

    \<gtr\> extern char *gets(char*);

    \<gtr\> let p = cooked $ malloc 1000;

    \<gtr\> gets (pointer_cast "char*" p);

    \;
  </verbatim>

  Such usage is always safe. If this approach isn't possible, you might want
  to use the lowlevel <hlink|<with|font-family|tt|ptrtag>|#ptrtag> operation
  instead. (This will clobber the type tag of the pointer, but you can always
  change it back afterwards.)

  <paragraph|Expression References><label|expression-references>

  Expression references provide a kind of mutable data cells which can hold
  any Pure expression. If you need these, then you're doomed. ;-) However,
  they can be useful as a last resort when you need to keep track of some
  local state or interface to the messy imperative world. Pure's references
  are actually implemented as expression pointers so that you can readily
  pass them as pointers to a C function which expects a
  <verbatim|pure_expr**> parameter. This may even be useful at times.

  <\description>
    <item*|<em|type> ref<label|ref/type>>The type of expression references.
    This is a subtype of the <hlink|<with|font-family|tt|pointer>|pure.tm#pointer/type>
    type.
  </description>

  <\description>
    <item*|ref x<label|ref>>Create a reference pointing to <verbatim|x>
    initially.
  </description>

  <\description>
    <item*|put r x<label|put>>Set a new value <verbatim|x>, and return that
    value.
  </description>

  <\description>
    <item*|get r<label|get>>Retrieve the current value <verbatim|r> points
    to.
  </description>

  <\description>
    <item*|unref r<label|unref>>Purge the referenced object and turn the
    reference into a dangling pointer. (This is used as a sentry on reference
    objects and shouldn't normally be called directly.)
  </description>

  <\description>
    <item*|refp x<label|refp>>Predicate to check for reference values.
  </description>

  Note that manually changing or removing the
  <hlink|<with|font-family|tt|unref>|#unref> sentry of a reference turns the
  reference into just a normal pointer object and renders it unusable as a
  reference. Doing this will also leak memory, so don't!

  There is another pitfall with expression references, namely that they can
  be used to create cyclic chains which currently can't be reclaimed by
  Pure's reference-counting garbage collector. For instance:

  <\verbatim>
    \;

    \<gtr\> using system;

    \<gtr\> done r = printf "done %s\\n" (str r);

    \<gtr\> let x = ref ();

    \<gtr\> let y = ref (sentry done 2,x);

    \<gtr\> put x (sentry done 1,y);

    1,#\<less\>pointer 0x3036400\<gtr\>

    \;
  </verbatim>

  At this point <verbatim|x> points to <verbatim|y> and vice versa. If you
  now purge the <verbatim|x> and <verbatim|y> variables then Pure won't be
  able to reclaim the cycle, resulting in a memory leak (you can verify this
  by noting that the sentries are not being called). To prevent this, you'll
  have to break the cycle first:

  <\verbatim>
    \;

    \<gtr\> put y 3;

    done 2

    3

    \<gtr\> clear x y

    done 1

    \;
  </verbatim>

  Note that, in a way, sentries work similar to expression references and
  thus the same caveats apply there. Having a limited amount of cyclic
  references won't do any harm. But if they can grow indefinitely then they
  may cause problems with long-running programs due to memory leakage, so
  it's a good idea to avoid such cycles if possible.

  <label|module-pointers><paragraph|Pointer
  Arithmetic><label|pointer-arithmetic><label|pointer-arithmetic>

  The pointers.pure module provides the usual C-style pointer arithmetic and
  comparisons of pointer values. This module normally is not included in the
  prelude, so to use these operations, you have to add the following import
  declaration to your program:

  <\verbatim>
    \;

    using pointers;

    \;
  </verbatim>

  The module overloads the comparison and some of the arithmetic operators
  (cf. <hlink|Arithmetic|#arithmetic>) so that they can be used to compare
  pointers and to perform C-style pointer arithmetic. To these ends, some
  conversions between pointers and numeric types are also provided.

  <\description>
    <item*|int p<label|int/pointer>>

    <item*|bigint p<label|bigint/pointer>>Convert a pointer to an int or
    bigint, giving its numeric address value, which usually denotes a byte
    offset relative to the beginning of the memory of the executing process.
    This value can then be used in arithmetic operations and converted back
    to a pointer using the <hlink|<with|font-family|tt|pointer>|#pointer>
    function from the prelude. (Note that to make this work on 64 bit
    systems, you'll have to convert the pointer values to bigints.)
  </description>

  <\description>
    <item*|p + n<label|+/pointer>>

    <item*|p - n<label|-/pointer>>

    <item*|p - q<label|-/pointerdiff>>Pointer arithmetic. <verbatim|p+n> and
    <verbatim|p-n> offsets a pointer <verbatim|p> by the given integer
    <verbatim|n> denoting the amount of bytes. In addition, <verbatim|p-q>
    returns the byte offset between two pointers <verbatim|p> and
    <verbatim|q>. Note that, in contrast to C pointer arithmetic which also
    takes into account the base type of the pointer, the Pure operations
    always use byte offsets, no matter what type of pointer (as given by the
    pointer tag) is passed to these operations.
  </description>

  <\description>
    <item*|p == q<label|==/pointer>>

    <item*|p <math|\<sim\>>= q<label|-tilde=/pointer>>Pointer equality and
    inequality. This is exactly the same as syntactic equality on pointers.
  </description>

  <\description>
    <item*|p \<less\>= q<label|\<less\>=/pointer>>

    <item*|p \<gtr\>= q<label|\<gtr\>=/pointer>>

    <item*|p \<gtr\> q<label|\<gtr\>/pointer>>

    <item*|p \<less\> q<label|\<less\>/pointer>>Pointer comparisons. One
    pointer <verbatim|p> is considered to be \Pless\Q than another pointer
    <verbatim|q> if it represents a \Plower\Q address in memory, i.e., if the
    byte offset <verbatim|p-q> is negative.
  </description>

  <subsection|Mathematical Functions><label|module-math>

  The math.pure module provides Pure's basic math routines. It also defines
  complex and rational numbers.

  <subsubsection|Imports><label|imports>

  To use the operations of this module, add the following import declaration
  to your program:

  <\verbatim>
    \;

    using math;

    \;
  </verbatim>

  <subsubsection|Basic Math Functions><label|basic-math-functions>

  The module defines the following real-valued constants:

  <\description>
    <item*|<em|constant> e = 2.71828...<label|e>>Euler's number.
  </description>

  <\description>
    <item*|<em|constant> pi = 3.1415...<label|pi>>Ludolph's number.
  </description>

  It also provides a reasonably comprehensive (pseudo) random number
  generator which uses the <hlink|Mersenne
  twister|http://www.math.sci.hiroshima-u.ac.jp/-tildem-mat/MT/emt.html> to
  avoid bad generators present in some C libraries.

  Please note that as of Pure 0.41, the runtime library includes a newer
  release of the Mersenne twister which fixes issues with some kinds of seed
  values, and will yield different values for given seeds. Also, the
  <hlink|<with|font-family|tt|random31>|#random31> and
  <hlink|<with|font-family|tt|random53>|#random53> functions have been added
  as a convenience to compute unsigned 31 bit integers and 53 bit double
  values, and the <hlink|<with|font-family|tt|srandom>|#srandom> function now
  also accepts an int matrix as seed value.

  <\description>
    <item*|random<label|random>>Return 32 bit pseudo random ints in the range
    <verbatim|-0x80000000..0x7fffffff>.
  </description>

  <\description>
    <item*|random31<label|random31>>Return 31 bit pseudo random ints in the
    range <verbatim|0..0x7fffffff>.
  </description>

  <\description>
    <item*|random53<label|random53>>Return pseudo random doubles in the range
    <verbatim|[0,1)> with 53 bits resolution.
  </description>

  <\description>
    <item*|srandom seed<label|srandom>>Sets the seed of the generator to the
    given 32 bit integer. You can also specify longer seeds using a nonempty
    row vector, e.g.: <verbatim|srandom> <verbatim|{0x123,> <verbatim|0x234,>
    <verbatim|0x345,> <verbatim|0x456}>.
  </description>

  The following functions work with both double and int/bigint arguments. The
  result is always a double. For further explanations please see the
  descriptions of the corresponding functions from the C math library.

  <\description>
    <item*|sqrt x<label|sqrt>>The square root function.
  </description>

  <\description>
    <item*|exp x<label|exp>>

    <item*|ln x<label|ln>>

    <item*|log x<label|log>>Exponential function, natural and decadic
    logarithms.
  </description>

  <\description>
    <item*|sin x<label|sin>>

    <item*|cos x<label|cos>>

    <item*|tan x<label|tan>>Trigonometric functions.
  </description>

  <\description>
    <item*|asin x<label|asin>>

    <item*|acos x<label|acos>>

    <item*|atan x<label|atan>>Inverse trigonometric functions.
  </description>

  <\description>
    <item*|atan2 y x<label|atan2>>Computes the arcus tangent of
    <verbatim|y/x>, using the signs of the two arguments to determine the
    quadrant of the result.
  </description>

  <\description>
    <item*|sinh x<label|sinh>>

    <item*|cosh x<label|cosh>>

    <item*|tanh x<label|tanh>>Hyperbolic trigonometric functions.
  </description>

  <\description>
    <item*|asinh x<label|asinh>>

    <item*|acosh x<label|acosh>>

    <item*|atanh x<label|atanh>>Inverse hyperbolic trigonometric functions.
  </description>

  <subsubsection|Complex Numbers><label|complex-numbers>

  <\description>
    <item*|x +: y<label|+:>>

    <item*|r \<less\>: t<label|\<less\>:>>Complex number constructors.
  </description>

  <\description>
    <item*|<em|constant> i = 0+:1<label|i>>Imaginary unit.
  </description>

  We provide both rectangular (<verbatim|x+:y>) and polar (<verbatim|r\<:a>)
  representations, where <verbatim|(x,y)> are the Cartesian coordinates and
  <verbatim|(r,t)> the radius (absolute value) and angle (in radians) of a
  complex number, respectively. The <hlink|<with|font-family|tt|+:>|#+:> and
  <hlink|<with|font-family|tt|\<less\>:>|#\<:> constructors (declared in the
  prelude) bind weaker than all other arithmetic operators and are
  non-associative.

  The polar representation <verbatim|r\<:t> is normalized so that
  <verbatim|r> is always nonnegative and <verbatim|t> falls in the range
  <verbatim|-pi\<t\<=pi>.

  The constant <hlink|<with|font-family|tt|i>|#i> is provided to denote the
  imaginary unit <verbatim|0+:1>.

  The arithmetic operations <hlink|<with|font-family|tt|+>|#+>,
  <hlink|<with|font-family|tt|*>|#*> etc. and the equality relations
  <hlink|<with|font-family|tt|==>|#==> and
  <hlink|<with|font-family|tt|<math|\<sim\>>=>|#-tilde=> work as expected,
  and the square root, exponential, logarithms, trigonometric and hyperbolic
  trigonometric functions (see <hlink|Basic Math
  Functions|#basic-math-functions>) are extended to complex numbers
  accordingly. These do <em|not> rely on complex number support in the C
  library, but should still conform to IEEE 754 and POSIX, provided that the
  C library provides a standards-compliant implementation of the basic math
  functions.

  The following operations all work with both the rectangular and the polar
  representation, promoting real (double, int/bigint) inputs to complex where
  appropriate. When the result of an operation is again a complex number, it
  generally uses the same representation as the input (except for explicit
  conversions). Mixed rect/polar and polar/rect arithmetic always returns a
  rect result, and mixed complex/real and real/complex arithmetic yields a
  rect or polar result, depending on what the complex input was.

  <\description>
    <item*|complex x<label|complex>>Convert any kind of number to a complex
    value.
  </description>

  <\description>
    <item*|polar z<label|polar>>

    <item*|rect z<label|rect>>Convert between polar and rectangular
    representations.
  </description>

  <\description>
    <item*|cis t<label|cis>>Create complex values on the unit circle. Note:
    To quickly compute <verbatim|exp> <verbatim|(x+:y)> in polar form, use
    <verbatim|exp> <verbatim|x> <verbatim|\<:> <verbatim|y>.
  </description>

  <\description>
    <item*|abs z<label|abs/complex>>

    <item*|arg z<label|arg>>Modulus (absolute value) and argument (angle,
    a.k.a. phase). Note that you can also find both of these in one go by
    converting to polar form.
  </description>

  <\description>
    <item*|re z<label|re>>

    <item*|im z<label|im>>Real and imaginary part.
  </description>

  <\description>
    <item*|conj z<label|conj>>Complex conjugate.
  </description>

  Examples:

  <\verbatim>
    \;

    \<gtr\> using math;

    \<gtr\> let z = 2^(1/i); z;

    0.769238901363972+:-0.638961276313635

    \<gtr\> let z = ln z/ln 2; z;

    0.0+:-1.0

    \<gtr\> abs z, arg z;

    1.0,-1.5707963267949

    \<gtr\> polar z;

    1.0\<less\>:-1.5707963267949

    \;
  </verbatim>

  Please note that, as the <hlink|<with|font-family|tt|+:>|#+:> and
  <hlink|<with|font-family|tt|\<less\>:>|#\<:> constructors bind weaker than
  the other arithmetic operators, complex numbers <em|must> be parenthesized
  accordingly, e.g.:

  <\verbatim>
    \;

    \<gtr\> (1+:2)*(3+:4);

    -5+:10

    \;
  </verbatim>

  <subsubsection|Rational Numbers><label|rational-numbers>

  <\description>
    <item*|x % y<label|%>>Exact division operator and rational number
    constructor.
  </description>

  Pure's rational numbers are constructed with the
  <with|font-series|bold|exact division> operator
  <hlink|<with|font-family|tt|%>|#\\%> (declared in the prelude) which has
  the same precedence and fixity as the other division operators.

  The <hlink|<with|font-family|tt|%>|#\\%> operator returns a rational or
  complex rational for any combination of integer, rational and complex
  integer/rational arguments, provided that the denominator is nonzero
  (otherwise it behaves like <verbatim|x> <verbatim|div> <verbatim|0>, which
  will raise an exception). Machine int operands are always promoted to
  bigints, thus normalized rationals always take the form <verbatim|x%y>
  where both the numerator <verbatim|x> and the denominator <verbatim|y> are
  bigints. For other numeric operands <hlink|<with|font-family|tt|%>|#\\%>
  works just like <hlink|<with|font-family|tt|/>|#/>. Rational results are
  normalized so that the sign is always in the numerator and numerator and
  denominator are relatively prime. In particular, a rational zero is always
  represented as <verbatim|0L%1L>.

  The usual arithmetic operations and equality/order relations are extended
  accordingly, as well as the <hlink|basic math
  functions|#basic-math-functions> and the <hlink|rounding
  functions|#rounding-functions>, and will return exact (rational or complex
  rational) results where appropriate. Rational operations are implemented
  using the GMP bigint functions where possible, and thus are reasonably
  fast.

  In addition, the module also provides following operations:

  <\description>
    <item*|rational x<label|rational>>Converts a real or complex value
    <verbatim|x> to a rational or complex rational. Note that the conversion
    from double values doesn't do any rounding, so it is guaranteed that
    converting the resulting rational back to a double reconstructs the
    original value.

    Conversely, the <hlink|<with|font-family|tt|int>|#int>,
    <hlink|<with|font-family|tt|bigint>|#bigint>,
    <hlink|<with|font-family|tt|double>|#double>,
    <hlink|<with|font-family|tt|complex>|#complex>,
    <hlink|<with|font-family|tt|rect>|#rect>,
    <hlink|<with|font-family|tt|polar>|#polar> and
    <hlink|<with|font-family|tt|cis>|#cis> conversion functions are
    overloaded so that they convert a rational to one of the other number
    types.
  </description>

  <\description>
    <item*|num x<label|num>>

    <item*|den x<label|den>>Numerator and denominator of a rational
    <verbatim|x>.
  </description>

  Examples:

  <\verbatim>
    \;

    \<gtr\> using math;

    \<gtr\> 5%7 + 2%3;

    29L%21L

    \<gtr\> 3%8 - 1%3;

    1L%24L

    \<gtr\> pow (11%10) 3;

    1331L%1000L

    \<gtr\> let x = pow 3 (-3); x;

    1L%27L

    \<gtr\> num x, den x;

    1L,27L

    \<gtr\> rational (3/4);

    3L%4L

    \;
  </verbatim>

  Note that doubles can't represent most rationals exactly, so conversion
  from double to rational <em|will> yield funny results in many cases (which
  are still accurate up to rounding errors). For instance:

  <\verbatim>
    \;

    \<gtr\> let x = rational (1/17); x;

    4238682002231055L%72057594037927936L

    \<gtr\> num x/den x;

    0.0588235294117647

    \<gtr\> double (1%17);

    0.0588235294117647

    \;
  </verbatim>

  <subsubsection|Semantic Number Predicates and
  Types><label|semantic-number-predicates-and-types>

  In difference to the syntactic predicates in
  <hlink|Primitives|#primitives>, these check whether the given value can be
  represented as an object of the given target type (up to rounding errors).
  Note that if <verbatim|x> is of syntactic type <verbatim|X>, then it is
  also of semantic type <verbatim|X>. Moreover, <verbatim|intvalp>
  <verbatim|x> <verbatim|=\>> <verbatim|bigintvalp> <verbatim|x>
  <verbatim|=\>> <verbatim|ratvalp> <verbatim|x> <verbatim|=\>>
  <verbatim|realvalp> <verbatim|x> <verbatim|=\>> <verbatim|compvalp>
  <verbatim|x> <verbatim|\<=\>> <verbatim|numberp> <verbatim|x>.

  <\description>
    <item*|compvalp x<label|compvalp>>Check for complex values (this is the
    same as <hlink|<with|font-family|tt|numberp>|#numberp>).
  </description>

  <\description>
    <item*|realvalp x<label|realvalp>>Check for real values (<verbatim|im>
    <verbatim|x==0>).
  </description>

  <\description>
    <item*|ratvalp x<label|ratvalp>>Check for rational values (same as
    <hlink|<with|font-family|tt|realvalp>|#realvalp>, except that IEEE 754
    infinities and NaNs are excluded).
  </description>

  <\description>
    <item*|bigintvalp x<label|bigintvalp>>Check for \Pbig\Q integer values
    which can be represented as a bigint.
  </description>

  <\description>
    <item*|intvalp x<label|intvalp>>Check for \Psmall\Q integer values which
    can be represented as a machine int.
  </description>

  <\description>
    <item*|<em|type> compval<label|compval>>

    <item*|<em|type> realval<label|realval>>

    <item*|<em|type> ratval<label|ratval>>

    <item*|<em|type> bigintval<label|bigintval>>

    <item*|<em|type> intval<label|intval>>Convenience types for the above
    predicates. These can be used as type tags on the left-hand side of an
    equation to match numeric values for which the corresponding predicate
    yields <hlink|<with|font-family|tt|true>|#true>.
  </description>

  <label|module-enum>

  <subsection|Enumerated Types><label|enumerated-types>

  <with|font-series|bold|Enumerated types>, or
  <with|font-series|bold|enumerations> for short, are algebraic types
  consisting only of nullary constructor symbols. The operations of this
  module equip such types with the necessary function definitions so that the
  members of the type can be employed in arithmetic operations, comparisons,
  etc. in the same way as the predefined enumerated types such as integers
  and characters. This also includes support for arithmetic sequences.

  Please note that this module is not included in the prelude by default, so
  you have to use the following import declaration to get access to its
  operations:

  <\verbatim>
    \;

    using enum;

    \;
  </verbatim>

  The following operations are provided:

  <\description>
    <item*|enum sym<label|enum>>The given symbol must denote an algebraic
    type consisting only of nonfix symbols.
    <hlink|<with|font-family|tt|enum>|#enum> adds the necessary rules for
    making members of the type work with enumerated type operations such as
    <hlink|<with|font-family|tt|ord>|#ord>,
    <hlink|<with|font-family|tt|succ>|#succ>,
    <hlink|<with|font-family|tt|pred>|#pred>, comparisons, basic arithmetic
    and arithmetic sequences. It also defines <verbatim|sym> as an ordinary
    function, called the <with|font-series|bold|enumeration function> of the
    type, which maps ordinal numbers to the corresponding members of the type
    (<verbatim|sym> <verbatim|0> yields the first member of the type,
    <verbatim|sym> <verbatim|1> the second, etc.). The members of the type
    are in the same order as given in the definition of the type.
  </description>

  <\description>
    <item*|defenum sym [symbols,...]<label|defenum>>A convenience function
    which declares a type <verbatim|sym> with the given elements and invokes
    <hlink|<with|font-family|tt|enum>|#enum> on it to make it enumerable in
    one go.
  </description>

  <\description>
    <item*|enumof sym<label|enumof>>Given a member of an enumerated type as
    defined with <hlink|<with|font-family|tt|enum>|#enum>, this returns the
    enumeration function of the type. Rules for this function are generated
    automatically by <hlink|<with|font-family|tt|enum>|#enum>.
  </description>

  <\description>
    <item*|<em|type> enum<label|enum/type>>The type of all enumerated type
    members. This is actually implemented as an interface type. It matches
    members of all enumerated types constructed with
    <hlink|<with|font-family|tt|enum>|#enum>.
  </description>

  <\description>
    <item*|enump x<label|enump>>Predicate to check for enumerated type
    members.
  </description>

  For instance, consider:

  <\verbatim>
    \;

    nonfix sun mon tue wed thu fri sat;

    type day sun \| day mon \| day tue \| day wed \| day thu \| day fri \|
    day sat;

    \;
  </verbatim>

  Once the type is defined, we can turn it into an enumeration simply as
  follows:

  <\verbatim>
    \;

    enum day;

    \;
  </verbatim>

  There's also a convenience function <hlink|<with|font-family|tt|defenum>|#defenum>
  which defines the type and makes it enumerable in one go:

  <\verbatim>
    \;

    defenum day [sun,mon,tue,wed,thu,fri,sat];

    \;
  </verbatim>

  In particular, this sets up the functions <verbatim|day> and <verbatim|ord>
  so that you can convert between members of the <verbatim|day> type and the
  corresponding ordinals:

  <\verbatim>
    \;

    \<gtr\> ord sun;

    0

    \<gtr\> day (ans+3);

    wed

    \;
  </verbatim>

  You can also retrieve the type of an enumerated type member (or rather its
  enumeration function) with <hlink|<with|font-family|tt|enumof>|#enumof>:

  <\verbatim>
    \;

    \<gtr\> enumof sun;

    day

    \<gtr\> ans 5;

    fri

    \;
  </verbatim>

  Basic arithmetic, comparisons and arithmetic sequences also work as usual,
  provided that the involved members are all from the same enumeration:

  <\verbatim>
    \;

    \<gtr\> succ mon;

    tue

    \<gtr\> pred sat;

    fri

    \<gtr\> sun+3;

    wed

    \<gtr\> fri-2;

    wed

    \<gtr\> fri-tue;

    3

    \<gtr\> mon..fri;

    [mon,tue,wed,thu,fri]

    \<gtr\> sun:tue..sat;

    [sun,tue,thu,sat]

    \<gtr\> sat:fri..mon;

    [sat,fri,thu,wed,tue,mon]

    \;
  </verbatim>

  Note that given one member of the enumeration, you can use
  <hlink|<with|font-family|tt|enumof>|#enumof> to quickly enumerate <em|all>
  members of the type starting at the given member. Here's a little helper
  function which does this:

  <\verbatim>
    \;

    enumerate x::enum = iterwhile (typep ty) succ x when ty = enumof x end;

    \;
  </verbatim>

  For instance:

  <\verbatim>
    \;

    \<gtr\> enumerate sun;

    [sun,mon,tue,wed,thu,fri,sat]

    \;
  </verbatim>

  Also note that <hlink|<with|font-family|tt|enum>|#enum> silently skips
  elements which are already enumerated type members (no matter whether of
  the same or another type). Thus if you later add more elements to the
  <verbatim|day> type, you can just call <hlink|<with|font-family|tt|enum>|#enum>
  again to update the enumeration accordingly:

  <\verbatim>
    \;

    \<gtr\> succ sat;

    sat+1

    \<gtr\> type day doomsday;

    \<gtr\> enum day;

    ()

    \<gtr\> succ sat;

    doomsday

    \;
  </verbatim>

  <subsection|Container Types><label|container-types>

  The standard library provides a variety of efficient container data
  structures for different purposes. These are all purely functional, i.e.,
  immutable data structures implemented using different flavours of binary
  trees. This means that instead of modifying a data structure in-place,
  operations like insertion and deletion return a new instance of the
  container, keeping the previous instance intact. Nevertheless, all
  operations are performed efficiently, in logarithmic time where possible.

  The container types are all implemented as abstract data structures, so
  client modules shouldn't rely on the internal representation. Each type
  provides a corresponding type tag (cf. <hlink|<em|Type
  Tags>|pure.tm#type-tags> in the Pure Manual), as given in the description
  of each type, which can be used to match values of the type, e.g.:

  <\verbatim>
    \;

    shift a::array = rmfirst a;

    \;
  </verbatim>

  All container types implement the equality predicates
  <hlink|<with|font-family|tt|==>|#==> and
  <hlink|<with|font-family|tt|<math|\<sim\>>=>|#-tilde=> by recursively
  comparing their members. In addition, the dictionary, set and bag data
  structures also provide the other comparison predicates
  (<hlink|<with|font-family|tt|\<less\>>|#\<>,
  <hlink|<with|font-family|tt|\<less\>=>|#\<=> etc.) which check whether one
  dictionary, set or bag is contained in another.

  <label|module-array><subsubsection|Arrays><label|arrays><label|arrays>

  The array.pure module implements an efficient functional array data
  structure which allows to access and update individual array members, as
  well as to add and remove elements at the beginning and end of an array.
  All these operations are carried out in logarithmic time.

  <\description>
    <item*|<em|type> array<label|array/type>>The array data type.
  </description>

  Imports

  To use the operations of this module, add the following import declaration
  to your program:

  <\verbatim>
    \;

    using array;

    \;
  </verbatim>

  <paragraph|Operations><label|operations>

  <\description>
    <item*|emptyarray<label|emptyarray>>return the empty array
  </description>

  <\description>
    <item*|array xs<label|array>>create an array from a list <verbatim|xs>
  </description>

  <\description>
    <item*|array2 xs<label|array2>>create a two-dimensional array from a list
    of lists
  </description>

  <\description>
    <item*|mkarray x n<label|mkarray>>create an array consisting of
    <verbatim|n> <verbatim|x>`s
  </description>

  <\description>
    <item*|mkarray2 x (n,m)<label|mkarray2>>create a two-dimensional array of
    <verbatim|n*m> <verbatim|x>`s
  </description>

  <\description>
    <item*|arrayp x<label|arrayp>>check whether <verbatim|x> is an array
  </description>

  <\description>
    <item*|# a<label|#/array>>size of <verbatim|a>
  </description>

  <\description>
    <item*|a ! i<label|!/array>>return the <verbatim|i>th member of
    <verbatim|a>
  </description>

  <\description>
    <item*|a ! (i,j)>two-dimensional subscript
  </description>

  <\description>
    <item*|null a<label|null/array>>test whether <verbatim|a> is the empty
    array
  </description>

  <\description>
    <item*|members a<label|members/array>>

    <item*|list a<label|list/array>>list of values stored in <verbatim|a>
  </description>

  <\description>
    <item*|members2 a<label|members2/array>>

    <item*|list2 a<label|list2/array>>list of members in a two-dimensional
    array
  </description>

  <\description>
    <item*|first a<label|first/array>>

    <item*|last a<label|last/array>>first and last member of <verbatim|a>
  </description>

  <\description>
    <item*|rmfirst a<label|rmfirst/array>>

    <item*|rmlast a<label|rmlast/array>>remove first and last member from
    <verbatim|a>
  </description>

  <\description>
    <item*|insert a x<label|insert/array>>insert <verbatim|x> at the
    beginning of <verbatim|a>
  </description>

  <\description>
    <item*|append a x<label|append/array>>append <verbatim|x> to the end of
    <verbatim|a>
  </description>

  <\description>
    <item*|update a i x<label|update/array>>replace the <verbatim|i>th member
    of <verbatim|a> by <verbatim|x>
  </description>

  <\description>
    <item*|update2 a (i,j) x<label|update2/array>>update two-dimensional
    array
  </description>

  <paragraph|Examples><label|examples>

  Import the module:

  <\verbatim>
    \;

    \<gtr\> using array;

    \;
  </verbatim>

  A one-dimensional array:

  <\verbatim>
    \;

    \<gtr\> let a::array = array (0.0:0.1..1.0);

    \<gtr\> #a; members a;

    11

    [0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0]

    \;
  </verbatim>

  Indexing an array works in the usual way, using Pure's
  <hlink|<with|font-family|tt|!>|#!> operator. By virtue of the prelude,
  slicing an array with <hlink|<with|font-family|tt|!!>|#!!> also works as
  expected:

  <\verbatim>
    \;

    \<gtr\> a!5;

    0.5

    \<gtr\> a!!(3..7);

    [0.3,0.4,0.5,0.6,0.7]

    \;
  </verbatim>

  Updating a member of an array produces a new array:

  <\verbatim>
    \;

    \<gtr\> let b::array = update a 1 2.0;

    \<gtr\> members b;

    [0.0,2.0,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0]

    \;
  </verbatim>

  Two-dimensional arrays can be created with
  <hlink|<with|font-family|tt|array2>|#array2> from a list of lists:

  <\verbatim>
    \;

    \<gtr\> let a2::array = array2 [[i,x \| x = [u,v,w]] \| i = 1..2];

    \<gtr\> members2 a2;

    [[(1,u),(1,v),(1,w)],[(2,u),(2,v),(2,w)]]

    \<gtr\> a2!(1,2);

    2,w

    \<gtr\> a2!![(0,1),(1,2)];

    [(1,v),(2,w)]

    \<gtr\> a2!!(0..1,1..2);

    [[(1,v),(1,w)],[(2,v),(2,w)]]

    \;
  </verbatim>

  Here's how to convert an array to a Pure matrix:

  <\verbatim>
    \;

    \<gtr\> matrix $ members a;

    {0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0}

    \<gtr\> matrix $ members2 a2;

    {(1,u),(1,v),(1,w);(2,u),(2,v),(2,w)}

    \;
  </verbatim>

  Converting back from a matrix to an array:

  <\verbatim>
    \;

    \<gtr\> let b2::array = array2 $ list2
    {(1,u),(1,v),(1,w);(2,u),(2,v),(2,w)};

    \<gtr\> members2 b2;

    [[(1,u),(1,v),(1,w)],[(2,u),(2,v),(2,w)]]

    \;
  </verbatim>

  <label|module-heap><subsubsection|Heaps><label|heaps><label|heaps>

  Heaps are a kind of priority queue data structure which allows quick
  (constant time) access to the smallest member, and to remove the smallest
  member and insert new elements in logarithmic time. Our implementation does
  not allow quick update of arbitrary heap members; if such functionality is
  required, bags can be used instead (see <hlink|Sets and
  Bags|#sets-and-bags>).

  Heap members <em|must> be ordered by the
  <hlink|<with|font-family|tt|\<less\>=>|#\<=> predicate. Multiple instances
  of the same element may be stored in a heap; however, the order in which
  equal elements are retrieved is not specified.

  <\description>
    <item*|<em|type> heap<label|heap/type>>The heap data type.
  </description>

  Imports

  To use the operations of this module, add the following import declaration
  to your program:

  <\verbatim>
    \;

    using heap;

    \;
  </verbatim>

  Operations

  <\description>
    <item*|emptyheap<label|emptyheap>>return the empty heap
  </description>

  <\description>
    <item*|heap xs<label|heap>>create a heap from a list <verbatim|xs>
  </description>

  <\description>
    <item*|heapp x<label|heapp>>check whether <verbatim|x> is a heap
  </description>

  <\description>
    <item*|# h<label|#/heap>>size of a heap
  </description>

  <\description>
    <item*|null h<label|null/heap>>test whether <verbatim|h> is the empty
    heap
  </description>

  <\description>
    <item*|members h<label|members/heap>>

    <item*|list h<label|list/heap>>list the members of <verbatim|h> in
    ascending order
  </description>

  <\description>
    <item*|first h<label|first/heap>>the first (i.e., smallest) member of
    <verbatim|h>
  </description>

  <\description>
    <item*|rmfirst h<label|rmfirst/heap>>remove the first (i.e., smallest)
    member from <verbatim|h>
  </description>

  <\description>
    <item*|insert h x<label|insert/heap>>insert <verbatim|x> into
    <verbatim|h>
  </description>

  Examples

  <\verbatim>
    \;

    \<gtr\> let h::heap = heap [5,1,3,11,3];

    \<gtr\> members h;

    [1,3,3,5,11]

    \<gtr\> first h;

    1

    \<gtr\> members $ rmfirst h;

    [3,3,5,11]

    \;
  </verbatim>

  <label|module-dict><subsubsection|Dictionaries><label|dictionaries><label|dictionaries>

  The dict.pure module provides Pure's dictionary data types based on AVL
  trees. There are actually four different types to choose from, depending on
  whether you need ordered or hashed dictionaries and whether multiple values
  for the same key should be allowed or not.

  <\description>
    <item*|<em|type> dict<label|dict/type>>An ordered dictionary. This
    assumes an ordered key type, i.e., the predicate
    <hlink|<with|font-family|tt|\<less\>>|#\<> must be defined on the keys.
  </description>

  <\description>
    <item*|<em|type> hdict<label|hdict/type>>A hashed dictionary which works
    with any (mixture of) key types but stores members in an apparently
    random order.
  </description>

  <\description>
    <item*|<em|type> mdict<label|mdict/type>>An ordered dictionary, like
    <hlink|<with|font-family|tt|dict>|#dict/type>, which allows multiple
    values to be associated with the same key.
  </description>

  <\description>
    <item*|<em|type> hmdict<label|hmdict/type>>A multi-valued dictionary,
    like <hlink|<with|font-family|tt|mdict>|#mdict/type>, but uses hashed
    keys like <hlink|<with|font-family|tt|hdict>|#hdict/type>.
  </description>

  <\description>
    <item*|<em|type> xdict<label|xdict/type>>This is just an abstract
    supertype for matching any kind of dictionary provided by this module.
  </description>

  <hlink|<with|font-family|tt|mdict>|#mdict/type> and
  <hlink|<with|font-family|tt|hmdict>|#hmdict/type> are also colloquially
  referred to as (ordered or hashed) <em|multidicts>. This implementation
  guarantees that different members for the same key are always kept in the
  order in which they were inserted, and this is also the order in which they
  will be retrieved by the <hlink|<with|font-family|tt|members>|#members/dict>,
  <hlink|<with|font-family|tt|keys>|#keys/dict>,
  <hlink|<with|font-family|tt|vals>|#vals/dict> and indexing operations.

  The usual comparison predicates (<hlink|<with|font-family|tt|==>|#==>,
  <hlink|<with|font-family|tt|<math|\<sim\>>=>|#-tilde=>,
  <hlink|<with|font-family|tt|\<less\>=>|#\<=>,
  <hlink|<with|font-family|tt|\<less\>>|#\<> etc.) are defined on all
  dictionary types, where two dictionaries are considered \Pequal\Q
  (<verbatim|d1==d2>) if they both contain the same <verbatim|key=\>value>
  pairs, and <verbatim|d1\<=d2> means that <verbatim|d1> is a sub-dictionary
  of <verbatim|d2>, i.e., all <verbatim|key=\>value> pairs of <verbatim|d1>
  are also contained in <verbatim|d2> (taking into account multiplicities in
  the multidict case). Ordered dictionaries compare keys using equality
  (assuming two keys <verbatim|a> and <verbatim|b> to be equal if neither
  <verbatim|a\<b> nor <verbatim|b\<a> holds), while hashed dictionaries check
  for syntactical equality (using <hlink|<with|font-family|tt|===>|#===>).
  The associated values are compared using the
  <hlink|<with|font-family|tt|==>|#==> predicate if it is defined, falling
  back to syntactic equality otherwise.

  The underlying AVL tree data structure can be found in the avltrees.pure
  module which is included in the library, but not to be invoked directly.

  The AVL tree algorithm has its origin in the SWI-Prolog implementation of
  association lists. The original implementation was created by R. A. O'Keefe
  and updated for SWI-Prolog by Jan Wielemaker. For the original source see
  <hlink|http://www.swi-prolog.org|http://www.swi-prolog.org>.

  The port from SWI-Prolog and the deletion stuff
  (<hlink|<with|font-family|tt|rmfirst>|#rmfirst/dict>,
  <hlink|<with|font-family|tt|rmlast>|#rmlast/dict>,
  <hlink|<with|font-family|tt|delete>|#delete/dict>) missing in the Prolog
  implementation was provided by Jiri Spitz. The generalization of the code
  to arbitrary combinations of ordered/hashed and single-/multi-valued keys
  was done by Albert Graef.

  Imports

  To use the operations of this module, add the following import declaration
  to your program:

  <\verbatim>
    \;

    using dict;

    \;
  </verbatim>

  Operations

  <\description>
    <item*|emptydict<label|emptydict>>

    <item*|emptyhdict<label|emptyhdict>>

    <item*|emptymdict<label|emptymdict>>

    <item*|emptyhmdict<label|emptyhmdict>>return an empty dictionary
  </description>

  <\description>
    <item*|dict xs<label|dict>>

    <item*|hdict xs<label|hdict>>

    <item*|mdict xs<label|mdict>>

    <item*|hmdict xs<label|hmdict>>create a dictionary of the corresponding
    type either from a list <verbatim|xs> of key-value pairs in the form
    <verbatim|key=\>value>, or from another dictionary; in the latter case
    the argument is converted to a dictionary of the desired target type
  </description>

  <\description>
    <item*|dictp d<label|dictp>>

    <item*|hdictp d<label|hdictp>>

    <item*|mdictp d<label|mdictp>>

    <item*|hmdictp d<label|hmdictp>>check whether <verbatim|d> is a
    dictionary of the corresponding type
  </description>

  <\description>
    <item*|mkdict y xs<label|mkdict>>

    <item*|mkhdict y xs<label|mkhdict>>

    <item*|mkmdict y xs<label|mkmdict>>

    <item*|mkhmdict y xs<label|mkhmdict>>create a dictionary from a list of
    keys and a constant value
  </description>

  <\description>
    <item*|d1 + d2<label|+/dict>>sum: <verbatim|d1+d2> adds the members of
    <verbatim|d2> to <verbatim|d1>
  </description>

  <\description>
    <item*|d1 - d2<label|-/dict>>difference: <verbatim|d1-d2> removes the
    members of <verbatim|d2> from <verbatim|d1>
  </description>

  <\description>
    <item*|d1 * d2<label|*/dict>>intersection: <verbatim|d1*d2> removes the
    members <em|not> in <verbatim|d2> from <verbatim|d1>
  </description>

  <\description>
    <item*|# d<label|#/dict>>size of a dictionary (the number of members it
    contains)
  </description>

  <\description>
    <item*|d ! x<label|!/dict>>get the value from <verbatim|d> by key
    <verbatim|x>; in the case of a multidict this actually returns a list of
    values (which may be empty if <verbatim|d> doesn't contain <verbatim|x>)
  </description>

  <\description>
    <item*|null d<label|null/dict>>test whether <verbatim|d> is an empty
    dictionary
  </description>

  <\description>
    <item*|member d x<label|member/dict>>test whether <verbatim|d> contains a
    member with key <verbatim|x>
  </description>

  <\description>
    <item*|members d<label|members/dict>>

    <item*|list d<label|list/dict>>list the members of <verbatim|d> (in
    ascending order for ordered dictionaries)
  </description>

  <\description>
    <item*|keys d<label|keys/dict>>list the keys of <verbatim|d> (in
    ascending order for ordered dictionaries)
  </description>

  <\description>
    <item*|vals d<label|vals/dict>>list the values of <verbatim|d>
  </description>

  <\description>
    <item*|first d<label|first/dict>>

    <item*|last d<label|last/dict>>return the first and the last member of
    <verbatim|d>, respectively
  </description>

  <\description>
    <item*|rmfirst d<label|rmfirst/dict>>

    <item*|rmlast d<label|rmlast/dict>>remove the first and the last member
    from <verbatim|d>, respectively
  </description>

  <\description>
    <item*|insert d (x=\<gtr\>y)<label|insert/dict>>

    <item*|update d x y<label|update/dict>>insert <verbatim|x=\>y> into
    <verbatim|d> (this always adds a new member in a multidict, otherwise it
    replaces an existing value if there is one); note that
    <hlink|<with|font-family|tt|update>|#update/dict> is just a fully curried
    version of <hlink|<with|font-family|tt|insert>|#insert/dict>, so
    <verbatim|update> <verbatim|d> <verbatim|x> <verbatim|y> behaves exactly
    like <verbatim|insert> <verbatim|d> <verbatim|(x=\>y)>
  </description>

  <\description>
    <item*|delete d x<label|delete/dict>>remove <verbatim|x> from
    <verbatim|d> if present (in the multidict case, only the first member
    with the given key <verbatim|x> is removed)
  </description>

  <\description>
    <item*|delete_val d (x=\<gtr\>y)<label|delete-val/dict>>remove a specific
    key-value pair <verbatim|x=\>y> from <verbatim|d> if present (in the
    multidict case, only the first instance of <verbatim|x=\>y> is removed);
    please also see the notes below regarding this operation
  </description>

  <\description>
    <item*|delete_all d x<label|delete-all/dict>>remove all instances of
    <verbatim|x> from <verbatim|d> (in the non-multidict case, this is just
    the same as <hlink|<with|font-family|tt|delete>|#delete/dict>)
  </description>

  <with|font-series|bold|Note:>

  <\itemize>
    <item>The infix operators <hlink|<with|font-family|tt|+>|#+/dict>,
    <hlink|<with|font-family|tt|->|#-/dict> and
    <hlink|<with|font-family|tt|*>|#*/dict> work like the corresponding set
    and bag operations (see <hlink|Sets and Bags|#sets-and-bags>), treating
    dictionaries as collections of <verbatim|key=\>val> pairs. You can mix
    arbitrary operand types with these operations, as well as with the
    comparison operations; the necessary conversions from less general
    dictionary types (ordered, single-valued) to more general types (hashed,
    multi-valued) are handled automatically.

    <item>The <hlink|<with|font-family|tt|delete_val>|#delete-val/dict>
    function compares values using equality
    (<hlink|<with|font-family|tt|==>|#==>) if it is defined, falling back to
    syntactic equality (<hlink|<with|font-family|tt|===>|#===>) otherwise. If
    there is more than one instance of the given value under the given key,
    the first such instance will be removed (which, if
    <hlink|<with|font-family|tt|==>|#==> is defined on the values, may be any
    instance that compares equal, not necessarily an exact match).

    <item>In the multidict case, <hlink|<with|font-family|tt|delete_val>|#delete-val/dict>
    may require linear time with respect to the number of different values
    stored under the given key. Since this operation is also needed to
    implement some other multidict operations like comparisons, difference
    and intersection, these may end up requiring quadratic running times in
    degenerate cases (i.e., if the majority of members happens to be
    associated with only very few keys).
  </itemize>

  Examples

  A normal (ordered) dictionary:

  <\verbatim>
    \;

    \<gtr\> using dict;

    \<gtr\> let d::dict = dict ["foo"=\<gtr\>77,"bar"=\<gtr\>99.1];

    \<gtr\> keys d; vals d; members d;

    ["bar","foo"]

    [99.1,77]

    ["bar"=\<gtr\>99.1,"foo"=\<gtr\>77]

    \;
  </verbatim>

  Indexing a dictionary works in the usual way, using Pure's
  <hlink|<with|font-family|tt|!>|#!> operator. An
  <hlink|<with|font-family|tt|out_of_bounds>|#out-of-bounds> exception is
  thrown if the key is not in the dictionary:

  <\verbatim>
    \;

    \<gtr\> d!"foo";

    77

    \<gtr\> d!"baz";

    \<less\>stdin\<gtr\>, line 5: unhandled exception 'out_of_bounds' while
    evaluating

    'd!"baz"'

    \;
  </verbatim>

  By virtue of the prelude, slicing a dictionary with
  <hlink|<with|font-family|tt|!!>|#!!> also works as expected:

  <\verbatim>
    \;

    \<gtr\> d!!["foo","bar","baz"];

    [77,99.1]

    \;
  </verbatim>

  A hashed dictionary can be used with any key values, which are stored in a
  seemingly random order:

  <\verbatim>
    \;

    \<gtr\> let h::hdict = hdict [foo=\<gtr\>77,42=\<gtr\>99.1];

    \<gtr\> keys h; vals h; members h;

    [42,foo]

    [99.1,77]

    [42=\<gtr\>99.1,foo=\<gtr\>77]

    \<gtr\> h!foo;

    77

    \<gtr\> h!!keys h;

    [99.1,77]

    \;
  </verbatim>

  Multidicts work in pretty much the same fashion, but allow more than one
  value for a given key to be stored in the dictionary. In this case, the
  indexing operation returns a list of all values for the given key, which
  may be empty if the key is not in the dictionary (rather than throwing an
  <hlink|<with|font-family|tt|out_of_bounds>|#out-of-bounds> exception):

  <\verbatim>
    \;

    \<gtr\> let d::mdict = mdict ["foo"=\<gtr\>77,"bar"=\<gtr\>99.1,"foo"=\<gtr\>99];

    \<gtr\> d!"foo"; d!"baz";

    [77,99]

    []

    \;
  </verbatim>

  Slicing thus returns a list of lists of values here:

  <\verbatim>
    \;

    \<gtr\> d!!["foo","bar","baz"];

    [[77,99],[99.1],[]]

    \;
  </verbatim>

  To obtain a flat list you can just concatenate the results:

  <\verbatim>
    \;

    \<gtr\> cat $ d!!["foo","bar","baz"];

    [77,99,99.1]

    \;
  </verbatim>

  Hashed multidicts provide both key hashing and multiple values per key:

  <\verbatim>
    \;

    \<gtr\> let h::hmdict = hmdict [foo=\<gtr\>77,42=\<gtr\>99.1,42=\<gtr\>77];

    \<gtr\> keys h; vals h; members h;

    [42,42,foo]

    [99.1,77,77]

    [42=\<gtr\>99.1,42=\<gtr\>77,foo=\<gtr\>77]

    \<gtr\> h!42;

    [99.1,77]

    \;
  </verbatim>

  There are also some set-like operations which allow you to add/remove the
  members (<verbatim|key=\>val> pairs) of one dictionary to/from another
  dictionary, and to compute the intersection of two dictionaries. For
  instance:

  <\verbatim>
    \;

    \<gtr\> let h1 = hmdict [a=\<gtr\>1,b=\<gtr\>2];

    \<gtr\> let h2 = hmdict [b=\<gtr\>2,c=\<gtr\>3];

    \<gtr\> members (h1+h2);

    [a=\<gtr\>1,c=\<gtr\>3,b=\<gtr\>2,b=\<gtr\>2]

    \<gtr\> members (h1-h2);

    [a=\<gtr\>1]

    \<gtr\> members (h1*h2);

    [b=\<gtr\>2]

    \;
  </verbatim>

  It's possible to mix dictionaries of different types in these operations.
  The necessary conversions are handled automatically:

  <\verbatim>
    \;

    \<gtr\> let h1 = hmdict [a=\<gtr\>1,b=\<gtr\>2];

    \<gtr\> let h2 = hdict \ [b=\<gtr\>3,c=\<gtr\>4];

    \<gtr\> members (h1+h2);

    [a=\<gtr\>1,c=\<gtr\>4,b=\<gtr\>2,b=\<gtr\>3]

    \;
  </verbatim>

  Note that the result will always be promoted to the most general operand
  type in such cases (a hashed multidict in the above example). If this is
  not what you want, you'll have to apply the necessary conversions manually:

  <\verbatim>
    \;

    \<gtr\> members (hdict h1+h2);

    [a=\<gtr\>1,c=\<gtr\>4,b=\<gtr\>3]

    \;
  </verbatim>

  <label|module-set><subsubsection|Sets and
  Bags><label|sets-and-bags><label|sets-and-bags>

  The set.pure module implements Pure's set data types based on AVL trees.
  These work pretty much like dictionaries (cf.
  <hlink|Dictionaries|#dictionaries>) but only store keys (called
  \Pelements\Q or \Pmembers\Q here) without any associated data values. Hence
  sets provide membership tests like dictionaries, but no indexing
  operations.

  There are four variations of this data structure to choose from, depending
  on whether the set members are ordered or hashed, and whether multiple
  instances of the same element are allowed (in this case the set is actually
  called a <em|multiset> or a <em|bag>).

  <\description>
    <item*|<em|type> set<label|set/type>>

    <item*|<em|type> bag<label|bag/type>>These implement the ordered set
    types. They require that members be ordered, i.e., the predicate
    <verbatim|\<> must be defined on them.
  </description>

  <\description>
    <item*|<em|type> hset<label|hset/type>>

    <item*|<em|type> hbag<label|hbag/type>>These implement the hashed set
    types which don't require an order of the members. Distinct members are
    stored in an apparently random order.
  </description>

  <\description>
    <item*|<em|type> xset<label|xset/type>>This is just an abstract supertype
    for matching any kind of set or bag provided by this module.
  </description>

  The usual comparison predicates (<hlink|<with|font-family|tt|==>|#==>,
  <hlink|<with|font-family|tt|<math|\<sim\>>=>|#-tilde=>,
  <hlink|<with|font-family|tt|\<less\>=>|#\<=>,
  <hlink|<with|font-family|tt|\<less\>>|#\<> etc.) are defined on all set and
  bag types, where two sets or bags are considered \Pequal\Q
  (<verbatim|m1==m2>) if they both contain the same elements, and
  <verbatim|m1\<=m2> means that <verbatim|m1> is a subset or subbag of
  <verbatim|m2>, i.e., all elements of <verbatim|m1> are also contained in
  <verbatim|m2> (taking into account multiplicities in the multiset case).
  Ordered sets and bags compare elements using equality (considering two
  elements <verbatim|a> and <verbatim|b> to be equal if neither
  <verbatim|a\<b> nor <verbatim|b\<a> holds), while hashed sets and bags
  check for syntactical equality (using <hlink|<with|font-family|tt|===>|#===>).

  The underlying AVL tree data structure can be found in the avltrees.pure
  module which is included in the library, but not to be invoked directly.
  The AVL tree algorithm has its origin in the SWI-Prolog implementation of
  association lists and was ported to Pure by Jiri Spitz, see
  <hlink|Dictionaries|#dictionaries> for details.

  Imports

  To use the operations of this module, add the following import declaration
  to your program:

  <\verbatim>
    \;

    using set;

    \;
  </verbatim>

  Operations

  <\description>
    <item*|emptyset<label|emptyset>>

    <item*|emptybag<label|emptybag>>

    <item*|emptyhset<label|emptyhset>>

    <item*|emptyhbag<label|emptyhbag>>return an empty set or bag
  </description>

  <\description>
    <item*|set xs<label|set>>

    <item*|bag xs<label|bag>>

    <item*|hset xs<label|hset>>

    <item*|hbag xs<label|hbag>>create a set or bag of the corresponding type
    from a list or another set or bag <verbatim|xs>; in the latter case the
    argument is converted to a set or bag of the desired target type
  </description>

  <\description>
    <item*|setp m<label|setp>>

    <item*|bagp m<label|bagp>>

    <item*|hsetp m<label|hsetp>>

    <item*|hbagp m<label|hbagp>>check whether <verbatim|m> is a set or bag of
    the corresponding type
  </description>

  <\description>
    <item*|m1 + m2<label|+/set>>union/sum: <verbatim|m1+m2> adds the members
    of <verbatim|m2> to <verbatim|m1>
  </description>

  <\description>
    <item*|m1 - m2<label|-/set>>difference: <verbatim|m1-m2> removes the
    members of <verbatim|m2> from <verbatim|m1>
  </description>

  <\description>
    <item*|m1 * m2<label|*/set>>intersection: <verbatim|m1*m2> removes the
    members <em|not> in <verbatim|m2> from <verbatim|m1>
  </description>

  <\description>
    <item*|# m<label|#/set>>size of a set or bag <verbatim|m>
  </description>

  <\description>
    <item*|null m<label|null/set>>test whether <verbatim|m> is an empty set
    or bag
  </description>

  <\description>
    <item*|member m x<label|member/set>>test whether <verbatim|m> contains
    <verbatim|x>
  </description>

  <\description>
    <item*|members m<label|members/set>>

    <item*|list m<label|list/set>>list the members of <verbatim|m> (in
    ascending order for ordered sets and bags)
  </description>

  <\description>
    <item*|first m<label|first/set>>

    <item*|last m<label|last/set>>return the first and the last member of
    <verbatim|m>, respectively
  </description>

  <\description>
    <item*|rmfirst m<label|rmfirst/set>>

    <item*|rmlast m<label|rmlast/set>>remove the first and the last member
    from <verbatim|m>, respectively
  </description>

  <\description>
    <item*|insert m x<label|insert/set>>insert <verbatim|x> into <verbatim|m>
    (replaces an existing element in the case of a set)
  </description>

  <\description>
    <item*|delete m x<label|delete/set>>remove <verbatim|x> from <verbatim|m>
    (in the bag case, only the first instance of <verbatim|x> is removed)
  </description>

  <\description>
    <item*|delete_all m x<label|delete-all/set>>remove all instances of
    <verbatim|x> from <verbatim|m> (in the set case, this is just the same as
    <hlink|<with|font-family|tt|delete>|#delete/set>)
  </description>

  <with|font-series|bold|Note:> The infix operators
  (<hlink|<with|font-family|tt|+>|#+/set>,
  <hlink|<with|font-family|tt|->|#-/set>,
  <hlink|<with|font-family|tt|*>|#*/set>, as well as the comparison
  operations) allow you to mix arbitrary operand types; the necessary
  conversions from less general set types (ordered, set) to more general
  types (hashed, multiset) are handled automatically.

  Also note that in the case of sets, <hlink|<with|font-family|tt|+>|#+/set>
  is just the ordinary set union. There are basically two generalizations of
  this operation to bags, <with|font-series|bold|multiset union> and
  <with|font-series|bold|multiset sum>; <hlink|<with|font-family|tt|+>|#+/set>
  implements the <em|latter>. Thus, if a bag <verbatim|m1> contains
  <verbatim|k1> instances of an element <verbatim|x> and a bag <verbatim|m2>
  contains <verbatim|k2> instances of <verbatim|x>, then <verbatim|m1+m2>
  contains <verbatim|k1+k2> instances of <verbatim|x> (rather than
  <verbatim|max> <verbatim|k1> <verbatim|k2> instances, which would be the
  case for multiset union). Multiset sum is probably more common in practical
  applications, and also generalizes easily to multidicts (see
  <hlink|Dictionaries|#dictionaries>). However, if multiset union is needed,
  it can easily be defined in terms of multiset sum as follows:

  <\verbatim>
    \;

    union m1 m2 = m1+(m2-m1);

    \;
  </verbatim>

  Examples

  Some basic set operations:

  <\verbatim>
    \;

    \<gtr\> let m::set = set [5,1,3,11,3];

    \<gtr\> members m;

    [1,3,5,11]

    \<gtr\> map (member m) (1..5);

    [1,0,1,0,1]

    \<gtr\> members $ m+set (3..6);

    [1,3,4,5,6,11]

    \<gtr\> members $ m-set (3..6);

    [1,11]

    \<gtr\> members $ m*set (3..6);

    [3,5]

    \;
  </verbatim>

  The bag operations work in a similar fashion, but multiple instances are
  permitted in this case, and each instance counts as a separate member:

  <\verbatim>
    \;

    \<gtr\> let m::bag = bag [5,1,3,11,3];

    \<gtr\> members m;

    [1,3,3,5,11]

    \<gtr\> members $ delete m 3;

    [1,3,5,11]

    \<gtr\> members $ insert m 1;

    [1,1,3,3,5,11]

    \<gtr\> members $ m+bag (3..6);

    [1,3,3,3,4,5,5,6,11]

    \<gtr\> members $ m-bag (3..6);

    [1,3,11]

    \<gtr\> members $ m*bag (3..6);

    [3,5]

    \;
  </verbatim>

  As already mentioned, operands of different types can be mixed with the
  infix operators; the necessary conversions are handled automatically. E.g.,
  here's how you add a set to a bag:

  <\verbatim>
    \;

    \<gtr\> let m1::bag = bag [5,1,3,11,3];

    \<gtr\> let m2::set = set (3..6);

    \<gtr\> members (m1+m2);

    [1,3,3,3,4,5,5,6,11]

    \;
  </verbatim>

  Note that the result will always be promoted to the most general operand
  type in such cases (a bag in the above example). If this is not what you
  want, you'll have to apply the necessary conversions manually:

  <\verbatim>
    \;

    \<gtr\> members (set m1+m2);

    [1,3,4,5,6,11]

    \;
  </verbatim>

  If set members aren't ordered then you'll get an exception when trying to
  create an ordered set or bag from them:

  <\verbatim>
    \;

    \<gtr\> set [a,b,c];

    \<less\>stdin\<gtr\>, line 5: unhandled exception 'failed_cond' while
    evaluating

    'set [a,b,c]'

    \;
  </verbatim>

  In such a case hashed sets and bags must be used instead. These work
  analogously to the ordered sets and bags, but distinct members are stored
  in an apparently random order:

  <\verbatim>
    \;

    \<gtr\> members $ hset [a,b,c] * hset [c,d,e];

    [c]

    \<gtr\> members $ hbag [a,b,c] + hbag [c,d,e];

    [a,c,c,b,d,e]

    \;
  </verbatim>

  <label|module-system><subsection|System
  Interface><label|system-interface><label|system-interface>

  This module offers some useful system routines, straight from the C
  library, as well as some convenience functions for wrapping these up in
  Pure. Even the \Ppurest\Q program needs to do some basic I/O every once in
  a while, and this module provides the necessary stuff to do just that. The
  operations provided in this module should work (if necessary by a suitable
  emulation) on all supported systems. Most of the following functions are
  extensively documented in the C library manual pages, so we concentrate on
  the Pure-specific aspects here.

  <subsubsection|Imports>

  To use the operations of this module, add the following import declaration
  to your program:

  <\verbatim>
    \;

    using system;

    \;
  </verbatim>

  Some functions of the system interface are provided in separate modules;
  see <hlink|Regex Matching|#regex-matching>, <hlink|Additional POSIX
  Functions|#additional-posix-functions> and <hlink|Option
  Parsing|#option-parsing>.

  <subsubsection|Errno and Friends><label|errno-and-friends>

  <\description>
    <item*|errno<label|errno>>

    <item*|set_errno n<label|set-errno>>

    <item*|perror msg<label|perror>>

    <item*|strerror n<label|strerror>>This value and the related routines are
    indispensable to give proper diagnostics when system calls fail for some
    reason. Note that, by its very nature,
    <hlink|<with|font-family|tt|errno>|#errno> is a fairly volatile value,
    don't expect it to survive a return to the command line in interactive
    sessions.
  </description>

  Example:

  <\verbatim>
    \;

    \<gtr\> using system;

    \<gtr\> fopen "junk" "r", perror "junk";

    junk: No such file or directory

    fopen "junk" "r"

    \;
  </verbatim>

  <subsubsection|POSIX Locale><label|posix-locale>

  <\description>
    <item*|setlocale category locale<label|setlocale>>Set or retrieve the
    current locale.
  </description>

  Details are platform-specific, but you can expect that at least the
  categories <verbatim|LC_ALL>, <verbatim|LC_COLLATE>, <verbatim|LC_CTYPE>,
  <verbatim|LC_MONETARY>, <verbatim|LC_NUMERIC> and <verbatim|LC_TIME> are
  defined, as well as the following values for the locale parameter:
  <verbatim|"C"> or <verbatim|"POSIX"> (the default POSIX locale),
  <verbatim|""> (the system default locale), and
  <hlink|<with|font-family|tt|NULL>|#NULL>, to just query the current locale.

  Other string values which can be passed as the locale argument depend on
  the implementation, please check your local setlocale(3) documentation for
  details. If locale is not <hlink|<with|font-family|tt|NULL>|#NULL>, the
  current locale is changed accordingly. The return value is the new locale,
  or the current locale when passing <hlink|<with|font-family|tt|NULL>|#NULL>
  for the locale parameter. In either case, the string returned by
  <hlink|<with|font-family|tt|setlocale>|#setlocale> is such that it can be
  passed to <hlink|<with|font-family|tt|setlocale>|#setlocale> to restore the
  same locale again. In case of an error,
  <hlink|<with|font-family|tt|setlocale>|#setlocale> fails (rather than
  returning a null pointer).

  Please note that calling this function alters the Pure interpreter's idea
  of what the current locale is. When the interpreter starts up, it always
  sets the default system locale. Unless your scripts rely on a specific
  encoding, setting the locale to either <verbatim|"C"> or <verbatim|"">
  should always be safe.

  Example:

  <\verbatim>
    \;

    \<gtr\> setlocale LC_ALL NULL;

    "en_US.UTF-8"

    \;
  </verbatim>

  <subsubsection|Signal Handling><label|signal-handling>

  <\description>
    <item*|trap action sig<label|trap>>Establish or remove Pure signal
    handlers.
  </description>

  The action parameter of <hlink|<with|font-family|tt|trap>|#trap> can be one
  of the predefined integer values <verbatim|SIG_TRAP>, <verbatim|SIG_IGN>
  and <verbatim|SIG_DFL>. <verbatim|SIG_TRAP> causes the given signal to be
  handled by mapping it to a Pure exception of the form <verbatim|signal>
  <verbatim|sig>. <verbatim|SIG_IGN> ignores the signal, <verbatim|SIG_DFL>
  reverts to the system's default handling. See <verbatim|show> <verbatim|-g>
  <verbatim|SIG*> for a list of known signal values on your system.

  Note: When the interpreter runs interactively, most standard termination
  signals (<verbatim|SIGINT>, <verbatim|SIGTERM>, etc.) are already set up to
  report corresponding Pure exceptions; if this is not desired, you can use
  <hlink|<with|font-family|tt|trap>|#trap> to either ignore these or revert
  to the default handlers instead.

  See <hlink|<em|Exception Handling>|pure.tm#exception-handling> in the Pure
  Manual for details and examples.

  <subsubsection|Time Functions><label|time-functions>

  The usual date/time functions from the C library are all provided. This
  includes some functions to retrieve wallclock and cpu time which usually
  offer much better resolution than the venerable
  <hlink|<with|font-family|tt|time>|#time> function.

  <\description>
    <item*|time<label|time>>Reports the current time in seconds since the
    <with|font-series|bold|epoch>, 00:00:00 UTC, Jan 1 1970. The result is
    always a bigint (in fact, the <hlink|<with|font-family|tt|time>|#time>
    value is already 64 bit on many OSes nowadays).
  </description>

  <\description>
    <item*|gettimeofday<label|gettimeofday>>Returns wallclock time as seconds
    since the epoch, like <hlink|<with|font-family|tt|time>|#time>, but
    theoretically offers resolutions in the microsec range (actual
    resolutions vary, but are usually in the msec range for contemporary
    systems). The result is returned as a double value (which also limits
    precision). This function may actually be implemented through different
    system calls, depending on what's available on the host OS.
  </description>

  <\description>
    <item*|clock<label|clock>>Returns the current CPU (not wallclock) time
    since an arbitrary point in the past, as a machine int. The number of
    \Pticks\Q per second is given by the <verbatim|CLOCKS_PER_SEC> constant.
    Note that this value will wrap around approximately every 72 minutes.
  </description>

  <\description>
    <item*|sleep t<label|sleep>>

    <item*|nanosleep t<label|nanosleep>>Suspend execution for a given time
    interval in seconds. <hlink|<with|font-family|tt|sleep>|#sleep> takes
    integer (int/bigint) arguments only and uses the <verbatim|sleep()>
    system function. <hlink|<with|font-family|tt|nanosleep>|#nanosleep> also
    accepts double arguments and theoretically supports resolutions down to 1
    nanosecond (again, actual resolutions vary). This function may actually
    be implemented through different system calls, depending on what's
    available on the host OS. Both functions usually return zero, unless the
    sleep was interrupted by a signal, in which case the time remaining to be
    slept is returned.
  </description>

  Examples:

  <\verbatim>
    \;

    \<gtr\> time,sleep 1,time;

    1270241703L,0,1270241704L

    \<gtr\> gettimeofday,nanosleep 0.1,gettimeofday;

    1270241709.06338,0.0,1270241709.16341

    \;
  </verbatim>

  Here's a little macro which lets you time evaluations:

  <\verbatim>
    \;

    def timex x = y,(t2-t1)/CLOCKS_PER_SEC when

    \ \ t1 = clock; y = x; t2 = clock;

    end;

    \;
  </verbatim>

  Example:

  <\verbatim>
    \;

    \<gtr\> timex (foldl (+) 0 (1..100000));

    705082704,0.07

    \;
  </verbatim>

  <\description>
    <item*|tzset<label|tzset>>Initialize timezone information.
  </description>

  <\description>
    <item*|<em|variable> tzname<label|tzname>>

    <item*|<em|variable> timezone<label|timezone>>

    <item*|<em|variable> daylight<label|daylight>>The timezone information.
  </description>

  The <hlink|<with|font-family|tt|tzset>|#tzset> function calls the
  corresponding routine from the C library and initializes the (Pure)
  variables <hlink|<with|font-family|tt|tzname>|#tzname>,
  <hlink|<with|font-family|tt|timezone>|#timezone> and
  <hlink|<with|font-family|tt|daylight>|#daylight> accordingly. See the
  tzset(3) manual page for details. This routine is also called automatically
  when the system module is loaded, so you only have to invoke it to get
  up-to-date information after changes to the locale or the timezone.
  Example:

  <\verbatim>
    \;

    \<gtr\> tzset;

    ()

    \<gtr\> tzname, timezone, daylight;

    ["CET","CEST"],-3600,1

    \<gtr\> tzname!daylight;

    "CEST"

    \;
  </verbatim>

  The following functions deal with date/time values in string and
  \Pbroken-down\Q time format. See the ctime(3), gmtime(3), localtime(3),
  mktime(3), asctime(3), strftime(3) and strptime(3) manual pages for
  details.

  <\description>
    <item*|ctime t<label|ctime>>Convert a time value as returned by the
    <hlink|<with|font-family|tt|time>|#time> function to a string in local
    time.
  </description>

  <\description>
    <item*|gmtime t<label|gmtime>>

    <item*|localtime t<label|localtime>>Convert a time value to UTC or local
    time in \Pbroken-down\Q form (a static pointer to a <verbatim|tm> struct
    containing a bunch of <verbatim|int> fields) which can then be passed to
    the <hlink|<with|font-family|tt|asctime>|#asctime> and
    <hlink|<with|font-family|tt|strftime>|#strftime> functions, or to
    <hlink|<with|font-family|tt|int_matrix>|#int-matrix> if you want to
    convert the data to a matrix; see the example below.
  </description>

  <\description>
    <item*|mktime tm<label|mktime>>Converts broken-down time to a time value
    (seconds since the epoch). As with <hlink|<with|font-family|tt|time>|#time>,
    the result is always a bigint.
  </description>

  <\description>
    <item*|asctime tm<label|asctime>>

    <item*|strftime format tm<label|strftime>>Format broken-down time as a
    string. <hlink|<with|font-family|tt|strftime>|#strftime> also uses a
    format string supplied by the user, see below for a list of the most
    important conversion specifiers.
  </description>

  <\description>
    <item*|strptime s format tm<label|strptime>>Parse a date/time string
    <verbatim|s> according to the given format (using more or less the same
    format specifiers as the <hlink|<with|font-family|tt|strftime>|#strftime>
    function) and store the broken-down time result in the given
    <verbatim|tm> struct. This function may fail, e.g., if
    <hlink|<with|font-family|tt|strptime>|#strptime> finds an error in the
    format string. Otherwise it returns the part of the string which wasn't
    processed, see the example below.
  </description>

  Examples:

  <\verbatim>
    \;

    \<gtr\> let t = time; t;

    1270239790L

    \<gtr\> let tm = localtime t; tm;

    #\<less\>pointer 0x7ff97ecbdde0\<gtr\>

    \<gtr\> mktime tm;

    1270239790L

    \<gtr\> asctime tm;

    "Fri Apr \ 2 22:23:10 2010\\n"

    \<gtr\> int_matrix 9 tm;

    {10,23,22,2,3,110,5,91,1}

    \<gtr\> strftime "%c" tm;

    "Fri 02 Apr 2010 10:23:10 PM CEST"

    \<gtr\> strptime ans "%c" tm, int_matrix 9 tm;

    "CEST",{10,23,22,2,3,110,5,91,1}

    \;
  </verbatim>

  In the above example, <hlink|<with|font-family|tt|strptime>|#strptime> was
  given a static pointer to a <verbatim|tm> struct returned by
  <hlink|<with|font-family|tt|localtime>|#localtime>. This always works, but
  in some situations it may be preferable to allocate dynamic storage
  instead. This storage should be properly initialized (zeroed out) before
  passing it to <hlink|<with|font-family|tt|strptime>|#strptime>, since
  <hlink|<with|font-family|tt|strptime>|#strptime> only stores the values
  specified (at least in principle; please consult your local C library
  documentation for details). Also note that while POSIX only specifies nine
  <verbatim|int> fields in a <verbatim|tm> struct, depending on the host
  operating system the struct may contain additional public and private
  fields. The actual size of a <verbatim|tm> struct is given by the
  <verbatim|SIZEOF_TM> constant, so a safe way to allocate suitable dynamic
  storage for the <hlink|<with|font-family|tt|strptime>|#strptime> function
  is as follows:

  <\verbatim>
    \;

    \<gtr\> let tm = pointer_cast "int*" $ calloc 1 SIZEOF_TM;

    \<gtr\> strptime "4/2/10" "%D" tm, int_matrix 9 tm;

    "",{0,0,0,2,3,110,5,91,0}

    \;
  </verbatim>

  Instead of explicitly allocating dynamic storage and converting it to a
  Pure matrix later, you can also invoke <hlink|<with|font-family|tt|strptime>|#strptime>
  directly with an int matrix of sufficient size:

  <\verbatim>
    \;

    \<gtr\> let tm = imatrix (SIZEOF_TM div SIZEOF_INT + 1);

    \<gtr\> strptime "4/2/10" "%D" tm, take 9 tm;

    "",{0,0,0,2,3,110,5,91,0}

    \;
  </verbatim>

  Last but not least, to make calling <hlink|<with|font-family|tt|strptime>|#strptime>
  more convenient, you can supply your own little wrapper function which
  takes care of allocating the storage, e.g.:

  <\verbatim>
    \;

    mystrptime s format = s,take 9 tm when

    \ \ tm = imatrix (SIZEOF_TM div SIZEOF_INT + 1);

    \ \ s = strptime s format tm;

    end;

    \;

    \<gtr\> mystrptime "4/2/10" "%D";

    "",{0,0,0,2,3,110,5,91,0}

    \;
  </verbatim>

  Here is a list of some common format specifiers which can be used with the
  <hlink|<with|font-family|tt|strftime>|#strftime> and
  <hlink|<with|font-family|tt|strptime>|#strptime> routines. These are all
  specified by POSIX and should thus be available on most platforms. Note
  that many more formats are usually supported than what is listed here, so
  please consult your local manual pages for the complete list.

  <\itemize>
    <item><verbatim|%d>, <verbatim|%m>, <verbatim|%y>: Day of the month,
    month and year as decimal two-digit numbers.

    <item><verbatim|%Y>: The year as a four-digit number which includes the
    century.

    <item><verbatim|%H>, <verbatim|%M>, <verbatim|%S>: Hours (range
    <verbatim|00> to <verbatim|23>), minutes and seconds as decimal two-digit
    numbers.

    <item><verbatim|%I>: The hours on a 12-hour clock (range <verbatim|01> to
    <verbatim|12>).
  </itemize>

  The following formats are locale-dependent:

  <\itemize>
    <item><verbatim|%a>, <verbatim|%A>: Abbreviated and full weekday name.

    <item><verbatim|%b>, <verbatim|%B>: Abbreviated and full month name.

    <item><verbatim|%p>: AM or PM. <verbatim|%P> is the same in lowercase
    (<verbatim|strftime> only).
  </itemize>

  There are also some useful meta-formats which specify various combinations
  of the above:

  <\itemize>
    <item><verbatim|%c>: The preferred date and time representation for the
    current locale.

    <item><verbatim|%D>: The American date format (<verbatim|%m/%d/%y>).

    <item><verbatim|%F>: The ISO 8601 date format (<verbatim|%Y-%m-%d>).
    (This is generally supported by <hlink|<with|font-family|tt|strftime>|#strftime>
    only, but <hlink|<with|font-family|tt|strptime>|#strptime> from GNU libc
    has it.)

    <item><verbatim|%r>: The time in AM/PM notation (<verbatim|%I:%M:%S>
    <verbatim|%p>).

    <item><verbatim|%R>: The time in 24-hour notation (<verbatim|%H:%M>).

    <item><verbatim|%T>: The time in 24-hour notation, including seconds
    (<verbatim|%H:%M:%S>).
  </itemize>

  In addition, <verbatim|%%> denotes a literal <verbatim|%> character,
  <verbatim|%n> newlines and <verbatim|%t> tabs. (For
  <hlink|<with|font-family|tt|strptime>|#strptime> the latter two are
  synonymous and match arbitrary whitespace.)

  Windows users should note that <hlink|<with|font-family|tt|strptime>|#strptime>
  isn't natively supported there. A basic emulation is provided by the Pure
  runtime, but at present this only supports the C locale.

  <subsubsection|Process Functions><label|process-functions>

  The following process functions are available on all systems. (Some
  additional process-related functions such as
  <hlink|<with|font-family|tt|fork>|#fork>,
  <hlink|<with|font-family|tt|kill>|#kill>,
  <hlink|<with|font-family|tt|wait>|#wait> and
  <hlink|<with|font-family|tt|waitpid>|#waitpid> are available in the
  <hlink|<with|font-family|tt|posix>|#module-posix> module, see
  <hlink|Additional POSIX Functions|#additional-posix-functions>.)

  <\description>
    <item*|system cmd<label|system>>Execute a shell command.
  </description>

  <\description>
    <item*|execv prog argv<label|execv>>

    <item*|execvp prog argv<label|execvp>>

    <item*|execve prog argv envp<label|execve>>Execute a new process.
    <verbatim|prog> denotes the name of the executable to be run,
    <verbatim|argv> the argument vector (which repeats the program name in
    the first component), and <verbatim|envp> a vector of environment strings
    of the form <verbatim|"var=value">. The
    <hlink|<with|font-family|tt|execv>|#execv> function executes the program
    <verbatim|prog> exactly as given, while
    <hlink|<with|font-family|tt|execvp>|#execvp> also performs a path search.
    The <hlink|<with|font-family|tt|execve>|#execve> function is like
    <hlink|<with|font-family|tt|execv>|#execv>, but also specifies an
    environment to be passed to the process. In either case, the new process
    replaces the current process. For convenience, both <verbatim|argv> and
    <verbatim|envp> can be specified as a Pure string vector or a list, which
    is automatically translated to the raw,
    <hlink|<with|font-family|tt|NULL>|#NULL>-terminated C string vectors
    (i.e., <verbatim|char**>) required by the underlying C functions.
  </description>

  <\description>
    <item*|spawnv mode prog argv<label|spawnv>>

    <item*|spawnvp mode prog argv<label|spawnvp>>

    <item*|spawnve mode prog argv envp<label|spawnve>>Spawn a new child
    process. These work like the corresponding MS Windows functions; on Un*x
    systems this functionality is implemented using a combination of
    <hlink|<with|font-family|tt|fork>|#fork> and
    <hlink|<with|font-family|tt|execv>|#execv>. The arguments are the same as
    for the <hlink|<with|font-family|tt|execv>|#execv> functions, except that
    there's an additional <verbatim|mode> argument which specifies how the
    process is to be executed: <verbatim|P_WAIT> waits for the process to
    finish, after which <hlink|<with|font-family|tt|spawnv>|#spawnv> returns
    with the exit status of the terminated child process; <verbatim|P_NOWAIT>
    makes <hlink|<with|font-family|tt|spawnv>|#spawnv> return immediately,
    returning the process id; and <verbatim|P_OVERLAY> causes the child
    process to replace its parent, just like with
    <hlink|<with|font-family|tt|execv>|#execv>. (On Windows, there's an
    additional <verbatim|P_DETACH> flag which works like <verbatim|P_NOWAIT>
    but also turns the child process into a background task.)
  </description>

  Note that, in addition, the prelude provides the
  <hlink|<with|font-family|tt|exit>|#exit> function which terminates the
  program with a given exit code, cf. <hlink|Other Special
  Primitives|#other-special-primitives>.

  Examples:

  <\verbatim>
    \;

    \<gtr\> system "pwd";

    /home/ag/svn/pure-lang/trunk/pure/lib

    0

    \<gtr\> spawnvp P_WAIT "pwd" ["pwd"];

    /home/ag/svn/pure-lang/trunk/pure/lib

    0

    \<gtr\> spawnv P_WAIT "/bin/sh" ["/bin/sh","-c","pwd"];

    /home/ag/svn/pure-lang/trunk/pure/lib

    0

    \;
  </verbatim>

  <subsubsection|Basic I/O Interface><label|basic-i-o-interface>

  Note that this module also defines the standard I/O streams
  <hlink|<with|font-family|tt|stdin>|#stdin>,
  <hlink|<with|font-family|tt|stdout>|#stdout> and
  <hlink|<with|font-family|tt|stderr>|#stderr> as variables on startup. These
  are ready to be used with the operations described below. Also note that
  for convenience some of the following routines are actually Pure wrappers,
  rather than just providing the raw C library routines.

  <\description>
    <item*|<em|variable> stdin<label|stdin>>

    <item*|<em|variable> stdout<label|stdout>>

    <item*|<em|variable> stderr<label|stderr>>The standard I/O streams.
  </description>

  <\description>
    <item*|fopen name mode<label|fopen>>

    <item*|popen cmd mode<label|popen>>Open a file or a pipe. These take care
    of closing a file object automagically when it's garbage-collected, and
    fail (instead of returning a null pointer) in case of error, so that you
    can provide any desired error handling simply by adding suitable
    equations.
  </description>

  <\description>
    <item*|fdopen fd mode<label|fdopen>>Associates a file object with a given
    existing file descriptor. Otherwise works like
    <hlink|<with|font-family|tt|fopen>|#fopen>, so the resulting file is
    closed automatically when it's garbage-collected.
  </description>

  <\description>
    <item*|freopen path mode fp<label|freopen>>Reopens a file object. The
    existing file object is closed. Otherwise works like
    <hlink|<with|font-family|tt|fopen>|#fopen>, so the resulting file is
    closed automatically when it's garbage-collected.
  </description>

  <\description>
    <item*|fclose fp<label|fclose>>

    <item*|pclose fp<label|pclose>>Close a file or a pipe.
  </description>

  <\description>
    <item*|tmpfile<label|tmpfile>>Creates a unique temporary file (opened in
    <verbatim|"w+b"> mode) which gets deleted automatically when it is closed
    or the file object gets garbage-collected.
  </description>

  <\description>
    <item*|feof fp<label|feof>>

    <item*|ferror fp<label|ferror>>

    <item*|clearerr fp<label|clearerr>>Check the end-of-file and error bits.
    <hlink|<with|font-family|tt|clearerr>|#clearerr> clears the error bit.
  </description>

  <\description>
    <item*|fileno fp<label|fileno>>Returns the file descriptor associated
    with the given file.
  </description>

  <\description>
    <item*|fflush fp<label|fflush>>Flushes the given file (or all open files
    if <verbatim|fp> is <hlink|<with|font-family|tt|NULL>|#NULL>).
  </description>

  <\description>
    <item*|fgets fp<label|fgets>>

    <item*|gets<label|gets>>Pure wrappers for the C <verbatim|fgets> and
    <verbatim|gets> functions which handle the necessary buffering
    automatically.
  </description>

  <\description>
    <item*|fget fp<label|fget>>A variation of
    <hlink|<with|font-family|tt|fgets>|#fgets> which slurps in an entire text
    file at once.
  </description>

  <\description>
    <item*|fputs s fp<label|fputs>>

    <item*|puts s<label|puts>>Output a string to the given file or
    <hlink|<with|font-family|tt|stdout>|#stdout>, respectively. These are
    just the plain C functions. Note that
    <hlink|<with|font-family|tt|puts>|#puts> automatically adds a newline,
    while <hlink|<with|font-family|tt|fputs>|#fputs> doesn't. Hmm.
  </description>

  <\description>
    <item*|fread ptr size nmemb fp<label|fread>>

    <item*|fwrite ptr size nmemb fp<label|fwrite>>Binary read/writes. Here
    you'll have to manage the buffers yourself. See the corresponding manual
    pages for details.
  </description>

  <\description>
    <item*|fseek fp offset whence<label|fseek>>

    <item*|ftell fp<label|ftell>>

    <item*|rewind fp<label|rewind>>Reposition the file pointer and retrieve
    its current value. The constants <verbatim|SEEK_SET>, <verbatim|SEEK_CUR>
    and <verbatim|SEEK_END> can be used for the <verbatim|whence> argument of
    <hlink|<with|font-family|tt|fseek>|#fseek>. The call <verbatim|rewind>
    <verbatim|fp> is equivalent to <verbatim|fseek> <verbatim|fp>
    <verbatim|0> <verbatim|SEEK_SET> (except that the latter also returns a
    result code). See the corresponding manual pages for details.
  </description>

  <\description>
    <item*|setbuf fp buf<label|setbuf>>

    <item*|setvbuf fp buf mode size<label|setvbuf>>Set the buffering of a
    file object, given as the first argument. The second argument specifies
    the buffer, which must be a pointer to suitably allocated memory or
    <hlink|<with|font-family|tt|NULL>|#NULL>. The <verbatim|mode> argument of
    <hlink|<with|font-family|tt|setvbuf>|#setvbuf> specifies the buffering
    mode, which may be one of the predefined constants <verbatim|_IONBF>,
    <verbatim|_IOLBF> and <verbatim|_IOFBF> denoting no buffering, line
    buffering and full (a.k.a. block) buffering, respectively; the
    <verbatim|size> argument denotes the buffer size.

    For <hlink|<with|font-family|tt|setbuf>|#setbuf>, the given buffer must
    be able to hold <verbatim|BUFSIZ> characters, where <verbatim|BUFSIZ> is
    a constant defined by this module. <verbatim|setbuf> <verbatim|fp>
    <verbatim|buf> is actually equivalent to the following call (except that
    <hlink|<with|font-family|tt|setvbuf>|#setvbuf> also returns an integer
    return value):

    <\verbatim>
      \;

      setvbuf fp buf (if null buf then _IONBF else _IOFBF) BUFSIZ

      \;
    </verbatim>

    Please see the setbuf(3) manual page for details.
  </description>

  Examples:

  <\verbatim>
    \;

    \<gtr\> puts "Hello, world!";

    Hello, world!

    14

    \;

    \<gtr\> map fileno [stdin,stdout,stderr];

    [0,1,2]

    \;

    \<gtr\> let fp = fopen "/etc/passwd" "r";

    \<gtr\> fgets fp;

    "at:x:25:25:Batch jobs daemon:/var/spool/atjobs:/bin/bash\\n"

    \<gtr\> fgets fp;

    "avahi:x:103:104:User for Avahi:/var/run/avahi-daemon:/bin/false\\n"

    \<gtr\> ftell fp;

    121L

    \<gtr\> rewind fp;

    ()

    \<gtr\> fgets fp;

    "at:x:25:25:Batch jobs daemon:/var/spool/atjobs:/bin/bash\\n"

    \;

    \<gtr\> split "\\n" $ fget $ popen "ls *.pure" "r";

    ["array.pure","dict.pure","getopt.pure","heap.pure","math.pure",

    "matrices.pure","prelude.pure","primitives.pure","quasiquote.pure",

    "set.pure","strings.pure","system.pure",""]

    \;
  </verbatim>

  C-style formatted I/O is provided through the following wrappers for the C
  <verbatim|printf> and <verbatim|scanf> functions. These wrapper functions
  take or return a tuple of values and are fully type-safe, so they should
  never segfault. All basic formats derived from <verbatim|%cdioux>,
  <verbatim|%efg>, <verbatim|%s> and <verbatim|%p> are supported, albeit
  without the standard length modifiers such as <verbatim|h> and
  <verbatim|l>, which aren't of much use in Pure. (However, in addition to C
  <verbatim|printf> and <verbatim|scanf>, the Pure versions also support the
  modifiers <verbatim|Z> and <verbatim|R> of the
  <hlink|GMP|http://gmplib.org> and <hlink|MPFR|http://www.mpfr.org>
  libraries, which are used for converting multiprecision integer and
  floating point values, as shown in the examples below.)

  <\description>
    <item*|printf format args<label|printf>>

    <item*|fprintf fp format args<label|fprintf>>Print a formatted string to
    <hlink|<with|font-family|tt|stdout>|#stdout> or the given file,
    respectively. Normally, these functions return the result of the
    underlying C routines (number of characters written, or negative on
    error). However, in case of an abnormal condition in the wrapper
    function, such as argument mismatch, they will throw an exception. (In
    particular, an <hlink|<with|font-family|tt|out_of_bounds>|#out-of-bounds>
    exception will be thrown if there are not enough arguments for the given
    format string.)
  </description>

  <\description>
    <item*|sprintf format args<label|sprintf>>Print a formatted string to a
    buffer and return the result as a string. Note that, unlike the C
    routine, the Pure version just returns the string result in the case of
    success; otherwise, the error handling is the same as with
    <hlink|<with|font-family|tt|printf>|#printf> and
    <hlink|<with|font-family|tt|fprintf>|#fprintf>. The implementation
    actually uses the C routine <verbatim|snprintf> for safety, and a
    suitable output buffer is provided automatically.
  </description>

  <\description>
    <item*|scanf format<label|scanf>>

    <item*|fscanf fp format<label|fscanf>>Read formatted input from
    <hlink|<with|font-family|tt|stdin>|#stdin> or the given file,
    respectively. These normally return a tuple (or singleton) with the
    converted values. An exception of the form <verbatim|scanf_error>
    <verbatim|ret>, where <verbatim|ret> is the tuple of successfully
    converted values (which may be less than the number of requested input
    items), is thrown if end-of-file was met or another error occurred while
    still reading. The handling of other abnormal conditions is analogous to
    <hlink|<with|font-family|tt|printf>|#printf> et al. Also note that this
    implementation doesn't accept any of the standard length modifiers; in
    particular, floating point values will <em|always> be read in double
    precision and you just specify <verbatim|e>, <verbatim|g> etc. for these.
    The \Passignment suppression\Q flag <verbatim|*> is understood, however;
    the corresponding items will not be returned.
  </description>

  <\description>
    <item*|sscanf s format<label|sscanf>>This works exactly like
    <hlink|<with|font-family|tt|fscanf>|#fscanf>, but input comes from a
    string (first argument) rather than a file.
  </description>

  Examples:

  <\verbatim>
    \;

    \<gtr\> do (printf "%s%d\\n") [("foo",5),("catch",22)];

    foo5

    catch22

    ()

    \<gtr\> sscanf "foo 5 22" "%s %d %g";

    "foo",5,22.0

    \;
  </verbatim>

  As mentioned above, special argument formats are provided for bigints and
  multiprecision floats:

  <\verbatim>
    \;

    \<gtr\> sscanf "a(5) = 1234" "a(%d) = %Zd";

    5,1234L

    \<gtr\> sprintf "a(%d) = %Zd" ans;

    "a(5) = 1234"

    \;

    \<gtr\> using mpfr;

    \<gtr\> mpfr_set_default_prec 113;

    ()

    \<gtr\> printf "pi = %0.30Rg\\n" (4*atan (mpfr 1));

    pi = 3.14159265358979323846264338328

    37

    \;
  </verbatim>

  There are a number of other options for these conversions, please check the
  <hlink|GMP|http://gmplib.org> and <hlink|MPFR|http://www.mpfr.org>
  documentation for details.

  <with|font-series|bold|Note:> In contrast to bigints, multiprecision floats
  aren't directly supported by the Pure language. If you would like to use
  these numbers, you'll have to install the
  <hlink|<with|font-family|tt|mpfr>|pure-mpfr.tm#module-mpfr> addon module
  which is not included in the standard library yet. Also note that, at the
  time of this writing, <hlink|MPFR|http://www.mpfr.org> only provides
  formatted output, so multiprecision floats are not supported by the
  <verbatim|scanf> functions. To work around this limitation, it is possible
  to read the number as a string and then convert it using the
  <hlink|<with|font-family|tt|mpfr>|pure-mpfr.tm#mpfr> function.

  <subsubsection|Stat and Friends><label|stat-and-friends>

  <\description>
    <item*|stat path<label|stat>>Return information about the given file.
    This is a simple wrapper around the corresponding system call, see the
    stat(2) manual page for details. The function returns a tuple with the
    most important fields from the <verbatim|stat> structure, in this order:
    <verbatim|st_dev>, <verbatim|st_ino>, <verbatim|st_mode>,
    <verbatim|st_nlink>, <verbatim|st_uid>, <verbatim|st_gid>,
    <verbatim|st_rdev>, <verbatim|st_size>, <verbatim|st_atime>,
    <verbatim|st_mtime>, <verbatim|st_ctime>. Among these,
    <verbatim|st_mode>, <verbatim|st_nlink>, <verbatim|st_uid> and
    <verbatim|st_gid> are simple machine integers, the rest is encoded as
    bigints (even on 32 bit platforms).
  </description>

  <\description>
    <item*|lstat path<label|lstat>>Return information about the given
    symbolic link (rather than the file it points to). On systems where this
    function isn't supported (e.g., Windows),
    <hlink|<with|font-family|tt|lstat>|#lstat> is identical to
    <hlink|<with|font-family|tt|stat>|#stat>.
  </description>

  <\description>
    <item*|fstat fp<label|fstat>>Return information about the given file
    object. Same as <hlink|<with|font-family|tt|stat>|#stat>, but here the
    file is given as a file pointer created with
    <hlink|<with|font-family|tt|fopen>|#fopen> (see <hlink|Basic I/O
    Interface|#basic-i-o-interface> above). Note that the corresponding
    system function actually takes a file descriptor, so the Pure
    implementation is equivalent to the C call <verbatim|fstat(fileno(fp))>.
    This function might not be supported on all platforms.
  </description>

  For average applications, the most interesting fields are
  <verbatim|st_mode> and <verbatim|st_size>, which can be retrieved with
  <verbatim|stat> <verbatim|filename!![2,7]>. Note that to facilitate access
  to the <verbatim|st_mode> field, the usual masks and bits for file types
  (<verbatim|S_IFMT>, <verbatim|S_IFREG>, etc.) and permissions
  (<verbatim|S_ISUID>, <verbatim|S_ISGID>, <verbatim|S_IRWXU>, etc.) are
  defined as constants by this module. Use the command <verbatim|show>
  <verbatim|-g> <verbatim|S_*> in the interpreter to get a full list of
  these. Other interesting fields are <verbatim|st_atime>,
  <verbatim|st_mtime> and <verbatim|st_ctime>, which can be accessed using
  <verbatim|stat> <verbatim|filename!!(8..10)>. The values of these fields
  are the times of last access, last modification and creation, respectively,
  which can be decoded using the appropriate time functions like
  <hlink|<with|font-family|tt|ctime>|#ctime> or
  <hlink|<with|font-family|tt|strftime>|#strftime>, see <hlink|Time
  Functions|#time-functions>.

  Examples:

  <\verbatim>
    \;

    \<gtr\> stat "/etc/passwd";

    64773L,9726294L,33188,1,0,0,0L,1623L,1250373163L,1242692339L,1242692339L

    \<gtr\> stat "/etc/passwd"!7; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ //
    file size

    1623L

    \<gtr\> strftime "%c" $ localtime $ stat "/etc/passwd"!10; \ \ //
    creation time

    "Tue 19 May 2009 02:18:59 AM CEST"

    \<gtr\> sprintf "0%o" $ stat "/etc/passwd"!2 and not S_IFMT; //
    permissions

    "0644"

    \<gtr\> stat "/etc/passwd"!2 and S_IFMT == S_IFREG; // this is a regular
    file

    1

    \<gtr\> stat "/etc"!2 and S_IFMT == S_IFDIR; \ \ \ \ \ \ \ // this is a
    directory

    1

    \;
  </verbatim>

  <subsubsection|Reading Directories><label|reading-directories>

  <\description>
    <item*|readdir name<label|readdir>>Read the contents of the given
    directory and return the names of all its entries as a list.
  </description>

  Example:

  <\verbatim>
    \;

    \<gtr\> readdir "/home";

    ["ag",".",".."]

    \;
  </verbatim>

  <subsubsection|Shell Globbing><label|shell-globbing>

  <\description>
    <item*|fnmatch pat s flags<label|fnmatch>>Returns a simple truth value (1
    if <verbatim|pat> matches <verbatim|s>, 0 if it doesn't), instead of an
    error code like the C function.
  </description>

  <\description>
    <item*|glob pat flags<label|glob>>Returns a Pure list with the matches
    (unless there is an error in which case the integer result code of the
    underlying C routine is returned).
  </description>

  The available flag values and glob error codes are available as symbolic
  <verbatim|FNM_*> and <verbatim|GLOB_*> constants defined as variables in
  the global environment. See the fnmatch(3) and glob(3) manpages for the
  meaning of these.

  Example:

  <\verbatim>
    \;

    \<gtr\> glob "*.pure" 0;

    ["array.pure","dict.pure","getopt.pure","heap.pure","math.pure",

    "matrices.pure","prelude.pure","primitives.pure","set.pure",

    "strings.pure","system.pure"]

    \;
  </verbatim>

  <subsubsection|Regex Matching><label|module-regex>

  Please note that, as of Pure 0.48, this part of the system interface is not
  included in the system module any more, but is provided as a separate regex
  module which can be used independently of the system module. To use the
  operations of this module, add the following import declaration to your
  program:

  <\verbatim>
    \;

    using regex;

    \;
  </verbatim>

  Since the POSIX regex functions (<verbatim|regcomp> and <verbatim|regexec>)
  have a somewhat difficult calling sequence, this module provides a couple
  of rather elaborate high-level wrapper functions for use in Pure programs.
  These are implemented in terms of a low-level interface provided in the
  runtime. (The low-level interface isn't documented here, but these
  functions are also callable if you want to create your own regular
  expression engines in Pure. You might wish to take a look at the
  implementation of the high-level functions in regex.pure to see how this
  can be done.)

  <\description>
    <item*|regex pat cflags s eflags<label|regex>>Compiles and matches a
    regex in one go, and returns the list of submatches (if any).

    Parameters:

    <\itemize>
      <item><with|font-series|bold|pat> (<hlink|<em|string>|#string>) \U the
      regular expression pattern

      <item><with|font-series|bold|cflags> (<hlink|<em|int>|#int>) \U the
      compilation flags (bitwise or of any of the flags accepted by
      regcomp(3))

      <item><with|font-series|bold|s> (<hlink|<em|string>|#string>) \U the
      subject string to be matched

      <item><with|font-series|bold|eflags> (<hlink|<em|int>|#int>) \U the
      matching execution flags (bitwise or of any of the flags accepted by
      regexec(3))
    </itemize>
  </description>

  Symbolic <verbatim|REG_*> constants are provided for the different flag
  values, see the regcomp(3) manpage for an explanation of these. (Please
  note that these symbolic \Pconstants\Q aren't really constants, but are
  actually implemented as variables, since their values may depend on which
  underlying regex library is being used. Please check <hlink|Perl Regex
  Compatibility|#perl-regex-compatibility> below for details.)

  Two particularly important compilation flags (to be included in the
  <verbatim|cflags> argument) are <verbatim|REG_NOSUB>, which prevents
  submatches to be computed, and <verbatim|REG_EXTENDED>, which switches
  <hlink|<with|font-family|tt|regex>|#regex> from \Pbasic\Q to \Pextended\Q
  regular expressions so that it understands all the regular expression
  elements of egrep(1) in the pattern argument.

  Depending on the flags and the outcome of the operation, the result of this
  function can take one of the following forms:

  <\itemize>
    <item><verbatim|regerr> <verbatim|code> <verbatim|msg>: This indicates an
    error during compilation of the pattern (e.g., if there was a syntax
    error in the pattern). <verbatim|code> is the nonzero integer code
    returned by <verbatim|regcomp>, and <verbatim|msg> is the corresponding
    error message string, as returned by <verbatim|regerror>. You can
    redefine the <verbatim|regerr> function as appropriate for your
    application (e.g., if you'd like to print an error message or throw an
    exception).

    <item><verbatim|0> or <verbatim|1>: Just a truth value indicates whether
    the pattern matched or not. This will be the form of the result if the
    <verbatim|REG_NOSUB> flag was specified for compilation, indicating that
    no submatch information is to be computed.

    <item><verbatim|0> (indicating no match), or <verbatim|1> (indicating a
    successful match), where the latter value is followed by a tuple of
    <verbatim|(pos,substr)> pairs for each submatch. This will be the form of
    the result only if the <verbatim|REG_NOSUB> flag was <em|not> specified
    for compilation, so that submatch information is available.
  </itemize>

  Note that, according to POSIX semantics, a return value of 1 does <em|not>
  generally mean that the entire subject string was matched, unless you
  explicitly tie the pattern to the beginning (<verbatim|^>) and end
  (<verbatim|$>) of the string.

  If the result takes the latter form, each <verbatim|(pos,substr)> pair
  indicates a portion of the subject string which was matched; <verbatim|pos>
  is the position at which the match starts, and <verbatim|substr> is the
  substring (starting at position <verbatim|pos>) which was matched. The
  first <verbatim|(pos,substr)> pair always indicates which portion of the
  string was matched by the entire pattern, the remaining pairs represent
  submatches for the parenthesized subpatterns of the pattern, as described
  on the regcomp(3) manual page. Note that some submatches may be empty (if
  they matched the empty string), in which case a pair <verbatim|(pos,"")>
  indicates the (nonnegative) position <verbatim|pos> where the subpattern
  matched the empty string. Other submatches may not participate in the match
  at all, in which case the pair <verbatim|(-1,"")> is returned.

  The following helper functions are provided to analyze the result returned
  by <hlink|<with|font-family|tt|regex>|#regex>.

  <\description>
    <item*|reg_result res<label|reg-result>>Returns the result of a
    <hlink|<with|font-family|tt|regex>|#regex> call, i.e., a
    <verbatim|regerr> term if compilation failed, and a flag indicating
    whether the match was successful otherwise.
  </description>

  <\description>
    <item*|reg_info res<label|reg-info>>Returns the submatch info if any,
    otherwise it returns <verbatim|()>.
  </description>

  <\description>
    <item*|reg n info<label|reg>>Returns the <verbatim|n>th submatch of the
    given submatch info, where <verbatim|info> is the result of a
    <hlink|<with|font-family|tt|reg_info>|#reg-info> call.
  </description>

  <\description>
    <item*|regs info<label|regs>>Returns all valid submatches, i.e., the list
    of all triples <verbatim|(n,p,s)> for which <verbatim|reg> <verbatim|n>
    <verbatim|==> <verbatim|(p,s)> with <verbatim|p\>=0>.
  </description>

  In addition, the following convenience functions are provided to perform
  global regex searches, to perform substitutions, and to tokenize a string
  according to a given delimiter regex.

  <\description>
    <item*|regexg f pat cflags s eflags<label|regexg>>Perform a global
    regular expression search. This routine will scan the entire string for
    (non-overlapping) instances of the pattern, applies the given function
    <verbatim|f> to the <verbatim|reg_info> for each match, and collects all
    results in a list. Note: Never specify the <verbatim|REG_NOSUB> flag with
    this function, it needs the submatch info.
  </description>

  <\description>
    <item*|regexgg f pat cflags s eflags<label|regexgg>>This works like
    <hlink|<with|font-family|tt|regexg>|#regexg>, but allows overlapping
    matches.
  </description>

  <\description>
    <item*|regsub f pat cflags s eflags<label|regsub>>Replaces all
    non-overlapping instances of a pattern with a computed substitution
    string. To these ends, the given function <verbatim|f> is applied to the
    <hlink|<with|font-family|tt|reg_info>|#reg-info> for each match. The
    result string is then obtained by concatenating <verbatim|f>
    <verbatim|info> for all matches, with the unmatched portions of the
    string in between. To make this work, <verbatim|f> must always return a
    string value; otherwise, <hlink|<with|font-family|tt|regsub>|#regsub>
    throws a <hlink|<with|font-family|tt|bad_string_value>|#bad-string-value>
    exception.
  </description>

  <\description>
    <item*|regsplit pat cflags s eflags<label|regsplit>>Splits a string into
    constituents delimited by substrings matching the given pattern.
  </description>

  Please note that these operations all operate in an eager fashion, i.e.,
  they process the entire input string in one go. This may be unwieldy or at
  least inefficient for huge amounts of text. As a remedy, the following lazy
  alternatives are available:

  <\description>
    <item*|regexgs f pat cflags s eflags<label|regexgs>>

    <item*|regexggs f pat cflags s eflags<label|regexggs>>

    <item*|regsplits pat cflags s eflags<label|regsplits>>These work like
    <hlink|<with|font-family|tt|regexg>|#regexg>,
    <hlink|<with|font-family|tt|regexgg>|#regexgg> and
    <hlink|<with|font-family|tt|regsplit>|#regsplit> above, but return a
    stream result which enables you to process the matches one by one, using
    \Pcall by need\Q evaluation.
  </description>

  <paragraph|Basic Examples><label|basic-examples>

  Let's have a look at some simple examples:

  <\verbatim>
    \;

    \<gtr\> let pat = "[[:alpha:]][[:alnum:]]*";

    \<gtr\> let s = "1var foo 99 BAR $%&";

    \;
  </verbatim>

  Simple match:

  <\verbatim>
    \;

    \<gtr\> regex pat 0 s 0;

    1,1,"var"

    \;
  </verbatim>

  Same without match info:

  <\verbatim>
    \;

    \<gtr\> regex pat REG_NOSUB s 0;

    1

    \;
  </verbatim>

  Global match, return the list of all matches:

  <\verbatim>
    \;

    \<gtr\> regexg id pat 0 s 0;

    [(1,"var"),(5,"foo"),(12,"BAR")]

    \;
  </verbatim>

  Same with overlapping matches:

  <\verbatim>
    \;

    \<gtr\> regexgg id pat 0 s 0;

    [(1,"var"),(2,"ar"),(3,"r"),(5,"foo"),(6,"oo"),(7,"o"),(12,"BAR"),

    (13,"AR"),(14,"R")]

    \;
  </verbatim>

  Note that <hlink|<with|font-family|tt|id>|#id> (the identity function) in
  the examples above can be replaced with an arbitrary function which
  processes the matches. For instance, if we only want the matched strings
  instead of the full match info:

  <\verbatim>
    \;

    \<gtr\> regexg (!1) pat 0 s 0;

    ["var","foo","BAR"]

    \;
  </verbatim>

  Lazy versions of both <hlink|<with|font-family|tt|regexg>|#regexg> and
  <hlink|<with|font-family|tt|regexgg>|#regexgg> are provided which return
  the result as a stream instead. These can be processed in a \Pcall by
  need\Q fashion:

  <\verbatim>
    \;

    \<gtr\> regexgs id pat 0 s 0;

    (1,"var"):#\<less\>thunk 0x7fb1b7976750\<gtr\>

    \<gtr\> last ans;

    12,"BAR"

    \;
  </verbatim>

  Let's verify that the processing is really done lazily:

  <\verbatim>
    \;

    \<gtr\> using system;

    \<gtr\> test x = printf "got: %s\\n" (str x) $$ x;

    \<gtr\> let xs = regexgs test pat 0 s 0;

    got: 1,"var"

    \<gtr\> xs!1;

    got: 5,"foo"

    5,"foo"

    \<gtr\> last xs;

    got: 12,"BAR"

    12,"BAR"

    \;
  </verbatim>

  As you can see, the first match is produced immediately, while the
  remaining matches are processed as the result stream is traversed. This is
  most useful if you have to deal with bigger amounts of text. By processing
  the result stream in a piecemeal fashion, you can avoid keeping the entire
  result list in memory. For instance, compare the following:

  <\verbatim>
    \;

    \<gtr\> let s2 = fget $ fopen "system.pure" "r";

    \<gtr\> stats -m

    \<gtr\> #regexg id pat 0 s2 0;

    7977

    0.18s, 55847 cells

    \<gtr\> #regexgs id pat 0 s2 0;

    7977

    0.12s, 20 cells

    \;
  </verbatim>

  <paragraph|Regex Substitutions and Splitting><label|regex-substitutions-and-splitting>

  We can also perform substitutions on matches:

  <\verbatim>
    \;

    \<gtr\> regsub (sprintf "\<less\>%d:%s\<gtr\>") pat 0 s 0;

    "1\<less\>1:var\<gtr\> \<less\>5:foo\<gtr\> 99 \<less\>12:BAR\<gtr\> $%&"

    \;
  </verbatim>

  Or split a string using a delimiter pattern (this uses an egrep pattern):

  <\verbatim>
    \;

    \<gtr\> let delim = "[[:space:]]+";

    \<gtr\> regsplit delim REG_EXTENDED s 0;

    ["1var","foo","99","BAR","$%&"]

    \<gtr\> regsplit delim REG_EXTENDED "The \ \ quick brown \ \ \ fox" 0;

    ["The","quick","brown","fox"]

    \;
  </verbatim>

  The <hlink|<with|font-family|tt|regsplit>|#regsplit> operation also has a
  lazy variation:

  <\verbatim>
    \;

    \<gtr\> regsplits "[[:space:]]+" REG_EXTENDED "The \ \ quick brown
    \ \ \ fox" 0;

    "The":#\<less\>thunk 0x7fb1b79775b0\<gtr\>

    \<gtr\> last ans;

    "fox"

    \;
  </verbatim>

  <paragraph|Empty Matches><label|empty-matches>

  Empty matches are permitted, too, subject to the constraint that at most
  one match is reported for each position (which also prevents looping). And
  of course an empty match will only be reported if nothing else matches. For
  instance:

  <\verbatim>
    \;

    \<gtr\> regexg id "" REG_EXTENDED "foo" 0;

    [(0,""),(1,""),(2,""),(3,"")]

    \<gtr\> regexg id "o*" REG_EXTENDED "foo" 0;

    [(0,""),(1,"oo"),(3,"")]

    \<gtr\> regexgg id "o*" REG_EXTENDED "foo" 0;

    [(0,""),(1,"oo"),(2,"o"),(3,"")]

    \;
  </verbatim>

  This also works when substituting or splitting:

  <\verbatim>
    \;

    \<gtr\> regsub (cst " ") "" REG_EXTENDED "some text" 0;

    " s o m e \ \ t e x t "

    \<gtr\> regsub (cst " ") " ?" REG_EXTENDED "some text" 0;

    " s o m e \ t e x t "

    \<gtr\> regsplit "" REG_EXTENDED "some text" 0;

    ["","s","o","m","e"," ","t","e","x","t",""]

    \<gtr\> regsplit " ?" REG_EXTENDED "some text" 0;

    ["","s","o","m","e","","t","e","x","t",""]

    \;
  </verbatim>

  <paragraph|Submatches><label|submatches>

  Parenthesized subexpressions in a pattern yield corresponding submatch
  information, which is useful if we need to retrieve the text matched by a
  given subexpression. For instance, suppose we want to parse environment
  lines, such as those returned by the shell's <verbatim|set> command. These
  can be dissected using the following regex:

  <\verbatim>
    \;

    \<gtr\> let env_pat = "^([^=]+)=(.*)$";

    \<gtr\> let env_flags = REG_EXTENDED or REG_NEWLINE;

    \<gtr\> regex env_pat env_flags "SHELL=/bin/sh" 0;

    1,0,"SHELL=/bin/sh",0,"SHELL",6,"/bin/sh"

    \;
  </verbatim>

  Note that we again used an extended regex here, and we also added the
  <verbatim|REG_NEWLINE> flag so that we properly deal with multiline input.
  The desired information is in the 4th and 6th element of the submatch info,
  we can retrieve that as follows:

  <\verbatim>
    \;

    \<gtr\> parse_env s = regexg (\\info -\<gtr\> info!3 =\<gtr\> info!5)
    env_pat env_flags s 0;

    \<gtr\> parse_env "SHELL=/bin/sh\\nHOME=/home/bar\\n";

    ["SHELL"=\<gtr\>"/bin/sh","HOME"=\<gtr\>"/home/bar"]

    \;
  </verbatim>

  We can get hold of the real process environment as follows:

  <\verbatim>
    \;

    \<gtr\> using system;

    \<gtr\> let env = parse_env $ fget $ popen "set" "r";

    \<gtr\> #env;

    109

    \<gtr\> head env;

    "BASH"=\<gtr\>"/usr/bin/sh"

    \;
  </verbatim>

  Just for the fun of it, let's convert this to a record, providing easy
  random access to the environment variables:

  <\verbatim>
    \;

    \<gtr\> let env = record env;

    \<gtr\> env!!["SHELL","HOME"];

    {"/bin/bash","/home/ag"}

    \;
  </verbatim>

  <paragraph|Perl Regex Compatibility><label|perl-regex-compatibility>

  Pure 0.64 and later can be built with support for Perl-style regular
  expressions in the runtime. This is disabled by default, but you can build
  the interpreter with the <verbatim|--with-pcre> configure option to enable
  it. You need to have the pcreposix library installed to make that work, see
  <hlink|http://www.pcre.org/|http://www.pcre.org/>.

  Once this option is enabled, Pure's regex operations will work as discussed
  above, except that they will now understand Perl-style regular expressions,
  as implemented by the libpcre library, instead of the (much more limited)
  POSIX syntax. For instance, you can now write:

  <\verbatim>
    \;

    \<gtr\> using regex;

    \<gtr\> regex "(?:Bob says: (\\\\w+))" 0 "Bob says: Go" 0;

    1,0,"Bob says: Go",10,"Go"

    \;
  </verbatim>

  Note that in Perl-style regexes the <verbatim|(?:...)> construct indicates
  a non-capturing group, so that the above invocation returns just a single
  submatch for the second <verbatim|(\\w+)> group.

  A discussion of Perl regexes is beyond the scope of this manual, so you may
  want to refer to <hlink|http://www.rexegg.com/|http://www.rexegg.com/> for
  more information or read a good book on the subject.

  Pure scripts can detect whether Perl regexes are enabled by inspecting the
  value of the <verbatim|pcre_version> variable. This variable will only be
  defined if the interpreter was built with the <verbatim|--with-pcre>
  configure option, in which case its value is the version number of the
  libpcre library as a string.

  Please note that enabling this option will change the meaning of some
  constructs in the regular expression syntax, even if you don't actually use
  any of the Perl-specific extensions. It's possible to write Pure scripts
  which work with either libpcre or the default (POSIX) regex library, but
  you need to be aware of the discrepancies. The most notable differences are
  that <verbatim|REG_EXTENDED> is always enabled and the treatment of
  newlines is different in some situations if <verbatim|REG_NEWLINE> is used;
  please check the pcreposix(3) manual page for details. Also, the
  <verbatim|REG_*> \Pconstants\Q differ between libpcre and the POSIX regex
  functions, so you should never hard-code these into batch-compiled scripts
  (simply avoid <hlink|<with|font-family|tt|const>|pure.tm#const> definitions
  involving these values, then you should be fine).

  <subsubsection|Additional POSIX Functions><label|module-posix>

  <em|Platforms:>Mac, Unix

  The posix module provides some additional POSIX functions not available on
  all supported systems. (In particular, none of these functions are provided
  on MS Windows.) You can load this module in addition to the system module
  if you need the additional functionality. To use the operations of this
  module, add the following import declaration to your program:

  <\verbatim>
    \;

    using posix;

    \;
  </verbatim>

  The following operations are provided. Please see the appropriate POSIX
  manual pages for a closer description of these functions.

  <\description>
    <item*|fork<label|fork>>Fork a new process.
  </description>

  <\description>
    <item*|getpid<label|getpid>>

    <item*|getppid<label|getppid>>Get the process id of the current process
    and its parent process, respectively.
  </description>

  <\description>
    <item*|wait status<label|wait>>

    <item*|waitpid pid status options<label|waitpid>>Wait for any child
    process, or the given one. The <verbatim|status> argument must be a
    pointer to an <verbatim|int> value, which is used to return the status of
    the child process.
  </description>

  <\description>
    <item*|kill pid sig<label|kill>>Send the given signal to the given
    process.
  </description>

  <\description>
    <item*|raise sig<label|raise>>Raise the given signal in the current
    process.
  </description>

  <\description>
    <item*|pause<label|pause>>Sleep until a signal is caught.
  </description>

  <label|module-getopt>

  <subsubsection|Option Parsing><label|option-parsing>

  This is a quick-and-dirty replacement for the GNU getopt functions, ported
  from the Q library. To use the operations of this module, add the following
  import declaration to your program:

  <\verbatim>
    \;

    using getopt;

    \;
  </verbatim>

  The following operation is provided:

  <\description>
    <item*|getopt opts args<label|getopt>>Parse options as given by
    <verbatim|opts> in the command line arguments <verbatim|args>, return the
    parsed options along with a list of the remaining (non-option) command
    line arguments.
  </description>

  The <hlink|<with|font-family|tt|getopt>|#getopt> function takes two
  arguments: <verbatim|opts>, a list of option descriptions in the format
  described below, and <verbatim|args>, a list of strings containing the
  command line parameters to be parsed for options. The result is a pair
  <verbatim|(opts_return,args_return)> where <verbatim|opts_return> is a list
  of options and their values, and <verbatim|args_return> is the list of
  remaining (non-option) arguments. Options are parsed using the rules of GNU
  getopt(1). If an invalid option is encountered (unrecognized option,
  missing or extra argument, etc.), <hlink|<with|font-family|tt|getopt>|#getopt>
  throws the offending option string as an exception.

  The <verbatim|opts_return> value is a list of \Phash pairs\Q
  <verbatim|opt=\>val> where <verbatim|opt> is the (long) option name (as
  given by the <verbatim|long_opt> field given in the <verbatim|opts>
  argument, see below) and <verbatim|val> is the corresponding value
  (<verbatim|()> if none). Note that this format is ready to be passed to the
  <hlink|<with|font-family|tt|dict>|#dict> or
  <hlink|<with|font-family|tt|hdict>|#hdict> function, cf.
  <hlink|Dictionaries|#dictionaries>, which makes it easy to retrieve option
  values or check for the presence of options. (As of Pure 0.41, you can also
  just convert the list to a record and employ the record functions to access
  the option data, cf. <hlink|Record Functions|#record-functions>.)

  The <verbatim|opts> argument of <verbatim|getopt> must be a list of triples
  <verbatim|(long_opt,> <verbatim|short_opt,> <verbatim|flag)>, where
  <verbatim|long_opt> denotes the long option, <verbatim|short_opt> the
  equivalent short option, and <verbatim|flag> is one of the symbolic integer
  values <verbatim|NOARG>, <verbatim|OPTARG> and <verbatim|REQARG> which
  specifies whether the option has no argument, an optional argument or a
  required argument, respectively. Either <verbatim|long_opt> or
  <verbatim|short_opt> should be a string value of the form
  <verbatim|"--abc"> or <verbatim|"-x">, respectively. Note that since the
  <verbatim|long_opt> value is always used to denote the corresponding option
  in the <verbatim|opts_return> list, you always have to specify a sensible
  value for that field. If no separate long option name is needed, you can
  specify the same value as in the <verbatim|short_opt> field, or some other
  convenient value (e.g., an integer) which designates the option.
  Conversely, to indicate that an option has no short option equivalent,
  simply specify an empty option string for the <verbatim|short_opt> field.

  Examples:

  <\verbatim>
    \;

    \<gtr\> let opts = [("--help", "-h", NOARG), \ \ \ \ \ \ // no argument

    \<gtr\> \ \ \ \ \ \ \ \ \ \ \ \ ("--version", "", NOARG), \ \ \ \ \ // no
    short option

    \<gtr\> \ \ \ \ \ \ \ \ \ \ \ \ ("--filename", "-f", REQARG), \ //
    required argument

    \<gtr\> \ \ \ \ \ \ \ \ \ \ \ \ ("--count", "-n", OPTARG)]; \ \ \ //
    optional argument

    \<gtr\> getopt opts ["foo", "-h", "--filename", "bar", "-n0", "baz"];

    ["--help"=\<gtr\>(),"--filename"=\<gtr\>"bar","--count"=\<gtr\>"0"],["foo","baz"]

    \<gtr\> catch invalid_option $ getopt opts ["-h","-v"];

    invalid_option "-v"

    \<gtr\> getopt opts [foo, "-h", bar];

    ["--help"=\<gtr\>()],[foo,bar]

    \;
  </verbatim>

  As the last example shows, non-option arguments (as well as option values
  specified as separate arguments) can actually be any values which are just
  copied to the result lists as is.

  <subsubsection*|<hlink|Table Of Contents|index.tm>><label|purelib-toc>

  <\itemize>
    <item><hlink|Pure Library Manual|#>

    <\itemize>
      <item><hlink|Prelude|#prelude>

      <\itemize>
        <item><hlink|Constants and Operators|#constants-and-operators>

        <item><hlink|Prelude Types|#prelude-types>

        <item><hlink|Basic Combinators|#basic-combinators>

        <item><hlink|Lists and Tuples|#lists-and-tuples>

        <item><hlink|Slicing|#slicing>

        <item><hlink|Hash Pairs|#hash-pairs>

        <item><hlink|List Functions|#list-functions>

        <\itemize>
          <item><hlink|Common List Functions|#common-list-functions>

          <item><hlink|List Generators|#list-generators>

          <item><hlink|Zip and Friends|#zip-and-friends>
        </itemize>

        <item><hlink|String Functions|#string-functions>

        <\itemize>
          <item><hlink|Basic String Functions|#basic-string-functions>

          <item><hlink|Low-Level Operations|#low-level-operations>
        </itemize>

        <item><hlink|Matrix Functions|#matrix-functions>

        <\itemize>
          <item><hlink|Matrix Construction and
          Conversions|#matrix-construction-and-conversions>

          <item><hlink|Matrix Inspection and
          Manipulation|#matrix-inspection-and-manipulation>

          <item><hlink|Pointers and Matrices|#pointers-and-matrices>
        </itemize>

        <item><hlink|Record Functions|#record-functions>

        <item><hlink|Primitives|#primitives>

        <\itemize>
          <item><hlink|Special Constants|#special-constants>

          <item><hlink|Arithmetic|#arithmetic>

          <item><hlink|Conversions|#conversions>

          <item><hlink|Predicates|#predicates>

          <item><hlink|Inspection|#inspection>

          <item><hlink|Eval and Friends|#eval-and-friends>

          <item><hlink|Expression Serialization|#expression-serialization>

          <item><hlink|Other Special Primitives|#other-special-primitives>

          <item><hlink|Pointer Operations|#pointer-operations>

          <item><hlink|Sentries|#sentries>

          <item><hlink|Tagged Pointers|#tagged-pointers>

          <item><hlink|Expression References|#expression-references>

          <item><hlink|Pointer Arithmetic|#pointer-arithmetic>
        </itemize>
      </itemize>

      <item><hlink|Mathematical Functions|#module-math>

      <\itemize>
        <item><hlink|Imports|#imports>

        <item><hlink|Basic Math Functions|#basic-math-functions>

        <item><hlink|Complex Numbers|#complex-numbers>

        <item><hlink|Rational Numbers|#rational-numbers>

        <item><hlink|Semantic Number Predicates and
        Types|#semantic-number-predicates-and-types>
      </itemize>

      <item><hlink|Enumerated Types|#enumerated-types>

      <item><hlink|Container Types|#container-types>

      <\itemize>
        <item><hlink|Arrays|#arrays>

        <\itemize>
          <item>Imports

          <item><hlink|Operations|#operations>

          <item><hlink|Examples|#examples>
        </itemize>

        <item><hlink|Heaps|#heaps>

        <\itemize>
          <item>Imports

          <item>Operations

          <item>Examples
        </itemize>

        <item><hlink|Dictionaries|#dictionaries>

        <\itemize>
          <item>Imports

          <item>Operations

          <item>Examples
        </itemize>

        <item><hlink|Sets and Bags|#sets-and-bags>

        <\itemize>
          <item>Imports

          <item>Operations

          <item>Examples
        </itemize>
      </itemize>

      <item><hlink|System Interface|#system-interface>

      <\itemize>
        <item>Imports

        <item><hlink|Errno and Friends|#errno-and-friends>

        <item><hlink|POSIX Locale|#posix-locale>

        <item><hlink|Signal Handling|#signal-handling>

        <item><hlink|Time Functions|#time-functions>

        <item><hlink|Process Functions|#process-functions>

        <item><hlink|Basic I/O Interface|#basic-i-o-interface>

        <item><hlink|Stat and Friends|#stat-and-friends>

        <item><hlink|Reading Directories|#reading-directories>

        <item><hlink|Shell Globbing|#shell-globbing>

        <item><hlink|Regex Matching|#module-regex>

        <\itemize>
          <item><hlink|Basic Examples|#basic-examples>

          <item><hlink|Regex Substitutions and
          Splitting|#regex-substitutions-and-splitting>

          <item><hlink|Empty Matches|#empty-matches>

          <item><hlink|Submatches|#submatches>

          <item><hlink|Perl Regex Compatibility|#perl-regex-compatibility>
        </itemize>

        <item><hlink|Additional POSIX Functions|#module-posix>

        <item><hlink|Option Parsing|#option-parsing>
      </itemize>
    </itemize>
  </itemize>

  Previous topic

  <hlink|The Pure Manual|pure.tm>

  Next topic

  <hlink|pure-avahi: Pure Avahi Interface|pure-avahi.tm>

  <hlink|toc|#purelib-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-avahi.tm> \|
  <hlink|previous|pure.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2018, Albert Gräf et al. Last updated on Mar
  18, 2018. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
