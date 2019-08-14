<TeXmacs|1.99.11>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-octave-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-rational.tm> \|
  <hlink|previous|pure-mpfr.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|pure-octave><label|module-octave>

  Version 0.12, August 14, 2019

  Albert Graef \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  A Pure interface to <hlink|GNU Octave|http://www.octave.org>.

  <subsection|Introduction><label|introduction>

  This is an Octave module for the Pure programming language, based on Paul
  Kienzle's <hlink|octave_embed|http://wiki.octave.org/wiki.pl?OctaveEmbedded>
  which allows Octave to be embedded in other languages. It allows you to
  execute arbitrary Octave commands and Octave functions from Pure.

  <subsection|Copying><label|copying>

  pure-octave is free software: you can redistribute it and/or modify it
  under the terms of the GNU General Public License as published by the Free
  Software Foundation, either version 3 of the License, or (at your option)
  any later version.

  pure-octave is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE.

  Please see the accompanying COPYING file for the precise license terms. The
  GPL can also be read online at <hlink|http://www.gnu.org/licenses/|http://www.gnu.org/licenses/>.

  <subsection|Installation><label|installation>

  Get the latest source from <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-octave-0.12.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-octave-0.12.tar.gz>.

  Run <verbatim|make> to compile the module and <verbatim|make>
  <verbatim|install> (as root) to install it in the Pure library directory.
  This requires GNU make, and of course you need to have both Pure and Octave
  installed (including Octave's <verbatim|mkoctfile> utility and the
  corresponding header files and libraries).

  <verbatim|make> tries to guess your Pure installation directory and
  platform-specific setup. If it gets this wrong, you can set some variables
  manually. In particular, <verbatim|make> <verbatim|install>
  <verbatim|prefix=/usr> sets the installation prefix. Please see the
  Makefile for details.

  This release of pure-octave has been tested and is known to work with
  Octave 3.6.2, 3.8, 4.0, 4.4, and 5.1. Older versions might require some
  fiddling with the sources to get the embedded Octave interface working.

  <with|font-series|bold|NOTE:> The embedded interpreter is broken with
  Octave <with|font-series|bold|4.2>, so make sure that you got a later
  version, or use one of the known good earlier versions listed above.

  <subsection|Basic Usage><label|basic-usage>

  Import this module into your Pure scripts as follows:

  <\verbatim>
    \;

    using octave;

    \;
  </verbatim>

  This will add an embedded instance of the Octave interpreter to your
  program. (You can import this module as often as you want, but there's
  always only one instance of Octave in each process.)

  <\description>
    <item*|octave_eval s<label|octave-eval>>Executes arbitrary Octave code.
  </description>

  <\verbatim>
    \;

    \<gtr\> octave_eval "eig([1 2;3 4])";

    ans =

    \;

    \ \ -0.37228

    \ \ \ 5.37228

    \;

    0

    \;
  </verbatim>

  This prints the result on stdout and returns a result code (zero if
  everything went fine). To suppress the printing of the result, simply
  terminate the Octave statement with a semicolon:

  <\verbatim>
    \;

    \<gtr\> octave_eval "eig([1 2;3 4]);";

    0

    \;
  </verbatim>

  <\description>
    <item*|octave_set var val<label|octave-set>>

    <item*|octave_get var<label|octave-get>>Set and get global variables in
    the Octave interpreter.
  </description>

  This allows you to define values to be used when evaluating Octave code,
  and to transfer results back to Pure. However, before such globals can be
  accessed in Octave, you must explicitly declare them as globals:

  <\verbatim>
    \;

    \<gtr\> octave_eval "global x y ans";

    0

    \;
  </verbatim>

  Now you can use <hlink|<with|font-family|tt|octave_set>|#octave-set> and
  <hlink|<with|font-family|tt|octave_get>|#octave-get> to transfer values
  between Pure and Octave as follows:

  <\verbatim>
    \;

    \<gtr\> octave_set "x" {1.0,2.0;3.0,4.0};

    {1.0,2.0;3.0,4.0}

    \<gtr\> octave_eval "eig(x);";

    0

    \<gtr\> octave_get "ans";

    {-0.372281323269014;5.37228132326901}

    \;
  </verbatim>

  Note that the most recent result can always be accessed through Octave's
  <verbatim|ans> variable. You can also use an explicit variable definition
  as follows:

  <\verbatim>
    \;

    \<gtr\> octave_eval "y = eig(x);";

    0

    \<gtr\> octave_get "y";

    {-0.372281323269014;5.37228132326901}

    \;
  </verbatim>

  <subsection|Direct Function Calls><label|direct-function-calls>

  <\description>
    <item*|octave_call fun n args<label|octave-call>>Call an octave function
    in a direct fashion. <verbatim|fun> denotes the name of the function,
    <verbatim|n> the number of function results and <verbatim|args> the
    function arguments.
  </description>

  <\verbatim>
    \;

    \<gtr\> let x = {1.0,2.0;3.0,4.0};

    \<gtr\> octave_call "eig" 1 x;

    {-0.372281323269014;5.37228132326901}

    \;
  </verbatim>

  Note the second argument, which denotes the desired number of <em|return>
  values. This will usually be 1 (or 0 if you don't care about the result),
  but some Octave functions may return a variable number of results,
  depending on how they're called. Multiple values are returned as tuples in
  Pure:

  <\verbatim>
    \;

    \<gtr\> octave_call "eig" 2 x;

    {-0.824564840132394,-0.415973557919284;0.565767464968992,-0.909376709132124},

    {-0.372281323269014,0.0;0.0,5.37228132326901}

    \;
  </verbatim>

  Multiple <em|arguments> are also specified as a tuple:

  <\verbatim>
    \;

    \<gtr\> octave_call "norm" 1 (x, 2);

    5.46498570421904

    \<gtr\> octave_call "norm" 1 (x, 1);

    6.0

    \;
  </verbatim>

  Instead of a function name, you can also specify the function to be called
  using a special kind of Octave object, a function value. These are
  returned, e.g., by Octave's <verbatim|str2func> and <verbatim|inline>
  builtins. For your convenience, pure-octave provides a frontend to these
  builtins, the <verbatim|octave_func> function, which lets you specify an
  Octave function in one of two ways:

  <\description>
    <item*|octave_func name<label|octave-func/name>>Returns the Octave
    function with the given name. This works like Octave's
    <verbatim|str2func> builtin.
  </description>

  <\description>
    <item*|octave_func expr<label|octave-func/expr>>Returns an \Pinline\Q
    function, where <verbatim|expr> is an Octave expression (as a string)
    describing the function value. This works like Octave's <verbatim|inline>
    builtin. Instead of just an Octave expression, you can also specify a
    tuple consisting of the inline expression and the parameter names.
    (Otherwise the parameters are determined automatically, see the
    description of the <verbatim|inline> function in the Octave manual for
    details.)
  </description>

  Note that inline functions allow you to call stuff that is not an Octave
  function and hence cannot be specified directly in
  <hlink|<with|font-family|tt|octave_call>|#octave-call>, such as an
  operator. Examples:

  <\verbatim>
    \;

    \<gtr\> let eig = octave_func "eig";

    \<gtr\> let mul = octave_func "x*y";

    \<gtr\> octave_call eig 1 (octave_call mul 1 (x,x));

    {0.138593383654928;28.8614066163451}

    \<gtr\> let add = octave_func ("x+y","x","y");

    \<gtr\> octave_call add 1 (x,x);

    {2.0,4.0;6.0,8.0}

    \;
  </verbatim>

  <subsection|Data Conversions><label|data-conversions>

  As shown above, the <hlink|<with|font-family|tt|octave_set>|#octave-set>,
  <hlink|<with|font-family|tt|octave_get>|#octave-get> and
  <hlink|<with|font-family|tt|octave_call>|#octave-call> functions convert
  Pure data to corresponding Octave values and vice versa. Octave scalars and
  matrices of boolean, integer, double, complex and character data are all
  directly supported by this interface, and are mapped to the corresponding
  Pure data types in a straightforward manner (scalars to scalars, matrices
  to matrices and strings to strings). Note that in any case these
  conversions create <em|copies> of the data, so modifying, say, an Octave
  matrix received via <hlink|<with|font-family|tt|octave_get>|#octave-get> in
  Pure only affects the Pure copy of the matrix and leaves the original
  Octave matrix unchanged.

  Octave's higher-dimensional numeric arrays, cell arrays and structures are
  not natively supported by the interface, but are implemented using special
  conversion hooks defined in the octave.pure module (see the
  <verbatim|__pure2oct__> and <verbatim|__oct2pure__> functions in
  octave.pure). This simplifies the implementation and makes these
  conversions customizable if the need arises. It also makes it possible to
  extend the interface for further special data structures in the future.
  Please check the octave.pure module for details. It's possible to disable
  these custom conversions with the <hlink|<with|font-family|tt|octave_converters>|#octave-converters>
  function:

  <\description>
    <item*|octave_converters flag<label|octave-converters>>Enable or disable
    custom data conversions between Pure and Octave. The given flag must be a
    truth value (zero means disable, any nonzero value enable). The function
    returns the previous value of the flag.
  </description>

  Octave objects which are neither handled natively by the interface nor
  through the auxiliary converters (if enabled) are just passed through as
  is, in the form of a cooked pointer to an Octave value which frees itself
  when garbage-collected. This allows these objects to be passed around
  freely, but you can't inspect or modify them in Pure. This applies, in
  particular, to Octave function objects, see <hlink|Direct Function
  Calls|#direct-function-calls>. You can check for such objects with the
  <hlink|<with|font-family|tt|octave_valuep>|#octave-valuep> predicate:

  <\description>
    <item*|octave_valuep x<label|octave-valuep>>Check for Octave value
    pointers.
  </description>

  <\verbatim>
    \;

    \<gtr\> let eig = octave_func "eig";

    \<gtr\> eig; octave_valuep eig;

    #\<less\>pointer 0x230dba0\<gtr\>

    1

    \;
  </verbatim>

  Such Octave value pointers can be used freely whereever an Octave value is
  needed (i.e., in invocations of <hlink|<with|font-family|tt|octave_set>|#octave-set>
  and <hlink|<with|font-family|tt|octave_call>|#octave-call>).

  You should also note the following:

  <\itemize>
    <item>Scalars and 1x1 matrices are indistinguishable in Octave, thus any
    1x1 matrix will be returned as a scalar from Octave to Pure.

    <item>All types of boolean and integer matrices are returned from Octave
    to Pure as (machine) integer matrices. When converted back to Octave,
    these all become Octave <verbatim|int32> matrices, but you can easily
    convert them to boolean or other types of matrices in Octave as needed.
    For instance:

    <\verbatim>
      \;

      \<gtr\> octave_set "a" {1,2;3,4};

      {1,2;3,4}

      \<gtr\> octave_eval "global a ans";

      0

      \<gtr\> octave_eval "eig(a)";

      error: eig: wrong type argument `int32 matrix'

      1

      \<gtr\> octave_eval "eig(double(a))";

      ans =

      \;

      \ \ -0.37228

      \ \ \ 5.37228

      \;

      0

      \<gtr\> octave_eval "a\<gtr\>2";

      ans =

      \;

      \ \ \ 0 \ \ 0

      \ \ \ 1 \ \ 1

      \;

      0

      \<gtr\> octave_get "ans";

      {0,0;1,1}

      \;
    </verbatim>

    <item>Octave strings are mapped to Pure strings, and character matrices
    with more than one row are mapped to (symbolic) column vectors of Pure
    strings. Example:

    <\verbatim>
      \;

      \<gtr\> octave_set "a" "Hello, world!";

      "Hello, world!"

      \<gtr\> octave_eval "a";

      a = Hello, world!

      0

      \<gtr\> octave_eval "[a;'abc']";

      ans =

      \;

      Hello, world!

      abc

      \;

      0

      \<gtr\> octave_get "ans";

      {"Hello, world!";"abc \ \ \ \ \ \ \ \ \ "}

      \;
    </verbatim>

    <item>With the default converters, Octave numeric and cell arrays are
    represented as symbolic Pure matrices, structs as Pure records. This is
    still experimental and minor details of the Pure data representations are
    subject to change; please check octave.pure for more information. Here
    are some examples:

    <\verbatim>
      \;

      \<gtr\> octave_call "rand" 1 (1,2,3);

      {{0.775409654288678,0.946392719372485,0.351919625087157},

      {0.388835562237807,0.589476406910984,0.839694088469728}}

      \<gtr\> octave_call "size" 1 ans;

      {1.0,2.0,3.0}

      \;

      \<gtr\> octave_eval "struct('name', 'Peter', 'age', 23);"; octave_get
      "ans";

      0

      {"name"=\<gtr\>"Peter","age"=\<gtr\>23.0}

      \<gtr\> octave_call (octave_func ("x.age","x")) 1 ans;

      23.0

      \;
    </verbatim>

    Nested cell arrays and structs are set off with the special
    <verbatim|cell> and <verbatim|struct> constructors:

    <\verbatim>
      \;

      \<gtr\> octave_eval "x = {[1,2,3], {1,2,3}}; x{3}.name = 'Peter';
      x{3}.age = 23;";

      0

      \<gtr\> octave_get "x";

      {{1.0,2.0,3.0},cell {1.0,2.0,3.0},struct
      {"name"=\<gtr\>"Peter","age"=\<gtr\>23.0}}

      \;
    </verbatim>

    Struct arrays are also supported:

    <\verbatim>
      \;

      \<gtr\> octave_eval "y = struct('name', {'Peter','Hannah'}, 'age', {23,
      16});";

      0

      \<gtr\> octave_get "y";

      {{"name"=\<gtr\>"Peter","age"=\<gtr\>23.0},{"name"=\<gtr\>"Hannah","age"=\<gtr\>16.0}}

      \;
    </verbatim>

    There's also a little convenience function to factor a struct array into
    a more condensed form (this format can also be used to denote a struct
    array in Pure):

    <\verbatim>
      \;

      \<gtr\> struct_array ans;

      {"name"=\<gtr\>{"Peter","Hannah"},"age"=\<gtr\>{23.0,16.0}}

      \<gtr\> octave_call "disp" 0 ans;

      \;

      \ \ 1x2 struct array containing the fields:

      \;

      \ \ \ \ name

      \ \ \ \ age

      ()

      \;
    </verbatim>
  </itemize>

  <subsection|Calling Back Into Pure><label|calling-back-into-pure>

  The embedded Octave interpreter provides one special builtin, the
  <verbatim|pure_call> function which can be used to call any function
  defined in the executing Pure script from Octave. For instance:

  <\verbatim>
    \;

    \<gtr\> even m::matrix = {~(int x mod 2) \| x=m};

    \<gtr\> octave_eval "pure_call('even', 1:12)";

    ans =

    \;

    \ \ 0 \ 1 \ 0 \ 1 \ 0 \ 1 \ 0 \ 1 \ 0 \ 1 \ 0 \ 1

    \;

    0

    \;
  </verbatim>

  Here's the description of the <verbatim|pure_call> function, as it is
  printed with Octave's <verbatim|help> command:

  <\verbatim>
    \;

    `pure_call' is a built-in function

    \;

    \ \ RES = pure_call(NAME, ARG, ...)

    \ \ [RES, ...] = pure_call(NAME, ARG, ...)

    \;

    \ \ Execute the Pure function named NAME (a string) with the given
    arguments.

    \ \ The Pure function may return multiple results as a tuple. Example:

    \ \ pure_call('succ', 99) =\<gtr\> 100.

    \;
  </verbatim>

  <subsection|Gnuplot Interface><label|gnuplot-interface>

  Octave has a comprehensive plotting interface based on Gnuplot. To make the
  plotting capabilities available in a convenient form in Pure, the
  distribution includes an additional gnuplot.pure module which provides
  simple wrappers of the most important plotting functions. Please check
  gnuplot.pure for details. For instance, here are a few simple plotting
  commands:

  <\verbatim>
    \;

    using gnuplot;

    using namespace gnuplot;

    \;

    sombrero(); // sample "sombrero" plot (3d)

    popup(); \ \ \ // show the plot window

    peaks 25; \ \ // another sample 3d plot

    refresh(); \ // update the window

    popdn(); \ \ \ // hide the plot window

    print "plot.eps"; // print the plot to an encapsulated PostScript file

    \;
  </verbatim>

  Note that most of the operations are in their own <verbatim|gnuplot>
  namespace, so we used a <verbatim|using> <verbatim|namespace> declaration
  for convenience here. The following example does the \Psombrero\Q plot
  again, but shows some of the explicit plotting commands and helper
  functions to generate the data:

  <\verbatim>
    \;

    using math;

    let u = linspace (-8, 8, 41);

    let x,y = meshgrid2 u;

    let z = {sin r/r \| r = {sqrt (x^2+y^2)+eps() \| x,y = zip x y}};

    mesh (u, u, z);

    popup();

    \;
  </verbatim>

  Note the commands that are needed to actually show the plot window and
  update its contents after doing each plot. Octave normally handles this
  automatically in its command loop, but since the embedded Octave
  interpreter doesn't have an interactive command line, you'll have to take
  care of this yourself when using this module.

  Also note that there doesn't seem to be a direct way to specify the default
  output terminal in the Octave gnuplot interface, so if you need to do this
  then you'll have to set the <verbatim|GNUTERM> environment variable as
  described in the gnuplot manual page.

  <subsection|Caveats and Notes><label|caveats-and-notes>

  Directly embedding Octave in Pure programs is convenient because it allows
  easy exchange of data between Pure and Octave, and you can also call Octave
  functions directly from Pure and vice versa. However, it also comes at a
  cost. A default build of Octave pulls in quite a few dependencies of its
  own which might conflict with other modules loaded in a Pure script.
  Specifically, we have found that older Octave versions may give problems
  with third-party graphics libraries such as
  <hlink|VTK|http://www.vtk.org/>, if used in the same program as Octave.
  (These seem to be fixed in the latest Octave and VTK versions, however.)

  <subsubsection*|<hlink|Table Of Contents|index.tm>><label|pure-octave-toc>

  <\itemize>
    <item><hlink|pure-octave|#>

    <\itemize>
      <item><hlink|Introduction|#introduction>

      <item><hlink|Copying|#copying>

      <item><hlink|Installation|#installation>

      <item><hlink|Basic Usage|#basic-usage>

      <item><hlink|Direct Function Calls|#direct-function-calls>

      <item><hlink|Data Conversions|#data-conversions>

      <item><hlink|Calling Back Into Pure|#calling-back-into-pure>

      <item><hlink|Gnuplot Interface|#gnuplot-interface>

      <item><hlink|Caveats and Notes|#caveats-and-notes>
    </itemize>
  </itemize>

  Previous topic

  <hlink|pure-mpfr|pure-mpfr.tm>

  Next topic

  <hlink|Pure-Rational - Rational number library for the Pure programming
  language|pure-rational.tm>

  <hlink|toc|#pure-octave-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-rational.tm> \|
  <hlink|previous|pure-mpfr.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2019, Albert Gräf et al. Last updated on Aug
  14, 2019. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
