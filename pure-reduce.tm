<TeXmacs|1.0.7.20>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-reduce-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-csv.tm> \|
  <hlink|previous|pure-rational.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|Computer Algebra with Pure: A Reduce
  Interface<label|module-reduce>>

  Version 0.4, September 09, 2014

  Albert Graef \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  Kurt Pagani \<less\><hlink|kp@scios.ch|mailto:kp@scios.ch>\<gtr\>

  One of Pure's distinguishing features as a term rewriting programming
  language is that it makes the symbolic manipulation of expressions very
  easy and convenient. It is thus a natural environment for hosting a
  full-featured computer algebra system (CAS). Computer algebra systems are
  complex pieces of software featuring advanced algorithms for simplification
  of algebraic expressions, symbolic integration, equation solving and much
  more. Reimplementing all these algorithms in Pure would be a major
  undertaking, to say the least. A much better option is to interface to an
  existing CAS which has already proven its worth to the scientific computing
  community, has been tested extensively and is known to be both reliable and
  efficient.

  This is also the approach taken by Pure's
  <hlink|<with|font-family|tt|reduce>|#module-reduce> module which interfaces
  to the well-known <hlink|Reduce|http://reduce-algebra.sourceforge.net/>
  system. Along with Macsyma/<hlink|Maxima|http://maxima.sourceforge.net/>,
  Reduce is one of the oldest computer algebra systems which has been around
  since the 1960s and is widely recognized as a state-of-the-art, powerful
  and efficient CAS. It is free/open source software distributed under a
  BSD-style <hlink|license|http://www.reduce-algebra.com/license.htm>,
  actively maintained on its <hlink|SourceForge|http://sourceforge.net/projects/reduce-algebra/>
  website, and implementations exist for all major computing platforms. The
  <hlink|<with|font-family|tt|reduce>|#module-reduce> module makes the
  functionality of Reduce available in Pure in a seamless way. It uses an
  ``embedded'' version of Reduce in the form of a shared library which is
  easy to build from the Reduce sources; the
  <hlink|Installation|#installation> section below describes how to do this.
  More background information and a discussion of the interface can be found
  in the <hlink|Embedding REDUCE|http://groups.google.com/group/pure-lang/browse-thread/thread/c11e82ca2e9e8cbb>
  thread on the Pure mailing list.

  The interface can be found in the reduce.pure module. It has two parts, a
  <hlink|low-level interface|#low-level-interface> which consists of a
  handful of C entry points supplied by the Reduce library, and a
  <hlink|high-level interface|#high-level-interface> which provides
  everything that the Pure programmer needs to use Reduce from Pure. Please
  note that at present this module is still experimental. But the basic
  functionality works, and you're welcome to discuss the new interface on the
  mailing list and/or submit bug reports and patches.

  <subsection|Copying<label|copying>>

  pure-reduce is available under the same 2-clause BSD
  <hlink|license|http://www.reduce-algebra.com/license.htm> as Reduce itself,
  please see the accompanying COPYING file and the reduce.pure file for
  details.

  <subsection|Installation<label|installation>>

  Get the latest source from <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-reduce-0.4.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-reduce-0.4.tar.gz>.

  You'll need both the Reduce library (named reduce.so, reduce.dylib or
  reduce.dll, depending on the system you have) and a Reduce image file
  (reduce.img) to make this module work. A Makefile is included with this
  package so that you can build these yourself from the Reduce sources. (In
  principle, this only needs to be done once for the initial installation of
  this module, but you may want to repeat this procedure every once in a
  while to get the latest Reduce version.)

  The full Reduce system is a big package, so we have packaged a
  stripped-down version of the Reduce source which contains all the bits and
  pieces needed to compile the Reduce library and image, and has also been
  patched up so that it compiles cleanly on recent Linux systems. At the time
  of this writing, you can find this package here:

  <\quote-env>
    <hlink|https://bitbucket.org/purelang/pure-lang/downloads/reduce-algebra-csl-r2204.tar.bz2|https://bitbucket.org/purelang/pure-lang/downloads/reduce-algebra-csl-r2204.tar.bz2>
  </quote-env>

  (You may want to check the download section on the Pure website for newer
  revisions of this package, since we may update the package from time to
  time to the latest source from the Reduce svn repository.)

  Unpack the reduce-algebra-csl tarball and move the resulting reduce-algebra
  directory into the pure-reduce source directory. Run <verbatim|make> and
  then (if needed) <verbatim|make> <verbatim|install> in the pure-reduce
  directory (<em|not> in the reduce-algebra directory!). You should also run
  <verbatim|make> <verbatim|check> which performs a few tests in order to
  verify that the interface works ok (this can be done without installing the
  package, but needs the Reduce image and library).

  For convenience, the Makefile also has a <verbatim|make> <verbatim|reduce>
  target which builds a minimal Reduce executable. If you use that option,
  <verbatim|make> <verbatim|install> installs this executable along with the
  library and image files, so that you can then run Reduce directly from the
  command line by just typing <verbatim|reduce>. Please note that this is a
  really minimalistic Reduce frontend which is most useful for testing
  purposes. (If you want the full Reduce version then you can find binary
  Reduce packages for various systems at <hlink|SourceForge|http://sourceforge.net/projects/reduce-algebra/>.
  But note that neither the minimalistic nor the full Reduce frontend is
  required for the pure-reduce module in any way.)

  It is also possible to build the Reduce library and image directly from the
  latest source in the Reduce svn repository. You can check out the
  repository with the following command:

  <\verbatim>
    svn co svn://svn.code.sf.net/p/reduce-algebra/code/trunk reduce-algebra
  </verbatim>

  This pulls down many hundreds of megabytes, so this may take a while. Once
  the checkout is finished, you'll end up with a reduce-algebra directory
  which you can drop into the pure-reduce source directory and proceed with
  the compilation as described above. Note that if you go that route then you
  should be prepared to deal with compilation problems in the Reduce sources.
  Reduce is a big and complicated software, so the svn sources are not always
  in a state which guarantees smooth compilation on all supported systems. If
  you run into problems then please consider using our streamlined
  reduce-algebra-csl package instead.

  <subsection|Low-Level Interface<label|low-level-interface>>

  The low-level interface is a straight wrapper of the C entry points
  provided by the Reduce library, also known as the ``procedural'' or
  <hlink|PROC|http://reduce-algebra.svn.sourceforge.net/viewvc/reduce-algebra/trunk/csl/cslbase/proc.h?view=markup>
  interface, for short. It uses an embedded version of Reduce which runs on a
  free and open-source Lisp flavour known as
  <hlink|CSL|http://lisp.codemist.co.uk/> (Codemist Standard Lisp). The
  external C routines are all declared in the <verbatim|reduce> namespace.
  Normally you shouldn't have to call these functions directly, since we
  provide a high-level, idiomatic Pure interface which makes calling Reduce
  from Pure much easier, see below.

  <subsection|High-Level Interface<label|high-level-interface>>

  The high-level interface provides a wrapper of the low-level PROC interface
  which makes calling Reduce from Pure easy and convenient. After installing
  the module, it can be imported in your Pure scripts as follows:

  <\verbatim>
    using reduce;
  </verbatim>

  This starts up Reduce and makes the following variables and functions
  available in Pure.

  <subsubsection|Starting and Stopping Reduce<label|starting-and-stopping-reduce>>

  <\description>
    <item*|<em|variable> REDUCE_PATH<label|REDUCE-PATH>>This variable holds a
    colon-delimited search path used to locate the Reduce image file (see
    <hlink|<with|font-family|tt|reduce::start>|#reduce::start> below). By
    default this includes the current directory and the Pure library
    directory.
  </description>

  <\description>
    <item*|reduce::start image::string args::smatrix<label|reduce::start>>Initializes
    the Reduce system. This is done automatically when loading this module,
    so normally you shouldn't have to call this manually, unless the default
    image file wasn't found or you want to restart the Reduce system with
    your own image file or your own set of options. When calling this
    operation manually, you need to specify the name of the Reduce image file
    and any desired extra arguments as a string vector. Unless the filename
    contains a slash, <hlink|<with|font-family|tt|reduce::start>|#reduce::start>
    searches the directories in <hlink|<with|font-family|tt|REDUCE_PATH>|#REDUCE-PATH>
    for the image file. An exception is raised if the image file isn't found.
  </description>

  <\description>
    <item*|reduce::finish<label|reduce::finish>>Finalizes the Reduce system.
    You can call this to release the resources of the Reduce system.
    (<hlink|<with|font-family|tt|reduce::start>|#reduce::start> also invokes
    this automatically if a Reduce instance is already running, so it isn't
    necessary to call <hlink|<with|font-family|tt|reduce::finish>|#reduce::finish>
    in this case.)
  </description>

  <subsubsection|Maintenance Operations<label|maintenance-operations>>

  <\description>
    <item*|reduce::verbosity n<label|reduce::verbosity>>Sets the verbosity
    level; 0 means no messages at all (which is the default when using this
    module), and the following values may be or'ed together to pick what you
    need:

    <\quote-env>
      1: messages whenever garbage collection happens

      2: messages whenever a module of code is loaded

      4: extra details in the garbage collector messages
    </quote-env>
  </description>

  <\description>
    <item*|reduce::switch name:string val::int<label|reduce::switch>>Lets you
    change global Reduce options. This works like Reduce's <verbatim|on> and
    <verbatim|off> declarations; please check the Reduce documentation for
    details.
  </description>

  <\description>
    <item*|reduce::capture flag::int<label|reduce::capture>>

    <item*|reduce::output<label|reduce::output>>Captures output from Reduce.
    If <verbatim|flag> is nonzero, <hlink|<with|font-family|tt|reduce::capture>|#reduce::capture>
    arranges for all output from Reduce to be buffered. The contents of the
    buffer can then be read using the <hlink|<with|font-family|tt|reduce::output>|#reduce::output>
    function which returns a string value. If <verbatim|flag> is zero,
    capturing is disabled so that output goes to stdout again.
  </description>

  <\description>
    <item*|reduce::feed s::string<label|reduce::feed>>Feeds input to Reduce.
    Reduce will read input from the given string <verbatim|s>, switching back
    to stdin after <verbatim|s> has been processed.
  </description>

  <\description>
    <item*|reduce::load name::string<label|reduce::load>>Loads Reduce
    packages. This works like Reduce's <verbatim|load_package> command;
    please check the Reduce documentation for details.
  </description>

  <\description>
    <item*|reduce::in name::string<label|reduce::in>>Sources the given Reduce
    (.red) file. This works like the Lisp <verbatim|in> function. Output is
    captured using <hlink|<with|font-family|tt|reduce::capture>|#reduce::capture>,
    see above.
  </description>

  <subsubsection|Evaluation<label|evaluation>>

  For convenience, the following operations are in the default namespace:

  <\description>
    <item*|simplify x<label|simplify>>This is the main entry point. It takes
    an algebraic expression in Pure format and tries to simplify it using
    Reduce. The result is then converted back to Pure format. Note that you
    need to quote <verbatim|x> if you want to prevent it from being evaluated
    on the Pure side.
  </description>

  <\description>
    <item*|simplifyd x<label|simplifyd>>A variation of
    <hlink|<with|font-family|tt|simplify>|#simplify> which takes care of
    customary mathematical notation for limits, integrals and differentials,
    so that you can write stuff like <verbatim|d> <verbatim|f/d> <verbatim|x>
    and <verbatim|lim> <verbatim|n> <verbatim|inf> <verbatim|(1/n)> and have
    that expanded to the corresponding Reduce calls automatically. This also
    tries to support most of the idioms and variations of notation which can
    be seen in output of the Reduce <verbatim|tmprint> module and which are
    commonly used in <hlink|TeXmacs|http://www.texmacs.org> documents.
  </description>

  <\description>
    <item*|lisp x<label|lisp>>This can be used to execute arbitrary Lisp
    code, which is sometimes necessary to perform special functions in the
    Reduce system. Note that you need to quote <verbatim|x> if you want to
    prevent it from being evaluated on the Pure side. This is true, in
    particular, for the quote itself, which needs an extra level so that one
    quote goes through to the Lisp system (e.g.: <verbatim|lisp>
    <verbatim|(''(a> <verbatim|b> <verbatim|c))>). For convenience, free
    symbols are quoted automatically, and Pure lists are mapped to
    corresponding Lisp lists and vice versa (so <verbatim|lisp>
    <verbatim|[a,b,c]> actually yields the same result as <verbatim|lisp>
    <verbatim|(''(a> <verbatim|b> <verbatim|c))>). The result is always a
    Pure list or an atomic value.
  </description>

  <\description>
    <item*|lispval x<label|lispval>>This converts a Pure expression to its
    Reduce equivalent, like <hlink|<with|font-family|tt|simplify>|#simplify>
    does, but without actually simplifying it. As with the other functions,
    you need to quote <verbatim|x> if you want to prevent it from being
    evaluated on the Pure side. The result is the Pure representation of a
    Lisp form which can be passed as a value to other Lisp routines by
    employing the <hlink|<with|font-family|tt|lisp>|#lisp> function.
    (Normally this requires that you double-quote the expression so that it
    doesn't get evaluated by the Lisp interpreter.) This function isn't for
    casual usage, but may be useful if you need to pass a Reduce expression
    to some Lisp function which cannot be called through
    <hlink|<with|font-family|tt|simplify>|#simplify>.
  </description>

  <\description>
    <item*|lispsym s::string<label|lispsym>>This function creates a special
    Pure identifier for any symbol given as a string, even symbols which
    don't conform to Pure syntax. This is sometimes needed to specify special
    Lisp symbols in calls to <hlink|<with|font-family|tt|lisp>|#lisp>, such
    as <verbatim|lisp> <verbatim|(lispsym> <verbatim|"oem-supervisor")>.
    (Note that if such a special symbol occurs as a literal in a result
    returned by <hlink|<with|font-family|tt|lisp>|#lisp> or
    <hlink|<with|font-family|tt|simplify>|#simplify> then it will get mangled
    into a form which conforms to Pure syntax.)
  </description>

  <\description>
    <item*|declare declsym [foo,bar,...]<label|declare>>Declare symbols and
    their properties; please see the Declarations section in the Reduce
    manual for details. The second argument can also be a singleton symbol.
    In the present implementation, <verbatim|declsym> must be one of:

    <\itemize>
      <item><verbatim|operator>: declares an operator symbol;

      <item><verbatim|precedence>: declares an infix operator and optionally
      specifies its precedence (giving the symbol priority over a second
      given symbol);

      <item><verbatim|antisymmetric>, <verbatim|symmetric>, <verbatim|even>,
      <verbatim|odd>, <verbatim|linear>, <verbatim|noncom> and
      <verbatim|nonzero>: declares properties of already declared operator
      symbols;

      <item><verbatim|depend>, <verbatim|nodepend>, <verbatim|factor>,
      <verbatim|remfac>, <verbatim|order>, <verbatim|korder>: declares kernel
      dependencies and orders. These take both symbols and ``kernels'' as
      arguments (the latter are simple prefix expressions which denote
      irreducible subterms such as <verbatim|cos> <verbatim|x>; Reduce treats
      these more or less like variables in algebraic simplifications).
    </itemize>
  </description>

  <\description>
    <item*|precision prec::int<label|precision>>Sets the internal Reduce
    precision in decimal digits for floating point calculations, and returns
    the previously set precision. This takes effect when rounded mode is
    enabled (<verbatim|reduce::switch> <verbatim|"rounded"> <verbatim|1>).
    Note that at present this only affects Reduce's internal precision,
    floating point values are still returned as double precision numbers in
    Pure land.
  </description>

  <\description>
    <item*|plotreset<label|plotreset>>This is identical to the
    <verbatim|plotreset> command provided by Reduce's
    <hlink|gnuplot|http://www.gnuplot.info/> interface, and is sometimes
    needed to reset the plot subsystem.
  </description>

  In Pure land, Reduce expressions are represented using Pure's standard
  curried notation. Marshalling of numeric data works in a straightforward
  fashion and includes all natively supported Pure data types (machine ints,
  bigints, doubles, rationals and complex numbers). Some special conversions
  are applied to algebraic expressions to make arithmetic operations such as
  <verbatim|+>, <verbatim|*> etc. work as expected. In addition, the
  <verbatim|==>, <verbatim|=\>>, <verbatim|..> and <verbatim|:=> infix
  operators can be used to denote equations, replacement rules, ranges and
  assignments in Reduce, respectively. (Note that you may have to quote these
  in some cases so that they don't get evaluated on the Pure side.) Also,
  Reduce's <verbatim|arbconst> <verbatim|n>, <verbatim|arbint> <verbatim|n>
  and <verbatim|arbcomplex> <verbatim|n> terms can be mapped to Greek symbols
  <verbatim|<ensuremath{\\alpha}n>>, <verbatim|<ensuremath{\\beta}n>> and
  <verbatim|<ensuremath{\\zeta}n>> on the Pure side. (This may cause issues
  in environments without proper Unicode support, so it's disabled by
  default.) For debugging purposes, all these automatic conversions can also
  be turned off on the output side with the `<verbatim|#!><nbsp>
  <verbatim|--disable> <verbatim|mapped>` compilation pragma; this needs to
  be placed <em|before> the `<verbatim|using> <verbatim|reduce;>` import
  clause to take effect. There are a number of other conditional compilation
  options which may be used to selectively turn off some of the conversions;
  please check the module source for details.

  Lisp expressions are handled in a similar fashion, but here only a few
  basic Pure data types (integers, doubles, strings and lists) are converted
  to and from corresponding Lisp data. Function applications in Pure's
  curried notation are mapped to corresponding Lisp forms. The result of
  invoking <hlink|<with|font-family|tt|lisp>|#lisp> is always one of the
  supported atomic types or a Pure list.

  The <hlink|<with|font-family|tt|lisp>|#lisp> function is to be used with
  care. An orderly Pure exception is raised if you try to execute a
  non-existing Lisp function. But there are some internal functions in Reduce
  which aren't very forgiving if you try to execute them with invalid
  arguments, and will most likely crash the Reduce system in such cases. You
  have been warned!

  <subsection|Basic Examples<label|basic-examples>>

  Here is a simple example showing how to start up Reduce and do some
  calculations:

  <\verbatim>
    \<gtr\> using reduce;

    Reduce (Free CSL version), 27-Sep-12 ...

    \<gtr\> simplify $ df ((x+5)^3) x;

    3*x^2+30*x+75

    \<gtr\> simplify $ intg (exp (2*x)) x;

    e^(2*x)/2

    \<gtr\> simplify $ solve (x^2+7) x;

    [x==sqrt 7*i,x==-sqrt 7*i]
  </verbatim>

  Note that the result returned by <hlink|<with|font-family|tt|simplify>|#simplify>
  is always a quoted expression. If the expression can be further reduced on
  the Pure side, you'll have to use Pure's
  <hlink|<with|font-family|tt|eval>|purelib.tm#eval> function to force its
  evaluation:

  <\verbatim>
    \<gtr\> using math;

    \<gtr\> eval ans;

    [x==0.0+:2.64575131106459,x==0.0+:-2.64575131106459]
  </verbatim>

  The following example shows how you can do a simple plot using Reduce's
  <hlink|gnuplot|http://www.gnuplot.info/> module:

  <\verbatim>
    \<gtr\> simplify $ plot [sin x/x, x=='(-20..20), terminal=="wxt"];

    0
  </verbatim>

  This pops up a wxWidgets window (<verbatim|terminal=="wxt">) with a plot of
  the given function in it, see the <hlink|screenshot|#screenshot> below. The
  <verbatim|x=='(-20..20)> argument specifies the desired range of the
  <verbatim|x> variable (note that the range needs to be quoted so that it
  gets through to Reduce rather than being evaluated on the Pure side).

  <hlink|<puredoc-image|_images/gnuplot.png|66%|66%||>|-images/gnuplot.png>

  Reduce gnuplot example.

  The same plot can be written to a PostScript file sinc.ps as follows:

  <\verbatim>
    \<gtr\> simplify $ plot [sin x/x, x=='(-20..20), terminal=="postscript",
    output=="sinc.ps"];

    0
  </verbatim>

  The <hlink|<with|font-family|tt|lisp>|#lisp> function can be used to
  execute Lisp code in the CSL interpreter hosting the Reduce system. Here
  are some basic examples. Note that, to be on the safe side, we just always
  quote the argument to <hlink|<with|font-family|tt|lisp>|#lisp> here to
  prevent its evaluation on the Pure side.

  <\verbatim>
    \<gtr\> lisp ('plus 2 3);

    5

    \<gtr\> lisp ('car (list a b c d e));

    a

    \<gtr\> lisp ('cdr [a,b,[c,d],e]);

    [b,[c,d],e]
  </verbatim>

  Lisp's truth values are <verbatim|t> and <verbatim|nil>; the latter is just
  the empty list, so that's what you get if a Lisp predicate evaluates to
  ``false'':

  <\verbatim>
    \<gtr\> lisp ('lessp 5 3);

    []

    \<gtr\> lisp ('greaterp 5 3);

    t
  </verbatim>

  Most simple kinds of Lisp calls should be doable that way, but don't expect
  any miracles; the <hlink|<with|font-family|tt|lisp>|#lisp> function is
  provided to access special functionality in the ``symbolic mode'' of the
  Reduce system, not to turn Pure into a full-featured Lisp frontend. The
  following example illustrates how you can use the
  <hlink|<with|font-family|tt|lisp>|#lisp> function to declare an operator
  symbol and change or query its properties:

  <\verbatim>
    \<gtr\> lisp ('operator [myop]);

    []

    \<gtr\> lisp ('flag [myop] odd);

    []

    \<gtr\> lisp ('prop myop);

    [odd:t,simpfn:simpiden]

    \<gtr\> simplify (myop (-x));

    -myop x
  </verbatim>

  If you find it awkward to evaluate Lisp forms in Pure, you can also achieve
  the same with the <hlink|<with|font-family|tt|declare>|#declare> function
  which covers most of the common Reduce declarations that might be needed:

  <\verbatim>
    \<gtr\> declare operator myop;

    []

    \<gtr\> declare odd myop;

    []

    \<gtr\> simplify (myop (-x));

    -myop x
  </verbatim>

  For basic Pure-based usage of Reduce, it's convenient to have a simple
  read-eval-print loop which lets you type some declarations and expressions
  to be simplified (in Pure syntax), and takes care of all the quoting and
  invoking <hlink|<with|font-family|tt|simplify>|#simplify> for you. Here's a
  little Pure script which does that:

  <\verbatim>
    using math, reduce, system;

    \;

    /* You might want to replace this with the real readline if you have the

    \ \ \ corresponding Pure module installed. See the red.pure script in the

    \ \ \ distribution for details. */

    myreadline prompt::string = fputs prompt stdout $$ fflush stdout $$ gets;

    \;

    red = loop with

    \ \ // A simplistic REPL.

    \ \ loop = case myreadline "\<gtr\> " of

    \ \ \ \ s::string = process s $$ loop if ~null s;

    \ \ \ \ _ = () otherwise;

    \ \ end;

    \ \ // Get rid of trailing blanks and semicolons.

    \ \ process s = process (init s) if any (==last s) [" ",";"];

    \ \ // Process a declaration or REDUCE expression.

    \ \ process s = case val s of

    \ \ \ \ val _ = fputs "** syntax error\\n" stderr if ~null lasterr;

    \ \ \ \ on flag = reduce::switch (str flag) 1;

    \ \ \ \ off flag = reduce::switch (str flag) 0;

    \ \ \ \ x@(declare _ _) = eval x;

    \ \ \ \ x = puts (str (simplify x)) otherwise;

    \ \ end;

    end;
  </verbatim>

  Now you can run <verbatim|red> at the Pure prompt and start typing the
  stuff you want to evaluate, one expression or declaration per line. Enter
  an empty line or <verbatim|Ctrl-D> when you're done to return to the Pure
  command prompt.

  <\verbatim>
    \<gtr\> red;

    \<gtr\> df ((x+5)^3) x

    3*x^2+30*x+75

    \<gtr\> intg (exp (2*x)) x

    e^(2*x)/2

    \<gtr\> on rounded

    \<gtr\> solve (x^2+7==17) x

    [x==3.16227766016838,x==-3.16227766016838]

    \<gtr\> off rounded

    \<gtr\> solve (x^2+7==17) x

    [x==sqrt 10,x==-sqrt 10]

    \<gtr\> declare operator myop

    \<gtr\> declare odd myop

    \<gtr\> myop (-x)

    -myop x

    \<gtr\> plot [sin x/x, x==(-20..20), terminal=="wxt"]

    0

    \<gtr\> ^D

    ()
  </verbatim>

  Note that we barely scratched the surface here; Reduce is a very complex
  system with lots of capabilities. The following section explores some of
  these areas in more detail.

  <subsection|Examples by Topic<label|examples-by-topic>>

  This is a small excerpt from the <with|font-series|bold|REDUCE User's
  Manual> <hlink|[REDUM]|#redum>, translated to Pure syntax. For any details
  we refer to that document. With this guide it should be straightforward to
  translate back and forth between Pure and REDUCE syntax for the invocation
  of REDUCE functions. The one thing you have to keep in mind is that Pure
  uses <em|curried> notation for function applications, so where a function
  is invoked as <verbatim|f(x,y,z)> in REDUCE, you'll have to call it as
  <verbatim|f> <verbatim|x> <verbatim|y> <verbatim|z> in Pure (with
  parentheses around each argument which is a compound expression).

  The REDUCE User's Manual as well as the documentation of each package and
  other valuable information may be found at:
  <hlink|http://www.reduce-algebra.com/documentation.htm|http://www.reduce-algebra.com/documentation.htm>

  <subsubsection|Differentiation<label|differentiation>>

  The operator <verbatim|df> is used to represent partial differentiation
  with respect to one or more variables.

  <\description>
    <item*|df exprn [var \<less\>num\<gtr\>]+>
  </description>

  Differentiation of the function <puredoc-image|_images/math/37d36052091ff4e8877a3b55f2014b62e81069e1.png|66%|66%||>
  with respect to <puredoc-image|_images/math/accc80fdf164cef264f56a82b6f9f6add320fe05.png|66%|66%||>,
  two, three and four times respectively, i.e
  <puredoc-image|_images/math/38a45ae1b8d8833859b5404bafb5bdbb9d2fdb9e.png|66%|66%||>:

  <\verbatim>
    \<gtr\> simplify $ df (x^2*y^3*z^4) x 2 y 3 z 4 ;

    288
  </verbatim>

  The derivative of <puredoc-image|_images/math/4b03686d9ad5334a024240873fb9eeccfc4c1b95.png|66%|66%||>:

  <\verbatim>
    \<gtr\> simplify $ df (log(sin x)^2) x;

    2*cos x*log (sin x)/sin x
  </verbatim>

  Note the parentheses.

  Suppose <puredoc-image|_images/math/f17b551f5909d3d00a2a02498aa05feaaf2b00fa.png|66%|66%||>.
  Let's calculate <puredoc-image|_images/math/fd073a38d9d0b95d33fe16c99aa444312f6affe6.png|66%|66%||>
  and <puredoc-image|_images/math/8bc7c95e9c4803652c2ed461d565822ac00f6e00.png|66%|66%||>
  :

  <\verbatim>
    \<gtr\> declare depend [z,cos x,y];

    []

    \<gtr\> simplify (df (sin z) (cos x));

    cos z*df z (cos x)

    \<gtr\> simplify (df (z^2) x);

    2*df z x*z
  </verbatim>

  Note how to declare dependencies.

  The results are <puredoc-image|_images/math/0cdbe7c88c7d85d852c7ab1cee1b7ed57b6d3fce.png|66%|66%||>
  and <puredoc-image|_images/math/8c5193aefe42abfae1781d7443e0d82fc08bbace.png|66%|66%||>,
  respectively, as expected.

  <subsubsection|Integration<label|integration>>

  <verbatim|INT> is an operator in REDUCE for indefinite integration using a
  combination of the Risch-Norman algorithm and pattern matching.

  <\description>
    <item*|intg exprn var>
  </description>

  Note that in Pure the operator is called <verbatim|intg> in order not to
  clash with the <hlink|<with|font-family|tt|int>|purelib.tm#int> conversion
  function.

  Example 1:

  <\center>
    <puredoc-image|_images/math/d50d198cd362adedbd72aa07c42ec19e77012ec9.png|66%|66%||>
  </center>

  <\verbatim>
    \<gtr\> simplify $ intg (1/(a*x+b)) x;

    log (a*x+b)/a
  </verbatim>

  Example 2:

  <\center>
    <puredoc-image|_images/math/c899f1b26ad30e41c731c4b1b99818309b557183.png|66%|66%||>
  </center>

  <\verbatim>
    \<gtr\> I a b n = simplify $ intg (x^2*(a*x+b)^n) x;

    \<gtr\> I a b n;

    ((a*x+b)^n*a^3*n^2*x^3+3*(a*x+b)^n*a^3*n*x^3+2*(a*x+b)^n*a^3*x^3+

    \ (a*x+b)^n*a^2*b*n^2*x^2+(a*x+b)^n*a^2*b*n*x^2-2*(a*x+b)^n*a*b^2*

    \ \ n*x+2*(a*x+b)^n*b^3)/(a^3*n^3+6*a^3*n^2+11*a^3*n+6*a^3)

    \<gtr\> I a b 0 ;

    x^3/3

    \<gtr\> I 0 b n;

    b^n*x^3/3

    \<gtr\> I a 0 k;

    x^k*a^k*x^3/(k+3)
  </verbatim>

  Example 3:

  <\center>
    <puredoc-image|_images/math/f7a6e901cfdb9900d803827750209a2f4315b375.png|66%|66%||>
  </center>

  <\verbatim>
    \<gtr\> simplify $ intg (sqrt(x+sqrt(x^2+1))/x) x ;

    intg (sqrt (sqrt (x^2+1)+x)/x) x
  </verbatim>

  Apparently no solution was found. There is a package <verbatim|ALGINT> in
  REDUCE which specifically deals with algebraic functions. The REDUCE User's
  Manual <hlink|[REDUM]|#redum> says:

  <\quote-env>
    <em|This package [...] will analytically integrate a wide range of
    expressions involving square roots where the answer exists in that class
    of functions. It is an implementation of the work described in J.H.
    Davenport> <hlink|[LNCS102]|#lncs102>.
  </quote-env>

  <\verbatim>
    \<gtr\> reduce::load "algint" ;

    0

    \<gtr\> simplify $ intg (sqrt(x+sqrt(x^2+1))/x) x ;

    atan ((sqrt (sqrt (x^2+1)+x)*sqrt (x^2+1)-sqrt (sqrt (x^2+1)+x)*x-sqrt

    (sqrt (x^2+1)+x))/2)+2*sqrt (sqrt (x^2+1)+x)+log (sqrt (sqrt

    (x^2+1)+x)-1)-log (sqrt (sqrt (x^2+1)+x)+1)
  </verbatim>

  Note how to load packages.

  <subsubsection|Length, Map and Select<label|length-map-and-select>>

  <verbatim|LENGTH> is a generic operator for finding the length of compound
  objects. Besides lists and matrices, this also includes algebraic
  expressions. The <verbatim|MAP> and <verbatim|SELECT> operators let you
  manipulate such objects by applying a function to each element of the
  structure, or by picking the elements satisfying a given predicate
  function. Thus these operations serve pretty much the same purposes as
  <hlink|<with|font-family|tt|#>|purelib.tm##> (or
  <hlink|<with|font-family|tt|dim>|purelib.tm#dim>),
  <hlink|<with|font-family|tt|map>|purelib.tm#map> and
  <hlink|<with|font-family|tt|filter>|purelib.tm#filter> in Pure, but in
  REDUCE they also work with the operands of an algebraic expression.

  <\description>
    <item*|length exprn>

    <item*|map fun exprn>

    <item*|select fun exprn>
  </description>

  <\verbatim>
    \<gtr\> simplify $ length (a+b);

    2

    \<gtr\> simplify $ length (x^n+a*x+2);

    3

    \;

    \<gtr\> simplify $ 'map sqrt [1,2,3];

    [1,2^(1/2),3^(1/2)]

    \<gtr\> simplify $ 'map log \ [x^n,x^m,sin x];

    [log (x^n),log (x^m),log (sin x)]
  </verbatim>

  Note that <verbatim|map> must be quoted if we want to evaluate it in
  REDUCE, since it's also a function in Pure. In this case, we might as well
  do the calculation using Pure's <verbatim|map>; the result is exactly the
  same.

  <\verbatim>
    \<gtr\> simplify $ map sqrt [1,2,3];

    [1,2^(1/2),3^(1/2)]

    \<gtr\> simplify $ map log \ [x^n,x^m,sin x];

    [log (x^n),log (x^m),log (sin x)]
  </verbatim>

  If the function to be applied in calls to <verbatim|MAP> or
  <verbatim|SELECT> is a compound expression, it must either contain a single
  free variable (indicated with the <verbatim|~> prefix, e.g.: <verbatim|~w>)
  or a replacement rule of the form <verbatim|var> <verbatim|=\>>
  <verbatim|exprn>. In either case the current elements are substituted for
  the free variable when the function is applied.

  <\verbatim>
    \<gtr\> simplify $ 'map (y=\<gtr\>df y x) \ \ [x^n,x^m,sin x];

    [x^n*n/x,x^m*m/x,cos x]

    \<gtr\> simplify $ 'map (y=\<gtr\>intg y x) [x^n,x^m,sin x];

    [x^n*x/(n+1),x^m*x/(m+1),-cos x]

    \;

    \<gtr\> simplify $ select (evenp (deg (~w) y)) ((x+y)^5);

    x^5+10*x^3*y^2+5*x*y^4

    \<gtr\> simplify $ select (w=\<gtr\>evenp (deg w y)) ((x+y)^5);

    x^5+10*x^3*y^2+5*x*y^4
  </verbatim>

  Contrast this with Pure where the function argument to
  <hlink|<with|font-family|tt|map>|purelib.tm#map> is often specified as a
  lambda:

  <\verbatim>
    \<gtr\> simplify $ map (\\y-\<gtr\>df y x) \ \ [x^n,x^m,sin x];

    [x^n*n/x,x^m*m/x,cos x]

    \<gtr\> simplify $ map (\\y-\<gtr\>intg y x) [x^n,x^m,sin x];

    [x^n*x/(n+1),x^m*x/(m+1),-cos x]
  </verbatim>

  In principle, the same correspondences also hold between REDUCE's
  <verbatim|select> and Pure's <hlink|<with|font-family|tt|filter>|purelib.tm#filter>.
  For instance, consider:

  <\verbatim>
    \<gtr\> simplify $ select (w=\<gtr\>evenp (deg w x)) [2*x^2,3*x^3,4*x^4];

    [2*x^2,4*x^4]
  </verbatim>

  The equivalent Pure <hlink|<with|font-family|tt|filter>|purelib.tm#filter>
  is:

  <\verbatim>
    \<gtr\> filter (\\w-\<gtr\>simplify $ evenp (deg w x))
    [2*x^2,3*x^3,4*x^4];

    [2*x^2,4*x^4]
  </verbatim>

  Note that REDUCE is now being called inside the predicate function, the
  rest of the processing is done in Pure.

  Of course, if you want to apply <hlink|<with|font-family|tt|map>|purelib.tm#map>,
  <hlink|<with|font-family|tt|filter>|purelib.tm#filter> and similar Pure
  functions to an algebraic expression, you'll first have to extract its
  components as a list. Here's a little Pure function which mimics the way in
  which <verbatim|MAP> and <verbatim|SELECT> decompose an expression:

  <\verbatim>
    terms x = case x of

    \ \ f@_ u v = collect f x with

    \ \ \ \ // Collect the operands of variadic Reduce operators.

    \ \ \ \ collect f (f@_ u v) = collect f u+collect f v;

    \ \ \ \ collect f x = [x] otherwise;

    \ \ end if any (===eval f) [(+),(-),(*),min,max];

    \ \ = [u,v] if arity f == 2;

    \ \ _ = [x] otherwise;

    end;
  </verbatim>

  For instance, consider:

  <\verbatim>
    \<gtr\> simplify $ 'map (w=\<gtr\>w+1) (df ((x+y)^3) x);

    3*x^2+6*x*y+3*y^2+3
  </verbatim>

  With the help of <verbatim|terms> we can also do this using Pure's
  <hlink|<with|font-family|tt|map>|purelib.tm#map> as follows:

  <\verbatim>
    \<gtr\> map (+1) $ terms (simplify (df ((x+y)^3) x));

    [3*x^2+1,6*x*y+1,3*y^2+1]

    \<gtr\> simplify $ foldl (+) 0 ans;

    3*x^2+6*x*y+3*y^2+3
  </verbatim>

  While the REDUCE version is shorter and only involves a single call to
  <hlink|<with|font-family|tt|simplify>|#simplify>, with a little bit of
  programming the Pure solution can be made just as convenient. More
  importantly, this method easily generalizes to other list operations. This
  makes it possible to apply Pure's full arsenal of generic list functions
  which goes beyond what's available in REDUCE.

  <subsubsection|Partial Fractions<label|partial-fractions>>

  The <verbatim|PF> operator transforms an expression into a list of partial
  fractions with respect to the main variable. <verbatim|PF> does a complete
  partial fraction decomposition.

  <\description>
    <item*|pf expr var>
  </description>

  Let us find the decomposition of:

  <\center>
    <puredoc-image|_images/math/6ad7d10cfa19f1ccab4ae0c476fef6d8370f68c7.png|66%|66%||>
  </center>

  <\verbatim>
    \<gtr\> let f = 2/((x+1)^2*(x+2));

    \<gtr\> simplify $ pf f x;

    [2/(x+2),(-2)/(x+1),2/(x^2+2*x+1)]
  </verbatim>

  This means:

  <\center>
    <puredoc-image|_images/math/75656f73ed0eba76e6598833830deebf17c26288.png|66%|66%||>
  </center>

  If one wants the denominators in factored form, one has to use the switch
  <verbatim|off> <verbatim|exp>:

  <\verbatim>
    \<gtr\> reduce::switch "exp" 0 ;

    0

    \<gtr\> simplify $ pf f x;

    [2/(x+2),(-2)/(x+1),2/(x+1)^2]
  </verbatim>

  Note how the value of a Reduce switch is changed in Pure.

  <subsubsection|Solving<label|solving>>

  <verbatim|SOLVE> is an operator for solving one or more simultaneous
  algebraic equations. It is used with the syntax:

  <\description>
    <item*|solve expr [var \| varlist]>
  </description>

  where <verbatim|expr> is a list of one or more expressions. Each expression
  is an algebraic equation, or is the difference of the two sides of the
  equation.

  Example 1:

  Find the solutions to

  <\center>
    <puredoc-image|_images/math/30b528de263466ab1d4b4dac653d077b4a8b5e0b.png|66%|66%||>
  </center>

  <\verbatim>
    \<gtr\> let eqn1 = log(sin (x+3))^5 == 8 ;

    \<gtr\> let sol1 = simplify $ solve eqn1 x;
  </verbatim>

  The variable <verbatim|sol1> now contains an entire list of solutions. How
  many are there?

  <\verbatim>
    \<gtr\> #sol1 ;

    10
  </verbatim>

  The first one is:

  <\verbatim>
    \<gtr\> sol1!0;

    x==2*arbint 5*pi+asin (e^(2^(3/5)*cos (2*pi/5))/e^(2^(3/5)*sin
    (2*pi/5)*i))-3
  </verbatim>

  <\center>
    <puredoc-image|_images/math/fbfbb9959df12ca065293445cc528fb3f88c4010.png|66%|66%||>
  </center>

  where <verbatim|n> is an arbitrary integer constant (shown as
  <verbatim|arbint> <verbatim|5> in the result of <verbatim|simplify>).

  It is also possible to obtain the right-hand side of any solution in the
  list via REDUCE commands:

  <\verbatim>
    \<gtr\> simplify $ rhs $ first $ solve eqn1 x;

    2*arbint 10*pi+asin (e^(2^(3/5)*cos (2*pi/5))/e^(2^(3/5)*sin
    (2*pi/5)*i))-3
  </verbatim>

  where <verbatim|first> gets the first solution in the list and
  <verbatim|rhs> obtains the right-hand side. Hence there is a wealth of
  possibilities to process the solution list.

  Example 2:

  Here are some simpler examples for the sake of clarity:

  <\center>
    <puredoc-image|_images/math/f9a7082422990788860c04d3a950a67b59cc4ec1.png|66%|66%||>
  </center>

  <\verbatim>
    \<gtr\> simplify $ solve [X^2+1==0] X;

    [X==i,X==-i]
  </verbatim>

  <\center>
    <puredoc-image|_images/math/b968e3106d18a983ac4bbfcfcdfbcb358c684d81.png|66%|66%||>
  </center>

  <\verbatim>
    \<gtr\> simplify $ solve [x+3*y==7,y-x==1] [x,y] ;

    [[x==1,y==2]]
  </verbatim>

  To get the multiplicities, turn on the switch <verbatim|multiplicities>:

  <\verbatim>
    \<gtr\> simplify $ solve [x^2==2*x-1] x;

    [x==1]

    \<gtr\> reduce::switch "multiplicities" 1;

    0

    \<gtr\> simplify $ solve [x^2==2*x-1] x;

    [x==1,x==1]
  </verbatim>

  For details consult the REDUCE user manual.

  <subsubsection|Even and Odd Operators<label|even-and-odd-operators>>

  An operator can be declared to be even or odd in its first argument by the
  declarations <verbatim|EVEN> and <verbatim|ODD> respectively.

  <\verbatim>
    \<gtr\> declare operator [f1,f2];

    []

    \<gtr\> declare odd f1;

    []

    \<gtr\> declare even f2;

    []

    \;

    \<gtr\> simplify $ f1(-a);

    -f1 a

    \;

    \<gtr\> simplify $ f2 (-a);

    f2 a

    \;

    \<gtr\> simplify $ f1 (-a) (-b);

    -f1 a (-b)
  </verbatim>

  <subsubsection|Linear Operators<label|linear-operators>>

  An operator can be declared to be linear in its first argument over powers
  of its second argument.

  <\center>
    <puredoc-image|_images/math/00f5f22f7944f4a4e4c6c07fab02bbf642007331.png|66%|66%||>
  </center>

  <\verbatim>
    \<gtr\> declare operator L;

    []

    \<gtr\> declare linear L;

    []

    \<gtr\> simplify $ L (a*x^5+b*x+c) x ;

    L (x^5) x*a+L x x*b+L 1 x*c
  </verbatim>

  <\center>
    <puredoc-image|_images/math/480d0c34e36dc76f7ce22067b6d93e9d3254a596.png|66%|66%||>
  </center>

  <\verbatim>
    \<gtr\> simplify $ L (a+b+c+d) y;

    L 1 y*a+L 1 y*b+L 1 y*c+L 1 y*d
  </verbatim>

  Note that <verbatim|L> <verbatim|x> <verbatim|y> binds stronger than
  <verbatim|(*)> in Pure.

  <subsubsection|Non-commuting Operators<label|non-commuting-operators>>

  An operator can be declared to be non-commutative under multiplication by
  the declaration <verbatim|NONCOM>.

  <\verbatim>
    \<gtr\> declare operator [u,v];

    []

    \<gtr\> simplify (u(x)*u(y)-u(y)*u(x));

    0

    \<gtr\> declare noncom [u,v];

    []

    \<gtr\> simplify (u(x)*u(y)-u(y)*u(x));

    u x*u y-u y*u x
  </verbatim>

  <subsubsection|Symmetric and Antisymmetric
  Operators<label|symmetric-and-antisymmetric-operators>>

  An operator can be declared to be symmetric with respect to its arguments
  by the declaration <verbatim|SYMMETRIC>. Similarly, the declaration
  <verbatim|ANTISYMMETRIC> declares an operator antisymmetric.

  <\verbatim>
    \<gtr\> declare operator [A,S];

    []

    \<gtr\> declare symmetric S;

    []

    \<gtr\> declare antisymmetric A;

    []

    \;

    \<gtr\> simplify $ A x x ;

    0

    \;

    \<gtr\> simplify $ (A x y z) + (A x z y) ;

    0

    \;

    \<gtr\> simplify $ S y x ;

    S x y

    \;

    \<gtr\> simplify $ A y x ;

    -A x y
  </verbatim>

  <subsubsection|Creating/Removing Variable
  Dependencies<label|creating-removing-variable-dependencies>>

  There are several facilities in REDUCE, such as the differentiation
  operator and the linear operator facility, which can utilize knowledge of
  the dependencies between various variables. Such dependencies may be
  expressed by the command <verbatim|DEPEND>.

  <\verbatim>
    \<gtr\> declare operator D ;

    []

    \<gtr\> declare depend [D,x,y];

    []

    \;

    \<gtr\> simplify $ df D a;

    0
  </verbatim>

  <verbatim|D> does not depend on <verbatim|a>, thus differentiating with
  respect to <verbatim|a> yields 0, but

  <\verbatim>
    \<gtr\> simplify $ df D x;

    df D x
  </verbatim>

  because <verbatim|D> is declared to depend on <verbatim|x>. If we also let
  <verbatim|a> depend on <verbatim|x>, then:

  <\verbatim>
    \<gtr\> declare depend [a,x];

    []

    \<gtr\> simplify $ df (D*a) x;

    df D x*a+df a x*D
  </verbatim>

  <with|font-series|bold|Note:> Dependencies remain active until they are
  explicitly removed:

  <\verbatim>
    \<gtr\> declare nodepend [a,x];

    \<gtr\> simplify $ df a x;

    0

    \<gtr\> simplify $ df (D*a) x;

    df D x*a
  </verbatim>

  <subsubsection|Internal Order of Variables<label|internal-order-of-variables>>

  It is possible for the user to change the internal order of variables by
  means of the declaration <verbatim|KORDER>. The syntax for this is:

  <\description>
    <item*|declare korder [v1,...,vn]>
  </description>

  Unlike the ORDER declaration, which has a purely cosmetic effect on the way
  results are printed, the use of KORDER can have a significant effect on
  computation time.

  <\verbatim>
    \<gtr\> declare korder [z,y,x];

    []

    \<gtr\> x+y+z;

    x+y+z

    \<gtr\> simplify $ x+y+z;

    z+y+x
  </verbatim>

  <subsubsection|Parts of Algebraic Expressions<label|parts-of-algebraic-expressions>>

  The following operators can be used to obtain a specific part of an
  expression, or even change such a part to another expression.

  <\description>
    <item*|coeff expr::polynomial var>

    <item*|coeffn expr::polynomial var n::int>

    <item*|part expr::algebraic [n::int]>
  </description>

  Examples:

  <\verbatim>
    \<gtr\> simplify $ coeff ((y^2+z)^3/z) y ;

    [z^2,0,3*z,0,3,0,1/z]

    \;

    \<gtr\> simplify $ coeffn ((y^2+z)^3/z) y 6;

    1/z

    \;

    \<gtr\> simplify $ part (a+b) 2 ;

    b

    \;

    \<gtr\> simplify $ part (a+b) 1 ;

    a

    \;

    \<gtr\> simplify $ part (a+b) 0 ;

    (+)
  </verbatim>

  <verbatim|PART> may also be used to substitute a given part of an
  expression. In this case, the <verbatim|PART> construct appears on the
  left-hand side of an assignment statement (cf.
  <hlink|Assignment|#assignment>), and the expression to replace the given
  part on the right-hand side.

  <\verbatim>
    \<gtr\> \ simplify $ xx:=a+b;

    a+b

    \<gtr\> \ simplify $ part xx 2 := c ;

    c

    \<gtr\> \ simplify $ xx;

    a+c
  </verbatim>

  <subsubsection|Polynomials and Rationals<label|polynomials-and-rationals>>

  REDUCE is capable of factorizing univariate and multivariate polynomials
  with integer coefficients, finding all factors with integer coefficients.
  The package for doing this was written by Dr. Arthur C. Norman and Ms. P.
  Mary Ann Moore at The University of Cambridge. It is described in
  <hlink|[SYMSAC81]|#symsac81>.

  <\description>
    <item*|factorize expr::polynomial [p::prime]>
  </description>

  Some examples:

  <\verbatim>
    \<gtr\> simplify $ factorize (x^105-1) ;

    [[x^48+x^47+x^46-x^43-x^42-2*x^41-x^40 ... ]

    \;

    \<gtr\> reduce::switch "ifactor" 1;

    0

    \<gtr\> simplify $ factorize (12*x^2 - 12) ;

    [[2,2],[3,1],[x+1,1],[x-1,1]]

    \<gtr\> reduce::switch "ifactor" 0;

    0
  </verbatim>

  The following operators should be well known:

  <\description>
    <item*|gcd expr1::polynomial expr2::polynomial -\<gtr\> polynomial>

    <item*|lcm expr1::polynomial expr2::polynomial -\<gtr\> polynomial>

    <item*|remainder expr1::polynomial expr2::polynomial -\<gtr\> polynomial>

    <item*|resultant expr1::polynomial expr2::polynomial var -\<gtr\>
    polynomial>

    <item*|decompose expr::polynomial -\<gtr\> list>

    <item*|interpol \<less\>values\<gtr\> \<less\>variable\<gtr\>
    \<less\>points\<gtr\>) -\<gtr\> polynomial>

    <item*|deg expr::polynomial var -\<gtr\>int>

    <item*|den expr::rational -\<gtr\> polynomial>

    <item*|lcof expr::polynomial var -\<gtr\> polynomial>

    <item*|lpower expr::polynomial var-\<gtr\> polynomial>

    <item*|lterm expr::polynomial var -\<gtr\> polynomial>

    <item*|mainvar expr::polynomial -\<gtr\> expr>

    <item*|num expr::rational -\<gtr\> polynomial>

    <item*|reduct expr::polynomial var -\<gtr\> polynomial>
  </description>

  Some examples of each operator:

  GCD/LCM

  <\verbatim>
    \<gtr\> simplify $ gcd (x^2+2*x+1) (x^2+3*x+2) ;

    x+1

    \<gtr\> simplify $ gcd (2*x^2-2*y^2) (4*x+4*y) ;

    2*x+2*y

    \<gtr\> simplify $ gcd (x^2+y^2) (x-y) ;

    1

    \;

    \<gtr\> simplify $ lcm (x^2+2*x+1) (x^2+3*x+2) ;

    x^3+4*x^2+5*x+2

    \<gtr\> simplify $ lcm (2*x^2-2*y^2) (4*x+4*y) ;

    4*x^2-4*y^2
  </verbatim>

  REMAINDER/RESULTANT

  <\verbatim>
    \<gtr\> simplify $ remainder ((x+y)*(x+2*y)) (x+3*y) ;

    2*y^2

    \<gtr\> simplify $ remainder (2*x+y) 2 ;

    y

    \;

    \<gtr\> simplify $ resultant (x/r*u+y) (u*y) u ;

    -y^2
  </verbatim>

  DECOMPOSE

  <\verbatim>
    \<gtr\> simplify $ decompose (x^8-88*x^7+2924*x^6-43912*x^5+263431*x^4-

    \<gtr\> \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 218900*x^3+65690*x^2-7700*x+234)
    ;

    [u^2+35*u+234,u==v^2+10*v,v==x^2-22*x]

    \;

    \<gtr\> simplify $ decompose (u^2+v^2+2*u*v+1) ;

    [w^2+1,w==u+v]
  </verbatim>

  DEG/DEN

  <\verbatim>
    \<gtr\> simplify $ deg ((a+b)*(c+2*d)^2) d ;

    2

    \<gtr\> simplify $ deg ((x+b)*(x^6+2*y)^2) x ;

    13

    \;

    \<gtr\> simplify $ den (x/y^2) ;

    y^2
  </verbatim>

  LCOF/LPOWER/LTERM

  <\verbatim>
    \<gtr\> simplify $ lcof ((a+b)*(c+2*d)^2) a ;

    c^2+4*c*d+4*d^2

    \<gtr\> simplify $ lcof ((a+b)*(c+2*d)^2) d ;

    4*a+4*b

    \<gtr\> simplify $ lcof ((a+b)*(c+2*d)) ('e) ;

    a*c+2*a*d+b*c+2*b*d

    \;

    \<gtr\> simplify $ lpower ((a+b)*(c+2*d)^2) a ;

    a

    \<gtr\> simplify $ lpower ((a+b)*(c+2*d)^2) d ;

    d^2

    \<gtr\> simplify $ lpower ((a+b)*(c+2*d)) x ;

    1

    \;

    \<gtr\> simplify $ lterm ((a+b)*(c+2*d)^2) a ;

    a*c^2+4*a*c*d+4*a*d^2

    \<gtr\> simplify $ lterm ((a+b)*(c+2*d)^2) d ;

    4*a*d^2+4*b*d^2

    \<gtr\> simplify $ lterm ((a+b)*(c+2*d)) x ;

    a*c+2*a*d+b*c+2*b*d
  </verbatim>

  MAINVAR/NUM/REDUCT

  <\verbatim>
    \<gtr\> simplify $ mainvar ((a+b)*(c+2*d)^2) ;

    a

    \<gtr\> simplify $ mainvar 2 ;

    0

    \;

    \<gtr\> simplify $ num (x/y^2) ;

    x

    \<gtr\> simplify $ num ('(100/6)) ;

    50

    \<gtr\> simplify $ num (a/4+b/6) ;

    3*a+2*b

    \;

    \<gtr\> simplify $ reduct ((a+b)*(c+2*d)) a ;

    b*c+2*b*d

    \<gtr\> simplify $ reduct ((a+b)*(c+2*d)) d ;

    a*c+b*c

    \<gtr\> simplify $ reduct ((a+b)*(c+2*d)) x ;

    0
  </verbatim>

  <subsubsection|Substitution<label|substitution>>

  An important class of commands in REDUCE define substitutions for variables
  and expressions to be made during the evaluation of expressions. One such
  operation is the prefix operator <verbatim|SUB>.

  <\description>
    <item*|sub \<less\>substlist\<gtr\> exprn::algebraic -\<gtr\> algebraic>
  </description>

  <\verbatim>
    \<gtr\> simplify $ sub [x==a+y,y==y+1] (x^2+y^2) ;

    a^2+2*a*y+2*y^2+2*y+1

    \;

    \<gtr\> simplify $ sub [a==sin x, b==sin y] (a^2+b^2) ;

    sin x^2+sin y^2
  </verbatim>

  Note that simple substitutions of this kind can also be done directly in
  Pure, using the <hlink|<with|font-family|tt|reduce>|purelib.tm#reduce>
  macro.

  <subsubsection|Assignment<label|assignment>>

  One may assign values to variables in the REDUCE environment. Note that in
  Pure the <verbatim|set> operator and <verbatim|:=> are equivalent, i.e.
  both sides are evaluated, contrary to the <verbatim|:=> version in REDUCE.

  <\description>
    <item*|set expr expr>

    <item*|expr := expr>
  </description>

  <\verbatim>
    \<gtr\> simplify $ P := a*x^n + b* x^m + c ; \ \ \ \ \ // P:=a*x^n + b*
    x^m + c;

    x^m*b+x^n*a+c

    \<gtr\> simplify P ; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ //
    return P (from Reduce)

    x^m*b+x^n*a+c

    \<gtr\> simplify $ df P x; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ //
    diff P x

    (x^m*b*m+x^n*a*n)/x

    \<gtr\> simplify $ Q := intg P x ; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ //
    integrate P x, store in Q

    (x^m*b*n*x+x^m*b*x+x^n*a*m*x+x^n*a*x+c*m*n*x+c*m*x+c*n*x+c*x)/(m*n+m+n+1)

    \;

    \<gtr\> simplify $ set Q (a*x^n + b* x^m + c) ;

    x^m*b+x^n*a+c
  </verbatim>

  <subsubsection|Matrix Calculations<label|matrix-calculations>>

  A very powerful feature of REDUCE is the ease with which matrix
  calculations can be performed. It fits very well into Pure's native matrix
  type.

  To keep it simple we show the usage of the different operators by examples
  using the well known <with|font-series|bold|Pauli matrices>. See, e.g.,
  <hlink|http://en.wikipedia.org/wiki/Pauli_matrices|http://en.wikipedia.org/wiki/Pauli-matrices>
  for a reference.

  <\center>
    <puredoc-image|_images/math/ef9429df1c03f8216e05dac3b1d943d56fb88af8.png|66%|66%||>
  </center>

  <\verbatim>
    let s0 = {1,0;0,1} ;

    let s1 = {0,1;1,0} ;

    let s2 = {0,-i;i,0};

    let s3 = {1,0;0,-1};
  </verbatim>

  Check the identities

  <\center>
    <puredoc-image|_images/math/216b21e2179433dcc0e06ff4647d3664ccf499c1.png|66%|66%||>
  </center>

  where <puredoc-image|_images/math/84e3ca966fe4905aa8e6549a570dd032675fb5da.png|66%|66%||>
  denotes the unit matrix.

  Note: Instead of <verbatim|s1*s1> we could also write <verbatim|s1^2> here.

  <\verbatim>
    \<gtr\> let r1 = simplify $ (s1*s1) ; r1;

    {1,0;0,1}

    \<gtr\> let r2 = simplify $ (s2*s2) ; r2;

    {1,0;0,1}

    \<gtr\> let r3 = simplify $ (s3*s3) ; r3;

    {1,0;0,1}

    \<gtr\> let r4 = simplify $ (-i*s1*s2*s3) ; r4;

    {1,0;0,1}

    \<gtr\> let r5 = all (==s0) [r1,r2,r3,r4] ; r5;

    1
  </verbatim>

  Check: <puredoc-image|_images/math/cd4a6dc4452fe2f8d015170e3e9f54378c498b36.png|66%|66%||>

  <\verbatim>
    \<gtr\> map (simplify . det) [s1,s2,s3] ;

    [-1,-1,-1]
  </verbatim>

  Calculate the eigenvalues/-vectors of <puredoc-image|_images/math/c228ed3c88cd90a7dff90a1693e80272b2e39303.png|66%|66%||>:

  <\verbatim>
    \<gtr\> let r7 = simplify $ mateigen s2 q; r7;

    [[q-1,1,{-c1*i;c2}],[q+1,1,{c3*i;c4}]]

    \;

    \<gtr\> let r8 = map head r7; r8; // -\<gtr\> [q-1,q+1] =\<gtr\>
    Eigenvalues q=+/-1

    [q-1,q+1]

    \;

    \<gtr\> let r9 = map (head.tail) r7 ; r9; // multiplicities

    [1,1]

    \;

    \<gtr\> let r10 = map last r7 ; r10; // eigenvectors

    [{-c1*i;c2},{c3*i;c4}]
  </verbatim>

  Transpose (operator <verbatim|tp>):

  <\verbatim>
    \<gtr\> map (simplify.tp) [s1,s2,s3] ; // -\<gtr\> [s1',s2',s3']

    [{0,1;1,0},{0,i;-i,0},{1,0;0,-1}]
  </verbatim>

  Trace (operator <verbatim|trace>):

  <\verbatim>
    \<gtr\> map (simplify.trace) [s1,s2,s3] ;

    [0,0,0]
  </verbatim>

  Cofactor (trivial here):

  <\verbatim>
    \<gtr\> simplify $ cofactor s2 1 1 ;

    0
  </verbatim>

  Nullspace of <puredoc-image|_images/math/c228ed3c88cd90a7dff90a1693e80272b2e39303.png|66%|66%||>
  + {0,i;0,0}:

  <\verbatim>
    \<gtr\> simplify $ nullspace (s2+{0,i;0,0}) ;

    [{0;1}]
  </verbatim>

  Rank:

  <\verbatim>
    \<gtr\> map (simplify . rank) [s0,s1,s2,s3] ;

    [2,2,2,2]
  </verbatim>

  Inverse (simply <puredoc-image|_images/math/eca231602567a7238426dd18cd9b8884244e80a6.png|66%|66%||>):

  <\verbatim>
    \<gtr\> let r15 = simplify $ 1/s2 ; r15;

    {0,1/i;(-1)/i,0}

    \;

    \<gtr\> simplify $ s2*r15 ;

    {1,0;0,1}
  </verbatim>

  Solving without <verbatim|solve>:

  <\center>
    <puredoc-image|_images/math/34f3da77dd3b880fec7bf1e230ffeca5cfbda0f1.png|66%|66%||>
  </center>

  <\verbatim>
    \<gtr\> simplify $ (1/{a11,a12;a21,a22}*{y1;y2}) ; // A^-1 * y' ;

    {(-a12*y2+a22*y1)/(a11*a22-a12*a21);(a11*y2-a21*y1)/(a11*a22-a12*a21)}
  </verbatim>

  <subsubsection|Limits<label|limits>>

  From the package description:

  LIMITS is a fast limit package for REDUCE for functions which are
  continuous except for computable poles and singularities, based on some
  earlier work by Ian Cohen and John P. Fitch. This package defines a LIMIT
  operator, called with the syntax:

  <\description>
    <item*|limit expr::alg var limpoint::alg -\<gtr\> alg>
  </description>

  <\center>
    <puredoc-image|_images/math/f8a2e36dcd35ca36fedb4eeec36b0083ef7e03a4.png|66%|66%||>
  </center>

  <\verbatim>
    \<gtr\> simplify $ limit (x*sin(1/x)) x infinity ;

    1

    \;

    \<gtr\> simplify $ limit (1/x) x 0 ;

    inf
  </verbatim>

  Notes: This package loads automatically. Author: Stanley L. Kameny.

  <subsubsection|Ordinary differential equations
  solver<label|ordinary-differential-equations-solver>>

  The <verbatim|ODESOLVE> package is a solver for ordinary differential
  equations.

  Problem 1:

  <\center>
    <puredoc-image|_images/math/f24b04d99037127809e6e6b1fbab50d43bfd555a.png|66%|66%||>
  </center>

  <\verbatim>
    \<gtr\> declare depend [y,x]; \ // declare: y depends on x

    []

    \;

    \<gtr\> simplify $ odesolve [df y x == x^2+exp(x)] [y] x ;

    [y==(3*C+3*e^x+x^3)/3]
  </verbatim>

  Problem 2:

  <\center>
    <puredoc-image|_images/math/0a39511ff3e7958dca65d4615b1b5346d2e537fa.png|66%|66%||>
  </center>

  <\verbatim>
    \<gtr\> simplify $ odesolve [(df y x 2) == y] [y] x
    [[x==0,y==A],[x==1,y==B]] ;

    [y==(-e^(2*x)*A+e^(2*x)*B*e+A*e^2-B*e)/(e^x*e^2-e^x)]
  </verbatim>

  Remember to remove dependencies:

  <\verbatim>
    \<gtr\> declare nodepend [y,x];

    []
  </verbatim>

  <subsubsection|Series Summation and Products<label|series-summation-and-products>>

  <verbatim|SUM>: A package for series summation

  From the package description:

  The package implements the Gosper algorithm for the summation of series. It
  defines operators <verbatim|SUM> and <verbatim|PROD>. The operator
  <verbatim|SUM> returns the indefinite or definite summation of a given
  expression, and <verbatim|PROD> returns the product of the given
  expression. This package loads automatically. Author: Fujio Kako.

  Calculate

  <\center>
    <puredoc-image|_images/math/fc9dd7cf2c7384de8e0a7981da76bb7e1d63e312.png|66%|66%||>
  </center>

  <\verbatim>
    \<gtr\> simplify $ sum (n^3) n 1 N ;

    (N^4+2*N^3+N^2)/4

    \;

    \<gtr\> simplify $ sum (a+k*r) k 0 (n-1) ;

    (2*a*n+n^2*r-n*r)/2

    \;

    \<gtr\> simplify $ sum (1/((p+(k-1)*q)*(p+k*q))) k 1 (n+1) ;

    (n+1)/(n*p*q+p^2+p*q)

    \;

    \<gtr\> simplify $ prod (k/(k+2)) k 1 N ;

    2/(N^2+3*N+2)
  </verbatim>

  <subsubsection|Taylor Series<label|taylor-series>>

  <verbatim|TAYLOR>: Manipulation of Taylor series

  From the package description:

  This package carries out the Taylor expansion of an expression in one or
  more variables and efficient manipulation of the resulting Taylor series.
  Capabilities include basic operations (addition, subtraction,
  multiplication and division) and also application of certain algebraic and
  transcendental functions. Author: Rainer Schöpf.

  Example:

  <\center>
    <puredoc-image|_images/math/d1ad9405c881f837437198ce7a7e55ca096b8ed7.png|66%|66%||>
  </center>

  For details consult the package documentation in the REDUCE distribution.

  <\verbatim>
    \<gtr\> simplify $ taylor (exp (x^2+y^2)) x 0 2 y 0 2 ;

    x^2*y^2+x^2+y^2+1

    \;

    \<gtr\> simplify $ taylor (exp x) x 0 3;

    (x^3+3*x^2+6*x+6)/6

    \;

    \<gtr\> simplify $ implicit_taylor (x^2+y^2-1) x y 0 1 5 ;

    (-x^4-4*x^2+8)/8

    \;

    \<gtr\> simplify $ inverse_taylor (exp(x)-1) x y 0 8;

    (-105*y^8+120*y^7-140*y^6+168*y^5-210*y^4+280*y^3-420*y^2+840*y)/840
  </verbatim>

  Note that the ``big O'' residual terms are omitted in the results returned
  by <verbatim|simplify>, although REDUCE will print them.

  <subsubsection|Boolean Expressions<label|boolean-expressions>>

  The truth values within REDUCE are <verbatim|t> and <verbatim|nil>
  <verbatim|=> <verbatim|()>. Not all predicates (functions returning a truth
  value) can be called by <verbatim|simplify>, however, so one has to use the
  <verbatim|lisp> function in some circumstances.

  Some examples:

  <\verbatim>
    \<gtr\> simplify $ evenp 200 ;

    t

    \<gtr\> simplify $ evenp 201 ;

    []

    \;

    \<gtr\> lisp (fixp 200) ;

    t
  </verbatim>

  where <verbatim|fixp> tests for integers.

  The following example shows a pitfall. Since there is a <verbatim|numberp>
  function in both Pure and REDUCE, the function needs to be quoted to make
  the expression go through to REDUCE:

  <\verbatim>
    \<gtr\> lisp (numberp x) ;

    0

    \<gtr\> lisp (numberp 111) ;

    1

    \;

    \<gtr\> lisp ('numberp x) ;

    []

    \<gtr\> lisp ('numberp 111) ;

    t
  </verbatim>

  In the first case <verbatim|numberp> <verbatim|x> evaluates to zero in
  Pure, so the <verbatim|lisp> function gets <verbatim|0> and returns
  <verbatim|0>. In the second case (quoted) the function <verbatim|numberp>
  is evaluated in REDUCE and returns <verbatim|nil>, i.e. <verbatim|[]> in
  Pure. Of course, both results are correct but there may be other cases
  where equally named functions have different meanings in the two
  environments.

  Some other useful predicates in REDUCE are <verbatim|ordp> and
  <verbatim|freeof>:

  <\verbatim>
    \<gtr\> lisp (ordp x y) ;

    t

    \<gtr\> lisp (ordp y x) ;

    []

    \<gtr\> lisp (ordp "abc" "abd") ;

    t

    \<gtr\> lisp (ordp "abd" "abc") ;

    []

    \<gtr\> lisp (ordp 3 5) ;

    []

    \<gtr\> lisp (ordp 5 3) ;

    t

    \;

    \<gtr\> simplify $ freeof (x^2+y) x ;

    0

    \<gtr\> simplify $ freeof (x^2+y) z ;

    1

    \<gtr\> simplify $ freeof (x^n*y^m) (y^m) ;

    0
  </verbatim>

  <subsubsection|Mathematical Functions<label|mathematical-functions>>

  REDUCE provides many mathematical functions which can take arbitrary scalar
  expressions as their single argument:

  <\quote-env>
    <\itemize>
      <item>ACOS ACOSH ACOT ACOTH ACSC ACSCH ASEC ASECH ASIN ASINH

      <item>ATAN ATANH ATAN2 COS COSH COT COTH CSC CSCH DILOG EI EXP

      <item>HYPOT LN LOG LOGB LOG10 SEC SECH SIN SINH SQRT TAN TANH ERF
    </itemize>
  </quote-env>

  Note that Pure also defines some these functions in its
  <hlink|<with|font-family|tt|math>|purelib.tm#module-math> module, so these
  may have to be quoted to prevent evaluation on the Pure side. For instance:

  <\verbatim>
    \<gtr\> simplify $ cos 4.3;

    cos (43/10)

    \<gtr\> using math;

    warning: external 'exp' shadows previous undefined use of this symbol

    warning: external 'sin' shadows previous undefined use of this symbol

    warning: external 'cos' shadows previous undefined use of this symbol

    \<gtr\> simplify $ cos 4.3;

    (-21601483)/53896027
  </verbatim>

  Some examples:

  <\verbatim>
    \<gtr\> simplify $ cos (-x) ;

    cos x

    \<gtr\> simplify $ cos (n*pi) ;

    cos (80143857*n/25510582)

    \<gtr\> simplify $ (quote e)^(3*i*(quote pi)/2) ;

    \;

    -i

    \<gtr\> simplify $ sec (quote pi);

    -1

    \<gtr\> let simplify $ log10 10 ;

    1

    \<gtr\> simplify $ erf (-a);

    -erf a
  </verbatim>

  The special functions are in two separate packages <verbatim|SPECFN> and
  <verbatim|SPECFN2>:

  <\quote-env>
    <\itemize>
      <item>Bernoulli Numbers and Euler Numbers;

      <item>Stirling Numbers;

      <item>Binomial Coefficients;

      <item>Pochhammer notation;

      <item>The Gamma function;

      <item>The Psi function and its derivatives;

      <item>The Riemann Zeta function;

      <item>The Bessel functions J and Y of the first and second kind;

      <item>The modified Bessel functions I and K;

      <item>The Hankel functions H1 and H2;

      <item>The Kummer hypergeometric functions M and U;

      <item>The Beta function, and Struve, Lommel and Whittaker functions;

      <item>The Airy functions;

      <item>The Exponential Integral, the Sine and Cosine Integrals;

      <item>The Hyperbolic Sine and Cosine Integrals;

      <item>The Fresnel Integrals and the Error function;

      <item>The Dilog function;

      <item>Hermite Polynomials;

      <item>Jacobi Polynomials;

      <item>Legendre Polynomials;

      <item>Spherical and Solid Harmonics;

      <item>Laguerre Polynomials;

      <item>Chebyshev Polynomials;

      <item>Gegenbauer Polynomials;

      <item>Euler Polynomials;

      <item>Bernoulli Polynomials.

      <item>Jacobi Elliptic Functions and Integrals;

      <item>3j symbols, 6j symbols and Clebsch Gordan coefficients;
    </itemize>
  </quote-env>

  In <verbatim|SPECFN2> are the generalized hypergeometric functions and
  Meijer's G function.

  Author: Chris Cannam, with contributions from Winfried Neun, Herbert
  Melenk, Victor Adamchik, Francis Wright and several others.

  <subsubsection|Definite Integrals<label|definite-integrals>>

  <verbatim|DEFINT>: Calculating definite integrals by using the Meijer G
  integration formula.

  <\center>
    <puredoc-image|_images/math/33dd216945188977c58adbd8625803b758ee4ca3.png|66%|66%||>
  </center>

  <\verbatim>
    \<gtr\> reduce::load "defint" ;

    0

    \;

    \<gtr\> simplify $ intg (exp(-x)) x 0 infinity ;

    1
  </verbatim>

  <\center>
    <puredoc-image|_images/math/061df7e1c31cee25f62ca1f993eb96c9bfa5c5bc.png|66%|66%||>
  </center>

  <\verbatim>
    \<gtr\> simplify $ intg (x^2*cos(x)*exp(-2*x)) x 0 infinity ;

    4/125
  </verbatim>

  <\center>
    <puredoc-image|_images/math/53005462bb7553344bca7b6e7ed26502fd107f17.png|66%|66%||>
  </center>

  <\verbatim>
    \<gtr\> simplify $ intg (x*exp(-1/2*x)) x 0 1 ;

    2*sqrt e*(2*sqrt e-3)/e
  </verbatim>

  <\center>
    <puredoc-image|_images/math/fccfe728856311a1b54d285d9380b3f884ae324f.png|66%|66%||>
  </center>

  <\verbatim>
    \<gtr\> simplify $ intg (x*log(1+x)) x 0 1 ;

    1/4
  </verbatim>

  <\center>
    <puredoc-image|_images/math/af9af53f1a7cfc1c898f0ba87bee44344987cab4.png|66%|66%||>
  </center>

  <\verbatim>
    \<gtr\> simplify $ intg (cos(2*x)) x y (2*y);

    (sin (4*y)-sin (2*y))/2
  </verbatim>

  Various transformations:

  <\verbatim>
    \<gtr\> simplify $ laplace_transform (exp(-a*x)) x ;

    1/(a+s)

    \;

    \<gtr\> simplify $ hankel_transform (exp(-a*x)) x ;

    s^(n/2)*gamma (n/2)*hypergeometric [(n+2)/2] [n+1]

    ((-s)/a)*n/(2*a^(n/2)*gamma (n+1)*a)

    \;

    \<gtr\> simplify $ y_transform (exp(-a*x)) x ;

    (a^n*gamma (n+1)*gamma ((-n)/2)*gamma ((-2*n-1)/2)*gamma

    ((2*n+3)/2)*hypergeometric [(-n+2)/2] [-n+1] ((-s)/a)+s^n*gamma

    (-n)*gamma (n/2)*hypergeometric [(n+2)/2] [n+1] ((-s)/a)*n*pi)/

    (2*s^(n/2)*a^(n/2)*gamma ((-2*n-1)/2)*gamma ((2*n+3)/2)*a*pi)

    \;

    \<gtr\> simplify $ k_transform (exp(-a*x)) x ;

    (-a^n*gamma (n+1)*gamma ((-n)/2)*hypergeometric [(-n+2)/2] [-n+1]

    (s/a)+s^n*gamma (-n)*gamma (n/2)*hypergeometric [(n+2)/2] [n+1] (s/a)*n)/

    (4*s^(n/2)*a^(n/2)*a)

    \;

    \<gtr\> \ simplify $ struveh_transform (exp(-a*x)) x ;

    2*s^((n+1)/2)*gamma ((n+3)/2)*hypergeometric [1,(n+3)/2] [(2*n+3)/2,3/2]

    ((-s)/a)/(sqrt pi*a^((n+1)/2)*gamma ((2*n+3)/2)*a)

    \;

    \<gtr\> simplify $ fourier_sin (exp(-a*x)) x ;

    s/(a^2+s^2)

    \<gtr\> simplify $ fourier_cos (exp(-a*x)) x ;

    a/(a^2+s^2)
  </verbatim>

  <subsubsection|Declarations, Switches and
  Loading<label|declarations-switches-and-loading>>

  Lisp evaluation can be used in the REDUCE system, in particular, to declare
  operator symbols and their properties (<verbatim|simplify> won't do that).
  E.g.:

  <\verbatim>
    \<gtr\> lisp ('operator [myop]);

    \<gtr\> lisp ('flag [myop] odd);

    \<gtr\> lisp ('prop myop); // =\<gtr\> [odd:t,simpfn:simpiden]

    \<gtr\> simplify (myop (-x)); // =\<gtr\> -myop x
  </verbatim>

  For the most common kinds of declarations, the
  <hlink|<with|font-family|tt|reduce>|#module-reduce> module provides the
  <hlink|<with|font-family|tt|declare>|#declare> function which takes care of
  the necessary Lisp magic and is safe to use. The above example can also be
  done as follows:

  <\verbatim>
    \<gtr\> declare operator myop;

    \<gtr\> declare odd myop;

    \<gtr\> simplify (myop (-x));

    -myop x
  </verbatim>

  Please see the description of <hlink|<with|font-family|tt|declare>|#declare>
  for a list of supported declarations.

  The <hlink|<with|font-family|tt|reduce>|#module-reduce> module also
  provides a few other basic maintenance functions which are done with
  special commands in REDUCE:

  <\description>
    <item*|reduce::switch "switch-name" 0\|1>

    <item*|reduce::load "package-name">

    <item*|reduce::in "path/filename.red">

    <item*|reduce::capture 0\|1>

    <item*|reduce::feed "text">
  </description>

  As already mentioned, REDUCE switches can be turned on and off with
  <hlink|<with|font-family|tt|reduce::switch>|#reduce::switch>, e.g.:

  <\verbatim>
    \<gtr\> reduce::switch "exp" 0 ;

    0
  </verbatim>

  Packages can be loaded with the <hlink|<with|font-family|tt|reduce::load>|#reduce::load>
  command:

  <\verbatim>
    \<gtr\> reduce::load "defint" ;

    0
  </verbatim>

  REDUCE source files can be read in with the
  <hlink|<with|font-family|tt|reduce::in>|#reduce::in> command:

  <\verbatim>
    \<gtr\> reduce::in "myreduce.red" ;

    0
  </verbatim>

  Last but not least, REDUCE terminal input and output can also be redirected
  to string buffers using the <hlink|<with|font-family|tt|reduce::feed>|#reduce::feed>
  and <hlink|<with|font-family|tt|reduce::capture>|#reduce::capture>
  functions. For instance, the following code feeds some text with a Lisp
  form to REDUCE, which gets read by evaluating the Lisp form
  <verbatim|(eval> <verbatim|read)>. The output is captured and can be
  inspected with the <hlink|<with|font-family|tt|reduce::output>|#reduce::output>
  function:

  <\verbatim>
    \<gtr\> reduce::feed "(print '(a b c d))";

    0

    \<gtr\> reduce::capture 1; // start capturing output

    0

    \<gtr\> lisp ('eval read); // read buffered input and evaluate

    [a,b,c,d]

    \<gtr\> reduce::output; \ \ \ // inspect buffered output

    "(a b c d)\\n"

    \<gtr\> reduce::capture 0; // stop capturing output

    0
  </verbatim>

  <subsubsection|Plotting<label|plotting>>

  REDUCE can do 2- and 3-dimensional function plots through its
  <hlink|gnuplot|http://www.gnuplot.info/> package. Some examples (note that
  we have to quote the <verbatim|x..y> ranges here so that they get through
  to Reduce, rather than being evaluated on the Pure side):

  <\verbatim>
    \<gtr\> simplify $ plot (sin x/x) (x=='(-15..15));

    \;

    // Multiple ranges.

    \<gtr\> simplify $ plot (sin(x^2 + y^2) / sqrt(x^2 + y^2))
    [x=='(-12..12), y=='(-12..12)];

    \;

    // Specifying options.

    \<gtr\> simplify $ plot (cos (sqrt(x^2 + y^2))) [x=='(-3..3),y=='(-3 ..
    3)] hidden3d;

    \;

    // Specifying points.

    \<gtr\> simplify $ plot [[0,0],[0,1],[1,1],[0,0],[1,0],[0,1],[0.5,1.5],[1,1],[1,0]];

    \;

    // Output options.

    \<gtr\> simplify $ plot (sin x) [x=='(0..10),terminal==postscript,output=="sin.ps"];
  </verbatim>

  <subsubsection|References<label|references>>

  <\description>
    <item*|[REDUM]<label|redum>><em|REDUCE User's Manual>, Version 3.8,
    Anthony C. Hearn, Santa Monica, CA, USA.
  </description>

  <\description>
    <item*|[LNCS102]<label|lncs102>><em|On the Integration of Algebraic
    Functions>, LNCS 102, Springer Verlag, 1981.
  </description>

  <\description>
    <item*|[SYMSAC81]<label|symsac81>>P. M. A. Moore and A.C. Norman,
    <em|Implementing a Polynomial Factorization and GCD Package>, Proc.
    SYMSAC '81, ACM (New York) (1981), 109-116.
  </description>

  <subsubsection*|<hlink|Table Of Contents|index.tm><label|pure-reduce-toc>>

  <\itemize>
    <item><hlink|Computer Algebra with Pure: A Reduce Interface|#>

    <\itemize>
      <item><hlink|Copying|#copying>

      <item><hlink|Installation|#installation>

      <item><hlink|Low-Level Interface|#low-level-interface>

      <item><hlink|High-Level Interface|#high-level-interface>

      <\itemize>
        <item><hlink|Starting and Stopping
        Reduce|#starting-and-stopping-reduce>

        <item><hlink|Maintenance Operations|#maintenance-operations>

        <item><hlink|Evaluation|#evaluation>
      </itemize>

      <item><hlink|Basic Examples|#basic-examples>

      <item><hlink|Examples by Topic|#examples-by-topic>

      <\itemize>
        <item><hlink|Differentiation|#differentiation>

        <item><hlink|Integration|#integration>

        <item><hlink|Length, Map and Select|#length-map-and-select>

        <item><hlink|Partial Fractions|#partial-fractions>

        <item><hlink|Solving|#solving>

        <item><hlink|Even and Odd Operators|#even-and-odd-operators>

        <item><hlink|Linear Operators|#linear-operators>

        <item><hlink|Non-commuting Operators|#non-commuting-operators>

        <item><hlink|Symmetric and Antisymmetric
        Operators|#symmetric-and-antisymmetric-operators>

        <item><hlink|Creating/Removing Variable
        Dependencies|#creating-removing-variable-dependencies>

        <item><hlink|Internal Order of Variables|#internal-order-of-variables>

        <item><hlink|Parts of Algebraic Expressions|#parts-of-algebraic-expressions>

        <item><hlink|Polynomials and Rationals|#polynomials-and-rationals>

        <item><hlink|Substitution|#substitution>

        <item><hlink|Assignment|#assignment>

        <item><hlink|Matrix Calculations|#matrix-calculations>

        <item><hlink|Limits|#limits>

        <item><hlink|Ordinary differential equations
        solver|#ordinary-differential-equations-solver>

        <item><hlink|Series Summation and
        Products|#series-summation-and-products>

        <item><hlink|Taylor Series|#taylor-series>

        <item><hlink|Boolean Expressions|#boolean-expressions>

        <item><hlink|Mathematical Functions|#mathematical-functions>

        <item><hlink|Definite Integrals|#definite-integrals>

        <item><hlink|Declarations, Switches and
        Loading|#declarations-switches-and-loading>

        <item><hlink|Plotting|#plotting>

        <item><hlink|References|#references>
      </itemize>
    </itemize>
  </itemize>

  Previous topic

  <hlink|Pure-Rational - Rational number library for the Pure programming
  language|pure-rational.tm>

  Next topic

  <hlink|Pure-CSV - Comma Separated Value Interface for the Pure Programming
  Language|pure-csv.tm>

  <hlink|toc|#pure-reduce-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-csv.tm> \|
  <hlink|previous|pure-rational.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2014, Albert Gräf et al. Last updated on Sep
  09, 2014. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
