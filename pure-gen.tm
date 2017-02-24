<TeXmacs|1.99.5>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-gen-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-readline.tm> \|
  <hlink|previous|pure-ffi.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|pure-gen: Pure interface generator><label|pure-gen-pure-interface-generator>

  Version 0.20, February 24, 2017

  Albert Gräf \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  <subsection|Name><label|name>

  pure-gen \U Pure interface generator

  pure-gen is a C interface generator for the Pure language. It takes a C
  header file as input and generates a corresponding Pure module with the
  constant definitions and extern declarations needed to use the C module
  from Pure. pure-gen can also generate FFI interfaces rather than externs
  (using the <hlink|<em|pure-ffi>|pure-ffi.tm> module), and it can optionally
  create a C wrapper module which allows you to create interfaces to pretty
  much any code which can be called via C.

  <subsection|Synopsis><label|synopsis>

  <\verbatim>
    \;

    pure-gen [options ...] input-file

    \;
  </verbatim>

  <subsection|Options><label|options>

  <subsubsection|General Options><label|general-options>

  <\description>
    <item*|-h<label|cmdoption-pure-gen-h>>

    <item*|--help<label|cmdoption-pure-gen--help>>Print a brief help message
    and exit.
  </description>

  <\description>
    <item*|-V<label|cmdoption-pure-gen-V>>

    <item*|--version<label|cmdoption-pure-gen--version>>Print version number
    and exit.
  </description>

  <\description>
    <item*|-e<label|cmdoption-pure-gen-e>>

    <item*|--echo<label|cmdoption-pure-gen--echo>>Echo preprocessor lines.
    Prints all processed <verbatim|#define>s, useful for debugging purposes.
  </description>

  <\description>
    <item*|-v<label|cmdoption-pure-gen-v>>

    <item*|--verbose<label|cmdoption-pure-gen--verbose>>Show parameters and
    progress information. Gives useful information about the conversion
    process.
  </description>

  <\description>
    <item*|-w[level]<label|cmdoption-pure-gen-w>>

    <item*|--warnings[=level]<label|cmdoption-pure-gen--warnings>>Display
    warnings, <verbatim|level> = 0 (disable most warnings), 1 (default, shows
    important warnings only) or 2 (lots of additional warnings useful for
    debugging purposes).
  </description>

  <subsubsection|Preprocessor Options><label|preprocessor-options>

  <\description>
    <item*|-I path<label|cmdoption-pure-gen-I>>

    <item*|--include path<label|cmdoption-pure-gen--include>>Add include
    path. Passed to the C preprocessor.
  </description>

  <\description>
    <item*|-D name[=value]<label|cmdoption-pure-gen-D>>

    <item*|--define name[=value]<label|cmdoption-pure-gen--define>>Define
    symbol. Passed to the C preprocessor.
  </description>

  <\description>
    <item*|-U name<label|cmdoption-pure-gen-U>>

    <item*|--undefine name<label|cmdoption-pure-gen--undefine>>Undefine
    symbol. Passed to the C preprocessor.
  </description>

  <\description>
    <item*|-C option<label|cmdoption-pure-gen-C>>

    <item*|--cpp option<label|cmdoption-pure-gen--cpp>>Pass through other
    preprocessor options and arguments.
  </description>

  <subsubsection|Generator Options><label|generator-options>

  <\description>
    <item*|-f iface<label|cmdoption-pure-gen-f>>

    <item*|--interface iface<label|cmdoption-pure-gen--interface>>Interface
    type (<verbatim|extern>, <verbatim|c>, <verbatim|ffi> or
    <verbatim|c-ffi>). Default is <verbatim|extern>. The <verbatim|extern>
    and <verbatim|c> types generate Pure <verbatim|extern> declarations,
    which is what you want in most cases. <verbatim|ffi> and <verbatim|c-ffi>
    employ Pure's libffi interface instead. The <verbatim|c> and
    <verbatim|c-ffi> types cause an additional C wrapper module to be created
    (see <hlink|Generating C Code|#generating-c-code>). These can also be
    combined with the <verbatim|-auto> suffix which creates C wrappers only
    when needed to get C struct arguments and returns working, see
    <hlink|Dealing with C Structs|#dealing-with-c-structs> for details.
  </description>

  <\description>
    <item*|-l lib<label|cmdoption-pure-gen-l>>

    <item*|--lib-name lib<label|cmdoption-pure-gen--lib-name>>Add dynamic
    library module to be imported in the Pure output file. Default is
    <verbatim|-l> <verbatim|c-file> (the filename specified with
    <hlink|<em|-c>|#cmdoption-pure-gen-c>, see below, without filename
    extension) if one of the <verbatim|-fc> options was specified, none
    otherwise.
  </description>

  <\description>
    <item*|-m name<label|cmdoption-pure-gen-m>>

    <item*|--namespace name<label|cmdoption-pure-gen--namespace>>Module
    namespace in which symbols should be declared.
  </description>

  <\description>
    <item*|-p prefix<label|cmdoption-pure-gen-p>>

    <item*|--prefix prefix<label|cmdoption-pure-gen--prefix>>Module name
    prefix to be removed from C symbols.
  </description>

  <\description>
    <item*|-P prefix<label|cmdoption-pure-gen-P>>

    <item*|--wrap prefix<label|cmdoption-pure-gen--wrap>>Prefix to be
    prepended to C wrapper symbols (<verbatim|-fc> and friends). Default is
    <verbatim|Pure_>.
  </description>

  <\description>
    <item*|-a<label|cmdoption-pure-gen-a>>

    <item*|--all<label|cmdoption-pure-gen--all>>Include \Phidden\Q symbols in
    the output. Built-in preprocessor symbols and symbols starting with an
    underscore are excluded unless this option is specified.
  </description>

  <\description>
    <item*|-s pattern<label|cmdoption-pure-gen-s>>

    <item*|--select pattern<label|cmdoption-pure-gen--select>>Selection of C
    symbols to be included in the output. <verbatim|pattern> takes the form
    <verbatim|[glob-patterns::][regex-pattern]>, designating a comma
    separated list of glob patterns matching the source filenames, and an
    extended regular expression matching the symbols to be processed. See
    glob(7) and regex(7). The default <verbatim|pattern> is empty which
    matches all symbols in all source modules.
  </description>

  <\description>
    <item*|-x pattern<label|cmdoption-pure-gen-x>>

    <item*|--exclude pattern<label|cmdoption-pure-gen--exclude>>Like
    <hlink|<em|-s>|#cmdoption-pure-gen-s>, but <em|excludes> all matching C
    symbols from the selection.
  </description>

  <\description>
    <item*|-t file<label|cmdoption-pure-gen-t>>

    <item*|--template file<label|cmdoption-pure-gen--template>>Specify a C
    template file to be used with C wrapper generation (<verbatim|-fc>). See
    <hlink|Generating C Code|#generating-c-code> for details.
  </description>

  <\description>
    <item*|-T file<label|cmdoption-pure-gen-T>>

    <item*|--alt-template file<label|cmdoption-pure-gen--alt-template>>Specify
    an alternate C template file to be used with C wrapper generation
    (<verbatim|-fc>). See <hlink|Generating C Code|#generating-c-code> for
    details.
  </description>

  <subsubsection|Output Options><label|output-options>

  <\description>
    <item*|-n<label|cmdoption-pure-gen-n>>

    <item*|--dry-run<label|cmdoption-pure-gen--dry-run>>Only parse without
    generating any output.
  </description>

  <\description>
    <item*|-N<label|cmdoption-pure-gen-N>>

    <item*|--noclobber<label|cmdoption-pure-gen--noclobber>>Append output to
    existing files.
  </description>

  <\description>
    <item*|-o file<label|cmdoption-pure-gen-o>>

    <item*|--output file<label|cmdoption-pure-gen--output>>Pure output
    (.pure) filename. Default is <verbatim|input-file> with new extension
    .pure.
  </description>

  <\description>
    <item*|-c file<label|cmdoption-pure-gen-c>>

    <item*|--c-output file<label|cmdoption-pure-gen--c-output>>C wrapper (.c)
    filename (<verbatim|-fc>). Default is <verbatim|input-file> with new
    extension .c.
  </description>

  <subsection|Description><label|description>

  pure-gen generates Pure bindings for C functions from a C header file. For
  instance, the command

  <\verbatim>
    \;

    pure-gen foo.h

    \;
  </verbatim>

  creates a Pure module foo.pure with <verbatim|extern> declarations for the
  constants (<verbatim|#define>s and enums) and C routines declared in the
  given C header file and (recursively) its includes.

  pure-gen only accepts a single header file on the command line. If you need
  to parse more than one header in a single run, you can just create a dummy
  header with all the necessary <verbatim|#include>s in it and pass that to
  pure-gen instead.

  When invoked with the <hlink|<em|-n>|#cmdoption-pure-gen-n> option,
  pure-gen performs a dry run in which it only parses the input without
  actually generating any output files. This is useful for checking the input
  (possibly in combination with the <hlink|<em|-e>|#cmdoption-pure-gen-e>,
  <hlink|<em|-v>|#cmdoption-pure-gen-v> and/or
  <hlink|<em|-w>|#cmdoption-pure-gen-w> options) before generating output. A
  particularly useful example is

  <\verbatim>
    \;

    pure-gen -ne foo.h \\

    \ \ \| awk '$1=="#" && $2~/^[0-9]+$/ && $3!~/^"\<less\>.*\<gtr\>"$/ \ {
    print $3 }' \\

    \ \ \| sort \| uniq

    \;
  </verbatim>

  which prints on standard output all headers which are included in the
  source. This helps to decide which headers you want to be included in the
  output, so that you can set up a corresponding filter patterns
  (<hlink|<em|-s>|#cmdoption-pure-gen-s> and
  <hlink|<em|-x>|#cmdoption-pure-gen-x> options, see below).

  The <hlink|<em|-I>|#cmdoption-pure-gen-I>,
  <hlink|<em|-D>|#cmdoption-pure-gen-D> and
  <hlink|<em|-U>|#cmdoption-pure-gen-U> options are simply passed to the C
  preprocessor, as well as any other option or argument escaped with the
  <hlink|<em|-C>|#cmdoption-pure-gen-C> flag. This is handy if you need to
  define additional preprocessor symbols, add directories to the include
  search path, etc., see cpp(1) for details.

  There are some other options which affect the generated output. In
  particular, <verbatim|-f> <verbatim|c> generates a C wrapper module along
  with the Pure module (see <hlink|Generating C Code|#generating-c-code>
  below), and <verbatim|-f> <verbatim|ffi> generates a wrapper using Pure's
  ffi module. Moreover, <verbatim|-l> <verbatim|libfoo> generates a
  <verbatim|using> <verbatim|"lib:libfoo"> declaration in the Pure source,
  for modules which require a shared library to be loaded. Any number of
  <hlink|<em|-l>|#cmdoption-pure-gen-l> options can be specified.

  Other options for more advanced uses are explained in the following
  sections.

  <subsection|Filtering><label|filtering>

  Note that pure-gen always parses the given header file as well as <em|all>
  its includes. If the header file includes system headers, by default you
  will get those declarations as well. This is often undesirable. As a
  remedy, pure-gen normally excludes built-in <verbatim|#define>s of the C
  preprocessor, as well as identifiers with a leading underscore (which are
  often found in system headers) from processing. You can use the
  <hlink|<em|-a>|#cmdoption-pure-gen-a> option to disable this, so that all
  these symbols are included as well.

  In addition, the <hlink|<em|-s>|#cmdoption-pure-gen-s> and
  <hlink|<em|-x>|#cmdoption-pure-gen-x> options enable you to filter C
  symbols using the source filename and the symbol as search criteria. For
  instance, to just generate code for a single header foo.h and none of the
  other headers included in foo.h, you can invoke pure-gen as follows:

  <\verbatim>
    \;

    pure-gen -s foo.h:: foo.h

    \;
  </verbatim>

  Note that even in this case all included headers will be parsed so that
  <verbatim|#define>d constants and enum values can be resolved, but the
  generated output will only contain definitions and declarations from the
  given header file.

  In general, the <hlink|<em|-s>|#cmdoption-pure-gen-s> option takes an
  argument of the form <verbatim|glob-patterns::regex-pattern> denoting a
  comma-separated list of glob patterns to be matched against the source
  filename in which the symbol resides, and an extended regex to be matched
  against the symbol itself. The <verbatim|glob-patterns::> part can also be
  omitted in which case it defaults to <verbatim|::> which matches any source
  file. The regex can also be empty, in which case it matches any symbol. The
  generated output will contain only the constant and function symbols
  matching the given regex, from source files matching any of the the glob
  patterns. Thus, for instance, the option <verbatim|-s>
  <verbatim|foo.h,bar.h::^(foo\|bar)_> pulls all symbols prefixed with either
  <verbatim|foo_> or <verbatim|bar_> from the files foo.h and bar.h in the
  current directory.

  Instead of <verbatim|::> you can also use a single semicolon <verbatim|;>
  to separate glob and regex pattern. This is mainly for Windows
  compatibility, where the msys shell sometimes eats the colons or changes
  them to <verbatim|;>.

  The <hlink|<em|-x>|#cmdoption-pure-gen-x> option works exactly the same,
  but <em|excludes> all matching symbols from the selection. Thus, e.g., the
  option <verbatim|-x> <verbatim|^bar_> causes all symbols with the prefix
  <verbatim|bar_> to <em|not> be included in the output module.

  Processing of glob patterns is performed using the customary rules for
  filename matching, see glob(7) for details. Note that some include files
  may be specified using a full pathname. This is the case, in particular,
  for system includes such as <verbatim|#include> <verbatim|\<stdio.h\>>,
  which are resolved by the C preprocessor employing a search of the system
  include directories (as well as any directories named with the
  <hlink|<em|-I>|#cmdoption-pure-gen-I> option).

  Since the <verbatim|*> and <verbatim|?> wildcards never match the pathname
  separator <verbatim|/>, you have to specify the path in the glob patterns
  in such cases. Thus, e.g., if the foo.h file actually lives in either
  /usr/include or /usr/local/include, then it must be matched using a pattern
  like <verbatim|/usr/include/*.h,/usr/local/include/*.h::>. Just
  <verbatim|foo.h::> will not work in this case. On the other hand, if you
  have set up your C sources in some local directory then specifying a
  relative pathname is ok.

  <subsection|Name Mangling><label|name-mangling>

  The <hlink|<em|-s>|#cmdoption-pure-gen-s> option is often used in
  conjuction with the <hlink|<em|-p>|#cmdoption-pure-gen-p> option, which
  lets you specify a \Pmodule name prefix\Q which should be stripped off from
  C symbols. Case is insignificant and a trailing underscore will be removed
  as well, so <verbatim|-p> <verbatim|foo> turns <verbatim|fooBar> into
  <verbatim|Bar> and <verbatim|FOO_BAR> into <verbatim|BAR>. Moreover, the
  <hlink|<em|-m>|#cmdoption-pure-gen-m> option allows you to specify the name
  of a Pure namespace in which the resulting constants and functions are to
  be declared. So, for instance, <verbatim|-s> <verbatim|"^(foo\|FOO)">
  <verbatim|-p> <verbatim|foo> <verbatim|-m> <verbatim|foo> will select all
  symbols starting with the <verbatim|foo> or <verbatim|FOO> prefix,
  stripping the prefix from the selected symbols and finally adding a
  <verbatim|foo::> namespace qualifier to them instead.

  <subsection|Generating C Code><label|generating-c-code>

  As already mentioned, pure-gen can be invoked with the <verbatim|-fc> or
  <verbatim|-fc-ffi> option to create a C wrapper module along with the Pure
  module it generates. There are various situations in which this is
  preferable, e.g.:

  <\itemize>
    <item>You are about to create a new module for which you want to generate
    some boilerplate code.

    <item>The C routines to be wrapped aren't available in a shared library,
    but in some other form (e.g., object file or static library).

    <item>You need to inject some custom code into the wrapper functions
    (e.g., to implement custom argument preprocessing or lazy dynamic loading
    of functions from a shared library).

    <item>The C routines can't be called directly through Pure externs.
  </itemize>

  The latter case might arise, e.g., if the module uses non-C linkage or
  calling conventions, or if some of the operations to be wrapped are
  actually implemented as C macros. (Note that in order to wrap macros as
  functions you'll have to create a staged header which declares the macros
  as C functions, so that they are wrapped in the C module. pure-gen doesn't
  do this automatically.)

  Another important case is that some of the C routines pass C structs by
  value or return them as results. This is discussed in more detail in the
  following section.

  For instance, let's say that we want to generate a wrapper foo.c from the
  foo.h header file whose operations are implemented in some library libfoo.a
  or libfoo.so. A command like the following generates both the C wrapper and
  the corresponding Pure module:

  <\verbatim>
    \;

    pure-gen -fc foo.h

    \;
  </verbatim>

  This creates foo.pure and foo.c, with an import clause for
  <verbatim|"lib:foo"> at the beginning of the Pure module. (You can also
  change the name of the Pure and C output files using the
  <hlink|<em|-o>|#cmdoption-pure-gen-o> and
  <hlink|<em|-c>|#cmdoption-pure-gen-c> options, respectively.)

  The generated wrapper is just an ordinary C file which should be compiled
  to a shared object (dll on Windows) as usual. E.g., using gcc on Linux:

  <\verbatim>
    \;

    gcc -shared -o foo.so foo.c -lfoo

    \;
  </verbatim>

  That's all. You should now be able to use the foo module by just putting
  the declaration <verbatim|using> <verbatim|foo;> into your programs. The
  same approach also works with the ffi interface if you replace the
  <verbatim|-fc> option with <verbatim|-fc-ffi>.

  You can also adjust the C wrapper code to some extent by providing your own
  template file, which has the following format:

  <\verbatim>
    \;

    /* frontmatter here */

    #include %h

    %%

    \;

    /* wrapper here */

    %r %w(%p)

    {

    \ \ return %n(%a);

    }

    \;
  </verbatim>

  Note that the code up to the symbol <verbatim|%%> on a line by itself
  denotes \Pfrontmatter\Q which gets inserted at the beginning of the C file.
  (The frontmatter section can also be empty or missing altogether if you
  don't need it, but usually it will contain at least an <verbatim|#include>
  for the input header file.)

  The rest of the template is the code for each wrapper function.
  Substitutions of various syntactical fragments of the function definition
  is performed using the following placeholders:

  <verbatim|%h> input header file

  <verbatim|%r> return type of the function

  <verbatim|%w> the name of the wrapper function

  <verbatim|%p> declaration of the formal parameters of the wrapper function

  <verbatim|%n> the real function name (i.e., the name of the target C
  function to be called)

  <verbatim|%a> the arguments of the function call (formal parameters with
  types stripped off)

  <verbatim|%%> escapes a literal %

  A default template is provided if you don't specify one (which looks pretty
  much like the template above, minus the comments). A custom template is
  specified with the <hlink|<em|-t>|#cmdoption-pure-gen-t> option. (There's
  also a <hlink|<em|-T>|#cmdoption-pure-gen-T> option to specify an
  \Palternate\Q template for dealing with routines returning struct values,
  see <hlink|Dealing with C Structs|#dealing-with-c-structs>.)

  For instance, suppose that we place the sample template above into a file
  foo.templ and invoke pure-gen on the foo.h header file as follows:

  <\verbatim>
    \;

    pure-gen -fc -t foo.templ foo.h

    \;
  </verbatim>

  Then in foo.c you'd get C output code like the following:

  <\verbatim>
    \;

    /* frontmatter here */

    #include "foo.h"

    \;

    /* wrapper here */

    void Pure_foo(int arg0, void* arg1)

    {

    \ \ return foo(arg0, arg1);

    }

    \;

    /* wrapper here */

    int Pure_bar(int arg0)

    {

    \ \ return bar(arg0);

    }

    \;
  </verbatim>

  As indicated, the wrapper function names are usually stropped with the
  <verbatim|Pure_> prefix. You can change this with the
  <hlink|<em|-P>|#cmdoption-pure-gen-P> option.

  This also works great to create boilerplate code for new modules. For this
  purpose the following template will do the trick:

  <\verbatim>
    \;

    /* Add #includes etc. here. */

    %%

    \;

    %r %n(%p)

    {

    \ \ /* Enter code of %n here. */

    }

    \;
  </verbatim>

  <subsection|Dealing with C Structs><label|dealing-with-c-structs>

  Modern C compilers allow you to pass C structs by value or return them as
  results from a C function. This represents a problem, because Pure doesn't
  provide any support for that in its extern declarations. Even Pure's libffi
  interface only has limited support for C structs (no unions, no bit
  fields), and at present pure-gen itself does not keep track of the internal
  structure of C structs either.

  Hence pure-gen will bark if you try to wrap an operation which passes or
  returns a C struct, printing a warning message like the following which
  indicates that the given function could not be wrapped:

  <\verbatim>
    \;

    Warning: foo: struct argument or return type, try -fc-auto

    \;
  </verbatim>

  What Pure <em|does> know is how to pass and return <em|pointers> to C
  structs in its C interface. This makes it possible to deal with struct
  arguments and return values in the C wrapper. To make this work, you need
  to create a C wrapper module as explained in the previous section. However,
  as C wrappers are only needed for functions which actually have struct
  arguments or return values, you can also use the <verbatim|-fc-auto> option
  (or <verbatim|-fc-ffi-auto> if you prefer the ffi interface) to only
  generate the C wrapper when required. This saves the overhead of an extra
  function call if it's not actually needed.

  Struct arguments in the original C function then become struct pointers in
  the wrapper function. E.g., if the function is declared in the header as
  follows:

  <\verbatim>
    \;

    typedef struct { double x, y; } point;

    extern double foo(point p);

    \;
  </verbatim>

  Then the generated wrapper code becomes:

  <\verbatim>
    \;

    double Pure_foo(point* arg0)

    {

    \ \ return foo(*arg0);

    }

    \;
  </verbatim>

  Which is declared in the Pure interface as:

  <\verbatim>
    \;

    extern double Pure_foo(point*) = foo;

    \;
  </verbatim>

  Struct return values are handled by returning a pointer to a static
  variable holding the return value. E.g.,

  <\verbatim>
    \;

    extern point bar(double x, double y);

    \;
  </verbatim>

  becomes:

  <\verbatim>
    \;

    point* Pure_bar(double arg0, double arg1)

    {

    \ \ static point ret;

    \ \ ret = bar(arg0, arg1); return &ret;

    }

    \;
  </verbatim>

  Which is declared in the Pure interface as:

  <\verbatim>
    \;

    extern point* Pure_bar(double, double) = bar;

    \;
  </verbatim>

  (Note that the generated code in this case comes from an alternate
  template. It's possible to configure the alternate template just like the
  normal one, using the <hlink|<em|-T>|#cmdoption-pure-gen-T> option instead
  of <hlink|<em|-t>|#cmdoption-pure-gen-t>. See the <hlink|Generating C
  Code|#generating-c-code> section above for details about code templates.)

  In a Pure script you can now call <verbatim|foo> and <verbatim|bar> as:

  <\verbatim>
    \;

    \<gtr\> foo (bar 0.0 1.0);

    \;
  </verbatim>

  Note, however, that the pointer returned by <verbatim|bar> points to static
  storage which will be overwritten each time you invoke the <verbatim|bar>
  function. Thus in the following example <em|both> <verbatim|u> and
  <verbatim|v> will point to the same <verbatim|point> struct, namely that
  defined by the latter call to <verbatim|bar>:

  <\verbatim>
    \;

    \<gtr\> let u = bar 1.0 0.0; let v = bar 0.0 1.0;

    \;
  </verbatim>

  Which most likely is <em|not> what you want. To avoid this, you'll have to
  take dynamic copies of returned structs. It's possible to do this manually
  by fiddling around with <verbatim|malloc> and <verbatim|memcpy>, but the
  most convenient way is to employ the struct functions provided by Pure's
  ffi module:

  <\verbatim>
    \;

    \<gtr\> using ffi;

    \<gtr\> let point_t = struct_t (double_t, double_t);

    \<gtr\> let u = copy_struct point_t (bar 1.0 0.0);

    \<gtr\> let v = copy_struct point_t (bar 0.0 1.0);

    \;
  </verbatim>

  Now <verbatim|u> and <verbatim|v> point to different, malloc'd structs
  which even take care of freeing themselves when they are no longer needed.
  Moreover, the ffi module also allows you to access the members of the
  structs in a direct fashion. Please refer to the
  <hlink|<em|pure-ffi>|pure-ffi.tm> documentation for further details.

  <subsection|Notes><label|notes>

  pure-gen currently requires gcc (<verbatim|-E>) as the C preprocessor. It
  also needs a version of gcc which understands the
  <verbatim|-fdirectives-only> option, which means gcc 4.3 or later. It will
  run with older versions of gcc, but then you'll get an error message from
  gcc indicating that it doesn't understand the <verbatim|-fdirectives-only>
  option. pure-gen then won't be able to extract any <verbatim|#define>d
  constants from the header files.

  pure-gen itself is written in Pure, but uses a C parser implemented in
  Haskell, based on the Language.C library written by Manuel Chakravarty and
  others.

  pure-gen can only generate C bindings at this time. Other languages may
  have their own calling conventions which make it hard or even impossible to
  call them directly through Pure's extern interface. However, if your C
  compiler knows how to call the other language, then it may be possible to
  interface to modules written in that language by faking a C header for the
  module and generating a C wrapper with a custom code template, as described
  in <hlink|Generating C Code|#generating-c-code>. In principle, this
  approach should even work with behemoths like C++, although it might be
  easier to use third-party tools like SWIG for that purpose.

  In difference to SWIG and similar tools, pure-gen doesn't require you to
  write any special \Pinterface files\Q, is controlled entirely by command
  line options, and the amount of marshalling overhead in C wrappers is
  negligible. This is possible since pure-gen targets only the Pure-C
  interface and Pure has good support for interfacing to C built into the
  language already.

  pure-gen usually works pretty well if the processed header files are
  written in a fairly clean fashion. Nevertheless, some libraries defy fully
  automatic wrapper generation and may thus require staged headers and/or
  manual editing of the generated output to get a nice wrapper module.

  In complex cases it may also be necessary to assemble the output of several
  runs of pure-gen for different combinations of header files, symbol
  selections and/or namespace/prefix settings. In such a situation it is
  usually possible to just concatenate the various output files produced by
  pure-gen to consolidate them into a single wrapper module. To make this
  easier, pure-gen provides the <hlink|<em|-N>|#cmdoption-pure-gen-N> a.k.a.
  <hlink|<em|\Unoclobber>|#cmdoption-pure-gen--noclobber> option which
  appends the output to existing files instead of overwriting them. See the
  example below.

  <subsection|Example><label|example>

  For the sake of a substantial, real-world example, here is how you can wrap
  the entire GNU Scientific Library in a single Pure module mygsl.pure, with
  the accompanying C module in mygsl.c:

  <\verbatim>
    \;

    rm -f mygsl.pure mygsl.c

    DEFS=-DGSL_DISABLE_DEPRECATED

    for x in /usr/include/gsl/gsl_*.h; do

    \ \ pure-gen $DEFS -N -fc-auto -s "$x::" $x -o mygsl.pure -c mygsl.c

    done

    \;
  </verbatim>

  The C module can then be compiled with:

  <\verbatim>
    \;

    gcc $DEFS -shared -o mygsl.so mygsl.c -lgsl

    \;
  </verbatim>

  Note that the <verbatim|GSL_DISABLE_DEPRECATED> symbol must be defined here
  to avoid some botches with constants being defined in incompatible ways in
  different GSL headers. Also, some GSL versions have broken headers lacking
  some system includes which causes hiccups in pure-gen's C parser. Fixing
  those errors or working around them through some appropriate cpp options
  should be a piece of cake, though.

  <subsection|License><label|license>

  BSD-like. See the accompanying COPYING file for details.

  <subsection|Authors><label|authors>

  Scott E. Dillard (University of California at Davis), Albert Graef
  (Johannes Gutenberg University at Mainz, Germany).

  <subsection|See Also><label|see-also>

  <\description>
    <item*|Language.C>A C parser written in Haskell by Manuel Chakravarty et
    al, <hlink|http://www.sivity.net/projects/language.c|http://www.sivity.net/projects/language.c>.

    <item*|SWIG>The Simplified Wrapper and Interface Generator,
    <hlink|http://www.swig.org|http://www.swig.org>.
  </description>

  <subsubsection*|<hlink|Table Of Contents|index.tm>><label|pure-gen-toc>

  <\itemize>
    <item><hlink|pure-gen: Pure interface generator|#>

    <\itemize>
      <item><hlink|Name|#name>

      <item><hlink|Synopsis|#synopsis>

      <item><hlink|Options|#options>

      <\itemize>
        <item><hlink|General Options|#general-options>

        <item><hlink|Preprocessor Options|#preprocessor-options>

        <item><hlink|Generator Options|#generator-options>

        <item><hlink|Output Options|#output-options>
      </itemize>

      <item><hlink|Description|#description>

      <item><hlink|Filtering|#filtering>

      <item><hlink|Name Mangling|#name-mangling>

      <item><hlink|Generating C Code|#generating-c-code>

      <item><hlink|Dealing with C Structs|#dealing-with-c-structs>

      <item><hlink|Notes|#notes>

      <item><hlink|Example|#example>

      <item><hlink|License|#license>

      <item><hlink|Authors|#authors>

      <item><hlink|See Also|#see-also>
    </itemize>
  </itemize>

  Previous topic

  <hlink|pure-ffi|pure-ffi.tm>

  Next topic

  <hlink|pure-readline|pure-readline.tm>

  <hlink|toc|#pure-gen-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-readline.tm> \|
  <hlink|previous|pure-ffi.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2017, Albert Gräf et al. Last updated on Feb
  24, 2017. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
