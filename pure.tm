<TeXmacs|1.0.7.20>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|purelib.tm> \|
  <hlink|previous|index.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|The Pure Manual<label|the-pure-manual>>

  Version 0.63, October 23, 2014

  Albert Gräf \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  Copyright (c) 2009-2014 by Albert Gräf. This document is available under
  the <hlink|GNU Free Documentation License|http://www.gnu.org/copyleft/fdl.html>.
  Also see the <hlink|Copying|#copying> section for licensing information of
  the software.

  This manual describes the Pure programming language and how to invoke the
  Pure interpreter program. To read the manual inside the interpreter, just
  type <verbatim|help> at the command prompt. See the <hlink|Online
  Help|#online-help> section for details.

  There is a companion to this manual, the <hlink|<em|Pure Library
  Manual>|purelib.tm> which contains the description of the standard library
  operations. More information about Pure and the latest sources can be found
  under the following URLs:

  <\itemize>
    <item>Pure website: <hlink|http://purelang.bitbucket.org|http://purelang.bitbucket.org>

    <item>Pure mailing list: <hlink|http://groups.google.com/group/pure-lang|http://groups.google.com/group/pure-lang>
  </itemize>

  <label|installation>Information about how to install Pure can be found in
  the document <hlink|<em|Installing Pure (and LLVM)>|install.tm>.

  <subsection|Introduction<label|introduction>>

  Pure is a functional programming language based on term rewriting. This
  means that all your programs are essentially just collections of symbolic
  equations which the interpreter uses to reduce expressions to their
  simplest (``normal'') form. This makes for a rather powerful and flexible
  programming model featuring dynamic typing and general polymorphism. In
  addition, Pure programs are compiled to efficient native code on the fly,
  using the <hlink|LLVM|#llvm> compiler framework, so programs are executed
  reasonably fast and interfacing to C is very easy. If you have the
  necessary 3rd party compilers installed then you can even inline functions
  written in C and a number of other languages and call them just like any
  other Pure function. The ease with which you can interface to 3rd party
  software makes Pure useful for a wide range of applications from symbolic
  algebra and scientific programming to database, web and multimedia
  applications.

  The Pure language is implemented by the <with|font-series|bold|Pure
  interpreter> program. Just like other programming language interpreters,
  the Pure interpreter provides an interactive environment in which you can
  type definitions and expressions, which are executed as you type them at
  the interpreter's command prompt. However, despite its name the Pure
  interpreter never really ``interprets'' any Pure code. Rather, it acts as a
  frontend to the <with|font-series|bold|Pure compiler>, which takes care of
  incrementally compiling Pure code to native (machine) code. This has the
  benefit that the compiled code runs much faster than the usual kinds of
  ``bytecode'' that you find in traditional programming language
  interpreters.

  You can use the interpreter interactively as a sophisticated kind of
  ``desktop calculator'' program. Simply run the program from the shell as
  follows:

  <\verbatim>
    $ pure

    \;

    \ __ \\ \ \| \ \ \| \ __\| _ \\ \ \ \ Pure 0.63
    (x86_64-unknown-linux-gnu)

    \ \| \ \ \| \| \ \ \| \| \ \ \ __/ \ \ \ Copyright (c) 2008-2014 by
    Albert Graef

    \ .__/ \\__,_\|_\| \ \\___\| \ \ \ (Type 'help' for help, 'help copying'

    _\| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ for license information.)

    \;

    Loaded prelude from /usr/lib/pure/prelude.pure.

    \;

    \<gtr\>
  </verbatim>

  The interpreter prints its sign-on message and leaves you at its ``\<gtr\>
  '' command prompt, where you can start typing definitions and expressions
  to be evaluated:

  <\verbatim>
    \<gtr\> 17/12+23;

    24.4166666666667

    \<gtr\> fact n = if n\<gtr\>0 then n*fact (n-1) else 1;

    \<gtr\> map fact (1..10);

    [1,2,6,24,120,720,5040,40320,362880,3628800]
  </verbatim>

  Typing the <verbatim|quit> command or the end-of-file character
  (<verbatim|Ctrl-d> on Unix systems) at the beginning of the command line
  exits the interpreter and takes you back to the shell.

  The interpreter can actually be invoked in a number of different ways.
  Instead of typing definitions and evaluating expressions in an interactive
  fashion as shown above, you can also put the same code in an (ASCII or
  UTF-8) text file called a <with|font-series|bold|Pure program> or
  <with|font-series|bold|script> which can then be executed by the
  interpreter in ``batch mode'', or compiled to a standalone executable which
  can be run directly from the command line. As an aid for writing script
  files, a bunch of syntax highlighting files and programming modes for
  various popular text editors are included in the Pure sources.

  More information about invoking the Pure interpreter can be found in the
  <hlink|Invoking Pure|#invoking-pure> section below. This is followed by a
  description of the Pure language in <hlink|Pure Overview|#pure-overview>
  and subsequent sections, including an extensive <hlink|Examples|#examples>
  section which can serve as a mini-tutorial on Pure. The interactive
  facilities of the Pure interpreter are discussed in the <hlink|Interactive
  Usage|#interactive-usage> section, while the <hlink|Batch
  Compilation|#batch-compilation> section explains how to translate Pure
  programs to native executables and a number of other object file formats.
  The <hlink|Caveats and Notes|#caveats-and-notes> section discusses useful
  tips and tricks, as well as various pitfalls and how to avoid them. The
  manual concludes with some authorship and licensing information and
  pointers to related software.

  <subsubsection|Further Reading<label|further-reading>>

  This manual is not intended as a general introduction to functional
  programming, so at least some familiarity with this programming style is
  assumed. If Pure is your first functional language then you might want to
  look at the <hlink|Functional Programming|http://en.wikipedia.org/wiki/Functional-programming>
  wikipedia article to see what it is all about and find pointers to current
  literature on the subject. In any case we hope that you'll find Pure
  helpful in exploring functional programming, as it is fairly easy to learn
  but a very powerful language.

  As already mentioned, Pure uses term rewriting as its underlying
  computational model, which goes well beyond functional programming in some
  ways. Term rewriting has long been used in computer algebra systems, and
  <hlink|Michael O'Donnell|#michael-o-donnell> pioneered its use as a
  programming language already in the 1980s. But until recently
  implementations have not really been efficient enough to be useful as
  general-purpose programming languages; Pure strives to change that. A good
  introduction to the theory of the term rewriting calculus and its
  applications is the book by <hlink|Baader and Nipkow|#baader-and-nipkow>.

  <subsubsection|Typographical Conventions<label|typographical-conventions>>

  Program examples are always set in typewriter font. Here's how a typical
  code sample may look like:

  <\verbatim>
    fact n = if n\<gtr\>0 then n*fact(n-1) else 1;
  </verbatim>

  These can either be saved to a file and then loaded into the interpreter,
  or you can also just type them directly in the interpreter. If some lines
  start with the interpreter prompt ``\<gtr\> '', this indicates an example
  interaction with the interpreter. Everything following the prompt
  (excluding the ``\<gtr\> '' itself) is meant to be typed exactly as
  written. Lines lacking the ``\<gtr\> '' prefix show results printed by the
  interpreter. Example:

  <\verbatim>
    \<gtr\> fact n = if n\<gtr\>0 then n*fact(n-1) else 1;

    \<gtr\> map fact (1..10);

    [1,2,6,24,120,720,5040,40320,362880,3628800]
  </verbatim>

  Similarly, lines starting with the ``$ '' prompt indicate shell
  interactions. For instance,

  <\verbatim>
    $ pure
  </verbatim>

  indicates that you should type the command <verbatim|pure> on your system's
  command line.

  The grammar notation in this manual uses an extended form of BNF
  (Backus-Naur form), which looks as follows:

  <\verbatim>
    expression ::= \ "{" expr_list (";" expr_list)* [";"] "}"

    expr_list \ ::= \ expression (',' expression)*
  </verbatim>

  Parentheses are used to group syntactical elements, while brackets denote
  optional elements. We also use the regular expression operators
  <verbatim|*> and <verbatim|+> to denote repetitions (as usual, <verbatim|*>
  denotes zero or more, <verbatim|+> one or more repetitions of the preceding
  element). Terminals (literal elements such as keywords and delimiters) are
  enclosed in double or single quotes.

  These EBNF rules are used for both lexical and syntactical elements, but
  note that the former are concerned with entities formed from single
  characters and thus tokens are meant to be typed exactly as written,
  whereas the latter deal with larger syntactical structures where whitespace
  between tokens is generally insignificant.

  <subsection|Invoking Pure<label|invoking-pure>>

  The Pure interpreter can be invoked from the shell in one of two different
  ways:

  <\verbatim>
    pure [options ...] [-x] script [args ...]

    pure [options ...] [-b\|-c\|-i] [script ...] [-- args ...]
  </verbatim>

  Use <verbatim|pure> <verbatim|-h> to get help about the command line
  options. Just the <verbatim|pure> command without any command line
  parameters invokes the interpreter in <with|font-series|bold|interactive
  mode>, see <hlink|Running Interactively|#running-interactively> below for
  details.

  The first form above is used if the interpreter is invoked on exactly one
  script file, which is loaded and executed, after which the interpreter
  exits. Any arguments following the script name are <em|not> processed by
  the interpreter, but are passed to the executing script by means of the
  <verbatim|argv> variable. This is also known as
  <with|font-series|bold|script mode>, and is commonly used if a script is to
  be run as a standalone program. Script mode can also be indicated
  explicitly with the <verbatim|-x> option, but this is optional unless you
  want to combine it with one of the <verbatim|-b>, <verbatim|-c> and
  <verbatim|-i> options discussed below. If the <verbatim|-x> option is
  present, it <em|must> be followed by the name of a script to be executed.
  Also note that in script mode, <em|all> interpreter options need to be
  specified before the script name; all remaining arguments (including
  options) are simply passed to the executing script.

  The second form is used if there may be any number of scripts which are to
  be executed in <with|font-series|bold|batch mode> (<verbatim|-b>,
  <verbatim|-c>) or <with|font-series|bold|interactive mode> (<verbatim|-i>),
  respectively. In this case <em|all> options on the command line will be
  processed by the interpreter, up to the <verbatim|--> option (if any),
  which stops option processing and indicates that the remaining arguments
  should be passed in the <verbatim|argv> variable. Any non-option arguments
  (before the <verbatim|--> option, if any) are interpreted as scripts which
  should be loaded by the interpreter. If no scripts are specified, or if the
  <verbatim|-i> option is present, the interpreter starts in interactive mode
  (after loading the given scripts, if any). Otherwise, if one of the
  <verbatim|-b> and <verbatim|-c> options is specified, the given scripts are
  run in batch mode, after which the interpreter exits. (In the case of
  <verbatim|-c>, the interpreter then also dumps the program as a native
  executable, performing <with|font-series|bold|batch compilation>, see
  <hlink|Compiling Scripts|#compiling-scripts> below.)

  Batch mode is also entered if the interpreter is invoked with one of the
  <verbatim|--ctags> and <verbatim|--etags> options. However, in this case
  the given scripts are not executed at all, but only parsed in order to
  produce a vi or emacs tags file, see <hlink|Tagging
  Scripts|#tagging-scripts> below.

  Here are some common ways to invoke the interpreter:

  <\description>
    <item*|<with|font-family|tt|pure>>Runs the interpreter interactively,
    without any script. Only the prelude gets loaded.

    <item*|<with|font-family|tt|pure> <with|font-family|tt|-g>>Runs the
    interpreter interactively, with debugging support.

    <item*|<with|font-family|tt|pure> <with|font-family|tt|-b>
    <with|font-family|tt|script> <with|font-family|tt|...>>Runs the given
    scripts in batch mode.

    <item*|<with|font-family|tt|pure> <with|font-family|tt|-i>
    <with|font-family|tt|script> <with|font-family|tt|...>>Runs the given
    scripts in batch mode as above, but then enters the interactive command
    loop. (Add <verbatim|-g> to also get debugging support, and <verbatim|-q>
    to suppress the sign-on message.)

    <item*|<with|font-family|tt|pure> <with|font-family|tt|script>
    <with|font-family|tt|[arg> <with|font-family|tt|...]>>Runs the given
    script with the given parameters. The script name and command line
    arguments are available in the global <verbatim|argv> variable.

    <item*|<with|font-family|tt|pure> <with|font-family|tt|-c>
    <with|font-family|tt|script> <with|font-family|tt|[-o>
    <with|font-family|tt|prog]>>Batch compilation: Runs the given script,
    compiling it to a native executable <verbatim|prog> (a.out by default).

    <item*|<with|font-family|tt|pure> <with|font-family|tt|--etags>
    <with|font-family|tt|script> <with|font-family|tt|...>
    <with|font-family|tt|[-T> <with|font-family|tt|TAGS]>>Parses the given
    scripts and produces an emacs tags file. (Use <verbatim|--ctags> to
    create a vi tags file instead. In either case, the actual name of the
    tags file can be set with the <verbatim|-T> option.)
  </description>

  The following commands provide helpful information about the interpreter,
  after which the interpreter exits immediately:

  <\description>
    <item*|<with|font-family|tt|pure> <with|font-family|tt|--help>>Print a
    short help message describing the command line syntax and available
    options. This can also be abbreviated as <verbatim|pure> <verbatim|-h>.

    <item*|<with|font-family|tt|pure> <with|font-family|tt|--version>>Print
    version information.
  </description>

  Depending on your local setup, there may be additional ways to run the Pure
  interpreter. In particular, if you have Emacs Pure mode installed, then you
  can just open a script in Emacs and run it with the <verbatim|C-c>
  <verbatim|C-k> keyboard command. For Emacs aficionados, this is probably
  the most convenient way to execute a Pure script interactively in the
  interpreter. Pure mode actually turns Emacs into a full IDE (integrated
  development environment) for Pure, which offers a lot of convenient
  features such as syntax highlighting, automatic indentation, online help
  and different ways to interact with the Pure interpreter.

  <subsubsection|Options<label|options>>

  The interpreter accepts various options which are described in more detail
  below.

  <\description>
    <item*|-b<label|cmdoption-pure-b>>Batch mode (execute the given scripts
    and exit).
  </description>

  <\description>
    <item*|-c<label|cmdoption-pure-c>>Batch compilation (compile the given
    scripts to a native binary).
  </description>

  <\description>
    <item*|--ctags<label|cmdoption-pure--ctags>>

    <item*|--etags<label|cmdoption-pure--etags>>Create a tags file in ctags
    (vi) or etags (emacs) format.
  </description>

  <\description>
    <item*|--disable optname<label|cmdoption-pure--disable>>Disable source
    option (conditional compilation).
  </description>

  <\description>
    <item*|--eager-jit<label|cmdoption-pure--eager-jit>>Enable eager JIT
    compilation. This requires LLVM 2.7 or later, otherwise this flag will be
    ignored.
  </description>

  <\description>
    <item*|--enable optname<label|cmdoption-pure--enable>>Enable source
    option (conditional compilation).
  </description>

  <\description>
    <item*|--escape char<label|cmdoption-pure--escape>>Interactive commands
    are prefixed with the specified character. Permitted prefixes are:
    <verbatim|!$%&*,:\<\>@\\\|>.
  </description>

  <\description>
    <item*|-fPIC<label|cmdoption-pure-fPIC>>

    <item*|-fpic<label|cmdoption-pure-fpic>>Create position-independent code
    (batch compilation).
  </description>

  <\description>
    <item*|-g<label|cmdoption-pure-g>>Enable symbolic debugging.
  </description>

  <\description>
    <item*|-h<label|cmdoption-pure-h>>

    <item*|--help<label|cmdoption-pure--help>>Print help message and exit.
  </description>

  <\description>
    <item*|-i<label|cmdoption-pure-i>>Interactive mode (read commands from
    stdin after sourcing the given scripts, if any).
  </description>

  <\description>
    <item*|-I directory<label|cmdoption-pure-I>>Add a directory to be
    searched for included source scripts.
  </description>

  <\description>
    <item*|-L directory<label|cmdoption-pure-L>>Add a directory to be
    searched for dynamic libraries.
  </description>

  <\description>
    <item*|-l libname<label|cmdoption-pure-l>>Library to be linked in batch
    compilation.
  </description>

  <\description>
    <item*|-mopt=val<label|cmdoption-pure-mopt>>Add llc machine options in
    batch compilation.
  </description>

  <\description>
    <item*|--main name<label|cmdoption-pure--main>>Name of main entry point
    in batch compilation.
  </description>

  <\description>
    <item*|--noediting<label|cmdoption-pure--noediting>>Disable command-line
    editing.
  </description>

  <\description>
    <item*|-n<label|cmdoption-pure-n>>

    <item*|--noprelude<label|cmdoption-pure--noprelude>>Do not load the
    prelude.
  </description>

  <\description>
    <item*|--norc<label|cmdoption-pure--norc>>Do not run the interactive
    startup files.
  </description>

  <\description>
    <item*|-o filename<label|cmdoption-pure-o>>Output filename for batch
    compilation.
  </description>

  <\description>
    <item*|-q<label|cmdoption-pure-q>>Quiet startup (suppresses sign-on
    message in interactive mode).
  </description>

  <\description>
    <item*|-T filename<label|cmdoption-pure-T>>Tags file to be written by
    <hlink|<em|--ctags>|#cmdoption-pure--ctags> or
    <hlink|<em|--etags>|#cmdoption-pure--etags>.
  </description>

  <\description>
    <item*|--texmacs<label|cmdoption-pure--texmacs>>Run Pure inside
    <hlink|TeXmacs|#texmacs>.
  </description>

  <\description>
    <item*|-u<label|cmdoption-pure-u>>Do not strip unused functions in batch
    compilation.
  </description>

  <\description>
    <item*|-v[level]<label|cmdoption-pure-v>>Set verbosity level.
  </description>

  <\description>
    <item*|--version<label|cmdoption-pure--version>>Print version information
    and exit.
  </description>

  <\description>
    <item*|-w<label|cmdoption-pure-w>>Enable compiler warnings.
  </description>

  <\description>
    <item*|-x<label|cmdoption-pure-x>>Script mode (execute a script with the
    given command line arguments).
  </description>

  <\description>
    <item*|--<label|cmdoption-pure-->>Stop option processing and pass the
    remaining command line arguments in the <verbatim|argv> variable.
  </description>

  Besides these, the interpreter also understands a number of other command
  line switches for setting various compilation options; please see
  <hlink|Compilation Options|#compilation-options> below for details.

  <with|font-series|bold|Note:> Option parsing follows the usual (Unix)
  conventions, but is somewhat more rigid than the GNU getopt conventions. In
  particular, it is <em|not> possible to combine short options, and there are
  no abbreviations for ``long'' options. Mixing options and other command
  line parameters is generally possible, but note that all option processing
  stops right after <verbatim|-x> and <verbatim|--> (or the first non-option
  parameter in script mode), passing the remaining parameters to the
  executing script in the Pure <verbatim|argv> variable.

  As usual, if an option takes a required argument, the argument may be
  written either as a separate command line parameter immediately following
  the option (as in <verbatim|-I> <em|directory> or <verbatim|--enable>
  <em|optname>), or directly after the option (<verbatim|-I><em|directory> or
  <verbatim|--enable=><em|optname>; note the equals sign in the case of a
  long option). Options with optional arguments work in the same fashion, but
  in this case the argument, if present, <em|must> be written directly behind
  the option.

  <subsubsection|Overview of Operation<label|overview-of-operation>>

  If any source scripts are specified on the command line, they are loaded
  and executed, after which the interpreter exits. Otherwise the interpreter
  enters the interactive read-eval-print loop, see <hlink|Running
  Interactively|#running-interactively> below. You can also use the
  <hlink|<em|-i>|#cmdoption-pure-i> option to enter the interactive loop
  (continue reading from stdin) even after processing some source scripts.

  Options and source files are processed in the order in which they are given
  on the command line. Processing of options and source files ends when
  either the <hlink|<em|-->|#cmdoption-pure--> or the
  <hlink|<em|-x>|#cmdoption-pure-x> option is encountered, or after the first
  script (non-option) argument in <with|font-series|bold|script mode> (i.e.,
  if none of the options <hlink|<em|-b>|#cmdoption-pure-b>,
  <hlink|<em|-i>|#cmdoption-pure-i>, <hlink|<em|--ctags>|#cmdoption-pure--ctags>
  and <hlink|<em|--etags>|#cmdoption-pure--etags> is present). In either
  case, any remaining parameters are passed to the executing script by means
  of the global <hlink|<with|font-family|tt|argc>|#argc> and
  <hlink|<with|font-family|tt|argv>|#argv> variables, denoting the number of
  arguments and the list of the actual parameter strings, respectively. In
  script mode this also includes the script name as <verbatim|argv!0>.

  Script mode is useful, in particular, to turn Pure scripts into executable
  programs by including a ``shebang'' like the following as the first line in
  your main script. (This trick only works with Unix shells, though.)

  <\verbatim>
    #!/usr/local/bin/pure
  </verbatim>

  The following variables are always predefined by the interpreter:

  <\description>
    <item*|<em|variable> argc<label|argc>>

    <item*|<em|variable> argv<label|argv>>The number of extra command line
    arguments and the arguments themselves as a list of strings; see above.
    These are useful if a script is usually run non-interactively and takes
    its input from the command line.
  </description>

  <\description>
    <item*|<em|variable> compiling<label|compiling>>A flag indicating whether
    the program is executed in a batch compilation
    (<hlink|<em|-c>|#cmdoption-pure-c> option), see <hlink|Compiling
    Scripts|#compiling-scripts> below.
  </description>

  <\description>
    <item*|<em|variable> version<label|version>>

    <item*|<em|variable> sysinfo<label|sysinfo>>The version string of the
    Pure interpreter and a string identifying the host system. These are
    useful if parts of your script depend on the particular version of the
    interpreter and the system it runs on. (An alternative way to deal with
    version and system dependencies is to use conditional compilation; see
    <hlink|Conditional Compilation|#conditional-compilation>.)
  </description>

  If available, the prelude script prelude.pure is loaded by the interpreter
  prior to any other definitions, unless the
  <hlink|<em|-n>|#cmdoption-pure-n> or <hlink|<em|--noprelude>|#cmdoption-pure--noprelude>
  option is specified. The prelude is searched for in the directory specified
  with the<label|index-0><hlink|<with|font-family|tt|PURELIB>|#envvar-PURELIB>
  environment variable. If the<label|index-1><hlink|<with|font-family|tt|PURELIB>|#envvar-PURELIB>
  variable is not set, a system-specific default is used. Relative pathnames
  of other source scripts specified on the command line are interpreted
  relative to the current working directory. In addition, the executed
  program may load other scripts and libraries via a
  <hlink|<with|font-family|tt|using>|#using> declaration in the source, which
  are searched for in a number of locations, including the directories named
  with the <hlink|<em|-I>|#cmdoption-pure-I> and
  <hlink|<em|-L>|#cmdoption-pure-L> options; see the
  <hlink|Declarations|#declarations> and <hlink|C Interface|#c-interface>
  sections for details.

  <subsubsection|Compiling Scripts<label|compiling-scripts>>

  The interpreter compiles scripts, as well as definitions that you enter
  interactively, automatically. This is done in an incremental fashion, as
  the code is needed, and is therefore known as JIT
  (<with|font-series|bold|just in time>) compilation. Thus the interpreter
  never really ``interprets'' the source program or some intermediate
  representation, it just acts as a frontend to the compiler, taking care of
  compiling source code to native machine code before it gets executed.

  Pure's LLVM backend does ``lazy JIT compilation'' by default, meaning that
  each function (global or local) is compiled no sooner than it is run for
  the first time. With the <hlink|<em|--eager-jit>|#cmdoption-pure--eager-jit>
  option, however, it will also compile all other (global or local) functions
  that may be called by the compiled function.
  (The<label|index-2><hlink|<with|font-family|tt|PURE_EAGER_JIT>|#envvar-PURE-EAGER-JIT>
  environment variable, when set to any value, has the same effect, so that
  you do not have to specify the <hlink|<em|--eager-jit>|#cmdoption-pure--eager-jit>
  option each time you run the interpreter.) Eager JIT compilation may be
  more efficient in some cases (since bigger chunks of compilation work can
  be done in one go) and less efficient in others (e.g., eager JITing may
  compile large chunks of code which aren't actually called later, except in
  rare circumstances).

  Note that the eager JIT mode is only available with LLVM 2.7 or later;
  otherwise this option will be ignored.

  It is also possible to compile your scripts to native code beforehand,
  using the <hlink|<em|-c>|#cmdoption-pure-c> batch compilation option. This
  option forces the interpreter to batch mode (unless
  <hlink|<em|-i>|#cmdoption-pure-i> is specified as well, which overrides
  <hlink|<em|-c>|#cmdoption-pure-c>). Any scripts specified on the command
  line are then executed as usual, but after execution the interpreter takes
  a snapshot of the program and compiles it to one of several supported
  output formats, LLVM assembler (.ll) or bitcode (.bc), native assembler
  (.s) or object (.o), or a native executable, depending on the output
  filename specified with <hlink|<em|-o>|#cmdoption-pure-o>. If the output
  filename ends in the .ll extension, an LLVM assembler file is created which
  can then be processed with the LLVM toolchain. If the output filename is
  just `-`, the assembler file is written to standard output, which is useful
  if you want to pass the generated code to the LLVM tools in a pipeline. If
  the output filename ends in the .bc extension, an LLVM bitcode file is
  created instead.

  The .ll and .bc formats are supported natively by the Pure interpreter, no
  external tools are required to generate these. If the target is an .s, .o
  or executable file, the Pure interpreter creates a temporary bitcode file
  on which it invokes the LLVM tools <with|font-series|bold|opt> and
  <with|font-series|bold|llc> to create a native assembler or object file,
  and then uses the C/C++ compiler to link the resulting program (if
  requested). You can also specify additional libraries to be linked into the
  executable with the <hlink|<em|-l>|#cmdoption-pure-l> option. If the output
  filename is omitted, it defaults to a.out (a.exe on Windows).

  The C/C++ compiler invoked by the batch compiler is normally
  <with|font-series|bold|gcc> by default, but you can change this with
  the<label|index-3><hlink|<with|font-family|tt|CC>|#envvar-CC>
  and<label|index-4><hlink|<with|font-family|tt|CXX>|#envvar-CXX> environment
  variables. The LLVM tools <with|font-series|bold|opt> and
  <with|font-series|bold|llc> are usually located on
  the<label|index-5><verbatim|PATH> or in a system-specific directory
  determined at installation time. It is also possible to use custom versions
  of these programs with the batch compiler, by placing them into the Pure
  library directory, as specified at installation time or by
  the<label|index-6><hlink|<with|font-family|tt|PURELIB>|#envvar-PURELIB>
  environment variable. (Note that this lets you use the batch compiler on
  systems which don't have the LLVM toolchain installed. In fact, you could
  even deploy a stand-alone version of the interpreter together with the
  requisite LLVM tools on systems which don't have LLVM installed at all, by
  linking both the Pure runtime and the <with|font-series|bold|opt> and
  <with|font-series|bold|llc> programs statically against LLVM.)

  The <hlink|<em|-c>|#cmdoption-pure-c> option provides a convenient way to
  quickly turn a Pure script into a standalone executable which can be
  invoked directly from the shell. One advantage of compiling your script is
  that this eliminates the JIT compilation time and thus considerably reduces
  the startup time of the program. Another reason to prefer a standalone
  executable is that it lets you deploy the program on systems without a full
  Pure installation (usually only the runtime library is required on the
  target system). On the other hand, compiled scripts also have some
  limitations, mostly concerning the use of the built-in
  <hlink|<with|font-family|tt|eval>|purelib.tm#eval> function. Please see the
  <hlink|Batch Compilation|#batch-compilation> section for details.

  The <verbatim|-v64> (or <verbatim|-v0100>) verbosity option can be used to
  have the interpreter print the commands it executes during compilation, see
  <hlink|Verbosity and Debugging Options|#verbosity-and-debugging-options>
  below. When creating an object file, this also prints the suggested linker
  command (including all the dynamic modules loaded by the script, which also
  have to be linked in to create a working executable), to which you only
  have to add the options describing the desired output file.

  <subsubsection|Tagging Scripts<label|tagging-scripts>>

  Pure programs often have declarations and definitions of global symbols
  scattered out over many different source files. The
  <hlink|<em|--ctags>|#cmdoption-pure--ctags> and
  <hlink|<em|--etags>|#cmdoption-pure--etags> options let you create a
  <hlink|tags|http://en.wikipedia.org/wiki/Ctags> file which allows you to
  quickly locate these items in text editors such as
  <with|font-series|bold|vi> and <with|font-series|bold|emacs> which support
  this feature.

  If <hlink|<em|--ctags>|#cmdoption-pure--ctags> or
  <hlink|<em|--etags>|#cmdoption-pure--etags> is specified, the interpreter
  enters a special variation of batch mode in which it only parses source
  files without executing them and collects information about the locations
  of global symbol declarations and definitions. The collected information is
  then written to a tags file in the ctags or etags format used by
  <with|font-series|bold|vi> and <with|font-series|bold|emacs>, respectively.
  The desired name of the tags file can be specified with the
  <hlink|<em|-T>|#cmdoption-pure-T> option; it defaults to tags for
  <hlink|<em|--ctags>|#cmdoption-pure--ctags> and TAGS for
  <hlink|<em|--etags>|#cmdoption-pure--etags> (which matches the default tags
  file names used by <with|font-series|bold|vi> and
  <with|font-series|bold|emacs>, respectively).

  The tags file contains information about the global constant, variable,
  macro, function and operator symbols of all scripts specified on the
  command line, as well as the prelude and other scripts included via a
  <hlink|<with|font-family|tt|using>|#using> clause. Tagged scripts which are
  located in the same directory as the tags file (or, recursively, in one of
  its subdirectories) are specified using relative pathnames, while scripts
  outside this hierarchy (such as included scripts from the standard library)
  are denoted with absolute pathnames. This scheme makes it possible to move
  an entire directory together with its tags file and have the tags
  information still work in the new location.

  <subsubsection|Running Interactively<label|running-interactively>>

  If the interpreter runs in interactive mode, it repeatedly prompts you for
  input (which may be any legal Pure code or some special interpreter
  commands provided for interactive usage), and prints computed results. This
  is also known as the <with|font-series|bold|read-eval-print> loop and is
  described in much more detail in the <hlink|Interactive
  Usage|#interactive-usage> section. To exit the interpreter, just type the
  <verbatim|quit> command or the end-of-file character (<verbatim|Ctrl-d> on
  Unix) at the beginning of the command line.

  The interpreter may also source a few additional interactive startup files
  immediately before entering the interactive loop, unless the
  <hlink|<em|--norc>|#cmdoption-pure--norc> option is specified. First
  .purerc in the user's home directory is read, then .purerc in the current
  working directory. These are ordinary Pure scripts which can be used to
  provide additional definitions for interactive usage. Finally, a .pure file
  in the current directory (usually containing a dump from a previous
  interactive session) is loaded if it is present.

  When the interpreter is in interactive mode and reads from a tty, unless
  the <hlink|<em|--noediting>|#cmdoption-pure--noediting> option is
  specified, commands are usually read using <with|font-series|bold|readline>
  or some compatible replacement, providing completion for all commands
  listed under <hlink|Interactive Usage|#interactive-usage>, as well as for
  symbols defined in the running program. When exiting the interpreter, the
  command history is stored in <math|\<sim\>>/.pure_history, from where it is
  restored the next time you run the interpreter.

  The interpreter also provides a simple source level debugger when run in
  interactive mode, see <hlink|Debugging|#debugging> for details. To enable
  the debugger, you need to specify the <hlink|<em|-g>|#cmdoption-pure-g>
  option when invoking the interpreter. This option causes your script to run
  <em|much> slower, so you should only use this option if you want to run the
  debugger.

  <subsubsection|Verbosity and Debugging Options<label|verbosity-and-debugging-options>>

  The <hlink|<em|-v>|#cmdoption-pure-v> option is useful for debugging the
  interpreter, or if you are interested in the code your program gets
  compiled to. The level argument is optional; it defaults to 1. Seven
  different levels are implemented at this time. Only the first two levels
  will be useful for the average Pure programmer; the remaining levels are
  mostly intended for maintenance purposes.

  <\description>
    <item*|1 (0x1, 001)>denotes echoing of parsed definitions and
    expressions.

    <item*|2 (0x2, 002)>adds special annotations concerning local bindings
    (de Bruijn indices, subterm paths; this can be helpful to debug tricky
    variable binding issues).

    <item*|4 (0x4, 004)>adds descriptions of the matching automata for the
    left-hand sides of equations (you probably want to see this only when
    working on the guts of the interpreter).

    <item*|8 (0x8, 010)>dumps the ``real'' output code (LLVM assembler, which
    is as close to the native machine code for your program as it gets; you
    definitely don't want to see this unless you have to inspect the
    generated code for bugs or performance issues).

    <item*|16 (0x10, 020)>adds debugging messages from the bison(1) parser;
    useful for debugging the parser.

    <item*|32 (0x20, 040)>adds debugging messages from the flex(1) lexer;
    useful for debugging the lexer.

    <item*|64 (0x40, 0100)>turns on verbose batch compilation; this is useful
    if you want to see exactly which commands get executed during batch
    compilation (<hlink|<em|-c>|#cmdoption-pure-c>).
  </description>

  These values can be or'ed together, and, for convenience, can be specified
  in either decimal, hexadecimal or octal. Thus 0xff or 0777 always gives you
  full debugging output (which isn't likely to be used by anyone but the Pure
  developers). Some useful flag combinations for experts are (in octal) 007
  (echo definitions along with de Bruijn indices and matching automata), 011
  (definitions and assembler code), 021 (parser debugging output along with
  parsed definitions) and 0100 (verbose batch compilation).

  Note that the <hlink|<em|-v>|#cmdoption-pure-v> option is only applied
  after the prelude has been loaded. If you want to debug the prelude, use
  the <hlink|<em|-n>|#cmdoption-pure-n> option and specify the prelude.pure
  file explicitly on the command line. Verbose output is also suppressed for
  modules imported through a <hlink|<with|font-family|tt|using>|#using>
  clause. As a remedy, you can use the interactive <verbatim|show> command
  (see the <hlink|Interactive Usage|#interactive-usage> section) to list
  definitions along with additional debugging information.

  <subsubsection|Compilation Options<label|compilation-options>>

  Besides the options listed above, the interpreter also understands some
  additional command line switches and corresponding environment variables to
  control various compilation options.

  <paragraph|Code Generation Options<label|code-generation-options>>

  These options take the form <verbatim|--opt> and <verbatim|--noopt>,
  respectively, where <verbatim|opt> denotes the option name (see below for a
  list of supported options). By default, these options are all enabled;
  <verbatim|--noopt> disables the option, <verbatim|--opt> reenables it. In
  addition, for each option <verbatim|opt> there is also a corresponding
  environment variable <verbatim|PURE_NOOPT> (with the option name in
  uppercase) which, when set, disables the option by default. (Setting this
  variable to any value will do, the interpreter only checks whether the
  variable exists in the environment.)

  For instance, the <verbatim|checks> option controls stack and signal
  checks. Thus <verbatim|--nochecks> on the command line disables the option,
  and setting the <verbatim|PURE_NOCHECKS> environment variable makes this
  the default, in which case you can use <verbatim|--checks> on the command
  line to reenable the option.

  Each code generation option can also be used as a
  <with|font-series|bold|pragma> (compiler directive) in source code so that
  you can control it on a per-rule basis. The pragma must be on a line by
  itself, starting in column 1, and takes the following form (using
  <verbatim|--nochecks> as an example):

  <\verbatim>
    #! --nochecks // line-oriented comment may go here
  </verbatim>

  Currently, the following code generation options are recognized:

  <\description>
    <item*|--checks<label|cmdoption-pure--checks>>

    <item*|--nochecks<label|cmdoption-pure--nochecks>>Enable or disable
    various extra stack and signal checks. By default, the interpreter checks
    for stack overflows and pending signals on entry to every function, see
    <hlink|Stack Size and Tail Recursion|#stack-size-and-tail-recursion> and
    <hlink|Handling of Asynchronous Signals|#handling-of-asynchronous-signals>
    for details. This is needed to catch these conditions in a reliable way,
    so we recommend to leave this enabled. However, these checks also make
    programs run a little slower (typically some 5%, YMMV). If performance is
    critical then you can disable the checks with the
    <hlink|<em|--nochecks>|#cmdoption-pure--nochecks> option. (Even then, a
    minimal amount of checking will be done, usually on entry to every global
    function.)
  </description>

  <\description>
    <item*|--const<label|cmdoption-pure--const>>

    <item*|--noconst<label|cmdoption-pure--noconst>>Enable or disable the
    precomputing of constant values in batch compilation (cf.
    <hlink|Compiling Scripts|#compiling-scripts>). If enabled (which is the
    default), the values of constants in <hlink|<with|font-family|tt|const>|#const>
    definitions are precomputed at compile time (if possible) and then stored
    in the generated executable. This usually yields faster startup times but
    bigger executables. You can disable this option with
    <hlink|<em|--noconst>|#cmdoption-pure--noconst> to get smaller
    executables at the expense of slower startup times. Please see the
    <hlink|Batch Compilation|#batch-compilation> section for an example.
  </description>

  <\description>
    <item*|--fold<label|cmdoption-pure--fold>>

    <item*|--nofold<label|cmdoption-pure--nofold>>Enable or disable constant
    folding in the compiler frontend. This means that constant expressions
    involving int and double values and the usual arithmetic and logical
    operations on these are precomputed at compile time. (This is mostly for
    cosmetic purposes; the LLVM backend will perform this optimization anyway
    when generating machine code.) For instance:

    <\verbatim>
      \<gtr\> foo x = 2*3*x;

      \<gtr\> show foo

      foo x = 6*x;
    </verbatim>

    Disabling constant folding in the frontend causes constant expressions to
    be shown as you entered them:

    <\verbatim>
      \<gtr\> #! --nofold

      \<gtr\> bar x = 2*3*x;

      \<gtr\> show bar

      bar x = 2*3*x;
    </verbatim>

    The same option also determines the handling of type aliases at compile
    time, see <hlink|Type Rules|#type-rules>.
  </description>

  <\description>
    <item*|--symbolic<label|cmdoption-pure--symbolic>>

    <item*|--nosymbolic<label|cmdoption-pure--nosymbolic>>Enable or disable
    <with|font-series|bold|symbolic mode>. Pure's default behaviour is to
    evaluate function applications in a symbolic fashion using the equations
    (rewriting rules) supplied by the programmer, cf. <hlink|Definitions and
    Expression Evaluation|#definitions-and-expression-evaluation>. This means
    that it is <em|not> normally an error if there is no equation which
    applies to the given function application to be evaluated; rather, the
    unevaluated function becomes a ``constructor symbol'' which is applied to
    the provided arguments to form a literal (``normal form'') term which
    stands for itself. E.g., here's what you get if you try to add an
    (undefined) symbol and a number:

    <\verbatim>
      \<gtr\> a+1;

      a+1
    </verbatim>

    The <hlink|<em|--nosymbolic>|#cmdoption-pure--nosymbolic> option changes
    this behaviour so that if a global function has <em|any> defining
    equations, then an attempt to invoke the function on a combination of
    arguments for which there is no applicable equation, raises an exception.
    So if the interpreter is invoked with
    <hlink|<em|--nosymbolic>|#cmdoption-pure--nosymbolic> then you'll see
    this instead:

    <\verbatim>
      \<gtr\> a+1;

      \<less\>stdin\<gtr\>, line 1: unhandled exception 'failed_match' while
      evaluating 'a+1'
    </verbatim>

    This behaviour is more in line with traditional languages where it is an
    error if a ``defined function'' cannot be evaluated in case of argument
    mismatch. It makes it easier to spot argument mismatch errors which might
    well go unnoticed if a program is executed in Pure's default symbolic
    mode. However, it also makes it impossible to perform symbolic expression
    evaluations which is one of the key features of term rewriting as a
    programming language.

    Much of Pure's library and many programming examples assume Pure's
    default mode of symbolic evaluation, so that it is generally not
    advisable to run the interpreter with a global
    <hlink|<em|--nosymbolic>|#cmdoption-pure--nosymbolic> option, except
    maybe for debugging purposes. More commonly
    <hlink|<em|--nosymbolic>|#cmdoption-pure--nosymbolic> is used as a pragma
    in source code where it only applies to a specific collection of function
    definitions. In addition, there's a <hlink|<em|--defined>|#cmdoption-pure-pragma--defined>
    pragma which enables you to mark individual functions as ``defined
    functions'', see below.
  </description>

  <\description>
    <item*|--tc<label|cmdoption-pure--tc>>

    <item*|--notc<label|cmdoption-pure--notc>>Enable or disable tail call
    optimization (TCO). TCO is needed to make tail-recursive functions
    execute in constant stack space, so we recommend to leave this enabled.
    However, at the time of this writing LLVM's TCO support is still
    bug-ridden on some platforms, so the <hlink|<em|--notc>|#cmdoption-pure--notc>
    option allows you to disable it. (Note that TCO can also be disabled when
    compiling the Pure interpreter, in which case these options have no
    effect; see the <hlink|<em|installation instructions>|install.tm> for
    details.)
  </description>

  <with|font-series|bold|Note:> All of the options above also have a
  corresponding ``option symbol'' so that they can be queried and set using
  the facilities described under <hlink|Conditional
  Compilation|#conditional-compilation> below. (The symbol is just the name
  of the option, e.g., <verbatim|checks> for the
  <hlink|<em|--checks>|#cmdoption-pure--checks>,
  <hlink|<em|--nochecks>|#cmdoption-pure--nochecks> option and pragma.)

  Besides these, there are the following special pragmas affecting the
  evaluation of some global function or macro, which is specified in the
  pragma. These pragmas can only be used in source code, they cannot be
  controlled using command line options or environment variables. Note that
  the given symbol <verbatim|fun> may in fact be an arbitrary symbol (not
  just an identifier), so that these pragmas can also be applied to special
  operator symbols (cf. <hlink|Lexical Matters|#lexical-matters>). Also note
  that each of these pragmas also implicitly declares the symbol, so if a
  symbol needs any special attributes then it must be declared before any
  pragmas involving it (cf. <hlink|Symbol
  Declarations|#symbol-declarations>).

  <\description>
    <item*|--eager fun<label|cmdoption-pure-pragma--eager>>Instruct the
    interpreter to JIT-compile the given function eagerly. This means that
    native code will be created for the function, as well as all other
    (global or local) functions that may be called by the compiled function,
    as soon as the function gets recompiled. This avoids the hiccups you get
    when a function is compiled on the fly if it is run for the first time,
    which is particularly useful for functions which are to be run in
    realtime (typically in multimedia applications). Please note that, in
    difference to the <em|--eager-jit> option, this feature is available for
    all LLVM versions (it doesn't require LLVM 2.7 or later).
  </description>

  <\description>
    <item*|--required fun<label|cmdoption-pure-pragma--required>>Inform the
    batch compiler (cf. <hlink|Compiling Scripts|#compiling-scripts>) that
    the given function symbol <verbatim|fun> should never be stripped from
    the program. This is useful, e.g., if a function is never called
    explicitly but only through <hlink|<with|font-family|tt|eval>|purelib.tm#eval>.
    Adding a <hlink|<em|--required>|#cmdoption-pure-pragma--required> pragma
    for the function then makes sure that the function is always linked into
    the program. Please see the <hlink|Batch Compilation|#batch-compilation>
    section for an example.
  </description>

  <\description>
    <item*|--defined fun<label|cmdoption-pure-pragma--defined>>

    <item*|--nodefined fun<label|cmdoption-pure-pragma--nodefined>>These
    pragmas change the behaviour of global functions defined in a Pure
    program. The <hlink|<em|--defined>|#cmdoption-pure-pragma--defined>
    pragma marks the given function or operator symbol as a ``defined
    function'' so that an exception is raised if the function is applied to a
    combination of arguments for which there is no applicable equation. This
    works similarly to the <hlink|<em|--nosymbolic>|#cmdoption-pure--nosymbolic>
    pragma (see above), but allows you to mark individual functions as
    ``defined''. For instance:

    <\verbatim>
      \<gtr\> #! --defined +

      \<gtr\> a+1;

      \<less\>stdin\<gtr\>, line 2: unhandled exception 'failed_match' while
      evaluating 'a+1'
    </verbatim>

    The <hlink|<em|--defined>|#cmdoption-pure-pragma--defined> status of a
    function can be changed at any time (causing the function to be
    recompiled on the fly if necessary), and the
    <hlink|<em|--nodefined>|#cmdoption-pure-pragma--nodefined> pragma
    restores the default behaviour of returning a normal form upon failure:

    <\verbatim>
      \<gtr\> #! --nodefined +

      \<gtr\> a+1;

      a+1
    </verbatim>

    More information and examples for common uses of the
    <hlink|<em|--defined>|#cmdoption-pure-pragma--defined> and
    <hlink|<em|--nosymbolic>|#cmdoption-pure--nosymbolic> pragmas can be
    found under <hlink|Defined Functions|#defined-functions> in the
    <hlink|Caveats and Notes|#caveats-and-notes> section.
  </description>

  <\description>
    <item*|--quoteargs fun<label|cmdoption-pure-pragma--quoteargs>>This
    pragma tells the macro evaluator (cf. <hlink|Macros|#macros>) that the
    given macro should receive its arguments unevaluated, i.e., in quoted
    form. This is described in more detail in the <hlink|Built-in Macros and
    Special Expressions|#built-in-macros-and-special-expressions> section.
  </description>

  <paragraph|Conditional Compilation<label|conditional-compilation>>

  As of version 0.49, Pure also provides a rudimentary facility for denoting
  optional and alternative code paths. This is supposed to cover the most
  common cases where conditional compilation is needed. (For more elaborate
  needs you can always use real Pure code which enables you to configure your
  program at runtime using, e.g., the <hlink|<with|font-family|tt|eval>|purelib.tm#eval>
  function.)

  Pure's conditional compilation pragmas are based on the notion of
  user-defined symbols (which can be really any text that does not contain
  whitespace or any of the shell wildcard characters <verbatim|*?[]>) called
  compilation <with|font-series|bold|options>. By default, all options are
  <em|undefined> and <em|enabled>. An option becomes <em|defined> as soon as
  it is set explicitly, either with an environment variable or one of the
  <hlink|<em|--enable>|#cmdoption-pure-pragma--enable> and
  <hlink|<em|--disable>|#cmdoption-pure-pragma--disable> pragmas, see below.

  You can define the value of an option by setting a corresponding
  environment variable <verbatim|PURE_OPTION_OPT>, where <verbatim|OPT> is
  the option symbol in uppercase. The value of the environment variable
  should either be <verbatim|0> (disabled) or <verbatim|1> (enabled).

  Options can be enabled and disabled in Pure scripts with the following
  pragmas, which are also available as command line options when invoking the
  Pure interpreter:

  <\description>
    <item*|--enable option<label|cmdoption-pure-pragma--enable>>

    <item*|--disable option<label|cmdoption-pure-pragma--disable>>Enable or
    disable the given option, respectively. Note that an option specified in
    the environment is overridden by a value specified with these options on
    the command line, which in turn is overridden by a corresponding pragma
    in source code.
  </description>

  The actual conditional compilation pragmas work in pretty much the same
  fashion as the C preprocessor directives <verbatim|#if>, <verbatim|#ifdef>
  etc. (except that, as already mentioned, an option is always <em|enabled>
  if it is undefined).

  <\description>
    <item*|--ifdef option<label|cmdoption-pure-pragma--ifdef>>

    <item*|--ifndef option<label|cmdoption-pure-pragma--ifndef>>Begins a code
    section which should be included in the program if the given option is
    defined or undefined, respectively.
  </description>

  <\description>
    <item*|--if option<label|cmdoption-pure-pragma--if>>

    <item*|--ifnot option<label|cmdoption-pure-pragma--ifnot>>Begins a code
    section which should be included in the program if the given option is
    enabled or disabled, respectively.
  </description>

  <\description>
    <item*|--else<label|cmdoption-pure-pragma--else>>Begins an alternative
    code section which is included in the program if the corresponding
    <hlink|<em|--ifdef>|#cmdoption-pure-pragma--ifdef>,
    <hlink|<em|--ifndef>|#cmdoption-pure-pragma--ifndef>,
    <hlink|<em|--if>|#cmdoption-pure-pragma--if> or
    <hlink|<em|--ifnot>|#cmdoption-pure-pragma--ifnot> section was excluded,
    and vice versa.
  </description>

  <\description>
    <item*|--endif<label|cmdoption-pure-pragma--endif>>Ends a conditional
    code section.
  </description>

  Conditional code sections may be nested to an arbitrary depth. Each
  <hlink|<em|--ifdef>|#cmdoption-pure-pragma--ifdef>,
  <hlink|<em|--ifndef>|#cmdoption-pure-pragma--ifndef>,
  <hlink|<em|--if>|#cmdoption-pure-pragma--if> or
  <hlink|<em|--ifnot>|#cmdoption-pure-pragma--ifnot> pragma must be followed
  by a matching <hlink|<em|--endif>|#cmdoption-pure-pragma--endif>. The
  <hlink|<em|--else>|#cmdoption-pure-pragma--else> section is optional; if
  present, it applies to the most recent <hlink|<em|--ifdef>|#cmdoption-pure-pragma--ifdef>,
  <hlink|<em|--ifndef>|#cmdoption-pure-pragma--ifndef>,
  <hlink|<em|--if>|#cmdoption-pure-pragma--if> or
  <hlink|<em|--ifnot>|#cmdoption-pure-pragma--ifnot> section not terminated
  by a matching <hlink|<em|--endif>|#cmdoption-pure-pragma--endif>. Unmatched
  conditional pragmas warrant an error message by the compiler.

  Conditional code is handled at the level of the lexical analyzer. Excluded
  code sections are treated like comments, i.e., the parser never gets to see
  them.

  The <hlink|<em|--ifdef>|#cmdoption-pure-pragma--ifdef> and
  <hlink|<em|--ifndef>|#cmdoption-pure-pragma--ifndef> pragmas are typically
  used to change the default of an option without clobbering defaults set by
  the user through an environment variable or a command line option. For
  instance:

  <\verbatim>
    #! --ifndef opt

    #! --disable opt

    #! --endif
  </verbatim>

  Here's a (rather contrived) example which shows all these pragmas in
  action. You may want to type this in the interpreter to verify that the
  code sections are indeed included and excluded from the Pure program as
  indicated:

  <\verbatim>
    // disable the 'bar' option

    #! --disable bar

    \;

    #! --ifdef foo

    1/2; // excluded

    #! --endif

    #! --ifndef bar

    1/3; // excluded

    #! --endif

    \;

    #! --if foo

    foo x = x+1; // included

    #! --if bar

    bar x = x-1; // excluded

    #! --else

    bar x = x/2; // included

    #! --endif // bar

    #! --endif // foo

    \;

    // reenable the 'bar' option

    #! --enable bar

    \;

    #! --if bar

    bar 99; // included

    #! --endif // bar

    \;

    #! --ifnot foo

    baz x = 2*x; // excluded

    #! --endif // not foo
  </verbatim>

  A few options are always predefined as ``builtins'' by the interpreter.
  This includes all of the options described under <hlink|Code Generation
  Options|#code-generation-options> and <hlink|Warning
  Options|#warning-options>, so that these can also be queried with
  <hlink|<em|--if>|#cmdoption-pure-pragma--if>,
  <hlink|<em|--ifnot>|#cmdoption-pure-pragma--ifnot> and set with
  <hlink|<em|--enable>|#cmdoption-pure-pragma--enable>,
  <hlink|<em|--disable>|#cmdoption-pure-pragma--disable>. For instance:

  <\verbatim>
    #! --ifnot checks

    puts "This program uses deep recursion, so we enable stack checks here!";

    #! --enable checks

    #! --endif // not checks

    \;

    #! --if warn

    puts "Beware of bugs in the above code.";

    puts "I have only proved it correct, not tried it.";

    #! --endif // warn
  </verbatim>

  Moreover, the following options are provided as additional builtins which
  are useful for handling special compilation requirements as well as system
  and version dependencies.

  <\itemize>
    <item>The <verbatim|compiled> option is enabled if a program is
    batch-compiled. This lets you pick alternative code paths depending on
    whether a script is compiled to a native executable or not. Please see
    the example at the end of the <hlink|Batch
    Compilation|#batch-compilation> section for details.

    <item>The <verbatim|interactive> and <verbatim|debugging> options are
    enabled if a program runs in interactive
    (<hlink|<em|-i>|#cmdoption-pure-i>) and/or debugging
    (<hlink|<em|-g>|#cmdoption-pure-g>) mode, respectively. These options are
    read-only; they cannot be changed with
    <hlink|<em|--enable>|#cmdoption-pure-pragma--enable>,
    <hlink|<em|--disable>|#cmdoption-pure-pragma--disable>. Example:

    <\verbatim>
      #! --if interactive

      puts "Usage: run 'main filename'";

      #! --else

      main (argv!1);

      #! --endif
    </verbatim>

    <item>The <verbatim|version-x.y> option indicates a check against the
    version of the host Pure interpreter. <verbatim|x.y> indicates the
    required (major/minor) version. You can also use <verbatim|x.y+> to
    indicate version <verbatim|x.y> or later, or <verbatim|x.y-> for version
    <verbatim|x.y> or earlier. By combining these, you can pick code
    depending on a particular range of Pure versions, or you can reverse the
    test to check for anything later or earlier than a given version:

    <\verbatim>
      #! --if version-0.36+

      #! --if version-0.48-

      // code to be executed for Pure versions 0.36..0.48 (inclusive)

      #! --endif

      #! --endif

      \;

      #! --ifnot version-0.48-

      // code to be executed for Pure versions \<gtr\> 0.48

      #! --endif
    </verbatim>

    <item>Last but not least, the interpreter always defines the target
    triplet of the host system as an option symbol. This is the same as what
    <hlink|<with|font-family|tt|sysinfo>|#sysinfo> returns, so you can check
    for a specific system like this:

    <\verbatim>
      #! --if x86_64-unknown-linux-gnu

      // 64 bit Linux-specific code goes here

      #! --endif
    </verbatim>

    It goes without saying that this method isn't very practical if you want
    to check for a wide range of systems. As a remedy, the
    <hlink|<em|--if>|#cmdoption-pure-pragma--if> and
    <hlink|<em|--ifnot>|#cmdoption-pure-pragma--ifnot> pragmas treat shell
    glob patterns in tests for option symbols in a special way, by matching
    the pattern against the host triplet to see whether the condition holds.
    This allows you to write a generic test, e.g., for Windows systems like
    this:

    <\verbatim>
      #! --if *-mingw32

      // Windows-specific code goes here

      #! --endif
    </verbatim>
  </itemize>

  <paragraph|Warning Options<label|warning-options>>

  The <hlink|<em|-w>|#cmdoption-pure-w> option enables some additional
  warnings which are useful to check your scripts for possible errors. In
  particular, it will report implicit declarations of function and type
  symbols, which might indicate undefined or mistyped symbols that need to be
  fixed, see <hlink|Symbol Lookup and Creation|#symbol-lookup-and-creation>
  for details.

  This option can also be controlled on a per-rule basis by adding the
  following pragmas to your script:

  <\description>
    <item*|--warn<label|cmdoption-pure-pragma--warn>>

    <item*|--nowarn<label|cmdoption-pure-pragma--nowarn>>Enable or disable
    compiler warnings. The <hlink|<em|-w>|#cmdoption-pure-w> flag sets the
    default for these pragmas.
  </description>

  <\description>
    <item*|--rewarn<label|cmdoption-pure-pragma--rewarn>>Reset compiler
    warnings to the default, as set with the
    <hlink|<em|-w>|#cmdoption-pure-w> flag (or not).
  </description>

  The latter pragma is useful to enable or disable warnings in a section of
  code and reset it to the default afterwards:

  <\verbatim>
    #! --warn

    // Code with warnings goes here.

    #! --rewarn
  </verbatim>

  (The same could also be achieved with conditional compilation, but only
  much more clumsily. However, note that <hlink|<em|--rewarn>|#cmdoption-pure-pragma--rewarn>
  only provides a single level of ``backup'', so nesting such sections is not
  supported.)

  <subsubsection|Startup Files<label|startup-files>>

  The interpreter may source various files during its startup. These are:

  <\description>
    <item*|<math|\<sim\>>/.pure_history>Interactive command history.
  </description>

  <\description>
    <item*|<math|\<sim\>>/.purerc, .purerc, .pure>Interactive startup files.
    The latter is usually a dump from a previous interactive session.
  </description>

  <\description>
    <item*|prelude.pure>Standard prelude. If available, this script is loaded
    before any other definitions, unless <hlink|<em|-n>|#cmdoption-pure-n>
    was specified.
  </description>

  <subsubsection|Environment<label|environment>>

  Various aspects of the interpreter can be configured through the following
  shell environment variables:

  <\description>
    <item*|CC<label|envvar-CC>>

    <item*|CXX<label|envvar-CXX>>C and C++ compiler used by the Pure batch
    compiler (<verbatim|pure> <verbatim|-c>) to compile and link native
    executables. Defaults to <with|font-series|bold|gcc> and
    <with|font-series|bold|g++>, respectively.
  </description>

  <\description>
    <item*|BROWSER<label|envvar-BROWSER>>If
    the<label|index-7><hlink|<with|font-family|tt|PURE_HELP>|#envvar-PURE-HELP>
    variable is not set (see below), this specifies a colon-separated list of
    browsers to try for reading the online documentation. See
    <hlink|http://catb.org/<math|\<sim\>>esr/BROWSER/|http://catb.org/-tildeesr/BROWSER/>.
  </description>

  <\description>
    <item*|PURELIB<label|envvar-PURELIB>>Directory to search for library
    scripts, including the prelude. If<label|index-8><hlink|<with|font-family|tt|PURELIB>|#envvar-PURELIB>
    is not set, it defaults to some location specified at installation time.
  </description>

  <\description>
    <item*|PURE_EAGER_JIT<label|envvar-PURE-EAGER-JIT>>Enable eager JIT
    compilation (same as <hlink|<em|--eager-jit>|#cmdoption-pure--eager-jit>),
    see <hlink|Compiling Scripts|#compiling-scripts> for details.
  </description>

  <\description>
    <item*|PURE_ESCAPE<label|envvar-PURE-ESCAPE>>If set, interactive commands
    are prefixed with the first character in the value of this variable (same
    as <hlink|<em|--escape>|#cmdoption-pure--escape>), see <hlink|Interactive
    Usage|#interactive-usage> for details.
  </description>

  <\description>
    <item*|PURE_HELP<label|envvar-PURE-HELP>>Command used to browse the Pure
    manual. This must be a browser capable of displaying html files. Default
    is <with|font-series|bold|w3m>.
  </description>

  <\description>
    <item*|PURE_INCLUDE<label|envvar-PURE-INCLUDE>>Additional directories (in
    colon-separated format) to be searched for included scripts.
  </description>

  <\description>
    <item*|PURE_LIBRARY<label|envvar-PURE-LIBRARY>>Additional directories (in
    colon-separated format) to be searched for dynamic libraries.
  </description>

  <\description>
    <item*|PURE_MORE<label|envvar-PURE-MORE>>Shell command to be used for
    paging through output of the <verbatim|show> command, when the
    interpreter runs in interactive mode.<label|index-9><verbatim|PURE_LESS>
    does the same for evaluation results printed by the interpreter.
  </description>

  <\description>
    <item*|PURE_PS<label|envvar-PURE-PS>>Command prompt used in the
    interactive command loop (``\<gtr\> '' by default).
  </description>

  <\description>
    <item*|PURE_STACK<label|envvar-PURE-STACK>>Maximum stack size in
    kilobytes (0 = unlimited). A reasonable default is provided (currently
    this is always 8192K - 128K for interpreter and runtime, which should
    work on most modern PCs). If you're still getting segfaults due to stack
    overflow then you'll either have to reduce this value or increase the
    actual stack space available to programs.
  </description>

  Besides these, the interpreter also understands a number of other
  environment variables for setting various compilation options (see
  <hlink|Compilation Options|#compilation-options> above) and commands to
  invoke different LLVM compilers on inline code (see <hlink|Inline
  Code|#inline-code>).

  <subsection|Pure Overview<label|pure-overview>>

  Pure is a fairly simple yet powerful language. Programs are basically
  collections of term rewriting rules, which are used to reduce expressions
  to <with|font-series|bold|normal form> in a symbolic fashion. For
  convenience, Pure also offers some extensions to the basic term rewriting
  calculus, like global variables and constants, nested scopes of local
  function and variable definitions, anonymous functions (lambdas), exception
  handling and a built-in macro facility. These are all described below and
  in the following sections.

  Most basic operations are defined in the standard
  <hlink|<em|prelude>|purelib.tm#prelude>. This includes the usual arithmetic
  and logical operations, as well as the basic string, list and matrix
  functions. The prelude is always loaded by the interpreter, so that you can
  start using the interpreter as a sophisticated kind of desktop calculator
  right away. Other useful operations are provided through separate library
  modules. Some of these, like the system interface and the container data
  structures, are distributed with the interpreter, others are available as
  separate add-on packages from the Pure website. A (very) brief overview of
  some of the modules distributed with the Pure interpreter can be found in
  the <hlink|Standard Library|#standard-library> section.

  In this section we first give a brief overview of the most important
  elements of the Pure language. After starting out with a discussion of the
  lexical syntax, we proceed by explaining definitions and expressions, which
  are the major ingredients of Pure programs. After studying this section you
  should be able to write simple Pure programs. Subsequent sections then
  describe the concepts and notions introduced here in much greater detail
  and also cover the more advanced language elements which we only gloss over
  here.

  <subsubsection|Lexical Matters<label|lexical-matters>>

  Pure is a <with|font-series|bold|free-format> language, i.e., whitespace is
  insignificant (unless it is used to delimit other symbols). Thus, in
  contrast to ``layout-based'' languages like Haskell, you <em|must> use the
  proper delimiters (<verbatim|;>) and keywords
  (<hlink|<with|font-family|tt|end>|#end>) to terminate definitions and block
  structures. In particular, definitions and expressions at the toplevel have
  to be terminated with a semicolon, even if you're typing them interactively
  in the interpreter.

  Comments use the same syntax as in C++: <verbatim|//> for line-oriented,
  and <verbatim|/*> <verbatim|...> <verbatim|*/> for multiline comments. The
  latter must not be nested. Lines beginning with <verbatim|#!> are treated
  as comments, too; as already discussed above, on Unix-like systems this
  allows you to add a ``shebang'' to your main script in order to turn it
  into an executable program.

  A few ASCII symbols are reserved for special uses, namely the semicolon,
  the ``at'' symbol <verbatim|@>, the equals sign <verbatim|=>, the backslash
  <verbatim|<>>, the Unix pipe symbol <verbatim|\|>, parentheses
  <verbatim|()>, brackets <verbatim|[]> and curly braces <verbatim|{}>.
  (Among these, only the semicolon is a ``hard delimiter'' which is always a
  lexeme by itself; the other symbols can be used inside operator symbols.)
  Moreover, there are some keywords which cannot be used as identifiers:

  <\verbatim>
    case \ \ const \ \ \ \ \ def \ \ \ \ else \ \ \ \ \ \ end \ \ \ \ extern
    \ \ \ \ if

    infix \ infixl \ \ \ \ infixr \ interface \ let \ \ \ \ namespace
    \ nonfix

    of \ \ \ \ otherwise \ outfix \ postfix \ \ \ prefix \ private
    \ \ \ public

    then \ \ type \ \ \ \ \ \ using \ \ when \ \ \ \ \ \ with
  </verbatim>

  Pure fully supports the <with|font-series|bold|Unicode> character set or,
  more precisely, UTF-8. This is an ASCII extension capable of representing
  all Unicode characters, which provides you with thousands of characters
  from most of the languages of the world, as well as an abundance of special
  symbols for almost any purpose. If your text editor supports the UTF-8
  encoding (most editors do nowadays), you can use all Unicode characters in
  your Pure programs, not only inside strings, but also for denoting
  identifiers and special operator symbols.

  The customary notations for identifiers, numbers and strings are all
  provided. In addition, Pure also allows you to define your own operator
  symbols. Identifiers and other symbols are described by the following
  grammar rules in EBNF format:

  <\verbatim>
    symbol \ \ \ \ ::= \ identifier \| special

    identifier ::= \ letter (letter \| digit)*

    special \ \ \ ::= \ punct+

    letter \ \ \ \ ::= \ "A"\|...\|"Z"\|"a"\|...\|"z"\|"_"\|...

    digit \ \ \ \ \ ::= \ "0"\|...\|"9"

    punct \ \ \ \ \ ::= \ "!"\|"#"\|"$"\|"%"\|"&"\|...
  </verbatim>

  Pure uses the following rules to distinguish ``punctuation'' (which may
  only occur in declared operator symbols) and ``letters'' (identifier
  constituents). In addition to the punctuation symbols in the 7 bit ASCII
  range, the following code points in the Unicode repertoire are considered
  as punctuation: U+00A1 through U+00BF, U+00D7, U+00F7, and U+20D0 through
  U+2BFF. This comprises the special symbols in the Latin-1 repertoire, as
  well as the Combining Diacritical Marks for Symbols, Letterlike Symbols,
  Number Forms, Arrows, Mathematical Symbols, Miscellaneous Technical
  Symbols, Control Pictures, OCR, Enclosed Alphanumerics, Box Drawing,
  Blocks, Geometric Shapes, Miscellaneous Symbols, Dingbats, Miscellaneous
  Mathematical Symbols A, Supplemental Arrows A, Supplemental Arrows B,
  Miscellaneous Mathematical Symbols B, Supplemental Mathematical Operators,
  and Miscellaneous Symbols and Arrows. This should cover almost everything
  you'd ever want to use in an operator symbol. All other extended Unicode
  characters are effectively treated as ``letters'' which can be used as
  identifier constituents. (Charts of all Unicode symbols can be found at the
  <hlink|Code Charts|http://www.unicode.org/charts/> page of the
  <hlink|Unicode Consortium|http://www.unicode.org/>.)

  The following are examples of valid identifiers: <verbatim|foo>,
  <verbatim|foo_bar>, <verbatim|FooBar>, <verbatim|BAR>, <verbatim|bar99>.
  Case is significant in identifiers, so <verbatim|Bar> and <verbatim|bar>
  are distinct identifiers, but otherwise the case of letters carries no
  meaning. Special symbols consist entirely of punctuation, such as
  <verbatim|::=>. These may be used as operator symbols, but have to be
  declared before they can be used (see <hlink|Symbol
  Declarations|#symbol-declarations>).

  Pure also has a notation for qualified symbols which carry a namespace
  prefix. These take the following format (note that no whitespace is
  permitted between the namespace prefix and the symbol):

  <\verbatim>
    qualified_symbol \ \ \ \ ::= \ [qualifier] symbol

    qualified_identifier ::= \ [qualifier] identifier

    qualifier \ \ \ \ \ \ \ \ \ \ \ ::= \ [identifier] "::" (identifier
    "::")*
  </verbatim>

  Example: <verbatim|foo::bar>.

  Number literals come in three flavours: integers, bigints (denoted with an
  <verbatim|L> suffix) and floating point numbers (indicated by the presence
  of the decimal point and/or a base 10 scaling factor). Integers and bigints
  may be written in different bases (decimal, binary, octal and hexadecimal),
  while floating point numbers are always denoted in decimal.

  <\verbatim>
    number \ \ \ ::= \ integer \| integer "L" \| float

    integer \ \ ::= \ digit+

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| "0" ("X"\|"x") hex_digit+

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| "0" ("B"\|"b") bin_digit+

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| "0" oct_digit+

    oct_digit ::= \ "0"\|...\|"7"

    hex_digit ::= \ "0"\|...\|"9"\|"A"\|...\|"F"\|"a"\|...\|"f"

    bin_digit ::= \ "0"\|"1"

    float \ \ \ \ ::= \ digit+ ["." digit+] exponent

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| digit* "." digit+ [exponent]

    exponent \ ::= \ ("E"\|"e") ["+"\|"-"] digit+
  </verbatim>

  Examples: <verbatim|4711>, <verbatim|4711L>, <verbatim|1.2e-3>. Numbers in
  different bases: <verbatim|1000> (decimal), <verbatim|0x3e8> (hexadecimal),
  <verbatim|01750> (octal), <verbatim|0b1111101000> (binary).

  String literals are arbitrary sequences of characters enclosed in double
  quotes, such as <verbatim|"Hello,> <verbatim|world!">.

  <\verbatim>
    string ::= \ '"' char* '"'
  </verbatim>

  Special escape sequences may be used to denote double quotes and
  backslashes (<verbatim|<">>, <verbatim|<next-line>>), control characters
  (<verbatim|<b>>, <verbatim|<f>>, <verbatim|<n>>, <verbatim|<r>>,
  <verbatim|<t>>, these have the same meaning as in C), and arbitrary Unicode
  characters given by their number or <hlink|XML entity
  name|http://www.w3.org/TR/xml-entity-names/> (e.g., <verbatim|<169>>,
  <verbatim|<0xa9>> and <verbatim|<&copy;>> all denote the Unicode copyright
  character, code point U+00A9). As indicated, numeric escapes can be
  specified in any of the supported bases for integer literals. For
  disambiguating purposes, these can also be enclosed in parentheses. E.g.,
  <verbatim|"\\(123)4"> is a string consisting of the character
  <verbatim|<123>> followed by the digit <verbatim|4>. Strings can also be
  continued across line ends by escaping the line end with a backslash. The
  escaped line end is ignored (use <verbatim|<n>> if you need to embed a
  newline in a string). For instance,

  <\verbatim>
    "Hello, \\

    world.\\n"
  </verbatim>

  denotes the same string literal as

  <\verbatim>
    "Hello, world.\\n"
  </verbatim>

  <subsubsection|Definitions and Expression
  Evaluation<label|definitions-and-expression-evaluation>>

  The real meat of a Pure program is in its definitions. In Pure these
  generally take the form of equations which tell the interpreter how
  expressions are to be evaluated. For instance, the following two equations
  together define a function <verbatim|fact> which computes, for each given
  integer <verbatim|n>, the factorial of <verbatim|n>:

  <\verbatim>
    fact 0 = 1;

    fact n::int = n*fact (n-1) if n\<gtr\>0;
  </verbatim>

  The first equation covers the case that <verbatim|n> is zero, in which case
  the result is <verbatim|1>. The second equation handles the case of a
  positive integer. Note the <verbatim|n::int> construct on the left-hand
  side, which means that the equation is restricted to (machine) integers
  <verbatim|n>. This construct is also called a ``type tag'' in Pure
  parlance. In addition, the <verbatim|n\>0> in the condition part of the
  second equation ensures that <verbatim|n> is positive. If these conditions
  are met, the equation becomes applicable and we recursively compute
  <verbatim|fact> <verbatim|(n-1)> and multiply by <verbatim|n> to obtain the
  result. The <verbatim|fact> function thus computes the product of all
  positive integers up to <verbatim|n>, which is indeed just how the
  factorial is defined in mathematics.

  To give this definition a try, you can just enter it at the command prompt
  of the interpreter as follows:

  <\verbatim>
    \<gtr\> fact 0 = 1;

    \<gtr\> fact n::int = n*fact (n-1) if n\<gtr\>0;

    \<gtr\> fact 10;

    3628800
  </verbatim>

  On the surface, Pure is quite similar to other modern functional languages
  like <hlink|Haskell|#haskell> and <hlink|ML|#ml>. But under the hood it is
  a much more dynamic language, more akin to Lisp. In particular, Pure is
  dynamically typed, so functions can process arguments of as many different
  types as you like. In fact, you can add to the definition of an existing
  function at any time. For instance, we can extend our example above to make
  the <verbatim|fact> function work with floating point numbers, too:

  <\verbatim>
    \<gtr\> fact 0.0 = 1.0;

    \<gtr\> fact n::double = n*fact (n-1) if n\<gtr\>0;

    \<gtr\> fact 10.0;

    3628800.0
  </verbatim>

  Here we employed the constant <verbatim|0.0> and the <verbatim|double> type
  tag to define the factorial for the case of floating point numbers. Both
  <verbatim|int> and <verbatim|double> are built-in types of the Pure
  language. Our earlier definition for the <verbatim|int> case still works as
  well:

  <\verbatim>
    \<gtr\> fact 10;

    3628800
  </verbatim>

  In FP parlance, we say that a function like <verbatim|fact> is
  <with|font-series|bold|polymorphic>, because it applies to different
  argument types. More precisely, the kind of polymorphism at work here is
  <with|font-series|bold|ad-hoc polymorphism>, because we have two distinct
  definitions of the same function which behave differently for different
  argument types.

  Note that in this specific case, the two definitions are in fact very
  similar, to the point that the right-hand sides of the definitions are
  almost the same. Observing these similarities, we may also define
  <verbatim|fact> in a completely generic way:

  <\verbatim>
    \<gtr\> clear fact

    \<gtr\> fact n = 1 if n==0;

    \<gtr\> fact n = n*fact (n-1) if n\<gtr\>0;
  </verbatim>

  (Note that before we can enter the new definition, we first need to scratch
  our previous definition of <verbatim|fact>, that's what the
  <verbatim|clear> <verbatim|fact> command does. This is necessary because,
  as we already saw, the interpreter would otherwise just keep adding
  equations to the definition of <verbatim|fact> that we already have.)

  Our new definition doesn't have any type tags on the left-hand side and
  will thus work with any type of numbers:

  <\verbatim>
    \<gtr\> fact 10; // int

    3628800

    \<gtr\> fact 30.0; // floating point

    2.65252859812191e+32

    \<gtr\> fact 50L; // bigint

    30414093201713378043612608166064768844377641568960512000000000000L
  </verbatim>

  Let's now take a look at how the equations are actually applied in the
  evaluation process. Conceptually, Pure employs term rewriting as its
  underlying model of computation, so the equations are applied as rewriting
  rules, reading them from left to right. An equation is applicable if its
  left-hand side matches the target term to be evaluated, in which case we
  can bind the variables in the left-hand side to the corresponding subterms
  in the target term. Equations are tried in the order in which they are
  written; as soon as the left-hand side of an equation matches (and the
  condition part of the equation, if any, is satisfied), it can be applied to
  reduce the target term to the corresponding right-hand side.

  For instance, let's take a look at the target term <verbatim|fact>
  <verbatim|3>. This matches both equations of our generic definition of
  <verbatim|fact> from above, with <verbatim|n> bound to <verbatim|3>. But
  the condition <verbatim|3==0> of the first equation fails, so we come to
  consider the second equation, whose condition <verbatim|3\>0> holds. Thus
  we can perform the reduction <verbatim|fact> <verbatim|3> <verbatim|==\>>
  <verbatim|3*fact> <verbatim|(3-1)> and then evaluate the new target term
  <verbatim|3*fact> <verbatim|(3-1)> recursively.

  At this point, we have to decide which of the several subterms we should
  reduce first. This is also called the <with|font-series|bold|reduction
  strategy> and there are different ways to go about it. For instance, we
  might follow the customary ``call-by-value'' strategy where the arguments
  of a function application are evaluated recursively before the function
  gets applied to it, and this is also what Pure normally does. More
  precisely, expressions are evaluated using the ``leftmost-innermost''
  reduction strategy where the arguments are considered from left to right.

  So this means that on the right-hand side of the second equation, first
  <verbatim|n-1> (being the argument of <verbatim|fact>) is evaluated, then
  <verbatim|fact> <verbatim|(n-1)> (which is an argument to the <verbatim|*>
  operator), and finally <verbatim|fact> <verbatim|(n-1)> is multiplied by
  <verbatim|n> to give the value of <verbatim|fact> <verbatim|n>. Thus the
  evaluation of <verbatim|fact> <verbatim|3> actually proceeds as follows
  (abbreviating reductions for the built-in arithmetic operations):

  <\verbatim>
    fact 3 =\<gtr\> 3*fact 2 =\<gtr\> 3*2*fact 1 =\<gtr\> 3*2*1*fact 0
    =\<gtr\> 3*2*1*1 =\<gtr\> 6.
  </verbatim>

  We mention in passing here that Pure also has a few built-in ``special
  forms'' which take some or all of their arguments unevaluated, using ``call
  by name'' argument passing. This is needed to handle some constructs such
  as logical operations and conditionals in an efficient manner, and it also
  provides a way to implement ``lazy'' data structures. We'll learn about
  these later.

  One of the convenient aspects of the rewriting model of computation is that
  it enables you to define a function by pattern matching on structured
  argument types. For instance, we might compute the sum of the elements of a
  list as follows:

  <\verbatim>
    \<gtr\> sum [] = 0;

    \<gtr\> sum (x:xs) = x+sum xs;
  </verbatim>

  This discriminates over the different cases for the argument value which
  might either be the empty list <verbatim|[]> or a non-empty list of the
  from <verbatim|x:xs> where the variables <verbatim|x> and <verbatim|xs>
  refer to the head element and the rest of the list, respectively. (The
  `<verbatim|:>` infix operator is Pure's way of writing Lisp's ``cons'';
  this works the same as in other modern FPLs and is discussed in much more
  detail later.)

  Let's give it a try:

  <\verbatim>
    \<gtr\> sum (1..10);

    55
  </verbatim>

  Note that <verbatim|1..10> denotes the list of all positive integers up to
  10 here, so we get the sum of the numbers 1 thru 10 as the result, which is
  indeed 55. (The `<hlink|<with|font-family|tt|..>|purelib.tm#..>` operation
  is provided in Pure's prelude, i.e., it is part of the standard library.)

  Due to its term rewriting semantics, Pure actually goes beyond most other
  functional languages in that it can do symbolic evaluations just as well as
  ``normal'' computations:

  <\verbatim>
    \<gtr\> square x = x*x;

    \<gtr\> square 4;

    16

    \<gtr\> square (a+b);

    (a+b)*(a+b)
  </verbatim>

  In fact, leaving aside the built-in support for some common data structures
  such as numbers and strings, all the Pure interpreter really does is
  evaluate expressions in a symbolic fashion, rewriting expressions using the
  equations supplied by the programmer, until no more equations are
  applicable. The result of this process is called a
  <with|font-series|bold|normal form> which represents the ``value'' of the
  original expression. Moreover, there's no distinction between ``defined''
  and ``constructor'' function symbols in Pure, so <em|any> function symbol
  or operator can be used <em|anywhere> on the left-hand side of an equation,
  and may act as a constructor symbol if it happens to occur in a normal form
  term. This enables you to work with algebraic rules like associativity and
  distributivity in a direct fashion:

  <\verbatim>
    \<gtr\> (x+y)*z = x*z+y*z; x*(y+z) = x*y+x*z;

    \<gtr\> x*(y*z) = (x*y)*z; x+(y+z) = (x+y)+z;

    \<gtr\> square (a+b);

    a*a+a*b+b*a+b*b
  </verbatim>

  The above isn't possible in languages like Haskell and ML which always
  enforce that only ``pure'' constructor symbols (without any defining
  equations) may occur as a subterm on the left-hand side of a definition;
  this is also known as the <with|font-series|bold|constructor discipline>.
  Thus equational definitions like the above are forbidden in these
  languages. Pure doesn't enforce the constructor discipline, so it doesn't
  keep you from writing such symbolic rules if you need them.

  Another way of looking at this is that Pure allows you to have
  <with|font-series|bold|constructor equations>. For instance, the following
  equation makes lists automatically stay sorted:

  <\verbatim>
    \<gtr\> x:y:xs = y:x:xs if x\<gtr\>y;

    \<gtr\> [13,7,9,7,1]+[1,9,7,5];

    [1,1,5,7,7,7,9,9,13]
  </verbatim>

  This isn't possible in Haskell and ML either because it violates the
  constructor discipline; since `<verbatim|:>` is a constructor it can't
  simultaneously be a defined function in these languages. Pure gives you
  much more freedom there.

  This symbolic mode of evaluation is rather unusual outside of the realm of
  symbolic algebra systems, but it provides the programmer with a very
  flexible model of computation and is one of Pure's most distinguishing
  features. In some cases, however, the unevaluated normal forms may also
  become a nuisance since they may obscure possible programming errors.
  Therefore Pure provides special <hlink|<em|--nosymbolic>|#cmdoption-pure--nosymbolic>
  and <hlink|<em|--defined>|#cmdoption-pure-pragma--defined> pragmas (cf.
  <hlink|Code Generation Options|#code-generation-options>) which force
  functions to be treated as defined functions, so that they become more like
  functions in traditional untyped languages such as Lisp and Python which
  raise an exception under such conditions. This is described in more detail
  under <hlink|Defined Functions|#defined-functions> in the <hlink|Caveats
  and Notes|#caveats-and-notes> section.

  <paragraph|Variables in Equations<label|variables-in-equations>>

  Taking another look at the examples above, you might wonder how the Pure
  interpreter figures out what the parameters (a.k.a. ``variables'') in an
  equation are. This is quite obvious in rules involving just variables and
  special operator symbols, such as <verbatim|(x+y)*z> <verbatim|=>
  <verbatim|x*z+y*z>. However, what about an equation like <verbatim|foo>
  <verbatim|(foo> <verbatim|bar)> <verbatim|=> <verbatim|bar>? Since most of
  the time we don't declare any symbols in Pure, how does the interpreter
  know that <verbatim|foo> is a literal function symbol here, while
  <verbatim|bar> is a variable?

  The answer is that the interpreter considers the different positions in the
  left-hand side expression of an equation. Basically, a Pure expression is
  just a tree formed by applying expressions to other expressions, with the
  atomic subexpressions like numbers and symbols at the leaves of the tree.
  (This is true even for infix expressions like <verbatim|x+y>, since in Pure
  these are always equivalent to a function application of the form
  <verbatim|(+)> <verbatim|x> <verbatim|y> which has the atomic subterms
  <verbatim|(+)>, <verbatim|x> and <verbatim|y> at its leaves.)

  Now the interpreter divides the leaves of the expression tree into ``head''
  (or ``function'') and ``parameter'' (or ``variable'') positions based on
  which leaves are leftmost in a function application or not. Thus, in an
  expression like <verbatim|f> <verbatim|x> <verbatim|y> <verbatim|z>,
  <verbatim|f> is in the head or function position, while <verbatim|x>,
  <verbatim|y> and <verbatim|z> are in parameter or variable positions. (Note
  that in an infix expression like <verbatim|x+y>, <verbatim|(+)> is the head
  symbol, not <verbatim|x>, as the expression is really parsed as
  <verbatim|(+)> <verbatim|x> <verbatim|y>, see above.)

  Identifiers in head positions are taken as literal function symbols by the
  interpreter, while identifiers in variable positions denote, well,
  variables. We also refer to this convention as the
  <with|font-series|bold|head = function rule>. It is quite intuitive and
  lets us get away without declaring the variables in equations. (There are
  some corner cases not covered here, however. In particular, Pure allows you
  to declare special ``nonfix'' symbols, if you need a symbol to be
  recognized as a literal even if it occurs in a variable position. This is
  done by means of a <hlink|<with|font-family|tt|nonfix>|#nonfix>
  declaration, see <hlink|Symbol Declarations|#symbol-declarations> for
  details.)

  <subsubsection|Expression Syntax<label|expression-syntax>>

  Like in other functional languages, expressions are the central ingredient
  of all Pure programs. All computation performed by a Pure program consists
  in the evaluation of expressions, and expressions also form the building
  blocks of the equational rules which are used to define the constants,
  variables, functions and macros of a Pure program.

  Typical examples of the different expression types are summarized in the
  following table. Note that lambdas bind most weakly, followed by the
  special <hlink|<with|font-family|tt|case>|#case>,
  <hlink|<with|font-family|tt|when>|#when> and
  <hlink|<with|font-family|tt|with>|#with> constructs, followed by
  conditional expressions (<hlink|<with|font-family|tt|if>|#if>-<hlink|<with|font-family|tt|then>|#then>-<hlink|<with|font-family|tt|else>|#else>),
  followed by the simple expressions. Operators are a part of the simple
  expression syntax, and are parsed according to their declared precedences
  and associativities (cf. <hlink|Symbol Declarations|#symbol-declarations>).
  Function application binds stronger than all operators. Parentheses can be
  used to group expressions and override default precedences as usual.

  <tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|l>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|l>|<cwith|1|-1|3|3|cell-halign|l>|<cwith|1|-1|3|3|cell-rborder|0ln>|<cwith|1|-1|1|-1|cell-valign|c>|<cwith|1|1|1|-1|cell-bborder|1ln>|<table|<row|<cell|Type>|<cell|Example>|<cell|Description>>|<row|<cell|Block>|<cell|<verbatim|<x>>
  <verbatim|y-\>2*x-y>>|<cell|anonymous function
  (lambda)>>|<row|<cell|>|<cell|<verbatim|case> <verbatim|f> <verbatim|u>
  <verbatim|of> <verbatim|x,y> <verbatim|=> <verbatim|x+y>
  <verbatim|end>>|<cell|case expression>>|<row|<cell|>|<cell|<verbatim|x+y>
  <verbatim|when> <verbatim|x,y> <verbatim|=> <verbatim|f> <verbatim|u>
  <verbatim|end>>|<cell|local variable definition>>|<row|<cell|>|<cell|<verbatim|f>
  <verbatim|u> <verbatim|with> <verbatim|f> <verbatim|(x,y)> <verbatim|=>
  <verbatim|x+y> <verbatim|end>>|<cell|local function
  definition>>|<row|<cell|Conditional>|<cell|<verbatim|if> <verbatim|x\>0>
  <verbatim|then> <verbatim|x> <verbatim|else>
  <verbatim|-x>>|<cell|conditional expression>>|<row|<cell|Simple>|<cell|<verbatim|x+y>,
  <verbatim|-x>, <verbatim|x> <verbatim|mod> <verbatim|y>>|<cell|operator
  application>>|<row|<cell|>|<cell|<verbatim|sin> <verbatim|x>,
  <verbatim|max> <verbatim|a> <verbatim|b>>|<cell|function
  application>>|<row|<cell|Primary>|<cell|<verbatim|4711>, <verbatim|4711L>,
  <verbatim|1.2e-3>>|<cell|number>>|<row|<cell|>|<cell|<verbatim|"Hello,>
  <verbatim|world!\\n">>|<cell|string>>|<row|<cell|>|<cell|<verbatim|foo>,
  <verbatim|x>, <verbatim|(+)>>|<cell|function or variable
  symbol>>|<row|<cell|>|<cell|<verbatim|[1,2,3]>,
  <verbatim|(1,2,3)>>|<cell|list and tuple>>|<row|<cell|>|<cell|<verbatim|{1,2;3,4}>>|<cell|matrix>>|<row|<cell|>|<cell|<verbatim|[x,-y>
  <verbatim|\|> <verbatim|x=1..n;> <verbatim|y=1..m;>
  <verbatim|x\<y]>>|<cell|list comprehension>>|<row|<cell|>|<cell|<verbatim|{i==j>
  <verbatim|\|> <verbatim|i=1..n;> <verbatim|j=1..m}>>|<cell|matrix
  comprehension>>>>>

  The formal syntax of expressions is as follows. (Note that the
  <hlink|<with|font-family|tt|rule>|#grammar-token-rule> and
  <hlink|<with|font-family|tt|simple_rule>|#grammar-token-simple-rule>
  elements are part of the definition syntax, which is explained in the
  <hlink|Rule Syntax|#rule-syntax> section.)

  <\verbatim>
    expr \ \ \ \ \ \ \ \ ::= \ "\\" prim_expr+ "-\<gtr\>" expr

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| "case" expr "of" rules "end"

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| expr "when" simple_rules "end"

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| expr "with" rules "end"

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| "if" expr "then" expr "else" expr

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| simple_expr

    simple_expr \ ::= \ simple_expr op simple_expr

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| op simple_expr

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| simple_expr op

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| application

    application \ ::= \ application prim_expr

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| prim_expr

    prim_expr \ \ \ ::= \ qualified_symbol

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| number

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| string

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| "(" op ")"

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| "(" left_op right_op ")"

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| "(" simple_expr op ")"

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| "(" op simple_expr ")"

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| "(" expr ")"

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| left_op expr right_op

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| "[" exprs "]"

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| "{" exprs (";" exprs)* [";"] "}"

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| "[" expr "\|" simple_rules "]"

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| "{" expr "\|" simple_rules "}"

    exprs \ \ \ \ \ \ \ ::= \ expr ("," expr)*

    op \ \ \ \ \ \ \ \ \ \ ::= \ qualified_symbol

    left_op \ \ \ \ \ ::= \ qualified_symbol

    right_op \ \ \ \ ::= \ qualified_symbol

    rules \ \ \ \ \ \ \ ::= \ rule (";" rule)* [";"]

    simple_rules ::= \ simple_rule (";" simple_rule)* [";"]
  </verbatim>

  <paragraph|Primary Expressions<label|primary-expressions>>

  The Pure language provides built-in support for machine integers (32 bit),
  bigints (implemented using <hlink|GMP|#gmp>), floating point values (double
  precision IEEE 754) and character strings (UTF-8 encoded). These can all be
  denoted using the corresponding literals described in <hlink|Lexical
  Matters|#lexical-matters>. Truth values are encoded as machine integers; as
  you might expect, zero denotes <em|false> and any non-zero value <em|true>,
  and the prelude also provides symbolic constants
  <hlink|<with|font-family|tt|false>|purelib.tm#false> and
  <hlink|<with|font-family|tt|true>|purelib.tm#true> to denote these. Pure
  also supports generic C pointers, but these don't have a syntactic
  representation in Pure, except that the predefined constant
  <hlink|<with|font-family|tt|NULL>|purelib.tm#NULL> may be used to denote a
  generic null pointer; other pointer values need to be created with external
  C functions.

  Together, these atomic types of expressions make up most of Pure's
  <with|font-series|bold|primary expression> syntax. Pure also provides
  built-in support for some types of ``compound primaries'' (lists, tuples
  and matrices). We also list these here since they are typically denoted in
  some kind of bracketed form, even though some related non-primary
  expression types such as <verbatim|x:y> or <verbatim|x,y> really belong to
  the <hlink|simple expressions|#simple-expressions>.

  <\description>
    <item*|Numbers: 4711, 4711L, 1.2e-3>The usual C notations for integers
    (decimal: <verbatim|1000>, hexadecimal: <verbatim|0x3e8>, octal:
    <verbatim|01750>) and floating point values are all provided. Integers
    can also be denoted in base 2 by using the <verbatim|0b> or <verbatim|0B>
    prefix: <verbatim|0b1111101000>. Integer constants that are too large to
    fit into machine integers are promoted to bigints automatically.
    Moreover, integer literals immediately followed by the uppercase letter
    <verbatim|L> are always interpreted as bigint constants, even if they fit
    into machine integers. This notation is also used when printing bigint
    constants, to distinguish them from machine integers.
  </description>

  <\description>
    <item*|Strings: "Hello, world!\\n">String constants are double-quoted and
    terminated with a null character, like in C. In contrast to C, strings
    are always encoded in UTF-8, and character escapes in Pure strings have a
    more flexible syntax (borrowed from the author's Q language) which
    provides notations to specify any Unicode character. Please refer to
    <hlink|Lexical Matters|#lexical-matters> for details.
  </description>

  <\description>
    <item*|Function and variable symbols: foo, foo_bar, BAR, foo::bar>These
    consist of the usual sequence of letters (including the underscore) and
    digits, starting with a letter. Case is significant, thus <verbatim|foo>,
    <verbatim|Foo> and <verbatim|FOO> are distinct identifiers. The
    `<verbatim|_>` symbol, when occurring on the left-hand side of an
    equation, is special; it denotes the <with|font-series|bold|anonymous
    variable> which matches any value without actually binding a variable.
    Identifiers can also be prefixed with a namespace identifier, like in
    <verbatim|foo::bar>. (This requires that the given namespace has already
    been created, as explained under <hlink|Namespaces|#namespaces> in the
    <hlink|Declarations|#declarations> section.)
  </description>

  <\description>
    <item*|Operator symbols: +, ==, not>For convenience, Pure also provides
    you with a limited means to extend the syntax of the language with
    special operator symbols by means of a corresponding
    <with|font-series|bold|fixity> declaration, as discussed in section
    <hlink|Symbol Declarations|#symbol-declarations>. Besides the usual
    infix, prefix and postfix operators, Pure also provides outfix (bracket)
    and nonfix (nullary operator) symbols. (Nonfix symbols actually work more
    or less like ordinary identifiers, but the
    <hlink|<with|font-family|tt|nonfix>|#nonfix> attribute tells the compiler
    that when such a symbol occurs on the left-hand side of an equation, it
    is always to be interpreted as a literal, cf. <hlink|The ``Head =
    Function'' Rule|#the-head-function-rule>.)

    Operator (and nonfix) symbols may take the form of an identifier or a
    sequence of punctuation characters, which may optionally be qualified
    with a namespace prefix. These symbols must always be declared before
    use. Once declared, they are always special, and can't be used as
    ordinary identifiers any more. However, like in Haskell, by enclosing an
    operator in parentheses, such as <verbatim|(+)> or <verbatim|(not)>, you
    can turn it into an ordinary function symbol.
  </description>

  <\description>
    <item*|Lists: [x,y,z], x:xs>Pure's basic list syntax is the same as in
    Haskell, thus <verbatim|[]> is the empty list and <verbatim|x:xs> denotes
    a list with head element <verbatim|x> and tail list <verbatim|xs>. The
    infix constructor symbol `<hlink|<with|font-family|tt|:>|purelib.tm#:>`
    is declared in the prelude. It associates to the right, so that
    <verbatim|x:y:z> is the same as <verbatim|x:(y:z)>. The usual syntactic
    sugar for list values in brackets is also provided, thus
    <verbatim|[x,y,z]> is exactly the same as <verbatim|x:y:z:[]>. (This kind
    of list value is also called a ``proper'' list. Pure also permits
    ``improper'' list values such as <verbatim|1:2:3> with a non-list value
    in the tail. These aren't of much use as ordinary list values, but are
    frequently used in patterns or symbolic expressions such as
    <verbatim|x:y> where the tail usually is a variable.)

    Lists can be nested to an arbitrary depth. Also note that, in contrast to
    Haskell, lists are not required to be homogeneous, so in general they may
    contain an arbitary mix of element types. E.g., <verbatim|[1,2.0,[x,y]]>
    is a three-element list consisting of an integer, a floating point number
    and a nested list containing two symbols.

    Pure also provides a notation for arithmetic sequences such as
    <verbatim|1..5>, which denotes the list <verbatim|[1,2,3,4,5]>. Note the
    missing brackets; Pure doesn't use any special syntax for arithmetic
    sequences, the `<hlink|<with|font-family|tt|..>|purelib.tm#..>` symbol is
    just an ordinary infix operator declared and defined in the prelude.
    Sequences with arbitrary stepsizes can be written by denoting the first
    two sequence elements using the `<hlink|<with|font-family|tt|:>|purelib.tm#:>`
    operator, as in <verbatim|1.0:1.2..3.0>. To prevent unwanted artifacts
    due to rounding errors, the upper bound in a floating point sequence is
    always rounded to the nearest grid point. Thus, e.g.,
    <verbatim|0.0:0.1..0.29> actually yields <verbatim|[0.0,0.1,0.2,0.3]>, as
    does <verbatim|0.0:0.1..0.31>.
  </description>

  <\description>
    <item*|Tuples: (x,y,z)>Pure's tuples are a flat variant of lists which
    are often used as aggregate function arguments and results when no
    elaborate hierarchical structure is needed. They are constructed using
    the infix ``pairing'' operator `<hlink|<with|font-family|tt|,>|purelib.tm#,>`,
    for which the empty tuple <hlink|<with|font-family|tt|()>|purelib.tm#()>
    acts as a neutral element (i.e., <verbatim|(),x> is just <verbatim|x>, as
    is <verbatim|x,()>). Pairs always associate to the right, meaning that
    <verbatim|x,y,z> <verbatim|=> <verbatim|x,(y,z)> <verbatim|=>
    <verbatim|(x,y),z>, where <verbatim|x,(y,z)> is the normalized
    representation. These rules imply that tuples can't be nested and that
    there are no ``true'' 1-tuples distinct from their single members; if you
    need this then you should use lists instead (cf. <hlink|Splicing Tuples
    and Matrices|#splicing-tuples-and-matrices>).

    Note that the parentheses are not really part of the tuple syntax in
    Pure, they're just used to group expressions. So <verbatim|(x,y,z)>
    denotes just <verbatim|x,y,z>. But since the
    `<hlink|<with|font-family|tt|,>|purelib.tm#,>` operator has a low
    precedence, the parentheses are often needed to include tuples in other
    contexts. In particular, the parentheses are required to set off tuple
    elements in lists and matrices. E.g., <verbatim|[(1,2),3,(4,5)]> denotes
    a three element list consisting of two tuples and an integer.

    Mathematically, Pure's notion of tuples corresponds to a
    <with|font-series|bold|monoid> with an associative binary operation
    `<hlink|<with|font-family|tt|,>|purelib.tm#,>` and neutral element
    <hlink|<with|font-family|tt|()>|purelib.tm#()>. This is different from
    the usual definition of tuples in mathematical logic, which are nestable
    and correspond to Pure's notion of lists. So in Pure you can take your
    pick and use either flat tuples or nestable lists, whatever is most
    convenient for the problem at hand.
  </description>

  <\description>
    <item*|Matrices: {1.0,2.0,3.0}, {1,2;3,4}, {cos t,-sin t;sin t,cos
    t}>Pure also offers matrices, a kind of two-dimensional arrays, as a
    built-in data structure which provides efficient storage and element
    access. These work more or less like their Octave/MATLAB equivalents, but
    using curly braces instead of brackets. Component values may either be
    individual elements (``scalars'') or submatrices which are combined to
    form a larger matrix, provided that all dimensions match up. Here, a
    scalar is any expression which doesn't yield a matrix; these are
    considered to be 1x1 submatrices for the purpose of matrix construction.
    (Note that this ``splicing'' behaviour pertains to matrix construction
    only; nested matrix <hlink|patterns|#patterns> are always matched
    literally.)

    The comma arranges submatrices and scalars in columns, while the
    semicolon arranges them in rows. So, if both <verbatim|x> and
    <verbatim|y> are <verbatim|n> x <verbatim|m> matrices, then
    <verbatim|{x,y}> becomes an <verbatim|n> x <verbatim|2*m> matrix
    consisting of all the columns of <verbatim|x> followed by all the columns
    of <verbatim|y>. Likewise, <verbatim|{x;y}> becomes a <verbatim|2*n> x
    <verbatim|m> matrix (all the rows of <verbatim|x> above of all rows of
    <verbatim|y>). For instance, <verbatim|{{1;3},{2;4}}> is another way to
    write the 2x2 matrix <verbatim|{1,2;3,4}>. Row vectors are denoted as 1 x
    <verbatim|n> matrices (<verbatim|{1,2,3}>), column vectors as
    <verbatim|n> x 1 matrices (<verbatim|{1;2;3}>). More examples can be
    found in the <hlink|Matrices and Vectors|#matrices-and-vectors> section.

    Pure supports both numeric and symbolic matrices. The former are
    homogeneous arrays of double, complex double or (machine) int matrices,
    while the latter can contain any mixture of Pure expressions. Pure will
    pick the appropriate type for the data at hand. If a matrix contains
    values of different types, or Pure values which cannot be stored in a
    numeric matrix, then a symbolic matrix is created instead (this also
    includes the case of bigints, which are considered as symbolic values as
    far as matrix construction is concerned). Numeric matrices use an
    internal data layout that is fully compatible with the GNU Scientific
    Library (<hlink|GSL|#gsl>), and can readily be passed to GSL routines via
    the C interface. (The Pure interpreter does not require GSL, however, so
    numeric matrices will work even if GSL is not installed.)
  </description>

  <\description>
    <item*|Comprehensions: [x,y \| x=1..n; y=1..m; x\<less\>y], {f x \|
    x=1..n}>Pure provides both list and matrix comprehensions as a convenient
    means to construct list and matrix values from a ``template'' expression
    and one or more ``generator'' and ``filter'' clauses. The former bind a
    pattern to values drawn from a list or matrix, the latter are just
    predicates determining which generated elements should actually be added
    to the result. Comprehensions are in fact just syntactic sugar for a
    combination of lambdas, conditional expressions and certain list and
    matrix operations, but they are often much easier to write.

    Thus, for instance, <verbatim|[f> <verbatim|x> <verbatim|\|>
    <verbatim|x=1..n]> is pretty much the same as <verbatim|map> <verbatim|f>
    <verbatim|(1..n)>, while <verbatim|[x> <verbatim|\|> <verbatim|x=xs;>
    <verbatim|x\>0]> corresponds to <verbatim|filter> <verbatim|(\>0)>
    <verbatim|xs>. However, comprehensions are considerably more general in
    that they allow you to draw values from different kinds of aggregates
    including lists, matrices and strings. Also, matrix comprehensions
    alternate between row and column generation so that most common
    mathematical abbreviations carry over quite easily. Patterns can be used
    on the left-hand side of generator clauses as usual, and will be matched
    against the actual list or matrix elements; any unmatched elements are
    filtered out automatically, like in Haskell.

    More details and examples can be found in the <hlink|Examples|#examples>
    section; in particular, see <hlink|List
    Comprehensions|#list-comprehensions> and <hlink|Matrices and
    Vectors|#matrices-and-vectors>.
  </description>

  <paragraph|Simple Expressions<label|simple-expressions>>

  The rest of Pure's expression syntax mostly revolves around the notion of
  function applications. For convenience, Pure also allows you to declare
  pre-, post-, out- and infix operator symbols, but these are in fact just
  syntactic sugar for function applications; see <hlink|Symbol
  Declarations|#symbol-declarations> for details. Function and operator
  applications are used to combine primary expressions to compound terms,
  also referred to as <with|font-series|bold|simple expressions>; these are
  the data elements which are manipulated by Pure programs.

  As in other modern FPLs, function applications are written simply as
  juxtaposition (i.e., in ``curried'' form) and associate to the left. This
  means that in fact all functions only take a single argument.
  Multi-argument functions are represented as chains of single-argument
  functions. For instance, in <verbatim|f> <verbatim|x> <verbatim|y>
  <verbatim|=> <verbatim|(f> <verbatim|x)> <verbatim|y> first the function
  <verbatim|f> is applied to the first argument <verbatim|x>, yielding the
  function <verbatim|f> <verbatim|x> which in turn gets applied to the second
  argument <verbatim|y>. This makes it possible to derive new functions from
  existing ones using <with|font-series|bold|partial applications> which only
  specify some but not all arguments of a function. For instance, taking the
  <verbatim|max> function from the prelude as an example, <verbatim|max>
  <verbatim|0> is the function which, for a given <verbatim|x>, returns
  <verbatim|x> itself if it is nonnegative and zero otherwise. This works
  because <verbatim|(max> <verbatim|0)> <verbatim|x> <verbatim|=>
  <verbatim|max> <verbatim|0> <verbatim|x> is the maximum of <verbatim|0> and
  <verbatim|x>.

  One major advantage of having curried function applications is that,
  without any further ado, functions become first-class objects. That is,
  they can be passed around freely both as parameters and as function return
  values. Much of the power of functional programming languages stems from
  this feature.

  Operator applications are written using prefix, postfix, outfix or infix
  notation, as the declaration of the operator demands, but are just ordinary
  function applications in disguise. As already mentioned, enclosing an
  operator in parentheses turns it into an ordinary function symbol, thus
  <verbatim|x+y> is exactly the same as <verbatim|(+)> <verbatim|x>
  <verbatim|y>. For convenience, partial applications of infix operators can
  also be written using so-called <with|font-series|bold|operator sections>.
  A <em|left section> takes the form <verbatim|(x+)> which is equivalent to
  the partial application <verbatim|(+)> <verbatim|x>. A <em|right section>
  takes the form <verbatim|(+x)> and is equivalent to the term
  <verbatim|flip> <verbatim|(+)> <verbatim|x>. (This uses the
  <hlink|<with|font-family|tt|flip>|purelib.tm#flip> combinator from the
  prelude which is defined as <verbatim|flip> <verbatim|f> <verbatim|x>
  <verbatim|y> <verbatim|=> <verbatim|f> <verbatim|y> <verbatim|x>.) Thus
  <verbatim|(x+)> <verbatim|y> is equivalent to <verbatim|x+y>, while
  <verbatim|(+x)> <verbatim|y> reduces to <verbatim|y+x>. For instance,
  <verbatim|(1/)> denotes the reciprocal and <verbatim|(+1)> the successor
  function. (Note that, in contrast, <verbatim|(-x)> always denotes an
  application of unary minus; the section <verbatim|(+-x)> can be used to
  indicate a function which subtracts <verbatim|x> from its argument.)

  The common operator symbols like <verbatim|+>, <verbatim|->, <verbatim|*>,
  <verbatim|/> etc. are all declared at the beginning of the prelude, see the
  <hlink|<em|Pure Library Manual>|purelib.tm> for a list of these. Arithmetic
  and relational operators mostly follow C conventions. However, since
  <verbatim|!>, <verbatim|<line-sep>> and <verbatim|\|> are used for other
  purposes in Pure, the logical and bitwise operations, as well as the
  negated equality predicates are named a bit differently: <verbatim|~>,
  <verbatim|&&> and <verbatim|\|\|> denote logical negation, conjunction and
  disjunction, while the corresponding bitwise operations are named
  <verbatim|not>, <verbatim|and> and <verbatim|or>. Moreover, following these
  conventions, inequality is denoted <verbatim|~=>. Also note that
  <verbatim|&&> and <verbatim|\|\|> are special forms which are evaluated in
  short-circuit mode (see <hlink|Special Forms|#special-forms> below),
  whereas the bitwise connectives receive their arguments using
  call-by-value, just like the other arithmetic operations.

  <paragraph|Special Expressions<label|special-expressions>>

  Some special notations are provided for conditional expressions as well as
  anonymous functions (lambdas) and local function and variable definitions.
  The latter are also called <with|font-series|bold|block expressions> since
  they introduce local bindings of variable and function symbols which may
  override other global or local bindings of these symbols. This gives rise
  to a kind of <with|font-series|bold|block structure> similar to Algol-like
  programming languages. Please check <hlink|Scoping Rules|#scoping-rules>
  below for more information about this.

  The constructs described here are called ``special'' because, in contrast
  to the other forms of expressions, they cannot occur in normal form terms
  as first-class values (at least not literally; there is an alternative
  quoted representation of special expressions, however, which <em|can> be
  manipulated with macros and functions for meta programming purposes, cf.
  <hlink|Built-in Macros and Special Expressions|#built-in-macros-and-special-expressions>).

  <\description>
    <item*|Conditional expressions: if x then y else z>Evaluates to
    <verbatim|y> or <verbatim|z> depending on whether <verbatim|x> is
    ``true'' (i.e., a nonzero integer). A
    <hlink|<with|font-family|tt|failed_cond>|purelib.tm#failed-cond>
    exception is raised if the condition is not an integer.
  </description>

  <\description>
    <item*|Lambdas: \\x -\<gtr\> y>These denote anonymous functions and work
    pretty much like in Haskell. A lambda matches its argument against the
    left-hand side pattern <verbatim|x> and then evaluates the right-hand
    side body <verbatim|y> with the variables in <verbatim|x> bound to their
    corresponding values. Pure supports multiple-argument lambdas (e.g,
    <verbatim|<x>> <verbatim|y> <verbatim|-\>> <verbatim|x*y>), as well as
    pattern-matching lambda abstractions such as <verbatim|<(x,y)>>
    <verbatim|-\>> <verbatim|x*y>. A <hlink|<with|font-family|tt|failed_match>|purelib.tm#failed-match>
    exception is raised if the actual arguments do not match the given
    patterns.
  </description>

  <\description>
    <item*|Case expressions: case x of u = v; ... end>Matches an expression,
    discriminating over a number of different cases, similar to the Haskell
    <verbatim|case> construct. The expression <verbatim|x> is matched in turn
    against each left-hand side pattern <verbatim|u> in the rule list, and
    the first pattern which matches <verbatim|x> gives the value of the
    entire expression, by evaluating the corresponding right-hand side
    <verbatim|v> with the variables in the pattern bound to their
    corresponding values. A <hlink|<with|font-family|tt|failed_match>|purelib.tm#failed-match>
    exception is raised if the target expression doesn't match any of the
    patterns.
  </description>

  <\description>
    <item*|When expressions: x when u = v; ... end>An alternative way to bind
    local variables by matching a collection of subject terms against
    corresponding patterns, similar to <hlink|Aardappel|#aardappel>`s
    <verbatim|when> construct. A single binding <verbatim|x> <verbatim|when>
    <verbatim|u> <verbatim|=> <verbatim|v> <verbatim|end> is equivalent to
    the lambda expression <verbatim|(\\u> <verbatim|-\>> <verbatim|x)>
    <verbatim|v> or the <verbatim|case> expression <verbatim|case>
    <verbatim|v> <verbatim|of> <verbatim|u> <verbatim|=> <verbatim|x>
    <verbatim|end>, so it matches <verbatim|v> against the pattern
    <verbatim|u> and evaluates <verbatim|x> with the variables in
    <verbatim|u> bound to their corresponding values (or raises a
    <hlink|<with|font-family|tt|failed_match>|purelib.tm#failed-match>
    exception if <verbatim|v> doesn't match <verbatim|u>). However, a
    <verbatim|when> clause may contain multiple definitions, which are
    processed from left to right, so that later definitions may refer to the
    variables in earlier ones. (This is exactly the same as several nested
    single definitions, with the first binding being the ``outermost'' one.)
  </description>

  <\description>
    <item*|With expressions: x with u = v; ... end>Defines local functions.
    Like Haskell's <verbatim|where> construct, but it can be used anywhere
    inside an expression (just like Aardappel's <verbatim|where>, but Pure
    uses the keyword <verbatim|with> which better lines up with
    <verbatim|case> and <verbatim|when>). Several functions can be defined in
    a single <verbatim|with> clause, and the definitions can be mutually
    recursive and consist of as many equations as you want. Local functions
    are applied in the same way as global ones, i.e., the argument patterns
    of each rule are matched against the actual function arguments and the
    first rule which matches has its right-hand side evaluated with the
    variables in the argument patterns bound to their corresponding values.
    If none of the rules match then the function application remains
    unevaluated (it becomes a normal form), so no exception is raised in this
    case. (This is in contrast to a lambda which otherwise is pretty much
    like a nameless local function defined by a single rule.)
  </description>

  The block constructs are similar to those available in most modern
  functional languages. In Pure these constructs are all implemented in terms
  of the basic term rewriting machinery, using <hlink|lambda
  lifting|http://en.wikipedia.org/wiki/Lambda-lifting> to eliminate local
  functions, and the following equivalences which reduce lambdas as well as
  <hlink|<with|font-family|tt|case>|#case> and
  <hlink|<with|font-family|tt|when>|#when> expressions to special kinds of
  local functions or local function applications:

  <\verbatim>
    \\x1 ... xn -\<gtr\> y

    == f with f x1 ... xn = y; f _ ... _ = throw failed_match end

    \;

    case x of y1 = z1; ...; yn = zn end

    == f x with f y1 = z1; ...; f yn = zn; f _ = throw failed_match end

    \;

    x when y = z end

    == f z with f y = x; f _ = throw failed_match end

    \;

    x when y1 = z1; ...; yn = zn end

    == x when yn = zn end ... when y1 = z1 end
  </verbatim>

  Note that by convention these constructs report a
  <hlink|<with|font-family|tt|failed_match>|purelib.tm#failed-match>
  exception in case of argument mismatch. So they're treated like
  <hlink|defined functions|#defined-functions>, which is somewhat at odds
  with the term rewriting semantics. This is done for convenience, however,
  so that the programmer doesn't have to deal with unevaluated applications
  of nameless block constructs in normal form terms. The case of named local
  functions is considered different because it effectively represents a local
  rewriting system which should be treated accordingly, in order to allow for
  symbolic evaluation.

  <subsubsection|Special Forms<label|special-forms>>

  As already mentioned, some operations are actually implemented as special
  forms which process some or all of their arguments using call-by-name.

  <\description>
    <item*|if x then y else z>The conditional expression is a special form
    with call-by-name arguments <verbatim|y> and <verbatim|z>; only one of
    the branches is actually evaluated, depending on the value of
    <verbatim|x>.
  </description>

  <\description>
    <item*|x && y<label|-amp-amp/special>>

    <item*|x \|\| y<label|\|\|/special>>The logical connectives evaluate
    their operands in <with|font-series|bold|short-circuit mode>. Thus the
    second operand is passed by name and will only be evaluated if the first
    operand fails to determine the value of the expression. For instance,
    <verbatim|x&&y> immediately becomes false if <verbatim|x> evaluates to
    false; otherwise <verbatim|y> is evaluated to give the value of the
    expression. The built-in definitions of these operations work as if they
    were defined by the following equations (but note that the second operand
    is indeed passed by name):

    <\verbatim>
      x::int && y = if x then y else x;

      x::int \|\| y = if x then x else y;
    </verbatim>

    Note that this isn't quite the same as in C, as the results of these
    operations are <em|not> normalized, i.e., they may return nonzero values
    other than 1 to denote ``true''. (This has the advantage that these
    operations can be implemented tail-recursively, see <hlink|Stack Size and
    Tail Recursion|#stack-size-and-tail-recursion>.) Thus, if you need a
    normalized truth value then you'll have to make sure that either both
    operands are already normalized, or you'll have to normalize the result
    yourself. (A quick way to turn a machine int <verbatim|x> into a
    normalized truth value is to compute <verbatim|~~x> or <verbatim|x~=0>.)

    Moreover, if the built-in definition fails because the first operand is
    not a machine int, then the second operand will be evaluated anyway and
    the resulting application becomes a normal form, which gives you the
    opportunity to extend these operations with your own definitions just
    like the other built-in operations. Note, however, that in this case the
    operands are effectively passed by value.
  </description>

  <\description>
    <item*|x $$ y<label|-dollar-dollar>>The sequencing operator
    <hlink|<with|font-family|tt|$$>|#-dollar-dollar> evaluates its left
    operand, immediately throws the result away and then goes on to evaluate
    the right operand which gives the result of the entire expression. This
    operator is useful to write imperative-style code such as the following
    prompt-input interaction:

    <\verbatim>
      \<gtr\> using system;

      \<gtr\> puts "Enter a number:" $$ scanf "%g";

      Enter a number:

      21

      21.0
    </verbatim>

    We mention in passing here that the same effect can be achieved with a
    <hlink|<with|font-family|tt|when>|#when> clause, which also allows you to
    execute a function solely for its side-effects and just ignore the return
    value:

    <\verbatim>
      \<gtr\> scanf "%g" when puts "Enter a number:" end;

      Enter a number:

      21

      21.0
    </verbatim>
  </description>

  <\description>
    <item*|x &<label|-amp>>The <hlink|<with|font-family|tt|&>|#-amp> operator
    does lazy evaluation. This is the only postfix operator defined in the
    standard prelude. It turns its operand into a kind of parameterless
    anonymous closure, deferring its evaluation. These kinds of objects are
    also commonly known as <with|font-series|bold|thunks> or
    <with|font-series|bold|futures>. When the value of a future is actually
    needed (during pattern-matching, or when the value becomes an argument of
    a C call), it is evaluated automatically and gets memoized, i.e., the
    computed result replaces the thunk so that it only has to be computed
    once.

    Futures are useful to implement all kinds of lazy data structures in
    Pure, in particular: lazy lists a.k.a. streams. A
    <with|font-series|bold|stream> is simply a list with a thunked tail,
    which allows it to be infinite. The Pure prelude defines many functions
    for creating and manipulating these kinds of objects; for further details
    and examples please <hlink|Lazy Evaluation and
    Streams|#lazy-evaluation-and-streams> in the <hlink|Examples|#examples>
    section.
  </description>

  <\description>
    <item*|quote x<label|quote>>

    <item*|' x<label|'>>This special form quotes an expression, i.e.,
    <verbatim|quote> <verbatim|x> (or, equivalently, <verbatim|'x>) returns
    just <verbatim|x> itself without evaluating it. The prelude also provides
    a function <hlink|<with|font-family|tt|eval>|purelib.tm#eval> which can
    be used to evaluate a quoted expression at a later time. For instance:

    <\verbatim>
      \<gtr\> let x = '(2*42+2^12); x;

      2*42+2^12

      \<gtr\> eval x;

      4180.0
    </verbatim>

    This enables some powerful metaprogramming techniques, which should be
    well familiar to Lisp programmers. However, there are some notable
    differences to Lisp's quote, please see <hlink|The Quote|#the-quote> in
    the <hlink|Examples|#examples> section for details and more examples.
  </description>

  <subsubsection|Toplevel<label|toplevel>>

  At the toplevel, a Pure program basically consists of rewriting rules
  (which are used to define functions, macros and types), constant and
  variable definitions, and expressions to be evaluated:

  <\verbatim>
    script ::= \ item*

    item \ \ ::= \ "let" simple_rule ";"

    \ \ \ \ \ \ \ \ \ \ \ \ \| "const" simple_rule ";"

    \ \ \ \ \ \ \ \ \ \ \ \ \| "def" macro_rule ";"

    \ \ \ \ \ \ \ \ \ \ \ \ \| "type" type_rule ";"

    \ \ \ \ \ \ \ \ \ \ \ \ \| rule ";"

    \ \ \ \ \ \ \ \ \ \ \ \ \| expr ";"
  </verbatim>

  These elements are discussed in more detail in the <hlink|Rule
  Syntax|#rule-syntax> section. Also, a few additional toplevel elements are
  part of the declaration syntax, see <hlink|Declarations|#declarations>.

  <\description>
    <item*|lhs = rhs;>Rewriting rules always combine a left-hand side pattern
    (which must be a simple expression) and a right-hand side (which can be
    any kind of Pure expression described above). The same format is also
    used in <hlink|<with|font-family|tt|with>|#with>,
    <hlink|<with|font-family|tt|when>|#when> and
    <hlink|<with|font-family|tt|case>|#case> expressions. In toplevel rules,
    <hlink|<with|font-family|tt|with>|#with> and
    <hlink|<with|font-family|tt|case>|#case> expressions, this basic form can
    also be augmented with a condition <verbatim|if> <verbatim|guard> tacked
    on to the end of the rule, where <verbatim|guard> is an integer
    expression which determines whether the rule is applicable. Moreover, the
    keyword <hlink|<with|font-family|tt|otherwise>|#otherwise> may be used to
    denote an empty guard which is always true (this is syntactic sugar to
    point out the ``default'' case of a definition; the interpreter just
    treats this as a comment). Pure also provides some abbreviations for
    factoring out common left-hand or right-hand sides in collections of
    rules; see the <hlink|Rule Syntax|#rule-syntax> section for details.
  </description>

  <\description>
    <item*|type lhs = rhs;>A rule starting with the keyword
    <hlink|<with|font-family|tt|type>|#type> defines a type predicate. This
    works pretty much like an ordinary rewriting rule, except that only a
    single right-hand side is permitted (which may also be omitted in some
    cases) and the left-hand side may involve at most one argument
    expression; see the <hlink|Type Rules|#type-rules> section for details.
    There's also an alternative syntax which lets you define types in a more
    abstract way and have the compiler generate the type rules for you; this
    is described in the <hlink|Interface Types|#interface-types> section.
  </description>

  <\description>
    <item*|def lhs = rhs;>A rule starting with the keyword
    <hlink|<with|font-family|tt|def>|#def> defines a macro function. No
    guards or multiple right-hand sides are permitted here. Macro rules are
    used to preprocess expressions on the right-hand side of other
    definitions at compile time, and are typically employed to implement
    user-defined special forms and simple kinds of optimization rules. See
    the <hlink|Macros|#macros> section below for details and examples.
  </description>

  <\description>
    <item*|let lhs = rhs;>Binds every variable in the left-hand side pattern
    to the corresponding subterm of the right-hand side (after evaluating
    it). This works like a <hlink|<with|font-family|tt|when>|#when> clause,
    but serves to bind global variables occurring free on the right-hand side
    of other function and variable definitions.
  </description>

  <\description>
    <item*|const lhs = rhs;>An alternative form of
    <hlink|<with|font-family|tt|let>|#let> which defines constants rather
    than variables. (These are not to be confused with nonfix symbols which
    simply stand for themselves!) Like <hlink|<with|font-family|tt|let>|#let>,
    this construct binds the variable symbols on the left-hand side to the
    corresponding values on the right-hand side (after evaluation). The
    difference is that <hlink|<with|font-family|tt|const>|#const> symbols can
    only be defined once, and thus their values do not change during program
    execution. This also allows the compiler to apply some special
    optimizations such as constant folding.
  </description>

  <\description>
    <item*|expr;>A singleton expression at the toplevel, terminated with a
    semicolon, simply causes the given value to be evaluated (and the result
    to be printed, when running in interactive mode).
  </description>

  <subsubsection|Scoping Rules<label|scoping-rules>>

  A few remarks about the scope of identifiers and other symbols are in order
  here. <hlink|Special expressions|#special-expressions> introduce
  <with|font-series|bold|local scopes> of functions and variables.
  Specifically, lambda expressions, as well as the left-hand sides of rules
  in <verbatim|case>, <verbatim|when> and <verbatim|with> expressions, bind
  the variables in the patterns to their corresponding values. In addition, a
  <verbatim|with> expression also binds function names to the corresponding
  functions defined by the rules given in the expression. In either case,
  these bindings are limited to the scope of the corresponding construct.
  Inside that scope they override other (global or local) definitions of the
  same symbols which may be present in the surrounding program code. This
  gives rise to a hierarchical <with|font-series|bold|block structure> where
  each occurrence of a symbol refers to the innermost definition of that
  symbol visible at that point of the program.

  The precise scoping rules for the different constructs are as follows:

  <\itemize>
    <item><verbatim|<x>> <verbatim|-\>> <verbatim|y>: The scope of the
    variables bound by the pattern <verbatim|x> is the lambda body
    <verbatim|y>.

    <item><verbatim|case> <verbatim|x> <verbatim|of> <verbatim|u>
    <verbatim|=> <verbatim|v;> <verbatim|...> <verbatim|end>: The scope of
    the variables bound by the pattern <verbatim|u> in each rule is the
    corresponding right-hand side <verbatim|v>.

    <item><verbatim|x> <verbatim|when> <verbatim|u> <verbatim|=>
    <verbatim|v;> <verbatim|...> <verbatim|end>: The scope of the variables
    bound by the pattern <verbatim|u> in each rule extends over the
    right-hand sides of all subsequent rules and the target expression
    <verbatim|x>.

    <item><verbatim|x> <verbatim|with> <verbatim|u> <verbatim|=>
    <verbatim|v;> <verbatim|...> <verbatim|end>: The scope of the variables
    bound by the pattern <verbatim|u> in each rule is the corresponding
    right-hand side <verbatim|v>. In addition, the scope of the <em|function>
    names defined by the <verbatim|with> clause (i.e., the head symbols of
    the rules) extends over the right-hand sides of all rules and the target
    expression <verbatim|x>. Note that this allows local function definitions
    to be mutually recursive, since the right-hand side of each rule in the
    <verbatim|with> clause may refer to any other function defined by the
    <verbatim|with> clause.
  </itemize>

  Like most modern functional languages, Pure uses
  <with|font-series|bold|lexical> or <with|font-series|bold|static> binding
  for local functions and variables. What this means is that the binding of a
  local name is completely determined at compile time by the surrounding
  program text, and does not change as the program is being executed. In
  particular, if a function returns another (anonymous or local) function,
  the returned function captures the environment it was created in, i.e., it
  becomes a (lexical) <with|font-series|bold|closure>. For instance, the
  following function, when invoked with a single argument <verbatim|x>,
  returns another function which adds <verbatim|x> to its argument:

  <\verbatim>
    \<gtr\> foo x = bar with bar y = x+y end;

    \<gtr\> let f = foo 99; f;

    bar

    \<gtr\> f 10, f 20;

    109,119
  </verbatim>

  This works the same no matter what other bindings of <verbatim|x> may be in
  effect when the closure is invoked:

  <\verbatim>
    \<gtr\> let x = 77; f 10, (f 20 when x = 88 end);

    109,119
  </verbatim>

  In contrast to local bindings, Pure's toplevel environment binds global
  symbols <with|font-series|bold|dynamically>, so that the bindings can be
  changed easily at any time during an interactive session. This is mainly a
  convenience for interactive usage, but works the same no matter whether the
  source code is entered interactively or being read from a script, in order
  to ensure consistent behaviour between interactive and batch mode
  operation.

  In particular, you can easily bind a global variable to a new value by just
  entering a corresponding <hlink|<with|font-family|tt|let>|#let> command.
  For instance, contrast the following with the local <verbatim|bar> function
  from above which had the <verbatim|x> value bound in the surrounding
  context:

  <\verbatim>
    \<gtr\> clear x

    \<gtr\> bar y = x+y;

    \<gtr\> bar 10, bar 20;

    x+10,x+20

    \<gtr\> let x = 99;

    \<gtr\> bar 10, bar 20;

    109,119

    \<gtr\> let x = 77;

    \<gtr\> bar 10, bar 20;

    87,97
  </verbatim>

  Observe how changing the value of the global <verbatim|x> variable
  immediately affects the value computed by the global <verbatim|bar>
  function. This works pretty much like global variables in imperative
  languages, but note that in Pure the value of a global variable can only be
  changed with a <hlink|<with|font-family|tt|let>|#let> command at the
  toplevel. Thus referential transparency is unimpaired; while the value of a
  global variable may change between different toplevel expressions, it will
  always take the same value in a single evaluation.

  Similarly, you can also add new equations to an existing function at any
  time. The Pure interpreter will then automatically recompile the function
  as needed. For instance:

  <\verbatim>
    \<gtr\> fact 0 = 1;

    \<gtr\> fact n::int = n*fact (n-1) if n\<gtr\>0;

    \<gtr\> fact 10;

    3628800

    \<gtr\> fact 10.0;

    fact 10.0

    \<gtr\> fact 1.0 = 1.0;

    \<gtr\> fact n::double = n*fact (n-1) if n\<gtr\>1;

    \<gtr\> fact 10.0;

    3628800.0

    \<gtr\> fact 10;

    3628800
  </verbatim>

  In interactive mode, it is even possible to completely erase a function
  definition and redo it from scratch, see section <hlink|Interactive
  Usage|#interactive-usage> for details.

  So, while the meaning of a local symbol never changes once its definition
  has been processed, toplevel definitions may well evolve while the program
  is being processed, and the interpreter will always use the latest
  definitions at a given point in the source when an expression is evaluated.

  <with|font-series|bold|Note:> As already mentioned, this behaviour makes
  Pure much more convenient to use in an interactive setting. We should point
  out, however, that dynamic environments are often frowned upon by
  functional programming purists (for good reasons), and Pure's dynamic
  toplevel certainly has its pitfalls just like any other. Specifically, even
  in a script file you'll have to take care that all symbols needed in an
  evaluation are completely defined before entering the expression to be
  evaluated. Nevertheless, it is expected that most Pure programmers will use
  Pure interactively most of the time, and so tailoring the design to
  interactive usage seems justifiable in this case.

  <subsection|Rule Syntax<label|rule-syntax>>

  Basically, the same rule syntax is used in all kinds of global and local
  definitions. However, some constructs (specifically,
  <hlink|<with|font-family|tt|when>|#when>,
  <hlink|<with|font-family|tt|let>|#let>,
  <hlink|<with|font-family|tt|const>|#const>,
  <hlink|<with|font-family|tt|type>|#type> and
  <hlink|<with|font-family|tt|def>|#def>) use a variation of the basic rule
  syntax which does away with guards and/or multiple left-hand or right-hand
  sides. The syntax of these elements is captured by the following grammar
  rules:

  <\verbatim>
    rule \ \ \ \ \ \ \ ::= \ pattern ("\|" pattern)* "=" expr [guard]

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (";" "=" expr [guard])*

    type_rule \ \ ::= \ pattern ("\|" pattern)* [ "=" expr [guard] ]

    macro_rule \ ::= \ pattern ("\|" pattern)* "=" expr

    simple_rule ::= \ pattern "=" expr \| expr

    pattern \ \ \ \ ::= \ simple_expr

    guard \ \ \ \ \ \ ::= \ "if" simple_expr

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| "otherwise"

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| guard "when" simple_rules "end"

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| guard "with" rules "end"
  </verbatim>

  When matching against a function or macro call, or the subject term in a
  <hlink|<with|font-family|tt|case>|#case> expression, the rules are always
  considered in the order in which they are written, and the first matching
  rule (whose guard evaluates to a nonzero value, if applicable) is picked.
  (Again, the <hlink|<with|font-family|tt|when>|#when> construct is treated
  differently, because each rule is actually a separate definition.)

  <subsubsection|Patterns<label|patterns>>

  The left-hand side of a rule is a special kind of simple expression, called
  a <with|font-series|bold|pattern>. The variables in a pattern serve as
  placeholders which are bound to corresponding values when the rule is
  applied to a target expression. To these ends, the pattern is
  <with|font-series|bold|matched> against the target expression, i.e., the
  literal parts of the pattern are compared against the target expression
  and, if everything matches up, the variables in the pattern are
  <with|font-series|bold|bound> to (set to the value of) the corresponding
  subterms of the target expression.

  Patterns are pervasive in Pure; they are used on the left-hand side of
  function and macro definitions, just as well as in global and local
  variable definitions. For instance, the following variable definition
  matches the result of evaluating the right-hand side list expression
  against the pattern <verbatim|x:y:xs> and binds the variables <verbatim|x>
  and <verbatim|y> to the first two elements of the resulting list and
  <verbatim|xs> to the list of remaining elements, respectively. We can then
  place <verbatim|x> and <verbatim|y> at the end of the list, thereby
  performing a kind of ``rotation'' of the first two list members:

  <\verbatim>
    \<gtr\> let x:y:xs = 1..10;

    \<gtr\> xs+[x,y];

    [3,4,5,6,7,8,9,10,1,2]
  </verbatim>

  The same works with a local variable definition:

  <\verbatim>
    \<gtr\> xs+[x,y] when x:y:xs = 1..10 end;

    [3,4,5,6,7,8,9,10,1,2]
  </verbatim>

  Or with a <hlink|<with|font-family|tt|case>|#case> expression:

  <\verbatim>
    \<gtr\> case 1..10 of x:y:xs = xs+[x,y] end;

    [3,4,5,6,7,8,9,10,1,2]
  </verbatim>

  The arguments of functions (and macros) are handled in the same fashion,
  too:

  <\verbatim>
    \<gtr\> rot2 (x:y:xs) = xs+[x,y];

    \<gtr\> rot2 (1..10);

    [3,4,5,6,7,8,9,10,1,2]
  </verbatim>

  However, there is a big difference here. For global and local variable
  definitions, it is an error if the pattern does not match the target
  expression:

  <\verbatim>
    \<gtr\> let x:y:xs = [1];

    \<less\>stdin\<gtr\>, line 7: failed match while evaluating 'let x:y:xs =
    [1]'
  </verbatim>

  The same holds if the target expression doesn't match any of the left-hand
  side patterns in a <hlink|<with|font-family|tt|case>|#case> expression:

  <\verbatim>
    \<gtr\> case [1] of x:y:xs = xs+[x,y] end;

    \<less\>stdin\<gtr\>, line 8: unhandled exception 'failed_match' while
    evaluating

    'case [1] of x:y:xs = xs+[x,y] end'
  </verbatim>

  (The error message is slightly different in this case, but the reported
  kind of exception is actually the same as with the
  <hlink|<with|font-family|tt|let>|#let> expression above.)

  This doesn't normally happen with functions and macros. Instead, a match
  failure just means that the corresponding rule will be bypassed and other
  rules will be tried instead. If there are no more rules, the target
  expression becomes a normal form which is simply returned as is:

  <\verbatim>
    \<gtr\> rot2 [1];

    rot2 [1]
  </verbatim>

  This may come as a surprise (other functional languages will give you an
  error in such cases), but is a crucial feature of term rewriting languages,
  as it opens the door to symbolic evaluation techniques, see
  <hlink|Definitions and Expression Evaluation|#definitions-and-expression-evaluation>.

  There are two different ways to force a function definition to bail out
  with an error if you prefer that behaviour. First, you can provide an
  explicit rule which raises an exception (cf. <hlink|Exception
  Handling|#exception-handling>). But this can make it difficult or even
  impossible to add more rules to the function later, as discussed below.
  Instead, you may want to use the <hlink|<em|--defined>|#cmdoption-pure-pragma--defined>
  pragma as follows:

  <\verbatim>
    \<gtr\> #! --defined rot2

    \<gtr\> rot2 [1];

    \<less\>stdin\<gtr\>, line 13: unhandled exception 'failed_match' while
    evaluating 'rot2 [1]'
  </verbatim>

  <with|font-series|bold|Note:> This pragma tells the compiler that
  <verbatim|rot2> is supposed to be a ``defined'' function, which means that
  it should be an error if no rule applies to it; please see <hlink|Defined
  Functions|#defined-functions> in the <hlink|Caveats and
  Notes|#caveats-and-notes> section for details. Also note that exceptions
  will always interfere with symbolic evaluation and thus the use of this
  facility isn't really recommended. However, there are situations in which
  it can make your life a lot easier.

  One of Pure's key features is that you can usually just keep on adding new
  rules to existing function definitions in order to handle different kinds
  of arguments. As already mentioned, the rules will then be considered in
  the order in which they are written, and the first rule which matches the
  given arguments will be used to reduce the function application. For
  instance, adding the following rule we can make the <verbatim|rot2>
  function also work with tuples:

  <\verbatim>
    \<gtr\> rot2 (x,y,xs) = xs,x,y;

    \<gtr\> rot2 (1,2,3,4,5);

    3,4,5,1,2
  </verbatim>

  This is also known as <with|font-series|bold|ad-hoc polymorphism>. By these
  means, you can make a function apply to as many different kinds of
  arguments as you want, and the pattern matching handles the necessary
  ``dispatching'' so that the right rule gets invoked for the provided
  arguments.

  Pattern matching is not limited to the predefined aggregates such as lists,
  tuples and matrices. In principle, any legal Pure expression can occur as a
  pattern on the left-hand side of a rule or definition, so you can also
  write something like:

  <\verbatim>
    \<gtr\> rot2 (point x y z) = point z x y;

    \<gtr\> rot2 (point 1 2 3);

    point 3 1 2
  </verbatim>

  Or even:

  <\verbatim>
    \<gtr\> foo (foo x) = foo x;

    \<gtr\> bar (foo x) = foo (bar x);

    \<gtr\> foo (bar (foo 99));

    foo (bar 99)
  </verbatim>

  Note that symbolic rules like in the latter example (which in this case
  express the idempotence of <verbatim|foo> and a kind of commutativity with
  respect to <verbatim|bar>) often involve symbols which play the role of
  both a function <em|and> a constructor symbol.

  Syntactically, patterns are <hlink|simple expressions|#simple-expressions>,
  thus <hlink|special expressions|#special-expressions> need to be
  parenthesized if you want to include them in a pattern. (In fact, special
  expressions are given special treatment if they occur in patterns, see the
  <hlink|Macros|#macros> section for details.) A few other special elements
  in patterns are discussed below.

  <paragraph|The ``Head = Function'' Rule<label|the-head-function-rule>>

  A central ingredient of all patterns are of course the variables which get
  bound in the pattern matching process. Pure is a rather terse language and
  thus it has no explicit way to declare which identifiers are the variables.
  Instead, the compiler figures them out on its own, using a rather intuitive
  rule already explained in <hlink|Variables in
  Equations|#variables-in-equations>.

  Recall that the variables in a pattern are the identifiers in ``variable
  positions''. The <with|font-series|bold|head = function> rule tells us that
  a variable position is any leaf (atomic subexpression) of the expression
  tree which is <em|not> the head symbol of a function application. Thus a
  pattern like <verbatim|f> <verbatim|(g> <verbatim|x)> <verbatim|y> contains
  the variables <verbatim|x> and <verbatim|y>, whereas <verbatim|f> and
  <verbatim|g> are interpreted as literal function symbols. This rule also
  applies to the case of infix, prefix or postfix operator symbols, if we
  write the corresponding application in its unsugared form. E.g.,
  <verbatim|x+y*z> is equivalent to <verbatim|(+)> <verbatim|x>
  <verbatim|((*)> <verbatim|y> <verbatim|z)> which contains the variables
  <verbatim|x>, <verbatim|y> and <verbatim|z> and the literal function
  symbols <verbatim|(+)> and <verbatim|(*)>.

  There are some exceptions to the ``head = function'' rule. Specifically, it
  is possible to declare an identifier as a
  <hlink|<with|font-family|tt|nonfix>|#nonfix> symbol so that it will be
  interpreted as a literal function symbol even if it occurs in a variable
  position, see <hlink|Symbol Declarations|#symbol-declarations> for details.
  For instance:

  <\verbatim>
    nonfix nil;

    foo nil = 0;
  </verbatim>

  Note that since <verbatim|nil> is declared as a
  <hlink|<with|font-family|tt|nonfix>|#nonfix> symbol here, the symbol is
  interpreted as a literal rather than a variable in the left-hand side
  <verbatim|foo> <verbatim|nil>, and thus <verbatim|foo> will return
  <verbatim|0> for a literal <verbatim|nil> value only.

  Another case which needs special consideration are patterns consisting of a
  single identifier, such as <verbatim|x>. Here the meaning depends on the
  kind of construct. All variable-binding constructs
  (<hlink|<with|font-family|tt|let>|#let>,
  <hlink|<with|font-family|tt|const>|#const>,
  <hlink|<with|font-family|tt|when>|#when> and
  <hlink|<with|font-family|tt|case>|#case>) treat a singleton identifier as a
  variable (unless it is declared <hlink|<with|font-family|tt|nonfix>|#nonfix>).
  Thus all of the following constructs will have the expected result of
  binding the variable <verbatim|x> to the given list value
  <verbatim|[1,2,3]>. In either case the result is <verbatim|[0,1,2,3]>:

  <\verbatim>
    let x = [1,2,3]; 0:x;

    0:x when x = [1,2,3] end;

    case [1,2,3] of x = 0:x end;
  </verbatim>

  In contrast, a single identifier is always interpreted as a literal if it
  occurs on the left-hand side of a function or macro definition, so that the
  following rule defines a parameterless function <verbatim|y>:

  <\verbatim>
    y = [1,2,3]; 0:y;
  </verbatim>

  (While they yield the same values here, there are some notable differences
  between the parameterless function <verbatim|y> and the global variable
  <verbatim|x> defined above; see <hlink|Defining
  Functions|#defining-functions> for details.)

  Please also check <hlink|``Head = Function''
  Pitfalls|#head-function-pitfalls> in the <hlink|Caveats and
  Notes|#caveats-and-notes> section which has some some further interesting
  details and workarounds concerning the ``head = function'' rule.

  <paragraph|Constant Patterns<label|constant-patterns>>

  Constants in patterns must be matched literally. For instance:

  <\verbatim>
    foo 0 = 1;
  </verbatim>

  This will only match an application of <verbatim|foo> to the machine
  integer <verbatim|0>, not <verbatim|0.0> or <verbatim|0L> (even though
  these compare equal to <verbatim|0> using the
  `<hlink|<with|font-family|tt|==>|purelib.tm#==>` operator).

  <paragraph|The Anonymous Variable<label|the-anonymous-variable>>

  The `<verbatim|_>` symbol is special in patterns; it denotes the
  <with|font-series|bold|anonymous variable> which matches an arbitrary value
  (independently for all occurrences) without actually binding a variable.
  This is useful if you don't care about an argument or one of its
  components, in which case you can just use the anonymous variable as a
  placeholder for the value and don't have to invent a variable name for it.
  For instance:

  <\verbatim>
    foo _ _ = 0;
  </verbatim>

  This will match the application of <verbatim|foo> to any combination of two
  arguments (and just ignore the values of these arguments).

  <paragraph|Non-Linear Patterns and Syntactic
  Equality<label|non-linear-patterns-and-syntactic-equality>>

  In contrast to Haskell, patterns may contain repeated variables (other than
  the anonymous variable), i.e., they may be
  <with|font-series|bold|non-linear>. Thus rules like the following are legal
  in Pure, and will only be matched if all occurrences of the same variable
  in the left-hand side pattern are matched to the same value:

  <\verbatim>
    \<gtr\> foo x x = x;

    \<gtr\> foo 1 1;

    1

    \<gtr\> foo 1 2;

    foo 1 2
  </verbatim>

  Non-linear patterns are particularly useful for computer algebra where you
  will frequently encounter rules such as the following:

  <\verbatim>
    \<gtr\> x*y+x*z = x*(y+z);

    \<gtr\> a*(3*4)+a*5;

    a*17
  </verbatim>

  The notion of ``sameness'' employed here is that of syntactical identity,
  which means that the matched subterms must be identical in structure and
  content. The prelude provides syntactic equality as a function
  <hlink|<with|font-family|tt|same>|purelib.tm#same> and a comparison
  predicate `<hlink|<with|font-family|tt|===>|purelib.tm#===>`. Thus the
  above definition of <verbatim|foo> is roughly equivalent to the following:

  <\verbatim>
    foo x y = x if same x y;
  </verbatim>

  It is important to note the differences between syntactic equality embodied
  by <hlink|<with|font-family|tt|same>|purelib.tm#same> and
  `<hlink|<with|font-family|tt|===>|purelib.tm#===>`, and the ``semantic''
  equality operator `<hlink|<with|font-family|tt|==>|purelib.tm#==>`. The
  former are always defined on all terms, whereas
  `<hlink|<with|font-family|tt|==>|purelib.tm#==>` is only available on data
  where it has been defined explicitly, either in the prelude or by the
  programmer. Also note that `<hlink|<with|font-family|tt|==>|purelib.tm#==>`
  may assert that two terms are equal even if they are syntactically
  different. Consider, e.g.:

  <\verbatim>
    \<gtr\> 0==0.0;

    1

    \<gtr\> 0===0.0;

    0
  </verbatim>

  This distinction is actually quite useful. It gives the programmer the
  flexibility to define `<hlink|<with|font-family|tt|==>|purelib.tm#==>` in
  any way that he sees fit, which is consistent with the way the other
  comparison operators like `<hlink|<with|font-family|tt|\<less\>>|purelib.tm#\<>`
  and `<hlink|<with|font-family|tt|\<gtr\>>|purelib.tm#\>>` are handled in
  Pure.

  Syntactic equality is also used in pattern matching in order to decide
  whether a constant in a pattern matches the corresponding subterm in the
  target expression. This explains why the pattern <verbatim|foo>
  <verbatim|0>, as already mentioned, only matches an application of
  <verbatim|foo> to the machine integer <verbatim|0>, not <verbatim|0.0> or
  <verbatim|0L> which aren't syntactically equal to <verbatim|0>.

  However, there is one caveat here. Due to its term rewriting heritage, Pure
  distinguishes between literal function symbols in patterns and named
  functions. The latter are runtime objects which are only considered
  syntactically equal if they not only have the same name but actually refer
  to the same (global or local) closure. In contrast, a function symbol in a
  pattern is just a literal symbol without reference to any particular
  closure that the symbol may be bound to in some context. Thus a function
  symbol in a pattern matches <em|any> instance of the symbol in the target
  expression, no matter whether it happens to be a pure constructor, quoted
  symbol or any named closure bound to that symbol.

  This leads to some discrepancies between pattern matching and syntactic
  equality which may be surprising at first sight. For instance, consider:

  <\verbatim>
    \<gtr\> foo x = case x of bar y = x===bar y end;

    \<gtr\> bar x y = x+y;

    \<gtr\> foo (bar 99);

    1

    \<gtr\> foo ('bar 99);

    0

    \<gtr\> foo (bar 99) with bar x y = x*y end;

    0
  </verbatim>

  Note that the argument term <verbatim|bar> <verbatim|99> matches the
  pattern <verbatim|bar> <verbatim|y> in the
  <hlink|<with|font-family|tt|case>|#case> expression in either case, even
  though in the last two expressions <verbatim|bar> is <em|not> considered
  syntactically equal to the global <verbatim|bar> function because it is
  quoted (cf. <hlink|The Quote|#the-quote>) or bound to a local closure of
  the same name, respectively.

  <paragraph|Special Patterns<label|special-patterns>>

  Last but not least, patterns may also contain the following special
  elements which are not permitted in right-hand side expressions:

  <\itemize>
    <item>A Haskell-style <with|font-series|bold|``as'' pattern> of the form
    <em|variable> <verbatim|@> <em|pattern> binds the given variable to the
    expression matched by the subpattern <em|pattern> (in addition to the
    variables bound by <em|pattern> itself). This is convenient if the value
    matched by the subpattern is to be used on the right-hand side of an
    equation.

    <item>A left-hand side variable (including the anonymous variable) may be
    followed by a <with|font-series|bold|type tag> of the form <verbatim|::>
    <em|name>, where <em|name> is either one of the built-in type symbols
    <verbatim|int>, <verbatim|bigint>, <verbatim|double>, <verbatim|string>,
    <verbatim|matrix>, <verbatim|pointer>, or an identifier denoting a
    user-defined data type. The variable can then match only values of the
    designated type. Thus, for instance, `<verbatim|x::int>` only matches
    machine integers. See the <hlink|Type Tags|#type-tags> section below for
    details.
  </itemize>

  To these ends, the expression syntax is augmented with the following
  grammar rule (but note that this form of expression is in fact only allowed
  on the left-hand side of a rule):

  <\verbatim>
    prim_expr ::= \ qualified_identifier

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ("::" qualified_identifier \| "@"
    prim_expr)
  </verbatim>

  As shown, both ``as'' patterns and type tags are primary expressions, and
  the subpattern of an ``as'' pattern is a primary expression, too. Thus, if
  a compound expression is to be used as the subpattern, it <em|must> be
  parenthesized. For instance, the following function duplicates the head
  element of a list:

  <\verbatim>
    foo xs@(x:_) = x:xs;
  </verbatim>

  Note that if you accidentally forget the parentheses around the subpattern
  <verbatim|x:_>, you still get a syntactically correct definition:

  <\verbatim>
    foo xs@x:_ = x:xs;
  </verbatim>

  But this gets parsed as <verbatim|(foo> <verbatim|xs@x):_> <verbatim|=>
  <verbatim|x:xs>, which is most certainly <em|not> what you want. It is thus
  a good idea to just always enclose the subpattern with parentheses in order
  to prevent such glitches.

  <with|font-series|bold|Note:> Another pitfall is that the notation
  <verbatim|foo::bar> is also used to denote ``qualified symbols'' in Pure,
  cf. <hlink|Namespaces|#namespaces>. Usually this will be resolved
  correctly, but if <verbatim|foo> happens to also be a valid namespace then
  most likely you'll get an error message about an undeclared symbol. You can
  always work around this by adding spaces around the `<verbatim|::>` symbol,
  as in <verbatim|foo> <verbatim|::> <verbatim|bar>. Spaces are never
  permitted in qualified symbols, so this makes it clear that the construct
  denotes a type tag. The same applies if the variable or the tag is a
  qualified identifier; in this case they should always be separated by
  whitespace.

  <subsubsection|Type Tags<label|type-tags>>

  Like Lisp, Pure is essentially a typeless language and doesn't really have
  a built-in notion of ``data types''. Rather, all data belongs to the same
  universe of terms. However, for convenience it is possible to describe data
  domains by means of (unary) type <em|predicates> which may denote arbitrary
  sets of terms. The names of these type predicates can then be used as
  <with|font-series|bold|type tags> on variables, so that they can only be
  matched by values of the given type.

  We have to emphasize here that Pure's notion of types has nothing to do
  with static typing. Type tags are merely used at runtime to restrict the
  kind of data that can be matched by a rule (and by the compiler to generate
  better code in some cases). But they will never cause the compiler to
  impose a static typing discipline and spit out corresponding ``type
  errors''. (This wouldn't make any sense in Pure anyway, as failure to match
  any of the rules given in the definition of a function simply means that a
  function application is in normal form.)

  Some basic types are built into the language. The corresponding tags enable
  you to match the built-in types of terms for which there is no way to spell
  out all ``constructors'', as there are infinitely many (or none, as in the
  case of <hlink|<with|font-family|tt|pointer>|#pointer/type> values which
  are constructed and inspected using special primitives, but are otherwise
  ``opaque'' at the Pure level). Specifically, the following data types are
  built-in (in fact, the pattern matcher has special knowledge about these so
  that they can be matched very efficiently):

  <\description>
    <item*|<em|type> int<label|int/type>>The type of machine integers.
  </description>

  <\description>
    <item*|<em|type> bigint<label|bigint/type>>The type of arbitrary
    precision integers (GMP bigints).
  </description>

  <\description>
    <item*|<em|type> double<label|double/type>>The type of double precision
    floating point numbers.
  </description>

  <\description>
    <item*|<em|type> string<label|string/type>>The type of character strings.
  </description>

  <\description>
    <item*|<em|type> matrix<label|matrix/type>>The type of all numeric and
    symbolic matrix values.
  </description>

  <\description>
    <item*|<em|type> pointer<label|pointer/type>>The type of C pointer
    values.
  </description>

  Pure's standard library provides additional data types along with the
  corresponding operations, such as rational and complex numbers, lists,
  tuples and the container data types (sets, dictionaries, etc.). These are
  all described in the <hlink|<em|Pure Library Manual>|purelib.tm>.

  You can define your own data types using a special kind of rule syntax
  which is explained in <hlink|Type Rules|#type-rules> below. For instance,
  we might represent points in the plane using a constructor symbol
  <verbatim|Point> which gets applied to pairs of coordinates. We can then
  define the <verbatim|point> data type as follows:

  <\verbatim>
    type point (Point x y);
  </verbatim>

  This introduces the type symbol <verbatim|point> and specifies that this
  type consists of terms of the form <verbatim|Point> <verbatim|x>
  <verbatim|y>. We can now equip this data type with an operation
  <verbatim|point> to construct a point from its coordinates, two operations
  <verbatim|xcoord> and <verbatim|ycoord> to retrieve the coordinates, and an
  operation <verbatim|move> to change the coordinates to the given values:

  <\verbatim>
    point x y = Point x y;

    xcoord (Point x y) = x;

    ycoord (Point x y) = y;

    move (Point _ _) x y = Point x y;
  </verbatim>

  Next we might define a function <verbatim|translate> which shifts the
  coordinates of a point by a given amount in the x and y directions as
  follows:

  <\verbatim>
    translate x y p::point = move p (xcoord p+x) (ycoord p+y);
  </verbatim>

  Note the use of <verbatim|point> as a type tag on the <verbatim|p>
  variable. By these means, we can ensure that the argument is actually an
  instance of the point data type we just defined. The type tag acts just
  like an extra guard of the equation defining <verbatim|translate>, but all
  the necessary type checking is done automatically during pattern matching.
  This is often more convenient (and, depending on the implementation, the
  compiler may generate more efficient code for a type tag than for an
  ordinary guard).

  The <verbatim|translate> function can be invoked as follows:

  <\verbatim>
    \<gtr\> let p::point = point 3 3;

    \<gtr\> p; translate 1 2 p;

    Point 3 3

    Point 4 5
  </verbatim>

  One important point to note here is that <verbatim|translate> can be
  defined without knowing or assuming <em|anything> about the internal
  representation of the <verbatim|point> data type. We have defined
  <verbatim|point> as a <with|font-series|bold|concrete data type> in this
  example, making its constructor and internal structure visible in the rest
  of the program. This is often convenient, but the <verbatim|Point>
  constructor might just as well be hidden by making it a private member of
  some namespace (cf. <hlink|Namespaces|#namespaces>), so that all accesses
  to the data structure would have to be done through the provided
  operations. Such a data type is also known as an
  <with|font-series|bold|abstract data type> (ADT).

  <with|font-series|bold|Note:> As we've already seen, Pure has some powerful
  capabilities which enable you to write functions to inspect and manipulate
  terms in a completely generic fashion. Thus the internal structure of term
  data is never truly opaque in Pure and it is always possible to break the
  ``abstraction barrier'' provided by an ADT. But if the user of an ADT plays
  such dirty tricks to wreak havoc on the internal representation of an ADT,
  he gets what he deserves.

  Pure provides some additional facilities to ease the handling of abstract
  data types. Specifically, instead of defining <verbatim|point> as a
  concrete data type using a <hlink|<with|font-family|tt|type>|#type> rule,
  we might also specify it as an <with|font-series|bold|interface type> which
  merely lists the supported operations as follows:

  <\verbatim>
    interface point with

    \ \ xcoord p::point;

    \ \ ycoord p::point;

    \ \ move p::point x y;

    end;
  </verbatim>

  We can implement this type the same way as before:

  <\verbatim>
    point x y = Point x y;

    xcoord (Point x y) = x;

    ycoord (Point x y) = y;

    move (Point _ _) x y = Point x y;
  </verbatim>

  The definition of the <verbatim|translate> function is also unchanged:

  <\verbatim>
    translate x y p::point = move p (xcoord p+x) (ycoord p+y);
  </verbatim>

  The difference is that now the structure of members of the type is not made
  explicit <em|anywhere> in the definition of the type. Instead, the compiler
  figures out which data matches the <verbatim|point> tag on its own. We can
  check the actual term patterns making up the <verbatim|point> type with the
  <verbatim|show> <verbatim|interface> command:

  <\verbatim>
    \<gtr\> show interface point

    type point (Point x y);
  </verbatim>

  As you can see, the compiler derived our previous definition of the type.
  But in fact <verbatim|translate> will now work with <em|any> data type
  which implements the <verbatim|point> interface (i.e., provides the
  <verbatim|xcoord>, <verbatim|ycoord> and <verbatim|move> operations), so we
  may swap out the underlying data structure on a whim. For instance, if we'd
  like to use vectors instead of constructor terms, all we have to do is to
  provide a corresponding construction function and implement the interface
  operations:

  <\verbatim>
    vpoint x y = {x,y};

    xcoord {x,y} = x;

    ycoord {x,y} = y;

    move {_,_} x y = {x,y};
  </verbatim>

  After these definitions the new data representation works just fine with
  existing <verbatim|point> operations such as <verbatim|translate>:

  <\verbatim>
    \<gtr\> show interface point

    type point (Point x y);

    type point {x,y};

    \<gtr\> let p::point = vpoint 3 3;

    \<gtr\> p; translate (1,2) p;

    {3,3}

    {4,5}
  </verbatim>

  This separation of interface and implementation of a data structure is an
  important ingredient of software engineering techniques. More examples and
  detailed explanations of Pure's notions of type predicates and interface
  types can be found in the <hlink|Type Rules|#type-rules> and
  <hlink|Interface Types|#interface-types> sections.

  <subsubsection|General Rules<label|general-rules>>

  The most general type of rule, used in function definitions and
  <hlink|<with|font-family|tt|case>|#case> expressions, consists of a
  left-hand side pattern, a right-hand side expression and an optional guard.
  The left-hand side of a rule can be omitted if it is the same as for the
  previous rule. This provides a convenient means to write out a collection
  of equations for the same left-hand side which discriminates over different
  conditions:

  <\verbatim>
    lhs \ \ \ \ \ \ = rhs if guard;

    \ \ \ \ \ \ \ \ \ \ = rhs if guard;

    \ \ \ \ \ \ \ \ \ \ ...

    \ \ \ \ \ \ \ \ \ \ = rhs otherwise;
  </verbatim>

  For instance:

  <\verbatim>
    fact n \ = n*fact (n-1) if n\<gtr\>0;

    \ \ \ \ \ \ \ \ = 1 otherwise;
  </verbatim>

  This expands to:

  <\verbatim>
    fact n \ = n*fact (n-1) if n\<gtr\>0;

    fact n \ = 1 otherwise;
  </verbatim>

  Pure also allows a collection of rules with different left-hand sides but
  the same right-hand side(s) to be abbreviated as follows:

  <\verbatim>
    lhs \ \ \ \ \ \ \|

    \ \ \ \ \ \ \ \ \ \ ...

    lhs \ \ \ \ \ \ = rhs;
  </verbatim>

  This is useful, e.g., if you specialize a rule to different type tags on
  the left-hand side variables. For instance:

  <\verbatim>
    fact n::int \ \ \ \|

    fact n::double = n*fact(n-1) if n\<gtr\>0;

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ = 1 otherwise;
  </verbatim>

  This expands to:

  <\verbatim>
    fact n::int \ \ \ = n*fact(n-1) if n\<gtr\>0;

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ = 1 otherwise;

    fact n::double = n*fact(n-1) if n\<gtr\>0;

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ = 1 otherwise;
  </verbatim>

  In fact, the left-hand sides don't have to be related at all, so you can
  also write something like:

  <\verbatim>
    foo x \| bar y = x*y;
  </verbatim>

  Which expands to:

  <\verbatim>
    foo x = x*y;

    bar y = x*y;
  </verbatim>

  But more often you'll have an ``as'' pattern which binds a common variable
  to a parameter value after checking that it matches one of several possible
  argument patterns (which is slightly more efficient than using an
  equivalent type-checking guard). E.g., the following definition binds the
  <verbatim|xs> variable to the parameter of <verbatim|foo>, which may be
  either the empty list or a list starting with an integer:

  <\verbatim>
    foo xs@[] \| foo xs@(_::int:_) = bar xs;
  </verbatim>

  The <verbatim|\|> notation also works in
  <hlink|<with|font-family|tt|case>|#case> expressions, which is convenient
  if different cases should be mapped to the same value, e.g.:

  <\verbatim>
    case ans of "y" \| "Y" = 1; _ = 0; end;
  </verbatim>

  Sometimes it is useful if local definitions
  (<hlink|<with|font-family|tt|when>|#when> and
  <hlink|<with|font-family|tt|with>|#with>) can be shared by the right-hand
  side and the guard of a rule. This can be done by placing the local
  definitions behind the guard, as follows (we only show the case of a single
  <hlink|<with|font-family|tt|when>|#when> clause here, but of course there
  may be any number of <hlink|<with|font-family|tt|when>|#when> and
  <hlink|<with|font-family|tt|with>|#with> clauses behind the guard):

  <\verbatim>
    lhs = rhs if guard when defns end;
  </verbatim>

  Note that this is different from the following, which indicates that the
  definitions only apply to the guard but not the right-hand side of the
  rule:

  <\verbatim>
    lhs = rhs if (guard when defns end);
  </verbatim>

  Conversely, definitions placed <em|before> the guard only apply to the
  right-hand side but not the guard (no parentheses are required in this
  case):

  <\verbatim>
    lhs = rhs when defns end if guard;
  </verbatim>

  An example showing the use of a local variable binding spanning both the
  right-hand side and the guard of a rule is the following quadratic equation
  solver, which returns the (real) solutions of the equation
  <verbatim|x^2+p*x+q> <verbatim|=> <verbatim|0> if the discriminant
  <verbatim|d> <verbatim|=> <verbatim|p^2/4-q> is nonnegative:

  <\verbatim>
    \<gtr\> using math;

    \<gtr\> solve p q = -p/2+sqrt d,-p/2-sqrt d if d\<gtr\>=0 when d =
    p^2/4-q end;

    \<gtr\> solve 4 2; solve 2 4;

    -0.585786437626905,-3.41421356237309

    solve 2 4
  </verbatim>

  Note that the above definition leaves the case of a negative discriminant
  undefined.

  <subsubsection|Simple Rules<label|simple-rules>>

  As already mentioned, <hlink|<with|font-family|tt|when>|#when>,
  <hlink|<with|font-family|tt|let>|#let> and
  <hlink|<with|font-family|tt|const>|#const> use a simplified kind of rule
  syntax which just consists of a left-hand and a right-hand side separated
  by the equals sign. In this case the meaning of the rule is to bind the
  variables in the left-hand side of the rule to the corresponding subterms
  of the value of the right-hand side. This is also called a
  <with|font-series|bold|pattern binding>.

  Guards or multiple left-hand or right-hand sides are not permitted in these
  rules. However, it is possible to omit the left-hand side if it is just the
  anonymous variable `<verbatim|_>` by itself, indicating that you don't care
  about the result. The right-hand side is still evaluated, if only for its
  side-effects, which is handy, e.g., for adding debugging statements to your
  code. For instance, here is a variation of the quadratic equation solver
  which also prints the discriminant after it has been computed:

  <\verbatim>
    \<gtr\> using math, system;

    \<gtr\> solve p q = -p/2+sqrt d,-p/2-sqrt d if d\<gtr\>=0

    \<gtr\> when d = p^2/4-q; printf "The discriminant is: %g\\n" d; end;

    \<gtr\> solve 4 2;

    The discriminant is: 2

    -0.585786437626905,-3.41421356237309

    \<gtr\> solve 2 4;

    The discriminant is: -3

    solve 2 4
  </verbatim>

  Note that simple rules of the same form <verbatim|lhs> <verbatim|=>
  <verbatim|rhs> are also used in macro definitions
  (<hlink|<with|font-family|tt|def>|#def>), to be discussed in the
  <hlink|Macros|#macros> section. In this case, however, the rule denotes a
  real rewriting rule, not a pattern binding, hence the left-hand side is
  mandatory in these rules.

  <subsubsection|Type Rules<label|type-rules>>

  In Pure the definition of a type takes a somewhat unusual form, since it is
  not a static declaration of the structure of the type's members, but rather
  an arbitrary predicate which determines through a runtime check which terms
  belong to the type. Thus the definition of a type looks more like an
  ordinary function definition (and that's essentially what it is, although
  types live in their own space where they can't be confused with functions
  of the same name).

  The definition of a type thus consists of one or more type rules which
  basically have the same format as the <hlink|general rules|#general-rules>,
  but with the keyword <hlink|<with|font-family|tt|type>|#type> in front of
  each rule. Also, each left-hand side must have at most one argument pattern
  and exactly one right-hand side. Hence, if the definition of a type
  requires several right-hand sides, you normally have to write a separate
  <hlink|<with|font-family|tt|type>|#type> rule for each of them. Multiple
  left-hand sides work the same as in the general rule format, though.

  As already mentioned, there is an alternative way for defining types in an
  indirect way through so-called <hlink|interface types|#interface-types>
  from which the corresponding type rules are derived automatically. These
  are part of Pure's declaration syntax and thus will be discussed later in
  the <hlink|Declarations|#declarations> section. In this section we focus on
  how you can write your own type rules in order to define types in a direct
  fashion.

  The identifier in the head of the left-hand side of a type rule is the name
  of the type which can then be used as a type tag in other equations, cf.
  <hlink|Type Tags|#type-tags>. This is just a normal, possibly qualified
  identifier subject to the same namespace mechanisms as other symbols; see
  <hlink|Namespaces|#namespaces> for details. However, as the type symbol
  only gets used as a type tag, it can never collide with function and
  variable symbols and hence the same symbol can be used both as a type and
  as a function or variable name.

  A collection of type rules specifies a predicate, i.e. a unary,
  truth-valued function which denotes a set of terms. The type consists
  precisely of those terms for which the type predicate yields a nonzero
  result. For instance, the following type defines the type <verbatim|triple>
  as the set of all tuples with exactly three elements:

  <\verbatim>
    type triple (x,y,z) = ~tuplep z;
  </verbatim>

  Note that the type check consists of two parts here: The left-hand side
  pattern <verbatim|(x,y,z)> restricts the set to all tuples with at least
  three elements. The right-hand side <verbatim|~tuplep> <verbatim|z> then
  verifies that the last component <verbatim|z> is not a tuple itself, and
  thus the entire tuple consists of exactly three elements.

  Another important point here is that the definition of the
  <verbatim|triple> predicate is <em|partial>, as the given rule only applies
  to tuples with at least three elements. A value will only match the
  <verbatim|triple> type tag if the predicate explicitly returns
  <hlink|<with|font-family|tt|true>|purelib.tm#true>; otherwise the match
  will fail, no matter what the result is (and even if the predicates just
  fails, i.e., returns an unevaluated normal form). Thus there is no need to
  make the predicate work on all terms (and in fact there are good reasons to
  <em|not> do so, see below).

  In general, you should try to make your type definitions as specific as
  possible. This makes it possible to extend the predicate later, just like
  Pure allows you to extend the definition of a function to new types of
  arguments. For instance, if you later decide that lists with three elements
  should be considered as triples, too, then you may add the following type
  rule:

  <\verbatim>
    type triple [x,y,z] = true;
  </verbatim>

  This makes it possible to define a type in a piecemeal fashion. Each
  subsequent rule enlarges the term set of the type. Conversely, consider a
  definition like:

  <\verbatim>
    type pair x = tuplep x && #x==2;
  </verbatim>

  In this case the type rule applies to all values <verbatim|x> and thus the
  type definition is complete; there is no way to extend it later. Whether to
  prefer the former or latter kind of definition depends on the situation. If
  you want to keep a type extensible, so that you can later make existing
  definitions of operations on the type work with new data representations,
  then you should use the former approach, otherwise the latter.

  As an example for an extensible type definition, consider the following
  type <verbatim|nat> which denotes the type of positive (machine) integers:

  <\verbatim>
    type nat x::int = x\<gtr\>0;
  </verbatim>

  This definition is complete for the case of machine integers, but allows
  the type to be extended for other base types, and we'll do that in a
  moment. But first let's define the factorial on <verbatim|nat> values as
  follows:

  <\verbatim>
    fact n::nat = if n==1 then 1 else n * fact (n-1);
  </verbatim>

  Note that this definition would loop on zero or negative values if we
  permitted arbitrary <verbatim|int> arguments. But since we restricted the
  argument type to <verbatim|nat>, this case cannot occur and so the
  definition is safe:

  <\verbatim>
    \<gtr\> fact 0;

    fact 0

    \<gtr\> map fact (1..10);

    [1,2,6,24,120,720,5040,40320,362880,3628800]
  </verbatim>

  The way we defined <verbatim|fact>, it works on positive machine integers,
  but nothing else:

  <\verbatim>
    \<gtr\> fact 10L;

    fact 10L
  </verbatim>

  If we later decide that positive bigints should be considered as members of
  <verbatim|nat> as well, we can simply add another rule for the
  <verbatim|nat> type:

  <\verbatim>
    type nat x::bigint = x\<gtr\>0;
  </verbatim>

  Et voila, our <verbatim|fact> routine now magically works with bigints,
  too:

  <\verbatim>
    \<gtr\> map fact (0L..10L);

    [fact 0L,1,2L,6L,24L,120L,720L,5040L,40320L,362880L,3628800L]
  </verbatim>

  Note that we did all this without ever touching our original definition of
  <verbatim|fact>. This works because the <verbatim|bigint> data type already
  provides all the operations which we expect to use with the <verbatim|nat>
  type. Pulling off this trick with other, more exotic kinds of data requires
  more preparation, since we'll first have to provide the required
  operations. In this case, we need at least multiplication, as well as
  comparisons with 1 and subtraction by 1. For instance, and just for the fun
  of it, let's implement our own variation of the <verbatim|nat> type using
  Peano arithmetic:

  <\verbatim>
    type nat (s x) = true;

    \;

    // addition

    x + 0 \ \ = x;

    x + 1 \ \ = s x;

    x + s y = s (x+y);

    \;

    // multiplication

    x * 0 \ \ = 0;

    x * 1 \ \ = x;

    x * s y = x + x*y;

    \;

    // subtract 1

    s x - 1 = x;

    \;

    // comparison with 0 and 1

    s x == 0 = false;

    s x == 1 = x == 0;
  </verbatim>

  This implements just the bare bones, but that should be enough to make
  <verbatim|fact> work. Let's give it a try:

  <\verbatim>
    \<gtr\> fact (s (s (s 0)));

    s (s (s (s (s (s 0)))))
  </verbatim>

  So, counting the <verbatim|s>`s, the factorial of 3 is 6. Works! (It goes
  without saying, though, that this implementation of <verbatim|nat> is not
  very practical; you'll get mountains of <verbatim|s>`s for larger values of
  <verbatim|n>.)

  As you can see, a type definition may in general consist of many type rules
  which may be scattered out over different parts of a program. This works in
  exactly the same way as with ordinary functions.

  There's an additional convenience provided for type rules, namely that the
  right-hand side may be omitted if it's just
  <hlink|<with|font-family|tt|true>|purelib.tm#true>. For instance, the rule

  <\verbatim>
    type nat (s x) = true;
  </verbatim>

  from above can also be written simply as:

  <\verbatim>
    type nat (s x);
  </verbatim>

  This kind of notation is particularly convenient for ``algebraic types''
  which are usually given by a collection of constructors with different
  arities. For instance, a binary tree data type might be defined as follows
  (here we employ the <verbatim|\|> symbol to separate the different
  left-hand sides so that we can give all the constructor patterns in one
  go):

  <\verbatim>
    nonfix nil;

    type bintree nil \| bintree (bin x left right);
  </verbatim>

  This method is also useful if you define your own abstract data types. In
  this case you're free to choose any suitable representation, so you might
  just wrap up all data objects of the type with a special constructor
  symbol, which makes checking the type simple and efficient. This is also
  the approach taken in the <verbatim|point> example in <hlink|Type
  Tags|#type-tags> above, as well as by the container data types in the
  standard library.

  The same notation can also be used to quickly make one type a ``subtype''
  of another, or to create a type which is the union of several existing
  types. The following example can be found in the standard library:

  <\verbatim>
    type integer x::int \| integer x::bigint;
  </verbatim>

  A type rule can also take the form of a function definition without
  arguments. The corresponding right-hand side may either be another type
  symbol, or any kind of closure denoting a (curried) type predicate. In this
  case the defined type is simply an <with|font-series|bold|alias> for the
  type denoted on the right-hand side. This is often done, e.g., for numeric
  types, to document that they actually stand for special kinds of
  quantities:

  <\verbatim>
    type speed = double;

    type size = int;
  </verbatim>

  Note that the definition of a type alias is always complete; there's no way
  to extend the corresponding type later. Therefore type aliases are normally
  resolved at compile time, so that they incur no additional runtime cost.
  For instance:

  <\verbatim>
    \<gtr\> half x::speed = x/2;

    \<gtr\> show half

    half x::double = x/2;
  </verbatim>

  (If necessary, this ``type folding'' can also be disabled with the
  <hlink|<em|--nofold>|#cmdoption-pure--nofold> pragma.)

  Finally, it's also possible to just specify the type name, without giving
  the right-hand side:

  <\verbatim>
    type thing;
  </verbatim>

  This doesn't have any effect other than just declaring the type symbol, so
  that it can be used as a type tag in subsequent definitions. You then still
  have to give a proper definition of the type later (either as an explicit
  predicate or an alias).

  Type aliases can also be used to quickly turn an existing predicate into a
  ``convenience'' type which can be used as a tag on the left-hand side of
  equations. The prelude defines a number of these, see <hlink|<em|Prelude
  Types>|purelib.tm#prelude-types>. For instance:

  <\verbatim>
    type closure = closurep;
  </verbatim>

  Conversely, you can turn any type tag into an ordinary predicate which can
  be used on the right-hand side of other definitions. To these ends, the
  prelude provides the <hlink|<with|font-family|tt|typep>|purelib.tm#typep>
  predicate which takes a type symbol and the value to be checked as
  arguments. For instance:

  <\verbatim>
    type odd x::int = x mod 2;

    type even x::int = ~odd x;

    \;

    odd x = typep odd x;

    even x = typep even x;
  </verbatim>

  With those definitions you get:

  <\verbatim>
    \<gtr\> map odd (0..10);

    [0,1,0,1,0,1,0,1,0,1,0]

    \<gtr\> map even (0..10);

    [1,0,1,0,1,0,1,0,1,0,1]
  </verbatim>

  There's one caveat here. As the type symbol passed to
  <hlink|<with|font-family|tt|typep>|purelib.tm#typep> gets evaluated in
  normal code you have to be careful if the symbol is also defined as a
  parameterless function or a variable; in such a case you'll have to quote
  the symbol, as described in section <hlink|The Quote|#the-quote>. For
  instance, we might rewrite the above definitions as follows, giving
  ``pointless'' definitions of the <verbatim|odd> and <verbatim|even>
  predicates in terms of <hlink|<with|font-family|tt|typep>|purelib.tm#typep>:

  <\verbatim>
    type odd x::int = x mod 2;

    type even x::int = ~odd x;

    \;

    odd = typep ('odd);

    even = typep ('even);
  </verbatim>

  Note that the quotes on <verbatim|odd> and <verbatim|even> are really
  needed here to prevent the predicate definitions from looping. If you need
  this a lot then you might define a little helper macro (cf.
  <hlink|Macros|#macros>) which quotes the type symbol in an automatic
  fashion:

  <\verbatim>
    def typep ty::symbol = typep ('ty);
  </verbatim>

  (However, this gets in the way if you want to check for computed type
  symbols, that's why this macro isn't defined in the prelude.)

  Pure places no a priori restrictions on the rules defining a data type
  (other than that they must either define a unary predicate or an alias for
  an existing data type). As far as Pure is concerned, types are just subsets
  of the universe of terms. Thus any type of relation between two data types
  is possible; they might be unrelated (disjoint) term sets, one may be a
  subset of another, or they might be related in some other way (some terms
  may be members of both types, while others aren't).

  For instance, consider the types <verbatim|nat> and <verbatim|odd> from
  above. Both are subtypes of the <verbatim|int> type (assuming our original
  definition of <verbatim|nat> as the positive <verbatim|int> values), but
  neither is a subtype of the other. It's sometimes useful to define the
  ``intersection type'' of two such types, which can be done in a
  straightforward way using the logical conjunction of the two type
  predicates:

  <\verbatim>
    type nat x::int = x\<gtr\>0;

    type odd x::int = x mod 2;

    type odd_nat x \ = typep nat x && typep odd x;
  </verbatim>

  Similarly, a variation of the <verbatim|integer> union type from above
  could be defined using logical disjunction (this employs the
  <hlink|<with|font-family|tt|intp>|purelib.tm#intp> and
  <hlink|<with|font-family|tt|bigintp>|purelib.tm#bigintp> predicates from
  the prelude):

  <\verbatim>
    type myinteger x = intp x \|\| bigintp x;
  </verbatim>

  (Note that this isn't quite the same as the previous definition, which uses
  explicit patterns in order to make the definition extensible.)

  Since the right-hand side of a type definition may in general be any
  predicate, it is up to the programmer to ensure that the definition of a
  type is actually computable. In fact, you should strive for the best
  possible efficiency in type predicates. A type definition which has worse
  than <puredoc-image|_images/math/62d0effd6477f4244d585fc25f46a645378a4ceb.png|66%|66%||>
  complexity may well be a serious performance hog depending on the way in
  which it is used, see <hlink|Recursive Types|#recursive-types> in the
  <hlink|Caveats and Notes|#caveats-and-notes> section for more information
  about this.

  Finally, note that in general it may be hard or even impossible to predict
  exactly when the code of a type definition will be executed at runtime.
  Thus, as a general rule, a type definition should not rely on side effects
  such as doing I/O (except maybe for debugging purposes), modifying
  references or external data structures via C pointers, etc.

  <subsection|Examples<label|examples>>

  This section assumes that you've read the <hlink|Pure
  Overview|#pure-overview> and <hlink|Rule Syntax|#rule-syntax> sections, so
  that you are familiar with the basic elements of the Pure language. We now
  bring the pieces together and show you how simple but typical problems can
  be solved using Pure. You might use this section as a mini-tutorial on the
  Pure language. As we haven't discussed the more advanced elements of the
  Pure language yet, the scope of this section is necessarily limited. But it
  should give you a pretty good idea of how Pure programs looks like. After
  working through these examples you should be able to write useful Pure
  programs and understand the more advanced features discussed in subsequent
  sections.

  <subsubsection|Hello, World<label|hello-world>>

  The notorious ``hello world'' program can be written in Pure as follows:

  <\verbatim>
    using system;

    puts "Hello, world!";
  </verbatim>

  This employs the <hlink|<with|font-family|tt|puts>|purelib.tm#puts>
  function from Pure's system module (which is in fact just the
  <verbatim|puts> function from the C library). If you put these lines into a
  script file, say, hello.pure, you can run the program from the command line
  as follows:

  <\verbatim>
    $ pure hello.pure

    Hello, world!
  </verbatim>

  You may notice a slight delay when executing the script, before the
  ``<verbatim|Hello,> <verbatim|world!>'' message appears. That's because the
  interpreter first has to compile the definitions in your script as well as
  the prelude and other imported modules before the <verbatim|puts>
  <verbatim|"Hello,> <verbatim|world!"> expression can be evaluated. The
  startup times can be reduced (sometimes considerably) by compiling scripts
  to native executables, see <hlink|Compiled Scripts|#compiled-scripts>
  below.

  <paragraph|Passing Parameters<label|passing-parameters>>

  Sometimes you may want to pass parameters to a script from the command
  line. To these ends, just follow the script name with the required
  parameters. The interpreter makes the command line parameters (including
  the script name) available as a list of strings in the
  <hlink|<with|font-family|tt|argv>|#argv> variable. For instance, here is a
  version of the ``hello world'' program which uses
  <hlink|<with|font-family|tt|printf>|purelib.tm#printf> to print the line
  <verbatim|Hello,> <verbatim|foo!> where <verbatim|foo> is whatever was
  specified as the first command line parameter:

  <\verbatim>
    using system;

    printf "Hello, %s!\\n" (argv!1);
  </verbatim>

  This script is invoked as:

  <\verbatim>
    $ pure hello.pure foo

    Hello, foo!
  </verbatim>

  Of course, many real-world programs will require more elaborate processing
  of command line parameters, such as recognizing program options. We won't
  discuss this here, but you can have a look at the
  <hlink|<with|font-family|tt|getopt>|purelib.tm#module-getopt> module which
  provides that kind of functionality in a convenient package.

  <paragraph|Executable Scripts<label|executable-scripts>>

  It is often convenient if you can turn a script into a standalone
  executable which can be invoked by just typing its name on the command
  line. There are several ways to do this.

  First, on most systems you can invoke the Pure script through some kind of
  shell script or command file which contains the command to invoke the
  interpreter. The details of this depend on the operating system and type of
  shell that you use, however, so we won't go into this here.

  Second, on Unix-like systems it is possible to make any script file
  executable like this:

  <\verbatim>
    $ chmod a+x hello.pure
  </verbatim>

  However, we also have to tell the shell about the command interpreter which
  should be invoked to run the script. (Otherwise the shell itself may try to
  execute the script, which won't work because it's not a shell script.) As
  already mentioned in <hlink|Overview of Operation|#overview-of-operation>,
  this is done by adding a special kind of comment, a ``shebang'', to the
  beginning of the script, so that it looks like:

  <\verbatim>
    #!/usr/local/bin/pure

    using system;

    puts "Hello, world!";
  </verbatim>

  Note that you <em|must> give the full path to the Pure interpreter in the
  shebang line. This path of course depends on where you installed Pure. The
  above shebang will work with an installation from source, unless you
  changed the installation prefix when configuring the source package. If you
  installed the interpreter from a binary package, the proper path will often
  be <verbatim|/usr/bin/pure> instead. In any case, you can find out where
  the interpreter lives by typing the following command in the shell:

  <\verbatim>
    $ which pure

    /usr/local/bin/pure
  </verbatim>

  If you get anything else on your system then you'll have to fix the shebang
  accordingly. You should then be able to run the script as follows:

  <\verbatim>
    $ ./hello.pure

    Hello, world!
  </verbatim>

  <with|font-series|bold|Note:> Many modern Unix-like systems provide the
  <verbatim|/usr/bin/env> utility which can perform a search for the
  interpreter executable, so that you can also use a shebang like:

  <\verbatim>
    #!/usr/bin/env pure
  </verbatim>

  This has the advantage that you don't have to hardcode the path to the Pure
  interpreter into the shebang; the <verbatim|/usr/bin/env> utility will
  locate the interpreter for you, provided that it is installed somewhere on
  the system<label|index-10><verbatim|PATH>.

  <paragraph|Compiled Scripts<label|compiled-scripts>>

  Last but not least, you can also turn a Pure script into an executable by
  ``batch-compiling'' it. This works on all supported systems (provided that
  you have the necessary LLVM tools and 3rd party compilers installed, see
  the <hlink|<em|installation instructions>|install.tm> for details). The
  result is a real native executable which can then be run directly just like
  any other binary program on your system. To these ends, the interpreter is
  run with the <hlink|<em|-c>|#cmdoption-pure-c> option which tells it to run
  in batch compilation mode, and the <hlink|<em|-o>|#cmdoption-pure-o> option
  which specifies the desired name of the executable. For instance:

  <\verbatim>
    $ pure -c hello.pure -o hello

    Hello, world!

    $ ./hello

    Hello, world!
  </verbatim>

  You'll notice that the compilation command in the first line above
  <em|also> prints the <verbatim|Hello,> <verbatim|world!> message. This
  reveals a rather unusual aspect of Pure's batch compiler: it actually
  <em|executes> the script even during batch compilation. The reasons for
  this behaviour and potential uses are discussed in the <hlink|Batch
  Compilation|#batch-compilation> section. If you want to suppress the
  program output during batch compilation, you can rewrite the program as
  follows:

  <\verbatim>
    using system;

    main = puts "Hello, world!";

    compiling \|\| main;
  </verbatim>

  Note that here we turned the code to be executed into a separate
  <verbatim|main> function. This isn't really necessary, but often
  convenient, since it allows us to run the code to be executed by just
  evaluating a single function. (Note that in contrast to C, the name
  <verbatim|main> has no special significance in Pure; it's just a function
  like any other. We still have to include a call to this function at the end
  of our program so that it gets executed.)

  The last line now reads <verbatim|compiling> <verbatim|\|\|>
  <verbatim|main> which is a shorthand for ``if the <verbatim|compiling>
  variable is nonzero then do nothing, otherwise evaluate the <verbatim|main>
  function''. In a batch compilation the interpreter sets this variable to a
  nonzero value so that the evaluation of <verbatim|main> is skipped:

  <\verbatim>
    $ pure -c hello.pure -o hello

    $ ./hello

    Hello, world!
  </verbatim>

  We should mention here that batch-compiled scripts have some limitations
  because the compiled executable runs under a trimmed-down runtime system.
  This disables some of the advanced compile time features which are only
  available when running a script with the interpreter or at
  batch-compilation time. However, this won't usually affect run-of-the-mill
  scripts like the one above. More information about this can be found in the
  <hlink|Batch Compilation|#batch-compilation> section.

  <subsubsection|Running the Interpreter<label|running-the-interpreter>>

  While Pure scripts can be run as standalone programs directly from the
  shell, most of the time you'll probably use the Pure interpreter in an
  interactive way. You then simply run it like this:

  <\verbatim>
    $ pure

    \;

    \ __ \\ \ \| \ \ \| \ __\| _ \\ \ \ \ Pure 0.63
    (x86_64-unknown-linux-gnu)

    \ \| \ \ \| \| \ \ \| \| \ \ \ __/ \ \ \ Copyright (c) 2008-2014 by
    Albert Graef

    \ .__/ \\__,_\|_\| \ \\___\| \ \ \ (Type 'help' for help, 'help copying'

    _\| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ for license information.)

    \;

    Loaded prelude from /usr/lib/pure/prelude.pure.

    \;

    \<gtr\>
  </verbatim>

  The interpreter prints its sign-on message and leaves you at its command
  prompt. (You can also try <verbatim|pure> <verbatim|--plain> for a less
  fancy sign-on, or <verbatim|pure> <verbatim|-q> to completely suppress the
  message.)

  At this point you can just start typing definitions and expressions to be
  evaluated. For instance:

  <\verbatim>
    \<gtr\> fact n = if n\<less\>=0 then 1 else n*fact (n-1);

    \<gtr\> map fact (1..10);

    [1,2,6,24,120,720,5040,40320,362880,3628800]
  </verbatim>

  Note that Pure is a free-format language, and thus definitions and
  expressions <em|must> be terminated with a semicolon, so that the
  interpreter knows when you're done entering each item. This probably needs
  getting used to, but it's convenient because you can easily type more than
  one expression on a single line, or split longer constructs across multiple
  lines:

  <\verbatim>
    \<gtr\> 6*7; 16.3805*5.0;

    42

    81.9025

    \<gtr\> 16753418726345

    \<gtr\> * 991726534256718265234;

    16614809890429729930396098173389730L
  </verbatim>

  If the interpreter appears to just eat away expressions without printing
  any results, then most likely you forgot to enter the terminating
  semicolon. In such a case you can just type the semicolon on a line by
  itself:

  <\verbatim>
    \<gtr\> 6*7

    \<gtr\> ;
  </verbatim>

  (This won't do any harm even if it's not needed, because an empty item is
  always valid input at Pure's toplevel.)

  The interpreter also reports syntax errors if you mistype an expression:

  <\verbatim>
    \<gtr\> 16.3805*(5;

    \<less\>stdin\<gtr\>, line 8: syntax error, unexpected ';', expecting
    when or with or ')'
  </verbatim>

  In such a case, just correct the error and resubmit the offending input.
  The interpreter's readline facility makes this pretty convenient, because
  you can use the cursor keys to recall previous input lines and edit them as
  needed.

  Other kinds of errors may happen at runtime, when evaluating a
  syntactically correct expression. These give rise to so-called exceptions.
  For instance:

  <\verbatim>
    \<gtr\> 1 div 0;

    \<less\>stdin\<gtr\>, line 9: unhandled exception 'signal 8' while
    evaluating '1 div 0'
  </verbatim>

  Besides integer division by zero (flagged as `<verbatim|signal>
  <verbatim|8>` here), common sources of exceptions are failed matches and
  conditionals, interrupts (e.g., if the user aborts an evaluation with
  <verbatim|Ctrl-c>) and stack overflows (cf. <hlink|Stack Size and Tail
  Recursion|#stack-size-and-tail-recursion>). Normally these are fatal and
  require you to fix the program or the expression that you entered, but
  programs can also catch these errors and handle them in any desired way,
  cf. <hlink|Exception Handling|#exception-handling>.

  Note that in contrast to most other programming languages, undefined
  identifiers are generally <em|not> an error in Pure. Instead, you'll simply
  get an unevaluated normal form:

  <\verbatim>
    \<gtr\> foo 5;

    foo 5
  </verbatim>

  Therefore, we recommend invoking the interpreter with the
  <hlink|<em|-w>|#cmdoption-pure-w> option so that it at least warns you
  about unknown symbols. You can also enter this option interactively or in a
  script using the <em|--warn> pragma:

  <\verbatim>
    \<gtr\> #! --warn

    \<gtr\> bar 5;

    \<less\>stdin\<gtr\>, line 12: warning: implicit declaration of 'bar'

    bar 5
  </verbatim>

  The interpreter has a global variable environment in which you can store
  intermediate results:

  <\verbatim>
    \<gtr\> let x = 16.3805*5;

    \<gtr\> x; x/2; 1/x;

    81.9025

    40.95125

    0.0122096395103935

    \<gtr\> let y = 2*x; y;

    163.805
  </verbatim>

  Another handy feature is the special built-in function
  <hlink|<with|font-family|tt|ans>|purelib.tm#ans> which yields the most
  recent result printed by the interpreter:

  <\verbatim>
    \<gtr\> 16.3805*5;

    81.9025

    \<gtr\> ans*2;

    163.805
  </verbatim>

  The interpreter recognizes a few other special commands which, like
  <hlink|<with|font-family|tt|ans>|purelib.tm#ans>, are only available when
  it is run interactively. For instance, you can purge the value of a
  variable like this (this also works with any other defined item, such as
  constants, functions and macros):

  <\verbatim>
    \<gtr\> clear x

    \<gtr\> x;

    x
  </verbatim>

  Another useful command is <verbatim|show> which prints the definition of
  anything that you can define in a Pure script, such as variables and
  functions. For instance:

  <\verbatim>
    \<gtr\> show fact

    fact n = if n\<less\>=0 then 1 else n*fact (n-1);
  </verbatim>

  You can also just type <verbatim|show> to print all definitions done
  interactively at the command prompt, which lets us review our
  accomplishments so far:

  <\verbatim>
    \<gtr\> show

    fact n = if n\<less\>=0 then 1 else n*fact (n-1);

    let y = 163.805;
  </verbatim>

  The <verbatim|dump> command saves these definitions in a file for later
  use:

  <\verbatim>
    \<gtr\> dump
  </verbatim>

  This command doesn't print anything, but you can have a look at the written
  file in a text editor and maybe edit it as needed. By default,
  <verbatim|dump> saves interactive definitions in a hidden file named
  <verbatim|.pure> in the current directory, which gets reloaded
  automatically if we later rerun the interpreter in the same directory. We
  can also print this file, e.g., with the Unix <verbatim|cat> command (note
  that `<verbatim|!>` executes a shell command):

  <\verbatim>
    \<gtr\> !cat .pure

    // dump written Wed Sep \ 5 10:00:15 2012

    fact n = if n\<less\>=0 then 1 else n*fact (n-1);

    let y = 163.805;
  </verbatim>

  If we mess up badly, it's often convenient to just rerun the interpreter
  from scratch so that we can try again in a clean environment:

  <\verbatim>
    \<gtr\> run
  </verbatim>

  As we've saved our scribblings with <verbatim|dump> previously, those
  definitions will be reloaded automatically:

  <\verbatim>
    \<gtr\> show

    fact n = if n\<less\>=0 then 1 else n*fact (n-1);

    let y = 163.805;
  </verbatim>

  If you don't want this then you can just remove the <verbatim|.pure> file
  or rename it before invoking <verbatim|run>.

  Another helpful command is <verbatim|help> which brings up the online
  documentation (this requires that you've configured the interpreter for the
  web browser that you use; see <hlink|Online Help|#online-help>):

  <\verbatim>
    \<gtr\> help help
  </verbatim>

  Last but not least, you can use the following command to exit the
  interpreter and return to the command shell:

  <\verbatim>
    \<gtr\> quit
  </verbatim>

  Typing just an end-of-file character (usually <verbatim|Ctrl-d> on
  Unix-like systems) at the beginning of the command line does the same.

  There are a few other built-in commands that you may find useful when
  working with the interpreter, and you can even define your own. These
  interactive commands are special; they have their own syntax and need to be
  typed on a separate line. Please refer to <hlink|Interactive
  Usage|#interactive-usage> for a detailed explanation of the command syntax
  and the available commands.

  <subsubsection|Basic Examples<label|basic-examples>>

  Pure has a few built-in data types, namely numbers (machine integers,
  bigints and double precision floating point numbers), strings, matrices,
  symbols, functions and pointer values. Compound expressions are formed from
  these using function application. In the syntax of the Pure language, these
  are also known as <hlink|simple expressions|#simple-expressions>. For want
  of a catchier name, we also simply call them <with|font-series|bold|terms>.
  Pure is a programming language based on <with|font-series|bold|term
  rewriting>, so all computations performed in Pure consist of the rewriting
  of terms. Some terms may reduce to other terms, others simply stand for
  themselves; the latter are also called <with|font-series|bold|normal forms>
  and are what constitutes a ``value'' in the Pure language.

  When the Pure interpreter starts up, it normally loads a collection of Pure
  scripts collectively called the <with|font-series|bold|prelude>. The
  prelude defines many of the usual operations on numbers, strings, lists and
  other basic data structures that you may need, so you can start using the
  interpreter as a sophisticated kind of desktop calculator right away. Let's
  begin with some simple calculations involving integer and floating point
  numbers:

  <\verbatim>
    \<gtr\> 6*7;

    42

    \<gtr\> 16.3805*5.0;

    81.9025

    \<gtr\> 16753418726345 * 991726534256718265234;

    16614809890429729930396098173389730L
  </verbatim>

  Note that the integer constants in the last example exceeded the 32 bit
  range of machine integers, so they were promoted to bigints. The result is
  again a bigint (indicated by the <verbatim|L> suffix). You can also turn
  <em|any> integer constant into a bigint by explicitly adding the
  <verbatim|L> suffix:

  <\verbatim>
    \<gtr\> 6L*7L;

    42L
  </verbatim>

  Arithmetic with mixed operands will generally return the most general type
  capable of holding the result:

  <\verbatim>
    \<gtr\> 6*7L;

    42L

    \<gtr\> 16.3805*5;

    81.9025

    \<gtr\> 16.3805*5L;

    81.9025
  </verbatim>

  But note that most operations involving only machine integers will produce
  another machine integer; the result is <em|never> promoted to a bigint
  automatically, even in case of ``overflow'' (i.e., wrap-around). So the
  following will yield the same kind of signed 32 bit result as you'd get in
  C:

  <\verbatim>
    \<gtr\> 2147483647 + 1;

    -2147483648
  </verbatim>

  This has the advantage that you always know the type of the result of each
  operation beforehand by just looking at the types of the operands. It also
  makes it possible to compile machine integer operations to efficient native
  code. Therefore, if you suspect that a machine integer operation may wrap
  around and you'd thus prefer to do the calculation with bigints instead,
  you'll have to convert at least one of the operands to a bigint beforehand:

  <\verbatim>
    \<gtr\> 2147483647L + 1;

    2147483648L
  </verbatim>

  Also note that, in contrast to C or Fortran, the result of the
  <hlink|<with|font-family|tt|/>|purelib.tm#/> (division) and
  <hlink|<with|font-family|tt|^>|purelib.tm#?5E> (exponentiation) operators
  is <em|always> a floating point value in Pure, even if both operands are
  integers:

  <\verbatim>
    \<gtr\> 14/12;

    1.16666666666667

    \<gtr\> 2L^60L;

    1.15292150460685e+18
  </verbatim>

  Integer division and modulo are done with the
  <hlink|<with|font-family|tt|div>|purelib.tm#div> and
  <hlink|<with|font-family|tt|mod>|purelib.tm#mod> operators, and exact
  powers of machine integers and bigints can be computed with the
  <hlink|<with|font-family|tt|pow>|purelib.tm#pow> function:

  <\verbatim>
    \<gtr\> 14 div 12; 14 mod 12;

    1

    2

    \<gtr\> pow 2 60;

    1152921504606846976L
  </verbatim>

  Also note that many of the standard math functions are available in a
  separate <hlink|<with|font-family|tt|math>|purelib.tm#module-math> module,
  so we need to import that module if we want to use one of these (see
  <hlink|Modules and Imports|#modules-and-imports> for a detailed explanation
  of Pure's module system). For instance:

  <\verbatim>
    \<gtr\> using math;

    \<gtr\> sqrt (16.3805*5)/.05;

    181.0
  </verbatim>

  The <hlink|<with|font-family|tt|math>|purelib.tm#module-math> module also
  provides you with complex and rational number types for doing more advanced
  calculations, but we won't go into that here.

  Before we proceed, a few remarks about the syntax of function applications
  are in order. Function application is an explicit operation in Pure, so
  that functions become first class values which can be passed around as
  function arguments and results. Like in most modern functional languages,
  function application is simply denoted by juxtaposition:

  <\verbatim>
    \<gtr\> sqrt 2;

    1.4142135623731
  </verbatim>

  In this case, you may also write <verbatim|sqrt(2)> instead, but multiple
  arguments are normally specified as <verbatim|f> <verbatim|x> <verbatim|y>
  <verbatim|z> rather than <verbatim|f(x,y,z)>. The former notation is known
  as <with|font-series|bold|currying> (named after the American mathematician
  and logician Haskell B. Curry), and is ubiquitous in modern functional
  programming languages. The latter notation can be used in Pure as well, but
  it actually indicates that <verbatim|f> is called on a <em|single>,
  structured argument (in this case a tuple). However, most predefined
  functions use the curried notation in Pure. For instance, the
  <hlink|<with|font-family|tt|max>|purelib.tm#max> function defined in the
  prelude takes two separate arguments, so it is invoked as follows:

  <\verbatim>
    \<gtr\> max 4 7;

    7
  </verbatim>

  Function application associates to the left, so the above is parsed as
  <verbatim|(max> <verbatim|4)> <verbatim|7>, where <verbatim|max>
  <verbatim|4> is called a <with|font-series|bold|partial application> of the
  <hlink|<with|font-family|tt|max>|purelib.tm#max> function. A partial
  application is a function in its own right; e.g., <verbatim|max>
  <verbatim|4> denotes the function which computes <verbatim|max>
  <verbatim|4> <verbatim|y> for each given <verbatim|y>.

  Parentheses are used for grouping expressions as usual. In particular,
  since function application associates to the left, a nested function
  application in a function argument must be parenthesized as follows:

  <\verbatim>
    \<gtr\> sqrt (sqrt 2);

    1.18920711500272
  </verbatim>

  The same is true for any kind of expression involving operators, since
  function application binds stronger than any of these:

  <\verbatim>
    \<gtr\> sqrt (2*3);

    2.44948974278318
  </verbatim>

  The <hlink|<with|font-family|tt|map>|purelib.tm#map> function lets us apply
  a function to each member of a given list, which gives us a quick way of
  tabulating function values:

  <\verbatim>
    \<gtr\> map sqrt (0..2);

    [0.0,1.0,1.4142135623731]
  </verbatim>

  Here, the list argument is specified as an
  <with|font-series|bold|arithmetic sequence> <verbatim|0..2> which evaluates
  to the list <verbatim|[0,1,2]>. This is fairly convenient when tabulating
  values of numeric functions. Here is another example which employs a
  partial application of the <hlink|<with|font-family|tt|max>|purelib.tm#max>
  function as the function argument:

  <\verbatim>
    \<gtr\> map (max 0) (-3..3);

    [0,0,0,0,1,2,3]
  </verbatim>

  Note that when the <verbatim|max> <verbatim|0> function gets applied, say,
  to the first list member <verbatim|-3>, we obtain the application
  <verbatim|max> <verbatim|0> <verbatim|(-3)> which now has all the arguments
  that it needs; we also say that <verbatim|max> <verbatim|0> <verbatim|(-3)>
  is a <with|font-series|bold|saturated> application, which means that it's
  ``ready to go''. Evaluating <verbatim|max> <verbatim|0> <verbatim|(-3)>
  gives <verbatim|0> which becomes the first member of the result list
  returned by <verbatim|map>. The other list members are calculated in an
  analogous fashion. It is easy to see that <verbatim|max> <verbatim|0> thus
  computes what mathematicians call the ``positive part'' of its argument
  <verbatim|x>, which is <verbatim|x> itself if it is greater than
  <verbatim|0> and <verbatim|0> otherwise.

  Operators aren't special either, they are just functions in disguise. You
  can turn any operator into an ordinary function by enclosing it in
  parentheses. Thus <verbatim|(+)> denotes the function which adds its two
  arguments, and <verbatim|x+1> can also be written as <verbatim|(+)>
  <verbatim|x> <verbatim|1>; in fact, the former expression is nothing but
  syntactic sugar for the latter. You can easily verify this in the
  interpreter:

  <\verbatim>
    \<gtr\> (+) x 1;

    x+1
  </verbatim>

  You can also have partial applications of operators like <verbatim|(*)>
  <verbatim|2> which denotes a function which doubles its argument:

  <\verbatim>
    \<gtr\> map ((*) 2) [1,2,3,4,5];

    [2,4,6,8,10]
  </verbatim>

  Moreover, Pure offers some convenient syntactic sugar to denote so-called
  <with|font-series|bold|operator sections> which specify a binary operator
  with only either its left or right operand. So the doubling function above
  may also be denoted as <verbatim|(2*)> or <verbatim|(*2)>. Similarly,
  <verbatim|(+1)> denotes the ``increment by 1'' and <verbatim|(1/)> the
  reciprocal function:

  <\verbatim>
    \<gtr\> map (+1) (1..5);

    [2,3,4,5,6]

    \<gtr\> map (1/) (1..5);

    [1.0,0.5,0.333333333333333,0.25,0.2]
  </verbatim>

  Note that the latter kind of section (also called a
  <with|font-series|bold|left section>) is just a convenient shorthand for a
  partial application:

  <\verbatim>
    \<gtr\> (1/);

    (/) 1
  </verbatim>

  The former kind (a <with|font-series|bold|right section>) can't be handled
  this way, because it's the <em|first> operand which is missing, and partial
  applications only allow you to omit trailing arguments. Instead, right
  sections expand to a partial application of the
  <hlink|<with|font-family|tt|flip>|purelib.tm#flip> function,

  <\verbatim>
    \<gtr\> (+1);

    flip (+) 1
  </verbatim>

  which is defined in the prelude as follows:

  <\verbatim>
    flip f x y = f y x;
  </verbatim>

  Note that <verbatim|flip> <verbatim|(+)> <verbatim|1> thus denotes a
  function which, when the missing operand is supplied, reduces to an
  application of the first (function) argument while also flipping around the
  operands. For another example, here's how you can compute third powers
  <verbatim|3^x> of some numbers <verbatim|x> with a right section of the
  `<hlink|<with|font-family|tt|^>|purelib.tm#?5E>` operator:

  <\verbatim>
    \<gtr\> map (^3) (1..5);

    [1.0,8.0,27.0,64.0,125.0]
  </verbatim>

  Note that this is exactly the same as:

  <\verbatim>
    \<gtr\> map (flip (^) 3) (1..5);

    [1.0,8.0,27.0,64.0,125.0]
  </verbatim>

  Such explicit applications of <hlink|<with|font-family|tt|flip>|purelib.tm#flip>
  also work with ordinary functions like <hlink|<with|font-family|tt|pow>|purelib.tm#pow>,
  so if we want to compute the cubes as exact bigint numbers, we can also
  write:

  <\verbatim>
    \<gtr\> map (flip pow 3) (1..5);

    [1L,8L,27L,64L,125L]
  </verbatim>

  Note the difference between <verbatim|flip> <verbatim|pow> <verbatim|3>
  which computes third powers, and <verbatim|pow> <verbatim|3> which is a
  partial application that computes powers of 3.

  Sometimes it is convenient to have function application as an explicit
  operation which can be passed as a function value to other functions. The
  <hlink|<with|font-family|tt|$>|purelib.tm#-dollar> operator is provided for
  this purpose. <verbatim|f> <verbatim|$> <verbatim|x> is just <verbatim|f>
  <verbatim|x>, so you can write, e.g.:

  <\verbatim>
    \<gtr\> map ($1) [(+2),(*2),(/2)];

    [3,2,0.5]
  </verbatim>

  Recall that <verbatim|($1)> is a right section which, when applied to an
  argument <verbatim|f>, evaluates to <verbatim|f> <verbatim|$> <verbatim|1>
  <verbatim|=> <verbatim|f> <verbatim|1>. E.g., we have that <verbatim|($1)>
  <verbatim|(+2)> <verbatim|=> <verbatim|(+2)> <verbatim|$> <verbatim|1>
  <verbatim|=> <verbatim|(+2)> <verbatim|1> <verbatim|=> <verbatim|1+2>
  <verbatim|=> <verbatim|3>. Hence the above expression actually applies a
  list of functions to the given argument <verbatim|1>.

  The <hlink|<with|font-family|tt|$>|purelib.tm#-dollar> operator has a low
  precedence and is right-associative, so that it is sometimes used to
  eliminate the parentheses in cascading function calls. For instance,
  <verbatim|sqrt> <verbatim|$> <verbatim|sqrt> <verbatim|$> <verbatim|2*3> is
  the same as <verbatim|sqrt> <verbatim|(sqrt> <verbatim|(2*3))>.

  Another convenient operation for combining functions is the function
  composition operator, denoted `<hlink|<with|font-family|tt|.>|purelib.tm#.>`.
  It applies two functions in sequence, so that <verbatim|(f.g)> <verbatim|x>
  evaluates to <verbatim|f> <verbatim|(g> <verbatim|x)>. For instance:

  <\verbatim>
    \<gtr\> g x = 2*x-1;

    \<gtr\> map g (-3..3);

    [-7,-5,-3,-1,1,3,5]

    \<gtr\> map (max 0 . g) (-3..3);

    [0,0,0,0,1,3,5]
  </verbatim>

  Operations like `<hlink|<with|font-family|tt|.>|purelib.tm#.>`, which take
  functions as arguments and return other functions as results, are also
  called <with|font-series|bold|higher-order functions>. We'll have a closer
  look at these later.

  As already mentioned, the interpreter also has a global variable
  environment in which you can store arbitrary expression values. This
  provides a means to define abbreviations for frequently-used expressions
  and for storing intermediate results. Global variable definitions are done
  with <hlink|<with|font-family|tt|let>|#let>. For instance:

  <\verbatim>
    \<gtr\> let x = 16.3805*5;

    \<gtr\> x;

    81.9025
  </verbatim>

  As we've explained above, functions are first-class citizens and can thus
  be assigned to variables as well:

  <\verbatim>
    \<gtr\> let f = sqrt;

    \<gtr\> f x/0.05;

    181.0
  </verbatim>

  The value of a global variable can be changed at any time. So we can type:

  <\verbatim>
    \<gtr\> let f = sin;

    \<gtr\> f x/0.05;

    4.38588407225469
  </verbatim>

  You can also bind several variables at once by using an expression
  <with|font-series|bold|pattern> as the left-hand side of a variable
  definition. This is useful if we need to extract elements from an aggregate
  value such as a list:

  <\verbatim>
    \<gtr\> let x1:x2:xs = map (^3) (1..5);

    \<gtr\> x1,x2,xs;

    1.0,8.0,[27.0,64.0,125.0]
  </verbatim>

  Pure also provides a kind of ``read-only'' variables a.k.a.
  <with|font-series|bold|constants>. They are defined pretty much like global
  variables (using the <hlink|<with|font-family|tt|const>|#const> keyword in
  lieu of <hlink|<with|font-family|tt|let>|#let>), but work more like a
  parameterless function whose value is precomputed at compile time:

  <\verbatim>
    \<gtr\> const \\ensuremath{\\pi} = 4*atan 1.0;

    \<gtr\> show \\ensuremath{\\pi}

    const \\ensuremath{\\pi} = 3.14159265358979;

    \<gtr\> h x = sin (2*\\ensuremath{\\pi}*x);

    \<gtr\> show h

    h x = sin (6.28318530717959*x);

    \<gtr\> map h [-1/4,-1/8,0,1/8,1/4];

    [-1.0,-0.707106781186547,0.0,0.707106781186547,1.0]
  </verbatim>

  Note that the compiler normally computes constant subexpressions at compile
  time, such as <verbatim|2*\\ensuremath{\\pi}> in the function <verbatim|h>.
  This works with all simple scalars (machine ints and doubles), see
  <hlink|Constant Definitions|#constant-definitions> for details.

  As an aside, the last example also shows that Pure has no problems with
  Unicode. <verbatim|<ensuremath{\\pi}>> is a Greek letter and thus an
  identifier as good as any other, although you will have a hard time finding
  that letter on an English keyboard. Fortunately, most operating systems
  nowadays provide you with an applet that lets you enter foreign language
  characters and other special symbols with ease.

  <subsubsection|Defining Functions<label|defining-functions>>

  Now that we've learned how to run the interpreter and evaluate some
  expressions, it's time to embark on some real programming. Like in other
  functional programming languages, we do this by defining
  <with|font-series|bold|functions> which perform the desired computation.
  The form these definitions take in Pure is a collection of
  <with|font-series|bold|rewriting rules> which specify how an application of
  the function reduces to another expression which then gets evaluated
  recursively to give the value of the function application.

  In the simplest case, the left-hand side of a rewriting rule may just
  specify the function name along with some argument names. For instance:

  <\verbatim>
    square x = x*x;
  </verbatim>

  Now, if we evaluate an expression like <verbatim|square> <verbatim|7>, it
  reduces to <verbatim|7*7> which in turn reduces to <verbatim|49> by the
  built-in rules for integer arithmetic. You can verify this by entering the
  definition in the interpreter:

  <\verbatim>
    \<gtr\> square x = x*x;

    \<gtr\> square 7;

    49
  </verbatim>

  In fact, the above definition is completely generic; since <verbatim|x> is
  an unqualified variable, we can apply <verbatim|square> to <em|any> value
  <verbatim|x> and have it evaluate to <verbatim|x*x>:

  <\verbatim>
    \<gtr\> square 7.0;

    49.0

    \<gtr\> square 7L;

    49L

    \<gtr\> square (a+b);

    (a+b)*(a+b)
  </verbatim>

  As the last example shows, this will even work if the supplied argument is
  no number at all, which is useful, e.g., if we want to do symbolic
  evaluations.

  Functions can have as many arguments as you like, subject to the constraint
  that each equation defining the function has the <em|same> number of
  arguments on the left-hand side. For instance, suppose that we want to
  calculate the sum of two squares. We can do this using the
  <verbatim|square> function from above as follows:

  <\verbatim>
    \<gtr\> sumsquares x y = square x + square y;

    \<gtr\> sumsquares 3 4;

    25
  </verbatim>

  The interpreter keeps track of the number of arguments of each defined
  function, so if we accidentally try to define <verbatim|sumsquares> with
  three arguments later then we'll get an error message:

  <\verbatim>
    \<gtr\> sumsquares x y z = square x + square y + square z;

    \<less\>stdin\<gtr\>, line 8: function 'sumsquares' was previously
    defined with 2 args
  </verbatim>

  This actually makes perfect sense if you think about the way curried
  function applications work. If the above was permitted, then an expression
  like <verbatim|sumsquares> <verbatim|x> <verbatim|y> would become ambiguous
  (would it denote an invocation of the binary <verbatim|sumsquares> or a
  partial application of the ternary one?).

  Thus Pure doesn't really have <with|font-series|bold|variadic> functions
  which take a variable number of arguments. There are ways to emulate this
  behaviour in some cases, but usually it's easier to just pass the arguments
  as a single structured value instead. It is customary to employ tuples for
  this purpose, so that the call uses the familiar notation <verbatim|f>
  <verbatim|(x,y,z)>. A typical example are optional arguments. For instance,
  suppose that we'd like to define a function <verbatim|incr> which
  increments a numeric value, where the amount to be added can be specified
  as an optional second value which defaults to 1. This can be done in Pure
  as follows:

  <\verbatim>
    incr (x,y) = x+y;

    incr x = x+1 otherwise;
  </verbatim>

  These equations <em|must> be in the indicated order. Pure considers
  different equations for the same function in the order in which they are
  written. Therefore ``special case'' rules, like the one for <verbatim|incr>
  <verbatim|(x,y)> in this example, must be listed first. (Note that if the
  second equation came first, <verbatim|incr> <verbatim|(5,2)> would reduce
  to <verbatim|(5,2)+1> rather than <verbatim|5+2>, because <verbatim|x> also
  matches, in particular, any tuple <verbatim|x,y>.)

  Functions taking a single tuple argument are also (somewhat misleadingly)
  called <with|font-series|bold|uncurried> functions, because their arguments
  have to be given all in one go, which precludes partial applications of the
  function. While curried functions are often preferred, uncurried functions
  can be more convenient at times, e.g., if you have to map a function to a
  list containing given combinations of arguments. For instance, given the
  above definition of <verbatim|incr> we may write:

  <\verbatim>
    \<gtr\> map incr [(5,1),(5,2),(6,3),(7,5)];

    [6,7,9,12]
  </verbatim>

  To make this work with curried functions, the prelude provides a function
  <hlink|<with|font-family|tt|uncurry>|purelib.tm#uncurry> which turns a
  curried function of two arguments into an uncurried one which takes a
  single tuple argument:

  <\verbatim>
    \<gtr\> map (uncurry (+)) [(5,1),(5,2),(6,3),(7,5)];

    [6,7,9,12]
  </verbatim>

  On the other hand, some generic list processing functions such as
  <hlink|<with|font-family|tt|foldl>|purelib.tm#foldl> expect curried
  functions, so the reverse transformation
  <hlink|<with|font-family|tt|curry>|purelib.tm#curry> is also provided:

  <\verbatim>
    \<gtr\> foldl (curry incr) 0 (1..10);

    55
  </verbatim>

  In fact, the definitions of <verbatim|curry> and <verbatim|uncurry> don't
  involve any special magic, they just translate curried calls to uncurried
  ones and vice versa. From the horse's mouth:

  <\verbatim>
    \<gtr\> show curry uncurry

    curry f x y = f (x,y);

    uncurry f (x,y) = f x y;
  </verbatim>

  A function can also have zero arguments, i.e., you can define parameterless
  functions such as:

  <\verbatim>
    foo = 1..3;
  </verbatim>

  The function is then simply invoked without any arguments:

  <\verbatim>
    \<gtr\> foo;

    [1,2,3]
  </verbatim>

  It is worth noting the difference between this and the variable definition:

  <\verbatim>
    let bar = 1..3;
  </verbatim>

  While <verbatim|bar> and <verbatim|foo> yield the same result
  <verbatim|[1,2,3]>, they do so in different ways. <verbatim|bar> is a
  global variable whose value is computed once and then stored under its
  name, so that the value can be simply recalled when <verbatim|bar> is later
  invoked in an expression. Also, the value of <verbatim|bar> can be changed
  at any time with an appropriate <hlink|<with|font-family|tt|let>|#let>
  statement. (If the value is not supposed to change later then you can also
  define it as a <hlink|<with|font-family|tt|const>|#const> instead.)

  In contrast, <verbatim|foo> is a function which recomputes the list value
  on each invocation. To avoid the overhead of recalculating the same value
  each time it is needed, a variable or constant is usually preferred over a
  parameterless function in Pure. However, a parameterless function will be
  needed if the computation involves some hidden side effects which cause a
  new value to be produced for each invocation. For instance, the
  <hlink|<with|font-family|tt|math>|purelib.tm#module-math> module provides a
  parameterless function <hlink|<with|font-family|tt|random>|purelib.tm#random>
  which computes a new pseudo random number each time it is called:

  <\verbatim>
    \<gtr\> using math;

    \<gtr\> random, random, random;

    -795755684,581869302,-404620562
  </verbatim>

  Many functions also involve conditionals which let them take different
  computation paths depending on the outcome of a condition. One way to do
  this is to employ a <with|font-series|bold|conditional expression>. For
  instance, we may compute the sign of a number as follows:

  <\verbatim>
    \<gtr\> sign x = if x\<gtr\>0 then 1 else if x\<less\>0 then -1 else 0;

    \<gtr\> map sign (-3..3);

    [-1,-1,-1,0,1,1,1]
  </verbatim>

  Alternatively, you can also use a collection of
  <with|font-series|bold|conditional rules> instead:

  <\verbatim>
    sign x = \ 1 if x\<gtr\>0;

    \ \ \ \ \ \ \ = -1 if x\<less\>0;

    \ \ \ \ \ \ \ = \ 0 otherwise;
  </verbatim>

  Note that here we omitted the left-hand side in the second and third
  equations, in which case the compiler assumes that it's the same as for the
  first equation; cf. <hlink|Rule Syntax|#rule-syntax> for details. Also note
  that the <hlink|<with|font-family|tt|otherwise>|#otherwise> keyword is only
  syntactic sugar in Pure, you can always omit it. However, it tends to
  improve readability by marking the default case of a definition.

  Both styles are frequently used in Pure programs; it depends on the
  situation which one is more appropriate. Conditional rules make the
  conditions stick out more clearly and hence tend to improve readability. On
  the other hand, conditional expressions can be nested more easily and thus
  facilitate the programming of complicated decision trees.

  Function definitions may also be recursive, i.e., a function may invoke
  itself either directly or indirectly in its definition. For instance, here
  is a definition of the Ackerman function using conditional rules:

  <\verbatim>
    ack x y = y+1 if x == 0;

    \ \ \ \ \ \ \ \ = ack (x-1) 1 if y == 0;

    \ \ \ \ \ \ \ \ = ack (x-1) (ack x (y-1)) otherwise;
  </verbatim>

  We will have more to say about recursive functions later; see
  <hlink|Recursion|#recursion> below.

  <subsubsection|Pattern Matching<label|pattern-matching>>

  So far we have only seen function definitions involving just unqualified
  variables as parameters. In general it is possible to specify arbitrary
  <hlink|patterns|#patterns> for the parameters, in which case the actual
  arguments are checked against the patterns and, if everything matches up,
  the right-hand side of the rule is invoked with the variables in the
  patterns bound to their corresponding values.

  The simplest nontrivial patterns are <hlink|type tags|#type-tags> which can
  be placed on a variable to restrict the type of value an argument can
  match. For instance:

  <\verbatim>
    \<gtr\> square x::int = x*x;

    \<gtr\> square 7;

    49
  </verbatim>

  Note that in contrast to our previous generic definition of the
  <verbatim|square> function we gave in <hlink|Defining
  Functions|#defining-functions>, this definition now only applies to the
  case of an <verbatim|int> argument:

  <\verbatim>
    \<gtr\> square 7.0;

    square 7.0
  </verbatim>

  Polymorphic definitions can be made by giving separate equations for the
  different argument types. For instance, we can easily add an equation for
  the <verbatim|double> case:

  <\verbatim>
    \<gtr\> square x::double = x*x;

    \<gtr\> show square

    square x::int = x*x;

    square x::double = x*x;

    \<gtr\> square 7; square 7.0;

    49

    49.0
  </verbatim>

  Here the right-hand sides of both rules are the same. Pure has a convenient
  shorthand notation for this case which lets you factor out the common
  right-hand side using the `<verbatim|\|>` delimiter as follows:

  <\verbatim>
    square x::int \| square x::double = x*x;
  </verbatim>

  The compiler expands this to the same two rules as above:

  <\verbatim>
    square x::int = x*x;

    square x::double = x*x;
  </verbatim>

  Let's compare this to our earlier generic definition of <verbatim|square>:

  <\verbatim>
    square x = x*x;
  </verbatim>

  There are two different kinds of polymorphism at work here. The latter,
  generic definition is an example of <with|font-series|bold|parametric
  polymorphism>; it applies to <em|any> type of argument <verbatim|x>
  whatsoever (at least if it makes sense to multiply a member of the type
  with itself). Also note that this definition is ``closed''; because
  equations are considered in the order in which they are written, there's no
  way you could add another ``special case'' rule to this definition later.

  In contrast, the former definition leaves any application of
  <verbatim|square> to a value other than <verbatim|int> or <verbatim|double>
  undefined. This gives us the opportunity to define <verbatim|square> on as
  many types of arguments as we like, and (this is the crucial point) define
  the function in <em|different> ways for different argument types. This is
  also known as <with|font-series|bold|ad-hoc polymorphism> or
  <with|font-series|bold|function overloading>. For instance, if we later
  need to square 2x2 matrices, we might add a rule like:

  <\verbatim>
    square {a,b;c,d} = {a*a+b*c,a*b+b*d;c*a+d*c,c*b+d*d};
  </verbatim>

  Pure places no restriction on the number of equations used to define a
  function, and the different equations may in fact be scattered out over
  many different places. So as long as the left-hand side patterns properly
  discriminate between the different cases, you can overload any operation in
  Pure to handle as many argument types as you want. However, it is important
  to note that in contrast to overloaded functions in statically typed
  languages such as C++, there's really only <em|one> <verbatim|square>
  function here which handles all the different argument types. The necessary
  ``dispatching'' to select the proper rewriting rule for the argument values
  at hand is done at runtime by pattern matching.

  Parametric polymorphism has the advantage that it lets you define
  polymorphic functions in a very concise way. On the other hand, ad-hoc
  polymorphism lets you deal with disparate cases of an operation which
  cannot easily be reconciled. It also allows you to tailor the definition to
  the specific case at hand, which might be more efficient than using a
  generic rule. You can also combine both approaches, but in this case you
  have to list the special case rules before the generic ones. For instance:

  <\verbatim>
    square x::int \| square x::double \|

    square x = x*x;
  </verbatim>

  (Note that the first two rules are just specialization of the last rule to
  <verbatim|int> and <verbatim|double> arguments, so we could in fact
  eliminate the special case rules here and still get the same results. But
  the type tags tell the compiler that the argument in these rules is always
  an <verbatim|int> or <verbatim|double>, respectively, so it may generate
  more efficient code for these cases.)

  Patterns may also involve constant values, in which case the constant must
  be matched literally in the argument. For instance, here is another
  definition of the Ackerman function from <hlink|Defining
  Functions|#defining-functions> which uses constant argument patterns
  instead of conditional rules:

  <\verbatim>
    ack 0 y = y+1;

    ack x 0 = ack (x-1) 1;

    ack x y = ack (x-1) (ack x (y-1)) otherwise;
  </verbatim>

  The first two rules take care of the ``base cases'' <verbatim|x==0> and
  <verbatim|y==0>. Note that these rules <em|must> be given in the indicated
  order to make them work. Specifically, the left-hand side <verbatim|ack>
  <verbatim|x> <verbatim|y> of the last equation also matches, in particular,
  terms like <verbatim|ack> <verbatim|0> <verbatim|y> and <verbatim|ack>
  <verbatim|x> <verbatim|0>, so placing the last equation before the first
  two will ``shadow'' those rules and cause non-termination, resulting in a
  stack overflow. Similarly, placing the second equation before the first one
  will cause the definition to loop on <verbatim|ack> <verbatim|0>
  <verbatim|0>.

  Another point that deserves mentioning here is that constants on the
  left-hand side of a rule <em|must> be matched literally, cf.
  <hlink|Constant Patterns|#constant-patterns>. E.g., <verbatim|ack>
  <verbatim|0> <verbatim|y> only matches if the first argument is really
  <verbatim|0>, not <verbatim|0.0> or <verbatim|0L> (although these compare
  equal to <verbatim|0>). So the above definition of <verbatim|ack> isn't
  quite the same as our previous definition from <hlink|Defining
  Functions|#defining-functions>. If you wanted the definition above to also
  work with double and bigint values, you'd have to add corresponding rules
  for the <verbatim|0.0> and <verbatim|0L> cases.

  Last but not least, patterns are also used to ``deconstruct'' structured
  values like lists, tuples and matrices, binding variables to the component
  values. For instance, to compute the sum of a list of values, you may
  write:

  <\verbatim>
    \<gtr\> sum [] = 0;

    \<gtr\> sum (x:xs) = x+sum xs;

    \<gtr\> sum (1..100);

    5050
  </verbatim>

  This definition works in a straightforward recursive manner. The first rule
  involves the constant pattern <verbatim|[]> and thus handles the base case
  of an empty list, in which case the sum is zero. The second rule has a
  structured argument pattern <verbatim|x:xs> which denotes a list with head
  element <verbatim|x> and tail <verbatim|xs>; in this case the result is
  <verbatim|x> added to the sum of the remaining list elements <verbatim|xs>.
  (In fact, this computational pattern is so common that the prelude provides
  a family of functions such as <hlink|<with|font-family|tt|foldl>|purelib.tm#foldl>
  and <hlink|<with|font-family|tt|foldr>|purelib.tm#foldr> to do this kind of
  operation in a generic way. Our <verbatim|sum> function above is actually
  equivalent to <verbatim|foldr> <verbatim|(+)> <verbatim|0>, see <hlink|List
  Processing|#list-processing> below for details.)

  Instead of placing the patterns directly into the left-hand sides of the
  function definition, you might also do the necessary pattern-matching in
  the right hand side, by employing a <hlink|<with|font-family|tt|case>|#case>
  expression:

  <\verbatim>
    sum xs = case xs of [] = 0; x:xs = x+sum xs end;
  </verbatim>

  This works a bit different, though, since a
  <hlink|<with|font-family|tt|case>|#case> expression raises an exception if
  the target expression is not matched (cf. <hlink|Patterns|#patterns>):

  <\verbatim>
    \<gtr\> sum (1:2:xs);

    \<less\>stdin\<gtr\>, line 2: unhandled exception 'failed_match' while
    evaluating 'sum (1:2:xs)'
  </verbatim>

  To avoid that, you may want to add a type tag, which ensures that the
  argument of <verbatim|sum> is of the proper type:

  <\verbatim>
    sum xs::list = case xs of [] = 0; x:xs = x+sum xs end;
  </verbatim>

  Now the case of an improper list is handled a bit more gracefully, yielding
  the same normal form expression you'd get with the first definition of
  <verbatim|sum> above:

  <\verbatim>
    \<gtr\> sum (1:2:xs);

    1+(2+sum xs)
  </verbatim>

  Pure also allows to define <verbatim|sum> in a more traditional way which
  will be familiar to Lisp programmers (note that
  <hlink|<with|font-family|tt|head>|purelib.tm#head> and
  <hlink|<with|font-family|tt|tail>|purelib.tm#tail> correspond to Lisp's
  ``car'' and ``cdr''):

  <\verbatim>
    sum xs::list = if null xs then 0 else head xs + sum (tail xs);
  </verbatim>

  Choosing one or the other is again a question of style. However, if you're
  dealing with concrete data structures such as lists, pattern-matching
  definitions are often more convenient and easier to understand.

  Pattern matching also works with user-defined constructors (cf. <hlink|Data
  Types|#data-types>). For instance, here's how to implement an insertion
  operation which can be used to construct a binary tree data structure
  useful for sorting and searching:

  <\verbatim>
    nonfix nil;

    \;

    insert nil y \ \ \ \ \ \ \ \ = bin y nil nil;

    insert (bin x L R) y = bin x (insert L y) R if y\<less\>x;

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ = bin x L (insert R y)
    otherwise;
  </verbatim>

  Note that <verbatim|nil> needs to be declared as a
  <hlink|<with|font-family|tt|nonfix>|#nonfix> symbol here, so that the
  compiler doesn't mistake it for a variable; see <hlink|The ``Head =
  Function'' Rule|#the-head-function-rule> for details. The following example
  illustrates how the above definition may be used to obtain a binary tree
  data structure from a list:

  <\verbatim>
    \<gtr\> tree [] = nil;

    \<gtr\> tree (x:xs) = insert (tree xs) x;

    \<gtr\> tree [7,12,9,5];

    bin 5 nil (bin 9 (bin 7 nil nil) (bin 12 nil nil))
  </verbatim>

  Conversely, it's also easy to convert such a tree structure back to a list.
  We can then combine these operations to sort a list in ascending order:

  <\verbatim>
    \<gtr\> list nil = [];

    \<gtr\> list (bin x L R) = list L + (x:list R);

    \<gtr\> list (tree [7,12,9,5]);

    [5,7,9,12]
  </verbatim>

  <subsubsection|Local Functions and Variables<label|local-functions-and-variables>>

  Up to this point our examples only involved global functions and variables.
  When the problems to be solved become more difficult, it will be necessary
  to structure the solution in some way, so that you'll often end up with
  many small functions which need to work in concert to solve the problem at
  hand. Typically only a few of these functions will serve as actual entry
  points, while other functions are only to be used internally. Pure supports
  this through <with|font-series|bold|local> functions and variables whose
  scope is limited either to the right-hand side of a rule or one of its
  subexpression. This offers two main advantages:

  <\itemize>
    <item>Local functions and variables are hidden from the main scope so
    that they can only be used in the context where they are needed and don't
    clutter up the global environment. This provides a way to define
    functions in a modular fashion while hiding internal details from the
    rest of the program.

    <item>The right-hand sides of local definitions have full access to other
    local functions and variables in their parent environments, which
    eliminates the ``plumbing'' which would otherwise be needed to pass these
    values around. For instance, a local function nested in another function
    can freely access the parent function's arguments and other local
    variables in its scope.
  </itemize>

  Local functions are defined using the <hlink|<with|font-family|tt|with>|#with>
  construct, while local variables can be introduced with a
  <hlink|<with|font-family|tt|when>|#when> or
  <hlink|<with|font-family|tt|case>|#case> expression, see <hlink|Special
  Expressions|#special-expressions> for details. These constructs can be
  tacked on to any expression, and they can also be nested. For instance:

  <\verbatim>
    \<gtr\> f 5 with f x = y+y when y = x*x end end;

    50
  </verbatim>

  Note that the local function <verbatim|f> there computes twice the square
  of its argument <verbatim|x>. To these ends, first <verbatim|x*x> is
  assigned to the local variable <verbatim|y> whose value is then doubled by
  computing <verbatim|y+y> which becomes the result of <verbatim|f>.

  Local functions can also be created without actually naming them, by
  employing a so-called <with|font-series|bold|lambda abstraction>. For
  instance, a function which squares its argument might be denoted as
  <verbatim|<x>> <verbatim|-\>> <verbatim|x*x>. This is pretty much the same
  as a local function <verbatim|f> <verbatim|with> <verbatim|f> <verbatim|x>
  <verbatim|=> <verbatim|x*x> <verbatim|end> except that the function remains
  nameless. This notation is pretty convenient for making up little
  ``one-off'' functions which are to be applied on the spot or passed as
  function arguments or results to other functions. For instance, here's how
  you can compute the first ten squares, first with an ordinary (named) local
  function, and then with an equivalent lambda:

  <\verbatim>
    \<gtr\> map f (1..10) with f x = x*x end;

    [1,4,9,16,25,36,49,64,81,100]

    \<gtr\> map (\\x -\<gtr\> x*x) (1..10);

    [1,4,9,16,25,36,49,64,81,100]
  </verbatim>

  For obvious reasons lambdas work best for non-recursive functions. While
  there are techniques to create recursive functions out of lambdas using
  so-called fixed point combinators (cf. <hlink|<with|font-family|tt|fix>|purelib.tm#fix>),
  named functions are much more convenient for that purpose.

  <hlink|Pattern matching|#pattern-matching> works in local definitions as
  usual. For instance, here are several ways to swap two values represented
  as a tuple, using either a local function or a
  <hlink|<with|font-family|tt|when>|#when> or
  <hlink|<with|font-family|tt|case>|#case> expression:

  <\verbatim>
    \<gtr\> swap (1,2) with swap (x,y) = y,x end;

    2,1

    \<gtr\> (\\(x,y) -\<gtr\> y,x) (1,2);

    2,1

    \<gtr\> y,x when x,y = 1,2 end;

    2,1

    \<gtr\> case 1,2 of x,y = y,x end;

    2,1
  </verbatim>

  You'll also frequently find code like the following, where a global
  ``wrapper'' function just sets up some initial parameter values and then
  invokes a local ``worker'' function which does all the real work. The
  following function calculates the sum of the positive integers up to
  <verbatim|n> (the ``accumulating parameters'' technique used in this
  example will be explained later, cf. <hlink|Recursion|#recursion>).

  <\verbatim>
    sum n = sum 0 n with

    \ \ sum s n = s if n \<less\> 0;

    \ \ \ \ \ \ \ \ \ \ = sum (s+n) (n-1) otherwise;

    end;
  </verbatim>

  Note that there are actually <em|two> separate functions named
  <verbatim|sum> here. This works because according to the <hlink|scoping
  rules|#scoping-rules> the right-hand side of the global definition is under
  the scope of the <hlink|<with|font-family|tt|with>|#with> clause, and thus
  the call <verbatim|sum> <verbatim|0> <verbatim|n> on the right-hand refers
  to the <em|local> <verbatim|sum> function, not the global one. (While it is
  perfectly correct and even makes sense in this example, this style may be
  somewhat confusing, so we often prefer to give wrapper and worker different
  names for clarity.)

  As discussed in <hlink|Scoping Rules|#scoping-rules>, a local function can
  refer to other local functions and variables in its parent environments. It
  can also be returned as a function value, which is where things get really
  interesting. The local function value then becomes a
  <with|font-series|bold|lexical closure> which carries around with it the
  local variable environment it was created in. For instance:

  <\verbatim>
    \<gtr\> adder x = add with add y = x+y end;

    \<gtr\> let g = adder 5; g; map g (1..5);

    add

    [6,7,8,9,10]
  </verbatim>

  Note that here the local function <verbatim|add> refers to the argument
  value <verbatim|x> of its parent function <verbatim|adder>. The invocation
  <verbatim|adder> <verbatim|5> thus returns an instance of <verbatim|add>
  which has <verbatim|x> bound to the value <verbatim|5>, so that
  <verbatim|add> <verbatim|y> reduces to <verbatim|5+y> for each
  <verbatim|y>. This works as if this instance of the <verbatim|add> closure
  had an invisible <verbatim|x> argument of <verbatim|5> attached to it. (And
  this is in fact how closures are implemented internally, using a
  transformation called <hlink|lambda lifting|http://en.wikipedia.org/wiki/Lambda-lifting>
  which effectively turns local functions into global ones.) You should study
  this example carefully until you fully understand how it works; we'll see a
  bunch of other, more complicated examples of this kind later.

  Lexical closures also provide a means to encapsulate data in a way
  reminiscent of object-oriented programming. For instance:

  <\verbatim>
    nonfix coords;

    \;

    point (x,y) = \\msg -\<gtr\> case msg of

    \ \ coords = x,y;

    \ \ move (dx,dy) = point (x+dx,y+dy);

    end;
  </verbatim>

  The anonymous function returned by <verbatim|point> in fact works like an
  ``object'' which can be queried for its coordinates and moved by a given
  offset through corresponding ``messages'' passed as arguments to the
  object:

  <\verbatim>
    \<gtr\> let p = point (1,2); p;

    #\<less\>closure 0x7f420660e658\<gtr\>

    \<gtr\> p coords; p (move (2,3)) coords;

    1,2

    3,5
  </verbatim>

  Note that this still lacks some typical features of object-oriented
  programming such as mutability and inheritance. It isn't really hard to add
  these, but this requires the use of some of Pure's more advanced machinery
  which we didn't discuss yet. For instance, mutability can be implemented in
  Pure by using so-called <hlink|<em|expression
  references>|purelib.tm#expression-references>, a kind of mutable storage
  cells which can hold arbitrary expression values:

  <\verbatim>
    \<gtr\> let x = ref 99; get x;

    99

    \<gtr\> put x 2;

    2

    \<gtr\> get x;

    2
  </verbatim>

  Using these we can rewrite our definition of the <verbatim|point> object as
  follows:

  <\verbatim>
    nonfix coords;

    \;

    point (x,y) = (\\msg -\<gtr\> case msg of

    \ \ coords = get x, get y;

    \ \ move (dx,dy) = put x (get x+dx), put y (get y+dy);

    end) when

    \ \ x,y = ref x,ref y;

    end;
  </verbatim>

  Note that the coordinates are kept in corresponding expression references
  assigned to the local <verbatim|x> and <verbatim|y> variables, which now
  shadow the <verbatim|x> and <verbatim|y> arguments of <verbatim|point>.
  This makes it possible to have <verbatim|move> actually modify the
  <verbatim|point> object in-place:

  <\verbatim>
    \<gtr\> let p = point (1,2); p coords;

    1,2

    \<gtr\> p (move (2,3)); p coords;

    3,5

    3,5
  </verbatim>

  It goes without saying that this style isn't preferred in functional
  programs, but it certainly has its uses, especially when interfacing to
  imperative code written in other languages such as C.

  <subsubsection|Data Types<label|data-types>>

  Before we consider the more advanced uses of functions in Pure, a few
  remarks about data types are in order. Like Lisp, Pure is basically a
  ``typeless'' language. That doesn't mean that there are no data types; in
  fact, they're a dime a dozen in Pure. But Pure lets you make up your own
  data structures as you go, without even formally defining a data type. Data
  types <em|can> be defined and associated with a name pretty much in the
  same way as functions, but that's just a convenience and completely
  optional. This sets Pure apart from statically typed languages like ML and
  Haskell, where explicit data type definitions are mandatory if you want to
  introduce new data structures.

  As we've seen, Pure knows about a few built-in types such as numbers,
  strings, symbols and functions; everything else is a function application.
  If a symbol is defined as a function, which merely means that there are
  some rewriting rules for it, then an application of that function to some
  arguments may evaluate to something else. But if it doesn't, then Pure is
  perfectly happy with that; it just means that the function application is
  in normal form and thus becomes a ``value''. For instance:

  <\verbatim>
    \<gtr\> cons 3 (cons 5 nil);

    cons 3 (cons 5 nil)
  </verbatim>

  There's nothing mysterious about this; the <verbatim|cons> and
  <verbatim|nil> symbols being used here aren't defined anywhere, and thus
  any terms constructed with these symbols are just ``data'', no questions
  asked. We also call such symbols <with|font-series|bold|constructors>.
  (Note that these are different from constructors in object-oriented
  programming; constructor applications in term rewriting and functional
  programming normally don't execute any code, they're just literal data
  objects.)

  We can now go ahead and define some operations on this kind of data. (To
  these ends, it's necessary to declare <verbatim|nil> as a nonfix symbol so
  that we can use it as a literal in patterns; cf. <hlink|Pattern
  Matching|#pattern-matching>.)

  <\verbatim>
    nonfix nil;

    \;

    #nil = 0;

    #cons x xs = #xs+1;

    \;

    head (cons x xs) = x;

    tail (cons x xs) = xs;

    \;

    nil + ys = ys;

    cons x xs + ys = cons x (xs + ys);
  </verbatim>

  Et voilà, we've just created our own list data structure! It's admittedly
  still a bit paltry, but if we keep at it and define all the other functions
  that we need then we could turn it into a full-blown replacement for Pure's
  list data structure. In fact Pure's lists work in a very similar fashion,
  using the infix `<verbatim|:>` constructor and the empty list <verbatim|[]>
  in lieu of <verbatim|cons> and <verbatim|nil>, respectively.

  If we want, we can define a new data type for the data structure we just
  invented. This works by giving a number of <hlink|type rules|#type-rules>
  similar to those used in function definitions. In general, these may denote
  arbitrary unary predicates, but in our case it's sufficient to just list
  the patterns of terms which are supposed to be members of the type (see
  <hlink|Type Rules|#type-rules> for an explanation of the definition
  syntax):

  <\verbatim>
    type mylist nil \| mylist (cons x xs);
  </verbatim>

  This definition lets us use the <verbatim|mylist> type as a tag on the
  left-hand side of an equation, cf. <hlink|Pattern
  Matching|#pattern-matching>. But if we're content with using the patterns
  directly then we might just as well do without that.

  Types consisting solely of constructor term patterns are sometimes also
  called <with|font-series|bold|algebraic types>. In fact, most user-defined
  data structures are algebraic types in Pure, and there are plenty of
  examples of these in the standard library as well. In particular, lists and
  tuples are algebraic types, as are complex and rational numbers, and most
  of Pure's container data types such as dictionaries and sets are also
  implemented as algebraic types.

  Pure differs from most functional languages in that symbols may act as
  <em|both> constructors and defined functions, depending on the arguments.
  Thus Pure allows you to have ``constructors with equations''. For instance:

  <\verbatim>
    cons nil ys = ys;

    cons (cons x xs) ys = cons x (cons xs ys);
  </verbatim>

  Now <verbatim|cons> has become a (partially) defined function. Note that
  these rules make <verbatim|cons> associative and turn <verbatim|nil> into a
  left-neutral element for <verbatim|cons>. This in fact makes
  <verbatim|cons> behave like concatenation, so that our lists are always
  flat now:

  <\verbatim>
    \<gtr\> cons (cons 1 (cons 2 nil)) (cons 3 nil);

    cons 1 (cons 2 (cons 3 nil))
  </verbatim>

  Examples of such constructor equations can be found in the standard library
  as well, such as the rules used to flatten tuples, keep rational numbers in
  lowest terms, or confine the angles of complex numbers in polar notation.

  Another possible use of constructor equations is to check the
  well-formedness of constructor terms. For instance, in our example we might
  want to preclude terms like <verbatim|cons> <verbatim|1> <verbatim|2> which
  don't have a <verbatim|mylist> in the second argument to <verbatim|cons>.
  This can be done with a constructor equation which raises an exception in
  such cases (cf. <hlink|Exception Handling|#exception-handling>):

  <\verbatim>
    \<gtr\> cons x y = throw (bad_mylist y) if ~typep mylist y;

    \<gtr\> cons 1 2;

    \<less\>stdin\<gtr\>, line 18: unhandled exception 'bad_mylist 2' while
    evaluating 'cons 1 2'
  </verbatim>

  A specific kind of algebraic data types which are useful in many
  applications are the <with|font-series|bold|enumerated types>. In this case
  the type consists of symbolic constants (nonfix symbols) only, which are
  the elements of the type. For instance:

  <\verbatim>
    nonfix sun mon tue wed thu fri sat;

    type day sun \| day mon \| day tue \| day wed \| day thu \| day fri \|
    day sat;
  </verbatim>

  However, to make this type actually work as an enumerated type, we may want
  to provide definitions for basic arithmetic,
  <hlink|<with|font-family|tt|ord>|purelib.tm#ord>,
  <hlink|<with|font-family|tt|succ>|purelib.tm#succ>, etc. This is rather
  straightforward, but tedious. So as of Pure 0.56, the standard library
  provides a little utility module, <hlink|<with|font-family|tt|enum>|purelib.tm#module-enum>,
  which generates the necessary definitions in an automatic fashion. All we
  have to do is to import the module and then invoke the
  <hlink|<with|font-family|tt|enum>|purelib.tm#enum> function on the type and
  we're set:

  <\verbatim>
    using enum;

    enum day;
  </verbatim>

  It's also possible to define the type and make it enumerable in one go
  using the <hlink|<with|font-family|tt|defenum>|purelib.tm#defenum>
  function:

  <\verbatim>
    defenum day [sun,mon,tue,wed,thu,fri,sat];
  </verbatim>

  In either case, we can now perform calculations with the members of the
  type just like with other predefined enumerated types such as numbers and
  characters:

  <\verbatim>
    \<gtr\> ord sun;

    0

    \<gtr\> day (ans+3);

    wed

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
  </verbatim>

  A more abstract way to define algebraic types are the <hlink|interface
  types|#interface-types>. For instance, if we take another look at the
  operations defined on our list type, we may observe that the data structure
  is quite apparent from the patterns in the rules of operations such as
  `<verbatim|#>` and `<verbatim|+>`. Pure lets us leverage that information
  by creating an algebraic type from a collection of operation patterns it
  supports. For instance, we may write:

  <\verbatim>
    interface list_alike with

    \ \ #x::list_alike;

    \ \ x::list_alike + y;

    end;
  </verbatim>

  This defines a generic type consisting of all terms which may be passed as
  an argument to both `<verbatim|#>` and `<verbatim|+>`. We can ask the
  interpreter about the patterns actually matched by the type as follows:

  <\verbatim>
    \<gtr\> show interface list_alike

    type list_alike s::string;

    type list_alike [];

    type list_alike (x:xs);

    type list_alike nil;

    type list_alike (cons x xs);
  </verbatim>

  Note that the <verbatim|list_alike> type not only includes our own list
  type, but also any other data structure providing the `<verbatim|#>` and
  `<verbatim|+>` operations. This also comprises the standard list and string
  types for which there are definitions of the `<verbatim|#>` and
  `<verbatim|+>` operations in the prelude.

  Pure's interface types are a first attempt at formalizing the notion of
  <hlink|Duck typing|http://en.wikipedia.org/wiki/Duck-typing> in Pure. They
  are thus still a bit experimental and require some diligence in defining
  the interface operations in a suitable way. Please check <hlink|Interface
  Types|#interface-types> in the <hlink|Declarations|#declarations> section
  for more information and examples.

  <subsubsection|Recursion<label|recursion>>

  Recursion means that a function calls itself, either directly or
  indirectly. It is one of the most fundamental techniques in functional
  programming, and you won't find many useful Pure programs which don't use
  it in one form or another. That's because most interesting programs execute
  pieces of code repeatedly. Pure doesn't have any special looping
  constructs, so recursion is the only way to do this in Pure. We've already
  seen various examples of this throughout the manual, so let's take a closer
  look at it now and learn a few related tricks along the way.

  For a simple example, consider the factorial. In order to compute the
  factorial of an integer <verbatim|n>, we need to multiply the positive
  integers up to <verbatim|n>. There's a straightforward recursive definition
  which does this:

  <\verbatim>
    fact n = if n\<gtr\>0 then n*fact (n-1) else 1;
  </verbatim>

  If you prefer conditional rules instead, you can also write:

  <\verbatim>
    fact n = n*fact (n-1) if n\<gtr\>0;

    \ \ \ \ \ \ \ = 1 otherwise;
  </verbatim>

  It's not hard to see how this definition operates. The first rule only
  applies if <verbatim|n\>0>, otherwise the second rule kicks in so that
  <verbatim|fact> <verbatim|n> becomes <verbatim|1> if <verbatim|n> is zero
  or negative (which is consistent with our informal description because in
  this case the product of all positive integers up to <verbatim|n> is the
  empty product which is <verbatim|1> by mathematical convention). The first
  rule is the interesting one where the recursion happens. If <verbatim|n\>0>
  then we may compute <verbatim|fact> <verbatim|n> by computing
  <verbatim|fact> <verbatim|(n-1)> recursively and multiplying that with
  <verbatim|n>, giving <verbatim|n*(n-1)*...*1>. Let's check that this works:

  <\verbatim>
    \<gtr\> map fact (1..10);

    [1,2,6,24,120,720,5040,40320,362880,3628800]
  </verbatim>

  Note that these numbers grow fairly quickly; they outgrow the 32 bit range
  and start wrapping around already at <verbatim|n==13>. To avoid that,
  you'll have to do the computation with bigints, or you could use floating
  point values if you don't mind the limited precision.

  <\verbatim>
    \<gtr\> fact 13;

    1932053504

    \<gtr\> fact 13L;

    6227020800L

    \<gtr\> fact 30L;

    265252859812191058636308480000000L

    \<gtr\> fact 30.0;

    2.65252859812191e+32
  </verbatim>

  However, you'll run into another, more serious obstacle if you want to
  compute factorials for some really big values of <verbatim|n>. For
  instance:

  <\verbatim>
    \<gtr\> fact 200000L;

    \<less\>stdin\<gtr\>, line 7: unhandled exception 'stack_fault' while
    evaluating 'fact 200000L'
  </verbatim>

  Oops. What happened there? Well, each recursive invocation of
  <verbatim|fact> needs some small amount of memory on the execution stack, a
  so-called ``stack frame''. Thus, when <verbatim|n> becomes big enough then
  our definition is in danger of running out of stack space. (This is also
  why you keep hearing in most CS 101 courses that you should try to avoid
  recursion. If you've forgotten how subroutine calls are executed by keeping
  the execution context on a stack then it's time to revisit those CS 101
  lecture notes now.)

  So how can we avoid using all that stack space? In a language like C we'd
  be using a specialized loop construct instead of recursion, e.g.:

  <\verbatim>
    int fact(int n)

    {

    \ \ int p = 1;

    \ \ while (n\<gtr\>0) { p = n*p; n = n-1; }

    \ \ return p;

    }
  </verbatim>

  Pure doesn't have a <verbatim|while> loop, but we can rewrite the
  definition so that it becomes <with|font-series|bold|tail-recursive>. This
  means that the recursive call becomes the final operation on the right-hand
  side of the recursive rule. The Pure compiler treats this pretty much like
  a loop in traditional programming languages.

  The trick of the trade to turn a recursive function into a tail-recursive
  one is the <with|font-series|bold|accumulating parameter> technique. The
  idea here is to have a separate ``worker'' function which carries around an
  extra argument representing the intermediate result for the current
  iteration. The final value of that parameter is then returned as the
  result. In the case of the factorial this can be done as follows:

  <\verbatim>
    fact n = loop n 1 with

    \ \ loop n p = loop (n-1) (n*p) if n\<gtr\>0;

    \ \ \ \ \ \ \ \ \ \ \ = p otherwise;

    end;
  </verbatim>

  Note that <verbatim|fact> has now become a simple ``wrapper'' which
  supplies the initial value of the accumulating parameter (<verbatim|p> in
  this case) for the ``worker'' function <verbatim|loop> which does all the
  hard work. This kind of design is fairly common in functional programs.

  Our worker function is tail-recursive since the recursive call to
  <verbatim|loop> is indeed the final call on the right-hand side of the
  first equation defining <verbatim|loop>. The Pure compiler generates code
  which optimizes such ``tail calls'' so that they reuse the stack frame of
  the calling function. Thus a tail-recursive function like <verbatim|loop>
  will execute in constant stack space; in fact it will be just as efficient
  as the <verbatim|while> loop in our little C snippet above (up to constant
  factors, of course). After entering our new definition of <verbatim|fact>
  we can now compute <verbatim|fact> <verbatim|200000L> just fine (this may
  take a little while, though, depending on how fast your computer is; the
  result has 973351 digits):

  <\verbatim>
    \<gtr\> fact 200000L;

    14202253454703144049669463336823059760899... // lots of digits follow
  </verbatim>

  The accumulating parameter technique isn't fully general, but it covers all
  the kinds of simple iterative algorithms which you'd do using loop
  constructs in traditional programming languages. Some algorithms may
  require additional techniques such as <with|font-series|bold|tabulation>
  (keeping track of some or all intermediate results), however, so that they
  can be written in an iterative form. To see how this can be done in Pure,
  let's consider the Fibonacci numbers. These can be computed with the
  following naive recursive definition:

  <\verbatim>
    fib n = if n\<less\>=1 then n else fib (n-2) + fib (n-1);
  </verbatim>

  Here are some members of this famous sequence:

  <\verbatim>
    \<gtr\> map fib (0..20);

    [0,1,1,2,3,5,8,13,21,34,55,89,144,233,377,610,987,1597,2584,4181,6765]
  </verbatim>

  Note that the right-hand side of the definition above involves <em|two>
  recursive invocations of <verbatim|fib> in the
  <hlink|<with|font-family|tt|else>|#else> branch. This is bad because it
  means our definition will need exponential running time. (More precisely,
  you'll find that the ratio between the running times of successive
  invocations quickly starts approaching the golden ratio <math|\<phi\>> =
  1.618..., which is no accident because the times are proportional to the
  Fibonacci function itself!)

  Using a simple iterative algorithm, it is possible to calculate the
  Fibonacci numbers in linear time instead. Observe that each member of the
  sequence is simply the sum of the two preceding members. If we keep track
  of the last two members of the sequence then we can compute the next member
  with a single addition. This yields the following tail-recursive
  implementation which uses the same kind of ``wrapper-worker'' design:

  <\verbatim>
    fib n = loop n 0L 1L with

    \ \ loop n a b = loop (n-1) b (a+b) if n\<gtr\>0;

    \ \ \ \ \ \ \ \ \ \ \ \ \ = a otherwise;

    end;
  </verbatim>

  Note that as a matter of prudence we primed the iteration with the bigints
  <verbatim|0L> and <verbatim|1L> so that we can compute large Fibonacci
  numbers without suffering wrap-around. For instance, try the following:

  <\verbatim>
    \<gtr\> fib 1000000;

    1953282128707757731632014947596256332443... // lots of digits follow
  </verbatim>

  Recursion also naturally occurs when traversing recursive data structures.
  We've already seen various examples of these, such as the binary tree data
  structure:

  <\verbatim>
    nonfix nil;

    \;

    insert nil y \ \ \ \ \ \ \ \ = bin y nil nil;

    insert (bin x L R) y = bin x (insert L y) R if y\<less\>x;

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ = bin x L (insert R y)
    otherwise;
  </verbatim>

  The <verbatim|insert> function implements a binary tree insertion algorithm
  which keeps the tree (represented with the <verbatim|bin> and
  <verbatim|nil> constructor symbols) sorted. To these ends, it recurses into
  the left or right subtree, depending on whether the element <verbatim|y> to
  be inserted is less than the current element <verbatim|x> or not. The final
  result is a new tree which has a <verbatim|nil> subtree replaced with a new
  <verbatim|bin> <verbatim|y> <verbatim|nil> <verbatim|nil> subtree at the
  right location.

  If we do an <with|font-series|bold|inorder> traversal of such a binary tree
  (at each non-<verbatim|nil> subtree, first visit the left subtree, then
  note the element at the top of the current subtree, and finally visit the
  right subtree), we obtain the elements of the tree in ascending order. This
  traversal is also implemented recursively, e.g., as follows:

  <\verbatim>
    list nil = [];

    list (bin x L R) = list L + (x:list R);
  </verbatim>

  Note that these functions can't be made tail-recursive using the
  accumulating parameter technique, because traversing a tree structure
  requires more general forms of recursion. There is in fact a more general
  <hlink|continuation passing|http://en.wikipedia.org/wiki/Continuation-passing-style>
  technique to do this, which we will look at in <hlink|The Same-Fringe
  Problem|#the-same-fringe-problem> below; alas, it's not as easy as
  accumulating parameters. Fortunately, some important recursive structures
  such as lists only involve simple recursion and can thus be traversed and
  manipulated in a tail-recursive fashion more easily. For instance, consider
  our earlier definition of the <verbatim|sum> function:

  <\verbatim>
    sum [] = 0;

    sum (x:xs) = x+sum xs;
  </verbatim>

  This definition isn't tail-recursive, but we can easily massage it into
  this form using the accumulating parameter technique:

  <\verbatim>
    sum xs::list = loop 0 xs with

    \ \ loop s [] = s;

    \ \ loop s (x:xs) = loop (s+x) xs;

    end;
  </verbatim>

  Functions can also be <with|font-series|bold|mutually recursive>, in which
  case two or more functions are defined in terms of each other. For
  instance, suppose that we'd like to skip every other element of a list
  (i.e., return a list with only the elements having either even or odd
  indices, respectively). One way to do this involves two functions (named
  <verbatim|pick> and <verbatim|skip> here) which recursively call each
  other:

  <\verbatim>
    \<gtr\> pick [] = []; pick (x:xs) = x:skip xs;

    \<gtr\> skip [] = []; skip (x:xs) = pick xs;

    \<gtr\> pick (1..10);

    [1,3,5,7,9]

    \<gtr\> skip (1..10);

    [2,4,6,8,10]
  </verbatim>

  <paragraph|A Numeric Root Finder<label|a-numeric-root-finder>>

  Let's now see how we can apply the techniques explained above in the
  context of a somewhat more practical example: a numeric root finder. That
  is, we're going to write a function which takes another function
  <verbatim|f> and determines a (double) value <verbatim|x> such that
  <verbatim|f> <verbatim|x> becomes (close to) zero.

  We'll develop this in a bottom-up fashion. The method we employ here is
  known as the Newton-Raphson algorithm, whose basic building block is the
  following routine <verbatim|improve> which improves a given candidate
  solution <verbatim|x> by computing a first-order approximation of the root.
  This involves computing (a numeric approximation of) the first derivative
  at the given point, which we do using a second function <verbatim|derive>:

  <\verbatim>
    improve f x = x - f x / derive f x;

    derive f x = (f (x+dx) - f x) / dx;
  </verbatim>

  If you still remember your calculus then these should look familiar. Note
  that in both functions, <verbatim|f> is our target function to be solved
  and <verbatim|x> the current candidate solution. The second equation is
  nothing but the difference quotient of the function at the point
  <verbatim|x>, using <verbatim|dx> as the increment along the <verbatim|x>
  axis. The <verbatim|improve> function computes the intersection of the
  corresponding secant of <verbatim|f> with the <verbatim|x> axis.

  To illustrate how the method works, let's perform a few improvement steps
  manually, using the target function <verbatim|f> <verbatim|x> <verbatim|=>
  <verbatim|x*x-2> which becomes zero at the square root of 2. Here we choose
  a <verbatim|dx> value of <verbatim|1e-8> and start from the initial guess
  <verbatim|2>:

  <\verbatim>
    \<gtr\> let dx = 1e-8;

    \<gtr\> improve f x = x - f x / derive f x;

    \<gtr\> derive f x = (f (x+dx) - f x) / dx;

    \<gtr\> f x = x*x-2;

    \<gtr\> improve f 2;

    1.49999999696126

    \<gtr\> improve f ans;

    1.41666666616021

    \<gtr\> improve f ans;

    1.41421568628522

    \<gtr\> improve f ans;

    1.41421356237468
  </verbatim>

  It should be apparent by now that this converges to the square root of 2
  rather quickly. To automate this process, we need another little helper
  function which iterates <verbatim|improve> until the current candidate
  solution is ``good enough''. A suitable termination criterion is that the
  improvement drops below a certain threshold (i.e., <verbatim|abs>
  <verbatim|(x-f> <verbatim|x)> <verbatim|\<=> <verbatim|dy> for some
  reasonably small <verbatim|dy>). For extra safety, we'll also bail out of
  the loop if a prescribed number <verbatim|n> of iterations has been
  performed. This function can be implemented in a tail-recursive fashion as
  follows:

  <\verbatim>
    loop n f x = x if n \<less\>= 0;

    \ \ = if abs (x-y) \<less\> dy then y else loop (n-1) f y when y = f x
    end;
  </verbatim>

  Let's give it a try:

  <\verbatim>
    \<gtr\> let dy = 1e-12;

    \<gtr\> loop n f x = x if n \<less\>= 0;

    \<gtr\> \ \ = if abs (x-y) \<less\> dy then y else loop (n-1) f y when y
    = f x end;

    \<gtr\> loop 20 (improve dx f) 2;

    1.4142135623731

    \<gtr\> ans*ans;

    2.0
  </verbatim>

  Looks good. So let's finally wrap this up in a main entry point
  <verbatim|solve> which takes the function to be solved and an initial guess
  as parameters. Our little helper functions <verbatim|improve>,
  <verbatim|derive> and <verbatim|loop> are only used internally, so we can
  turn them into local functions of <verbatim|solve>. The additional
  parameters of the algorithm are implemented as global variables so that we
  can easily modify their values if needed. The end result looks as follows.
  Note that the initial guess <verbatim|x> is an implicit parameter of the
  <verbatim|solve> function, so the function actually gets invoked as
  <verbatim|solve> <verbatim|f> <verbatim|x>.

  <\verbatim>
    let dx = 1e-8; \ // delta value for the approximation of the derivative

    let dy = 1e-12; // delta value for testing convergence

    let nmax = 20; \ // maximum number of iterations

    \;

    solve f = loop nmax (improve f) with

    \ \ loop n f x = x if n \<less\>= 0;

    \ \ \ \ = if abs (x-y) \<less\> dy then y else loop (n-1) f y when y = f
    x end;

    \ \ improve f x = x - f x / derive f x;

    \ \ derive f x = (f (x+dx) - f x) / dx;

    end;
  </verbatim>

  Here are some examples showing how the <verbatim|solve> function is used.
  Note that we specify the target functions to be solved as lambdas here.
  E.g., <verbatim|<t>> <verbatim|-\>> <verbatim|t^3-x> denotes a function
  mapping <verbatim|t> to <verbatim|t^3-x>, which becomes zero if
  <verbatim|t> equals the cube root of <verbatim|x>.

  <\verbatim>
    \<gtr\> sqrt x = solve (\\t -\<gtr\> t*t-x) x;

    \<gtr\> sqrt 2; sqrt 5;

    1.4142135623731

    2.23606797749979

    \<gtr\> cubrt x = solve (\\t -\<gtr\> t^3-x) x;

    \<gtr\> cubrt 8;

    2.0
  </verbatim>

  Our little root finder isn't perfect. It needs a fairly well-behaved target
  function and/or a good initial guess to work properly. For instance,
  consider:

  <\verbatim>
    \<gtr\> solve (\\t -\<gtr\> 1/t-2) 1;

    0.00205230175365927
  </verbatim>

  Here <verbatim|solve> didn't find the real root at 0.5 at all. In fact, if
  you print the solution candidates then you will find that <verbatim|solve>
  converges rather slowly in this case and thus bails out after 20 iterations
  before a good solution is found. Increasing the <verbatim|nmax> value fixes
  this:

  <\verbatim>
    \<gtr\> let nmax = 50;

    \<gtr\> solve (\\t -\<gtr\> 1/t-2) 1;

    0.5
  </verbatim>

  There are other pathological cases where the algorithm performs even more
  poorly. Further improvements of the method presented here can be found in
  textbooks on numeric algorithms; the interested reader may want to cut his
  teeth on these algorithms by translating them to Pure in the way we've
  shown here.

  <paragraph|The Same-Fringe Problem<label|the-same-fringe-problem>>

  This is one of the classical problems in functional programming which has a
  straightforward recursive solution, but needs some thought if we want to
  solve it in an efficient way. Consider a (rooted, directed) tree consisting
  of branches and leaves. To keep things simple, we may represent these
  structures as nested lists, e.g.:

  <\verbatim>
    let t1 = [[a,b],c,[[d]],e,[f,[[g,h]]]];

    let t2 = [a,b,c,[[d],[],e],[f,[g,[h]]]];

    let t3 = [[a,b],d,[[c]],e,[f,[[g,h]]]];
  </verbatim>

  Thus each inner node of the tree is represented as a list containing its
  (zero or more) subtrees, and the leaves are the ``atomic'' (non-list)
  elements. The <with|font-series|bold|fringe> of such a structure is the
  list of all leaves in left-to-right order, which can be computed as
  follows:

  <\verbatim>
    fringe t = if listp t then catmap fringe t else [t];
  </verbatim>

  Note that <hlink|<with|font-family|tt|listp>|purelib.tm#listp> is a
  predicate which decides whether its argument is a (proper or improper) list
  and the <hlink|<with|font-family|tt|catmap>|purelib.tm#catmap> function
  applies the given function to a list, like
  <hlink|<with|font-family|tt|map>|purelib.tm#map>, and concatenates all the
  resulting lists, like <hlink|<with|font-family|tt|cat>|purelib.tm#cat>.
  Thus, if the argument <verbatim|t> is an ``atom'' (leaf) then
  <verbatim|fringe> simply returns <verbatim|[t]>, otherwise it recursively
  applies itself to all the subtrees and concatenates the results:

  <\verbatim>
    \<gtr\> fringe t1;

    [a,b,c,d,e,f,g,h]

    \<gtr\> fringe t2;

    [a,b,c,d,e,f,g,h]

    \<gtr\> fringe t3;

    [a,b,d,c,e,f,g,h]
  </verbatim>

  Note that <verbatim|t1> and <verbatim|t2> differ in structure but have the
  same fringe, while <verbatim|t1> and <verbatim|t3> have the same structure
  but different fringes. The problem now is to decide, given any two trees,
  whether they have the same fringe. Of course, we can easily solve this by
  just computing the fringes and comparing them with
  `<hlink|<with|font-family|tt|===>|purelib.tm#===>` (note that we employ
  <hlink|syntactic equality|#syntactic-equality> here which also allows us to
  compare symbols, for which `<hlink|<with|font-family|tt|==>|purelib.tm#==>`
  isn't normally defined):

  <\verbatim>
    \<gtr\> fringe t1 === fringe t2;

    1

    \<gtr\> fringe t3 === fringe t2;

    0
  </verbatim>

  However, this is rather inefficient since we always have to fully construct
  the fringes which may need considerable extra time and space if the trees
  are large. Most of this effort may be completely wasted if we only need to
  inspect a tiny fraction of the fringes to find out that they're different,
  as in the case of <verbatim|t2> and <verbatim|t3>. Also note that our
  version of the <verbatim|fringe> function isn't tail-recursive and we may
  thus run into stack overflows for large trees.

  This problem, while posed in an abstract way here, is not only of academic
  interest. For instance, trees may be used as an alternative string data
  structure which implements concatenation in constant time by just delaying
  it. In this case we certainly don't want to explicitly carry out all those
  concatenations in order to decide whether two such objects are the same.

  Therefore, this problem has been studied extensively and more efficient
  approaches have been developed. One way to solve the problem involves the
  technique of <with|font-series|bold|continuation passing> which is a
  generalization of the accumulating parameter technique we already
  discussed. It never constructs any part of the fringes explicitly and also
  works in constant stack space. The algorithm can be implemented in Pure as
  follows. (This is a slightly modified transliteration of a Lisp program
  given in Henry Baker's article ``Iterators: Signs of Weakness in
  Object-Oriented Languages'', ACM OOPS Messenger 4(3), 1993, pp. 18-25,
  which is also available from <hlink|Henry Baker's Archive of Research
  Papers|http://home.pipeline.com/-tildehbaker1/>.)

  <\verbatim>
    samefringe t1 t2 =

    samefringe (\\c -\<gtr\> genfringe t1 c done) (\\c -\<gtr\> genfringe t2
    c done) with

    \ \ done c = c [] done;

    \ \ samefringe g1 g2 =

    \ \ \ \ g1 (\\x1 g1 -\<gtr\> g2 (\\x2 g2 -\<gtr\> x1===x2 && (x1===[]
    \|\| samefringe g1 g2)));

    \ \ genfringe [] c g = g c;

    \ \ genfringe (x:t) c g = genfringe x c (\\c -\<gtr\> genfringe t c g);

    \ \ genfringe x c g = c x g;

    end;
  </verbatim>

  As Baker admits himself, this style of programming isn't ``particularly
  perspicuous'', so we'll explain the algorithm in a moment. But first let us
  verify that the program indeed works as advertized. It's helpful to print
  out the actual comparisons performed in the innermost lambda in the
  definition of the local <verbatim|samefringe> function, which can be done
  by adding a little debugging statement as follows (this also needs an
  import clause ``<verbatim|using> <verbatim|system;>'' to make the
  <hlink|<with|font-family|tt|printf>|purelib.tm#printf> function available):

  <\verbatim>
    samefringe g1 g2 =

    \ \ g1 (\\x1 g1 -\<gtr\> g2 (\\x2 g2 -\<gtr\> printf "%s === %s?\\n" (str
    x1,str x2) $$

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ x1===x2 &&
    (x1===[] \|\| samefringe g1 g2)));
  </verbatim>

  With this we get:

  <\verbatim>
    \<gtr\> samefringe t1 t2;

    a === a?

    b === b?

    c === c?

    d === d?

    e === e?

    f === f?

    g === g?

    h === h?

    [] === []?

    1
  </verbatim>

  So in this case we do a complete traversal of both trees which is the best
  that we can hope for if the fringes are the same. Note that the final
  comparison <verbatim|[]> <verbatim|===> <verbatim|[]> ensures that we also
  hit the end of the two fringes at the same time. This test deals with the
  corner case that one fringe is a prefix of the other. For instance:

  <\verbatim>
    \<gtr\> let t4 = [[a,b],c,[[d]],e,[f,[[g,h,i]]]];

    \<gtr\> samefringe t4 t2;

    a === a?

    b === b?

    c === c?

    d === d?

    e === e?

    f === f?

    g === g?

    h === h?

    i === []?

    0
  </verbatim>

  Things go a bit differently, however, when comparing <verbatim|t3> and
  <verbatim|t2>; as soon as we hit the first discrepany between the two
  fringes, the algorithm bails out and correctly asserts that the fringes are
  different:

  <\verbatim>
    \<gtr\> samefringe t3 t2;

    a === a?

    b === b?

    d === c?

    0
  </verbatim>

  Let's take a closer look at the various parts of the algorithm now. First,
  the <verbatim|genfringe> function:

  <\verbatim>
    genfringe [] c g = g c;

    genfringe (x:t) c g = genfringe x c (\\c -\<gtr\> genfringe t c g);

    genfringe x c g = c x g;
  </verbatim>

  This routine generates the fringe of a tree, given as the first argument,
  on the fly. The second argument <verbatim|c> (the ``consumer'') is a
  function which gets invoked on the current leaf, to do any required
  processing. (As we'll see later, it may also get invoked with the special
  ``sentinel'' value <verbatim|[]> to indicate the end of the fringe.)

  The third argument <verbatim|g> (the ``generator'') is a
  <with|font-series|bold|continuation>, a kind of ``callback function'' to be
  invoked <em|after> the current subtree has been traversed, in order to
  process the remainder of the tree. It takes the consumer function
  <verbatim|c> as its sole argument. Consequently, <verbatim|genfringe>
  simply invokes the continuation <verbatim|g> on the consumer <verbatim|c>
  when applied to an empty subtree <verbatim|[]>, i.e., if there aren't any
  leaves to be processed. This case is handled in the first equation for
  <verbatim|genfringe>.

  The second equation for <verbatim|genfringe> is the interesting one where
  the recursion happens. It deals with a nonempty tree <verbatim|x:t> by
  invoking itself recursively on <verbatim|x>, setting up a new continuation
  <verbatim|<c>> <verbatim|-\>> <verbatim|genfringe> <verbatim|t>
  <verbatim|c> <verbatim|g>, which will take care of processing the rest of
  the subtree <verbatim|t>, after which it chains to the previous
  continuation <verbatim|g> which will handle the rest of the tree.

  The third equation for <verbatim|genfringe> handles the case of a non-list
  argument, i.e., a leaf. In this case we just pass the leaf <verbatim|x> to
  the consumer function <verbatim|c> along with the continuation
  <verbatim|g>. The consumer processes <verbatim|x> as needed and may then
  decide to call the continuation <verbatim|g> on itself in order to continue
  processing the rest of the tree, or simply bail out, returning any value.
  Note that this entire process is tail-recursive, as long as <verbatim|c>
  chains to <verbatim|g> as the last call. It thus only needs constant stack
  space in addition to what <verbatim|c> itself uses.

  Note that we need an initial continuation <verbatim|g> to get the process
  started. This is provided by the <verbatim|done> function:

  <\verbatim>
    done c = c [] done;
  </verbatim>

  As we've defined it, <verbatim|done> invokes the consumer <verbatim|c> on
  an empty list to signal the end of the fringe. For good measure, it also
  passes itself as the continuation argument; however, normally the consumer
  will never use this argument and just bail out when invoked on the
  <verbatim|[]> value.

  To see how this works, we can just enter <verbatim|done> and
  <verbatim|genfringe> as global functions and invoke them on a suitable
  consumer function, e.g.:

  <\verbatim>
    \<gtr\> done c = c [] done;

    \<gtr\> genfringe [] c g = g c;

    \<gtr\> genfringe (x:t) c g = genfringe x c (\\c -\<gtr\> genfringe t c
    g);

    \<gtr\> genfringe x c g = c x g;

    \<gtr\> c x g = if x===[] then g else printf "%s... " (str x) $$ g c;

    \<gtr\> genfringe t1 c done;

    a... b... c... d... e... f... g... h... done
  </verbatim>

  In the case of <verbatim|samefringe>, we use the local
  <verbatim|samefringe> function as our consumer instead. This works pretty
  much the same, except that <verbatim|samefringe> employs <em|two>
  continuations <verbatim|g1> and <verbatim|g2> to traverse both trees at the
  same time:

  <\verbatim>
    samefringe g1 g2 =

    \ \ g1 (\\x1 g1 -\<gtr\> g2 (\\x2 g2 -\<gtr\> x1===x2 && (x1===[] \|\|
    samefringe g1 g2)));
  </verbatim>

  Note that the outer lambda <verbatim|(\\x1> <verbatim|g1> <verbatim|-\>>
  <verbatim|...)> becomes the consumer for the first generator <verbatim|g1>
  which traverses <verbatim|t1>. When called, it then invokes the second
  generator <verbatim|g2>, which traverses <verbatim|t2>, on the consumer
  (inner lambda) <verbatim|(\\x2> <verbatim|g2> <verbatim|-\>>
  <verbatim|...)>. This in turn does the necessary tests to verify that the
  current leaf elements are the same, or to bail out from the recursion if
  they aren't or if we reached the end of the fringes. Also note that this is
  still tail-recursive because the short-circuit logical operations
  <hlink|<with|font-family|tt|&&>|purelib.tm#-amp-amp> and
  <hlink|<with|font-family|tt|\|\|>|purelib.tm#\|\|> are both tail-recursive
  in their second operand (cf. <hlink|Stack Size and Tail
  Recursion|#stack-size-and-tail-recursion>).

  <subsubsection|Higher-Order Functions<label|higher-order-functions>>

  As we have seen, functions are first-class citizens in Pure which can be
  created on the fly (using partial applications as well as lambdas and local
  functions), assigned to variables and passed around freely as function
  arguments and results. Thus it becomes possible to define
  <with|font-series|bold|higher-order functions> which take other functions
  as arguments and/or return them as results. This is generally considered a
  hallmark feature of functional programming, and much of the power of
  functional programming stems from it. In fact, higher-order functions are
  so deeply ingrained in the modern functional programming style that you'll
  hardly find a nontrivial program that doesn't use them in some way, and we
  have already seen many examples of them throughout the manual. While most
  imperative programming languages today let you treat functions as values,
  too, they're typically much more limited in the ways that new functions can
  be created dynamically. Only recently have partial application and
  anonymous closures arrived in some mainstream imperative languages, and
  they are often still rather awkward to use.

  The simplest case of a higher-order function is a function which takes
  another function as an argument. For instance, we have seen the function
  <hlink|<with|font-family|tt|map>|purelib.tm#map> which applies a function
  to each member of a list. If it wasn't in the prelude, it could be defined
  as follows:

  <\verbatim>
    map f [] = [];

    map f (x:xs) = f x : map f xs;
  </verbatim>

  (Note that this isn't the actual definition from the prelude, which goes to
  some lengths to make the operation tail-recursive and properly handle lazy
  lists. But we won't dive into these technicalities here since we're only
  interested in the higher-order aspect right now.)

  This definition is rather straightforward: To map a function <verbatim|f>
  to a list, just apply it to the head element <verbatim|x> and recurse into
  the tail <verbatim|xs>. The recursion stops at the empty list which is
  returned as is. For instance:

  <\verbatim>
    \<gtr\> map (*2) (0..10);

    [0,2,4,6,8,10,12,14,16,18,20]
  </verbatim>

  The prelude includes an entire collection of such generic list functions
  which have proven their utility as basic building blocks for many list
  processing tasks. We'll have a closer look at these later, see <hlink|List
  Processing|#list-processing>.

  Another numerical example is the function <verbatim|derive> which we used
  in our root finder example to calculate the difference quotient of a
  function <verbatim|f> at a given point <verbatim|x>:

  <\verbatim>
    derive f x = (f (x+dx) - f x) / dx;
  </verbatim>

  This example is also interesting because we can turn <verbatim|derive> into
  a function mapping functions to other functions, by partially applying it
  to the target function. So we may write:

  <\verbatim>
    \<gtr\> let dx = 1e-8;

    \<gtr\> map (derive square) (1..4) with square x = x*x end;

    [1.99999998784506,3.99999997569012,5.99999996353517,7.99999995138023]
  </verbatim>

  This illustrates an easy way to create new functions from existing ones:
  partial application. (In fact we also did that when we applied the operator
  section <verbatim|(*2)> using <verbatim|map> above. Note that
  <verbatim|(*2)> is a function which doubles its single argument.) This
  simple recipe is surprisingly powerful. For instance, the prelude defines
  the function composition operator `<hlink|<with|font-family|tt|.>|purelib.tm#.>`
  as:

  <\verbatim>
    (f.g) x = f (g x);
  </verbatim>

  The partial application <verbatim|f.g> thus applies two given functions
  <verbatim|f> and <verbatim|g> in sequence (first <verbatim|g>, then
  <verbatim|f>). Functions of this kind, which create new functions by
  combining existing ones, are also known as
  <with|font-series|bold|combinators>. For instance, using
  `<hlink|<with|font-family|tt|.>|purelib.tm#.>` we can easily create a
  function which ``clamps'' its argument between given bounds by just
  combining the <hlink|<with|font-family|tt|min>|purelib.tm#min> and
  <hlink|<with|font-family|tt|max>|purelib.tm#max> functions from the prelude
  as follows:

  <\verbatim>
    \<gtr\> clamp a b = max a . min b;

    \<gtr\> map (clamp (-3) 3) (-5..5);

    [-3,-3,-3,-2,-1,0,1,2,3,3,3]
  </verbatim>

  Note that partial application works with constructor symbols, too:

  <\verbatim>
    \<gtr\> map (0:) [1..3,4..6,7..9];

    [[0,1,2,3],[0,4,5,6],[0,7,8,9]]
  </verbatim>

  Another more direct way to define combinators is to make them return a
  local or anonymous function. For instance, the following equations lift the
  `<hlink|<with|font-family|tt|+>|purelib.tm#+>` and
  `<hlink|<with|font-family|tt|->|purelib.tm#->` operators to pointwise
  operations:

  <\verbatim>
    f + g = \\x -\<gtr\> f x + g x if nargs f \<gtr\> 0 && nargs g \<gtr\> 0;

    f - g = \\x -\<gtr\> f x - g x if nargs f \<gtr\> 0 && nargs g \<gtr\> 0;
  </verbatim>

  This employs the <hlink|<with|font-family|tt|nargs>|purelib.tm#nargs>
  function from the standard library which returns the argument count of a
  global or local function. We use this here to check that the operands are
  defined functions taking at least one argument. The result is a function
  which applies the function operands to the given argument and computes
  their sum and difference, respectively. For instance:

  <\verbatim>
    \<gtr\> map (f+g-h) (1..10) with f x = 2*x+1; g x = x*x; h x = 3 end;

    [1,6,13,22,33,46,61,78,97,118]
  </verbatim>

  These rules also handle functions taking multiple arguments, so that you
  can write, e.g.:

  <\verbatim>
    \<gtr\> (max-min) 2 5;

    3
  </verbatim>

  Constructors can be extended in exactly the same way:

  <\verbatim>
    \<gtr\> f,g = \\x -\<gtr\> f x, g x if nargs f \<gtr\> 0 && nargs g
    \<gtr\> 0;

    \<gtr\> (max,min,max-min) 2 5;

    5,2,3
  </verbatim>

  <subsubsection|List Processing<label|list-processing>>

  Pure's list data structure provides you with a convenient way to represent
  sequences of arbitrary values. This is one of the few compound data
  structures which has built-in support by the compiler, so that some
  syntactic sugar is available which allows you to express certain list
  operations in a convenient way. But for the most part, lists are
  implemented in the prelude just like any other data structure.

  The empty list is denoted <hlink|<with|font-family|tt|[]>|purelib.tm#[]>,
  and compound lists can be put together in a right-recursive fashion using
  the `<hlink|<with|font-family|tt|:>|purelib.tm#:>` operator. The customary
  bracketed notation is provided as well, and this is also the syntax the
  interpreter normally uses to print list values:

  <\verbatim>
    \<gtr\> 1:2:3:[];

    [1,2,3]
  </verbatim>

  Note that the bracketed notation is just syntactic sugar; internally all
  list values are represented as right-recursive applications of the
  `<hlink|<with|font-family|tt|:>|purelib.tm#:>` operator. Thus it is
  possible to match the head and tail of a list using a pattern like
  <verbatim|x:xs>:

  <\verbatim>
    \<gtr\> case [1,2,3] of x:xs = x,xs end;

    1,[2,3]
  </verbatim>

  Lists can contain any combination of elements (also from different types)
  and they may also be nested:

  <\verbatim>
    \<gtr\> [1,2.0,[x,y],"a string"];

    [1,2.0,[x,y],"a string"]
  </verbatim>

  List concatenation is denoted <hlink|<with|font-family|tt|+>|purelib.tm#+/list>,
  and the <hlink|<with|font-family|tt|#>|purelib.tm##>,
  <hlink|<with|font-family|tt|!>|purelib.tm#!> and
  <hlink|<with|font-family|tt|!!>|purelib.tm#!!> operators can be used to
  compute the length of a list and extract elements and slices of a list
  using zero-based indexing:

  <\verbatim>
    \<gtr\> [a,b,c]+[x,y,z];

    [a,b,c,x,y,z]

    \<gtr\> #ans, ans!5, ans!![2,3];

    6,z,[c,x]
  </verbatim>

  Note that lists are immutable in Pure (just like most of Pure's built-in
  and predefined data structures), so there are no operations which modify
  lists in-place. E.g., concatenation works as if it was defined recursively
  by the following rules:

  <\verbatim>
    []+ys = ys;

    (x:xs) + ys = x : (xs+ys);
  </verbatim>

  So a new list is created which replaces the empty list in the last
  component of the left operand with the right operand. This even works if
  the second operand is no list at all, in which case an improper list value
  is produced:

  <\verbatim>
    \<gtr\> [a,b,c]+y;

    a:b:c:y
  </verbatim>

  These can be useful, e.g., to represent symbolic list values. Note that a
  <with|font-series|bold|proper> list value contains the empty list
  <verbatim|[]> in its rightmost component; an
  <with|font-series|bold|improper> list value is one which doesn't. There are
  some list functions like <hlink|<with|font-family|tt|reverse>|purelib.tm#reverse>
  which really need proper lists to work and will throw an exception
  otherwise, but many predefined operations will deal with improper lists
  just fine:

  <\verbatim>
    \<gtr\> map f (x:y:z);

    f x:f y:map f z
  </verbatim>

  Lists can also be compared using the <hlink|<with|font-family|tt|==>|purelib.tm#==/list>
  and <hlink|<with|font-family|tt|<math|\<sim\>>=>|purelib.tm#-tilde=/list>
  operators:

  <\verbatim>
    \<gtr\> [1,2,3] == [1,2,4];

    0
  </verbatim>

  Arithmetic sequences are denoted with the
  <hlink|<with|font-family|tt|..>|purelib.tm#..> operator:

  <\verbatim>
    \<gtr\> 1..10; 10:9..1; 0.0:0.1..1.0;

    [1,2,3,4,5,6,7,8,9,10]

    [10,9,8,7,6,5,4,3,2,1]

    [0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0]
  </verbatim>

  List comprehensions provide another way to construct (proper) list values
  using a convenient math-like notation:

  <\verbatim>
    \<gtr\> [2^x \| x = 1..10];

    [2.0,4.0,8.0,16.0,32.0,64.0,128.0,256.0,512.0,1024.0]
  </verbatim>

  We'll discuss this construct in more detail later, see <hlink|List
  Comprehensions|#list-comprehensions>.

  The prelude provides a fairly comprehensive collection of useful list
  functions, including some powerful generic operations which let you do most
  common list manipulations with ease. For instance, we have already seen the
  <hlink|<with|font-family|tt|map>|purelib.tm#map> function:

  <\verbatim>
    \<gtr\> map (\\x-\<gtr\>2*x-1) (1..10);

    [1,3,5,7,9,11,13,15,17,19]
  </verbatim>

  There's also a function <hlink|<with|font-family|tt|do>|purelib.tm#do>
  which works in the same fashion but throws away all the results and simply
  returns <verbatim|()>. Of course this makes sense only if the applied
  function has some interesting side-effect. E.g., here's a quick way to
  print all members of a list, one per line. This combines the
  <hlink|<with|font-family|tt|str>|purelib.tm#str> function (which converts
  any Pure expression to its printable representation, cf. <hlink|String
  Processing|#string-processing> below) with the
  <hlink|<with|font-family|tt|puts>|purelib.tm#puts> function from the
  <hlink|<with|font-family|tt|system>|purelib.tm#module-system> module (which
  is just the corresponding C function, so it prints a string on the
  terminal, followed by a newline).

  <\verbatim>
    \<gtr\> using system;

    \<gtr\> do (puts.str) (1..3);

    1

    2

    3

    ()
  </verbatim>

  Another useful list function is <hlink|<with|font-family|tt|filter>|purelib.tm#filter>
  which applies a predicate to each member of a list and collects all list
  elements which satisfy the predicate:

  <\verbatim>
    \<gtr\> odd x = x mod 2; even x = ~odd x;

    \<gtr\> filter odd (1..20);

    [1,3,5,7,9,11,13,15,17,19]

    \<gtr\> filter even (1..20);

    [2,4,6,8,10,12,14,16,18,20]
  </verbatim>

  In addition, the <hlink|<with|font-family|tt|all>|purelib.tm#all> and
  <hlink|<with|font-family|tt|any>|purelib.tm#any> functions can be used to
  check whether all or any list elements satisfy a given predicate:

  <\verbatim>
    \<gtr\> any even (1:3..20);

    0

    \<gtr\> all odd (1:3..20);

    1
  </verbatim>

  There's also a family of functions such as
  <hlink|<with|font-family|tt|foldl>|purelib.tm#foldl> which generalize the
  notion of aggregate functions such as list sums and products. Starting from
  a given initial value <verbatim|a>, <verbatim|foldl> iterates a binary
  function <verbatim|f> over a list <verbatim|xs> and returns the accumulated
  result. It's defined as follows:

  <\verbatim>
    foldl f a [] = a;

    foldl f a (x:xs) = foldl f (f a x) xs;
  </verbatim>

  For instance, we can use <verbatim|foldl> to compute list sums and
  products:

  <\verbatim>
    \<gtr\> foldl (+) 0 (1..10);

    55

    \<gtr\> foldl (*) 1 (1..10);

    3628800
  </verbatim>

  Note that <hlink|<with|font-family|tt|foldl>|purelib.tm#foldl>
  (``fold-left'') accumulates results from left to right, so the result
  accumulated so far is passed as the <em|left> argument to the function
  <verbatim|f>. There's a <hlink|<with|font-family|tt|foldr>|purelib.tm#foldr>
  (``fold-right'') function which works analogously but collects results from
  right to left, and accordingly passes the accumulated result in the
  <em|right> argument. Usually this won't make a difference if the iterated
  function is associative, but <verbatim|foldl> and <verbatim|foldr> have
  lots of applications beyond these simple use cases. For instance, we may
  use <verbatim|foldl> to reverse a list as follows:

  <\verbatim>
    \<gtr\> foldl (flip (:)) [] (1..10);

    [10,9,8,7,6,5,4,3,2,1]
  </verbatim>

  Note that we have to flip the arguments of the `<verbatim|:>` constructor
  here, since <verbatim|foldl> passes the accumulated list in the left
  argument, but `<verbatim|:>` wants it on the right. Conversely, we have
  that:

  <\verbatim>
    \<gtr\> foldr (:) [] (1..10);

    [1,2,3,4,5,6,7,8,9,10]
  </verbatim>

  This just returns the list unchanged. So the order in which we accumulate
  results does matter here.

  In a similar fashion, we might use <verbatim|foldl> (or <verbatim|foldr>)
  to build any kind of compound data structure from a list of its members.
  For instance, recall our binary tree example:

  <\verbatim>
    nonfix nil;

    insert nil y \ \ \ \ \ \ \ \ = bin y nil nil;

    insert (bin x L R) y = bin x (insert L y) R if y\<less\>x;

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ = bin x L (insert R y)
    otherwise;
  </verbatim>

  We can then use <verbatim|foldl> <verbatim|insert> to construct a binary
  tree from its member list as follows:

  <\verbatim>
    \<gtr\> foldl insert nil [7,12,9,5];

    bin 7 (bin 5 nil nil) (bin 12 (bin 9 nil nil) nil)
  </verbatim>

  Sometimes we'd like to know not just the final result of an aggregate
  function, but all the intermediate results as well. The
  <hlink|<with|font-family|tt|scanl>|purelib.tm#scanl> function does this.
  For instance:

  <\verbatim>
    \<gtr\> scanl (+) 0 (1..10);

    [0,1,3,6,10,15,21,28,36,45,55]
  </verbatim>

  Note that this computes the same list of partial sums as:

  <\verbatim>
    \<gtr\> [foldl (+) 0 (1..n) \| n = 0..10];

    [0,1,3,6,10,15,21,28,36,45,55]
  </verbatim>

  However, the former is more efficient since it does all the partial sums in
  one go.

  Like <verbatim|foldl>, <verbatim|scanl> also has a sibling called
  <hlink|<with|font-family|tt|scanr>|purelib.tm#scanr> which collects results
  from right to left, starting at the end of the list:

  <\verbatim>
    \<gtr\> scanr (+) 0 (1..10);

    [55,54,52,49,45,40,34,27,19,10,0]
  </verbatim>

  Another useful list generation function is
  <hlink|<with|font-family|tt|iterwhile>|purelib.tm#iterwhile> which keeps
  applying a function starting at a given initial value, as long as the
  current value satisfies the given predicate. So another way to generate the
  odd numbers up to 20 is:

  <\verbatim>
    \<gtr\> iterwhile (\<less\>=20) (+2) 1;

    [1,3,5,7,9,11,13,15,17,19]
  </verbatim>

  Or we might collect all powers of 2 which fall into the 16 bit range:

  <\verbatim>
    \<gtr\> iterwhile (\<less\>0x10000) (*2) 1;

    [1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768]
  </verbatim>

  There are also various functions to partition a list into different parts
  according to various criteria. The simplest of these are the
  <hlink|<with|font-family|tt|head>|purelib.tm#head> and
  <hlink|<with|font-family|tt|tail>|purelib.tm#tail> functions:

  <\verbatim>
    \<gtr\> let xs = 1..10;

    \<gtr\> head xs; tail xs;

    1

    [2,3,4,5,6,7,8,9,10]
  </verbatim>

  Conversely, the <hlink|<with|font-family|tt|last>|purelib.tm#last> and
  <hlink|<with|font-family|tt|init>|purelib.tm#init> functions give you the
  last element of a list, and all but the last element, respectively:

  <\verbatim>
    \<gtr\> last xs; init xs;

    10

    [1,2,3,4,5,6,7,8,9]
  </verbatim>

  The <hlink|<with|font-family|tt|take>|purelib.tm#take> and
  <hlink|<with|font-family|tt|drop>|purelib.tm#drop> functions take or remove
  a given number of initial elements, while
  <hlink|<with|font-family|tt|takewhile>|purelib.tm#takewhile> and
  <hlink|<with|font-family|tt|dropwhile>|purelib.tm#dropwhile> take or remove
  initial elements while a given predicate is satisfied:

  <\verbatim>
    \<gtr\> take 4 xs; drop 4 xs;

    [1,2,3,4]

    [5,6,7,8,9,10]

    \<gtr\> takewhile (\<less\>=4) xs; dropwhile (\<less\>=4) xs;

    [1,2,3,4]

    [5,6,7,8,9,10]
  </verbatim>

  Lists can be reversed with <hlink|<with|font-family|tt|reverse>|purelib.tm#reverse>
  and sorted using <hlink|<with|font-family|tt|sort>|purelib.tm#sort>:

  <\verbatim>
    \<gtr\> reverse xs;

    [10,9,8,7,6,5,4,3,2,1]

    \<gtr\> sort (\<less\>) (xs + ans);

    [1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10]
  </verbatim>

  You can also concatenate a list of lists with the
  <hlink|<with|font-family|tt|cat>|purelib.tm#cat> function:

  <\verbatim>
    \<gtr\> cat [1..n \| n = 1..5];

    [1,1,2,1,2,3,1,2,3,4,1,2,3,4,5]
  </verbatim>

  Last but not least, there is the <verbatim|zip> family of functions which
  let you combine members of two or more lists in different ways. The
  <hlink|<with|font-family|tt|zip>|purelib.tm#zip> function itself collects
  pairs of corresponding elements in two input lists:

  <\verbatim>
    \<gtr\> zip (1..5) ("a".."e");

    [(1,"a"),(2,"b"),(3,"c"),(4,"d"),(5,"e")]
  </verbatim>

  The effect of <hlink|<with|font-family|tt|zip>|purelib.tm#zip> can be
  undone with <hlink|<with|font-family|tt|unzip>|purelib.tm#unzip> which
  returns a pair of lists:

  <\verbatim>
    \<gtr\> unzip ans;

    [1,2,3,4,5],["a","b","c","d","e"]
  </verbatim>

  The <hlink|<with|font-family|tt|zipwith>|purelib.tm#zipwith> function is a
  generic version of <hlink|<with|font-family|tt|zip>|purelib.tm#zip> which
  combines corresponding members from two lists using a given binary function
  <verbatim|f>:

  <\verbatim>
    \<gtr\> zipwith (*) (1..10) (1..10);

    [1,4,9,16,25,36,49,64,81,100]
  </verbatim>

  You might also consider <verbatim|zipwith> a variant of <verbatim|map>
  working with two lists at the same time (in fact this operation is also
  known as <verbatim|map2> in some functional programming languages). There
  are also variations of these functions which work with three lists
  (<hlink|<with|font-family|tt|zip3>|purelib.tm#zip3>,
  <hlink|<with|font-family|tt|unzip3>|purelib.tm#unzip3>,
  <hlink|<with|font-family|tt|zipwith3>|purelib.tm#zipwith3>).

  Note that <verbatim|zip> itself is equivalent to <verbatim|zipwith>
  <verbatim|(,)>:

  <\verbatim>
    \<gtr\> zipwith (,) (1..5) ("a".."e");

    [(1,"a"),(2,"b"),(3,"c"),(4,"d"),(5,"e")]
  </verbatim>

  Also note that since tuples are formed by just applying the `<verbatim|,>`
  operator repeatedly, you can use multiple calls of <verbatim|zip> to piece
  together tuples of any length:

  <\verbatim>
    \<gtr\> zip (1..3) (zip ("a".."c") [a,b,c]);

    [(1,"a",a),(2,"b",b),(3,"c",c)]
  </verbatim>

  This can be achieved even more easily by folding <verbatim|zip> over a list
  of lists; here we employ a variation <hlink|<with|font-family|tt|foldr1>|purelib.tm#foldr1>
  of <hlink|<with|font-family|tt|foldr>|purelib.tm#foldr> which takes the
  initial value from the beginning of the list.

  <\verbatim>
    \<gtr\> foldr1 zip [1..3,"a".."c",[a,b,c]];

    [(1,"a",a),(2,"b",b),(3,"c",c)]
  </verbatim>

  Note that this method easily scales up to as many element lists as you
  want. Recovering the original element lists is a bit trickier, though, but
  it can be done using this little helper function:

  <\verbatim>
    unzipn n xs = xs if n\<less\>=1;

    \ \ \ \ \ \ \ \ \ \ \ \ = xs,unzipn (n-1) ys when xs,ys = unzip xs end
    otherwise;
  </verbatim>

  For instance:

  <\verbatim>
    \<gtr\> foldr1 zip [1..3,"a".."c",[a,b,c]];

    [(1,"a",a),(2,"b",b),(3,"c",c)]

    \<gtr\> unzipn 3 ans;

    [1,2,3],["a","b","c"],[a,b,c]
  </verbatim>

  Also, the elements to be zipped don't have to be singletons, they can
  themselves be tuples of any size:

  <\verbatim>
    \<gtr\> foldr1 zip [[1,2,3],[a,(),c],[x,y,(z,t)]];

    [(1,a,x),(2,y),(3,c,z,t)]
  </verbatim>

  But note that in this case you loose the information which elements came
  from which sublists, so <verbatim|unzip> won't be able to recover the
  original lists any more. If you need to avoid that then it's best to use
  other aggregates such as lists or vectors for the sublist elements.

  There are other interesting list functions in the prelude, but we'll leave
  it at that for now. Please check the <hlink|<em|Pure Library
  Manual>|purelib.tm> for a full account of the available operations.

  <subsubsection|String Processing<label|string-processing>>

  Let's take a short break from lists and look at strings. We postponed that
  until now since strings are in many ways just like lists of characters. In
  fact the similarities run so deep that in some languages, most notably
  Haskell, strings <em|are> in fact just lists. Pure doesn't go quite that
  far; it still represents strings as null-terminated arrays of characters in
  the UTF-8 encoding, which is a much more compact representation and eases
  interoperability with C. However, most common list operations also work on
  strings in an analogous fashion. Thus you can concatenate strings, compute
  their length, and index, slice and compare them as usual:

  <\verbatim>
    \<gtr\> "abc"+"xyz";

    "abcxyz"

    \<gtr\> #ans, ans!5, ans!![2,3];

    6,"z","cx"

    \<gtr\> "abc"=="abd";

    0
  </verbatim>

  In addition, strings can also be ordered lexicographically:

  <\verbatim>
    \<gtr\> "abd"\<less\>"abcd";

    0

    \<gtr\> "abd"\<gtr\>"abcd";

    1

    \<gtr\> sort (\<less\>) ["the","little","brown","fox"];

    ["brown","fox","little","the"]
  </verbatim>

  Where it makes sense, list operations on strings return again a string
  result:

  <\verbatim>
    \<gtr\> head "abc"; tail "abc";

    "a"

    "bc"

    \<gtr\> take 4 "abcdefg"; drop 4 "abcdefg";

    "abcd"

    "efg"
  </verbatim>

  A slight complication arises with the <hlink|<with|font-family|tt|map>|purelib.tm#map>
  function, because in this case the result is not guaranteed to be a string
  in all cases. For instance:

  <\verbatim>
    \<gtr\> map ord "HAL";

    [72,65,76]
  </verbatim>

  To have <verbatim|map> work consistently, it will thus yield a list even in
  cases where the result <em|could> again be represented as a string. If you
  want a string result instead, you'll have to do the conversion explicitly,
  using the <hlink|<with|font-family|tt|string>|purelib.tm#string> function:

  <\verbatim>
    \<gtr\> map (+1) "HAL";

    ["I","B","M"]

    \<gtr\> string ans;

    "IBM"
  </verbatim>

  Conversely, you can also convert a string to a list of its characters using
  either <hlink|<with|font-family|tt|chars>|purelib.tm#chars> or the generic
  <hlink|<with|font-family|tt|list>|purelib.tm#list/string> conversion
  function:

  <\verbatim>
    \<gtr\> list ans;

    ["I","B","M"]
  </verbatim>

  As in the case of <hlink|<with|font-family|tt|map>|purelib.tm#map>, this
  conversion is usually done automatically if a list operation from the
  prelude is applied to a string. This also happens if a list comprehension
  draws values from a string:

  <\verbatim>
    \<gtr\> [x-1 \| x = "IBM"];

    ["H","A","L"]
  </verbatim>

  Talking about characters, these are simply single character strings, so
  Pure has no separate data type for them. However, there is a type tag
  <hlink|<with|font-family|tt|char>|purelib.tm#char/type> for the single
  character strings which can be used in pattern matching:

  <\verbatim>
    \<gtr\> isupper x::char = "A"\<less\>=x && x\<less\>= "Z";

    \<gtr\> filter isupper "The Little Brown Fox";

    "TLBF"

    \<gtr\> any isupper "The Little Brown Fox";

    1
  </verbatim>

  Maybe you wondered how that <verbatim|"HAL"> <verbatim|=\>>
  <verbatim|"IBM"> transformation above came about? Well, the prelude also
  defines basic arithmetic on characters:

  <\verbatim>
    \<gtr\> "a"+1, "a"+2, "z"-1;

    "b","c","y"

    \<gtr\> "z"-"a";

    25
  </verbatim>

  This considers characters as an enumerated data type where each character
  corresponds to a numeric code point in Unicode. Hence, e.g.,
  <verbatim|"a"+1> gives <verbatim|"b"> because <verbatim|"b"> is the code
  point following <verbatim|"a"> in Unicode, and <verbatim|"b"-"a"> gives 1
  for the same reason.

  So here's the rot13 encoding in Pure:

  <\verbatim>
    rot13 x::string = string (map rot13 x) with

    \ \ rot13 c = c+13 if "a" \<less\>= lower c && lower c \<less\>= "m";

    \ \ \ \ \ \ \ \ \ \ = c-13 if "n" \<less\>= lower c && lower c \<less\>=
    "z";

    \ \ \ \ \ \ \ \ \ \ = c otherwise;

    \ \ lower c = "a"+(c-"A") if "A"\<less\>=c && c\<less\>="Z";

    \ \ \ \ \ \ \ \ \ \ = c otherwise;

    end;
  </verbatim>

  For instance:

  <\verbatim>
    \<gtr\> rot13 "The quick brown fox";

    "Gur dhvpx oebja sbk"

    \<gtr\> rot13 ans;

    "The quick brown fox"
  </verbatim>

  Character arithmetic also makes arithmetic sequences of characters work as
  expected:

  <\verbatim>
    \<gtr\> "a".."k"; "k":"j".."a";

    ["a","b","c","d","e","f","g","h","i","j","k"]

    ["k","j","i","h","g","f","e","d","c","b","a"]

    \<gtr\> string ("a":"c".."z");

    "acegikmoqsuwy"
  </verbatim>

  You can also convert between characters and their ordinal numbers using the
  <hlink|<with|font-family|tt|ord>|purelib.tm#ord> and
  <hlink|<with|font-family|tt|chr>|purelib.tm#chr> functions:

  <\verbatim>
    \<gtr\> ord "a";

    97

    \<gtr\> chr (ans+1);

    "b"
  </verbatim>

  Thus using Horner's rule we might convert a string of decimal digits to its
  numeric representation as follows:

  <\verbatim>
    \<gtr\> foldl (\\x c -\<gtr\> 10*x+ord c-ord "0") 0 "123456";

    123456
  </verbatim>

  However, there are much easier and more general ways to convert between
  strings and Pure expressions. Specifically,
  <hlink|<with|font-family|tt|val>|purelib.tm#val> and
  <hlink|<with|font-family|tt|str>|purelib.tm#str> can be used to convert
  between any Pure value and its string representation:

  <\verbatim>
    \<gtr\> val "2*(3+4)"; str ans;

    2*(3+4)

    "2*(3+4)"
  </verbatim>

  If you also want to evaluate the string representation of a Pure expression
  then <hlink|<with|font-family|tt|eval>|purelib.tm#eval> is your friend:

  <\verbatim>
    \<gtr\> eval "2*(3+4)";

    14
  </verbatim>

  Two other convenient functions are <hlink|<with|font-family|tt|split>|purelib.tm#split>
  which breaks apart a string at a given delimiter string, and
  <hlink|<with|font-family|tt|join>|purelib.tm#join> which concatenates a
  list of strings, interpolating the delimiter string between successive list
  elements:

  <\verbatim>
    \<gtr\> split " " "The quick brown fox";

    ["The","quick","brown","fox"]

    \<gtr\> join ":" ans;

    "The:quick:brown:fox"
  </verbatim>

  If you don't need the intervening delimiters then you can also concatenate
  string lists simply with <hlink|<with|font-family|tt|strcat>|purelib.tm#strcat>:

  <\verbatim>
    \<gtr\> strcat ["The","quick","brown","fox"];

    "Thequickbrownfox"
  </verbatim>

  These operations are all implemented in an efficient way so that they run
  in linear time. (Note that the <hlink|<with|font-family|tt|string>|purelib.tm#string>
  conversion function we mentioned above is in fact just
  <hlink|<with|font-family|tt|strcat>|purelib.tm#strcat> on lists of strings,
  but it also works with other aggregates such as vectors of strings.)

  For more elaborate needs there's also a suite of functions for doing
  regular expression matching in the <hlink|<with|font-family|tt|regex>|purelib.tm#module-regex>
  module, and the <hlink|<with|font-family|tt|system>|purelib.tm#module-system>
  module provides the usual facilities for reading and writing strings
  from/to text files and the terminal, as well as the
  <hlink|<with|font-family|tt|printf>|purelib.tm#printf> and
  <hlink|<with|font-family|tt|scanf>|purelib.tm#scanf> family of functions
  which are used to print and parse strings according to a given format
  string. These are all explained in detail in the <hlink|<em|Pure Library
  Manual>|purelib.tm>.

  <subsubsection|List Comprehensions<label|list-comprehensions>>

  List comprehensions are Pure's main workhorse for generating and processing
  all kinds of list values. You can think of them as a combination of
  <hlink|<with|font-family|tt|map>|purelib.tm#map> and
  <hlink|<with|font-family|tt|filter>|purelib.tm#filter> using a prettier
  syntax reminiscent of the way in which sets are commonly specified in
  mathematics. List comprehensions are in fact just syntactic sugar, so
  anything that can be done with them can also be accomplished with Pure's
  generic list functions; but often they are much easier to write and
  understand.

  In the simplest case, list comprehensions are just a shorthand for
  <hlink|<with|font-family|tt|map>|purelib.tm#map> with lambdas:

  <\verbatim>
    \<gtr\> [2*x-1 \| x = 1..10];

    [1,3,5,7,9,11,13,15,17,19]
  </verbatim>

  This can be read aloud as ``the list of all <verbatim|2*x-1> for which
  <verbatim|x> runs through the list <verbatim|1..10>''. The part
  <verbatim|x> <verbatim|=> <verbatim|1..10> is called a
  <with|font-series|bold|generator clause>. The comprehension binds
  <verbatim|x> to each member of the list <verbatim|1..10> in turn and
  evaluates the target expression <verbatim|2*x+1> in the context of this
  binding. This is equivalent to the following <verbatim|map> expression:

  <\verbatim>
    \<gtr\> map (\\x-\<gtr\>2*x-1) (1..10);

    [1,3,5,7,9,11,13,15,17,19]
  </verbatim>

  List comprehensions may also involve <with|font-series|bold|filter
  clauses>: predicates which determine the elements that are to be included
  in the result list.

  <\verbatim>
    \<gtr\> [2*x-1 \| x = 1..10; x mod 3];

    [1,3,7,9,13,15,19]
  </verbatim>

  This can be read as ``the list of all <verbatim|2*x-1> for which
  <verbatim|x> runs through <verbatim|1..10> and for which <verbatim|x>
  <verbatim|mod> <verbatim|3> is non-zero'' (which means that <verbatim|x> is
  not a multiple of <verbatim|3>). It is roughly equivalent to:

  <\verbatim>
    \<gtr\> map (\\x-\<gtr\>2*x-1) (filter (\\x-\<gtr\>x mod 3) (1..10));

    [1,3,7,9,13,15,19]
  </verbatim>

  List comprehensions can also draw values from other kinds of aggregates
  such as strings and matrices, but the result is always a list:

  <\verbatim>
    \<gtr\> [x-1 \| x = "IBM"];

    ["H","A","L"]

    \<gtr\> [1/x \| x = {1,2,3;4,5,6}; ~x mod 2];

    [0.5,0.25,0.166666666666667]
  </verbatim>

  List comprehensions can have as many generator and filter clauses as you
  want. The clauses are considered in left-to-right order so that later
  clauses may refer to any variables introduced in earlier generator clauses.
  E.g., here's how you can generate the list of all pairs <verbatim|(i,j)>
  with <verbatim|1\<=i\<=j\<=5> such that <verbatim|i+j> is even:

  <\verbatim>
    \<gtr\> [i,j \| i = 1..5; j = i..5; ~(i+j) mod 2];

    [(1,1),(1,3),(1,5),(2,2),(2,4),(3,3),(3,5),(4,4),(5,5)]
  </verbatim>

  The left-hand side of a generator clause can be an arbitary pattern, which
  is useful if you need to peek at the list elements to see what's inside.
  For instance, let's take the previous result and check that the sums of the
  number pairs are in fact all even:

  <\verbatim>
    \<gtr\> [i+j \| i,j = ans];

    [2,4,6,4,6,6,8,8,10]
  </verbatim>

  Generator clauses involving patterns also act as filters; unmatched
  elements are filtered out automatically:

  <\verbatim>
    \<gtr\> [i+j \| i,j = ["to be ignored",(1,1),(2,2),3]];

    [2,4]
  </verbatim>

  List comprehensions can also be nested to an arbitrary depth. For instance,
  we may rewrite the ``even sums'' comprehension from above as follows, in
  order to group the pairs into sublists for each value of <verbatim|i>:

  <\verbatim>
    \<gtr\> [[i,j \| j = i..5; ~(i+j) mod 2] \| i = 1..5];

    [[(1,1),(1,3),(1,5)],[(2,2),(2,4)],[(3,3),(3,5)],[(4,4)],[(5,5)]]
  </verbatim>

  A notorious example is the following recursive algorithm which implements a
  variation of Erathosthenes' classical prime sieve. (This method is actually
  rather slow and thus not suitable for computing large primes, but we're not
  concerned with that here.)

  <\verbatim>
    primes n \ \ \ \ \ \ \ = sieve (2..n) with

    \ \ sieve [] \ \ \ \ \ = [];

    \ \ sieve (p:qs) \ = p : sieve [q \| q = qs; q mod p];

    end;
  </verbatim>

  Note that the sieve recursively filters out the multiples of the current
  front element <verbatim|p> of the list, which, by virtue of the
  construction, is always a prime number. The result is the list of all
  primes up to <verbatim|n>:

  <\verbatim>
    \<gtr\> primes 100;

    [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97]
  </verbatim>

  List comprehensions are also a useful device to organize backtracking
  searches. For instance, here's an algorithm for the n queens problem, which
  returns the list of all placements of <verbatim|n> queens on an
  <verbatim|n> x <verbatim|n> board (encoded as lists of <verbatim|n> pairs
  <verbatim|(i,j)> with <verbatim|i> <verbatim|=> <verbatim|1..n>), so that
  no two queens hold each other in check:

  <\verbatim>
    queens n \ \ \ \ \ \ = search n 1 [] with

    \ \ search n i p = [reverse p] if i\<gtr\>n;

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ = cat [search n (i+1) ((i,j):p) \| j =
    1..n; safe (i,j) p];

    \ \ safe (i,j) p = ~any (check (i,j)) p;

    \ \ check (i1,j1) (i2,j2)

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ = i1==i2 \|\| j1==j2 \|\| i1+j1==i2+j2 \|\|
    i1-j1==i2-j2;

    end;
  </verbatim>

  <subsubsection|Lazy Evaluation and Streams<label|lazy-evaluation-and-streams>>

  As already mentioned, lists can also be evaluated in a ``lazy'' fashion, by
  just turning the tail of a list into a future. This special kind of list is
  also called a <with|font-series|bold|stream>. Streams enable you to work
  with infinite lists (or finite lists which are so huge that you would never
  want to keep them in memory in their entirety). E.g., here's one way to
  define the infinite stream of all Fibonacci numbers:

  <\verbatim>
    \<gtr\> let fibs = fibs 0L 1L with fibs a b = a : fibs b (a+b) & end;

    \<gtr\> fibs;

    0L:#\<less\>thunk 0xb5d54320\<gtr\>
  </verbatim>

  Note the <hlink|<with|font-family|tt|&>|#-amp> on the tail of the list in
  the definition of the local <verbatim|fibs> function. This turns the result
  of <verbatim|fibs> into a stream, which is required to prevent the function
  from recursing into samadhi. Also note that we work with bigints in this
  example because the Fibonacci numbers grow quite rapidly, so with machine
  integers the values would soon start wrapping around to negative integers.

  Streams like these can be worked with in pretty much the same way as with
  lists. Of course, care must be taken not to invoke ``eager'' operations
  such as <hlink|<with|font-family|tt|#>|purelib.tm##> (which computes the
  size of a list) on infinite streams, to prevent infinite recursion.
  However, many list operations work with infinite streams just fine, and
  return the appropriate stream results. E.g., the
  <hlink|<with|font-family|tt|take>|purelib.tm#take> function (which
  retrieves a given number of elements from the front of a list) works with
  streams just as well as with ``eager'' lists:

  <\verbatim>
    \<gtr\> take 10 fibs;

    0L:#\<less\>thunk 0xb5d54350\<gtr\>
  </verbatim>

  Hmm, not much progress there, but that's just how streams work (or rather
  they don't, they're lazy bums indeed!). Nevertheless, the stream computed
  with <hlink|<with|font-family|tt|take>|purelib.tm#take> is in fact finite
  and we can readily convert it to an ordinary list, forcing its evaluation:

  <\verbatim>
    \<gtr\> list (take 10 fibs);

    [0L,1L,1L,2L,3L,5L,8L,13L,21L,34L]
  </verbatim>

  An alternative way to achieve this is to cut a ``slice'' from the stream:

  <\verbatim>
    \<gtr\> fibs!!(0..10);

    [0L,1L,1L,2L,3L,5L,8L,13L,21L,34L,55L]
  </verbatim>

  Note that since we bound the stream to a variable, the already computed
  prefix of the stream has been memoized, so that this portion of the stream
  is now readily available in case we need to have another look at it later.
  By these means, possibly costly reevaluations are avoided, trading memory
  for execution speed:

  <\verbatim>
    \<gtr\> fibs;

    0L:1L:1L:2L:3L:5L:8L:13L:21L:34L:55L:#\<less\>thunk 0xb5d54590\<gtr\>
  </verbatim>

  The prelude also provides some convenience operations for generating stream
  values. Infinite arithmetic sequences are specified using <verbatim|inf> or
  <verbatim|-inf> to denote an upper (or lower) infinite bound for the
  sequence, e.g.:

  <\verbatim>
    \<gtr\> let u = 1..inf; let v = -1.0:-1.2..-inf;

    \<gtr\> u!!(0..10); v!!(0..10);

    [1,2,3,4,5,6,7,8,9,10,11]

    [-1.0,-1.2,-1.4,-1.6,-1.8,-2.0,-2.2,-2.4,-2.6,-2.8,-3.0]
  </verbatim>

  Other useful stream generator functions are
  <hlink|<with|font-family|tt|iterate>|purelib.tm#iterate>, which keeps
  applying the same function over and over again,
  <hlink|<with|font-family|tt|repeat>|purelib.tm#repeat>, which just repeats
  its argument forever, and <hlink|<with|font-family|tt|cycle>|purelib.tm#cycle>,
  which cycles through the elements of the given list:

  <\verbatim>
    \<gtr\> iterate (*2) 1!!(0..10);

    [1,2,4,8,16,32,64,128,256,512,1024]

    \<gtr\> repeat 1!!(0..10);

    [1,1,1,1,1,1,1,1,1,1,1]

    \<gtr\> cycle [0,1]!!(0..10);

    [0,1,0,1,0,1,0,1,0,1,0]
  </verbatim>

  Moreover, list comprehensions can draw values from streams and return the
  appropriate stream result:

  <\verbatim>
    \<gtr\> let rats = [m,n-m \| n=2..inf; m=1..n-1; gcd m (n-m) == 1]; rats;

    (1,1):#\<less\>thunk 0xb5d54950\<gtr\>

    \<gtr\> rats!!(0..10);

    [(1,1),(1,2),(2,1),(1,3),(3,1),(1,4),(2,3),(3,2),(4,1),(1,5),(5,1)]
  </verbatim>

  We can also rewrite our prime sieve so that it generates the infinite
  stream of <em|all> prime numbers:

  <\verbatim>
    all_primes \ \ \ \ \ = sieve (2..inf) with

    \ \ sieve (p:qs) \ = p : sieve [q \| q = qs; q mod p] &;

    end;
  </verbatim>

  Note that we can omit the empty list case of <verbatim|sieve> here, since
  the sieve now never becomes empty. Example:

  <\verbatim>
    \<gtr\> let P = all_primes;

    \<gtr\> P!!(0..20);

    [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73]

    \<gtr\> P!299;

    1987
  </verbatim>

  You can also just print the entire stream. Note that this sieve algorithm
  isn't tail-recursive, so the following will eventually result in a stack
  overflow. But this will take a while, so you may want to hit
  <verbatim|Ctrl-c> when you get bored:

  <\verbatim>
    \<gtr\> using system;

    \<gtr\> do (printf "%d\\n") all_primes;

    2

    3

    5

    \ \ ...
  </verbatim>

  It's also possible to convert an ordinary list to a stream:

  <\verbatim>
    \<gtr\> stream (1..10);

    1:#\<less\>thunk 0x7f2692a0f138\<gtr\>
  </verbatim>

  This may seem like a silly thing to do, because the original list is
  already fully known beforehand. But this transformation allows us to
  traverse the list in a lazy fashion, which can be useful if the list is
  employed in a list comprehension or processed by functions such as
  <hlink|<with|font-family|tt|cat>|purelib.tm#cat> and
  <hlink|<with|font-family|tt|map>|purelib.tm#map>. For instance, we can use
  this to rewrite the <verbatim|fringe> function from <hlink|The Same-Fringe
  Problem|#the-same-fringe-problem> so that it calculates the fringe in a
  lazy fashion:

  <\verbatim>
    lazyfringe t = if listp t then catmap lazyfringe (stream t) else [t];
  </verbatim>

  Recall that the fringe of a tree is the list of its leaves in left-to-right
  order. The tree itself is represented as a nested list, to which
  <verbatim|lazyfringe> applies <hlink|<with|font-family|tt|stream>|purelib.tm#stream>
  recursively so that the fringe becomes a stream whose elements are only
  produced on demand:

  <\verbatim>
    \<gtr\> lazyfringe [[a,b],c,[[d]],e,[f,[[g,h]]]];

    a:#\<less\>thunk 0x7f127fc1f090\<gtr\>

    \<gtr\> list ans;

    [a,b,c,d,e,f,g,h]
  </verbatim>

  Hence a simple syntactic equality check now suffices to solve the
  same-fringe problem in an efficient way. For instance, consider the
  following sample trees from <hlink|The Same-Fringe
  Problem|#the-same-fringe-problem>:

  <\verbatim>
    let t1 = [[a,b],c,[[d]],e,[f,[[g,h]]]];

    let t2 = [a,b,c,[[d],[],e],[f,[g,[h]]]];

    let t3 = [[a,b],d,[[c]],e,[f,[[g,h]]]];
  </verbatim>

  Let's also bind the fringes to some variables so that we can check which
  parts actually get evaluated:

  <\verbatim>
    let l1 = lazyfringe t1;

    let l2 = lazyfringe t2;

    let l3 = lazyfringe t3;
  </verbatim>

  Now comparing <verbatim|l3> and <verbatim|l2> we get:

  <\verbatim>
    \<gtr\> l3 === l2; l3; l2;

    0

    a:b:d:#\<less\>thunk 0x7fd308116178\<gtr\>

    a:b:c:#\<less\>thunk 0x7fd308116060\<gtr\>
  </verbatim>

  As you can see, the two fringes were only constructed as far as needed to
  decide that they differ. Of course, if we compare <verbatim|l1> and
  <verbatim|l2> then the fringes will still be fully constructed before we
  find that they're equal:

  <\verbatim>
    \<gtr\> l1 === l2; l1; l2;

    1

    [a,b,c,d,e,f,g,h]

    [a,b,c,d,e,f,g,h]
  </verbatim>

  But this doesn't really matter if we construct the fringes as temporary
  values, as in:

  <\verbatim>
    \<gtr\> fringe t1 === fringe t2;
  </verbatim>

  Now only the parts of the fringes are in memory which are currently under
  scrutiny as the `<hlink|<with|font-family|tt|===>|purelib.tm#===>` operator
  passes over them; the prefixes which have already been found to be equal
  can be garbage-collected immediately. Moreover, the
  `<hlink|<with|font-family|tt|===>|purelib.tm#===>` operator is
  tail-recursive so that the entire equality test can be executed in constant
  stack space. This gives us an easier way to solve the same-fringe problem
  which has pretty much the same benefits as our earlier solution using
  continuations. The latter might still be considered more elegant, because
  it works without actually constructing the fringes at all. But the solution
  using lazy evaluation is certainly much simpler.

  <subsubsection|Matrices and Vectors<label|matrices-and-vectors>>

  Pure has a versatile matrix data structure offering compact storage and
  efficient random access to its members. Pure matrices work pretty much like
  in MATLAB or Octave, except that indexes are zero-based and elements are
  stored in C's row-major rather than Fortran's column-major format. They are
  also binary-compatible with the GNU Scientific Library (<hlink|GSL|#gsl>)
  so that they can readily be passed to GSL functions for doing numeric
  calculations.

  Pure offers a number of basic matrix operations, such as matrix
  construction, pattern matching, indexing, slicing, as well as getting the
  size and dimensions of a matrix. It does <em|not> supply built-in support
  for matrix arithmetic and other linear algebra algorithms, but it's easy to
  roll your own if desired, as we'll see below. (Usually this won't offer the
  same performance as the GSL and other carefully optimized C and Fortran
  routines, however. So if you need to do some heavy-duty number crunching
  then you might want to take a look at the pure-gsl module available at the
  Pure website, which is an ongoing project to make the GSL functions
  available in Pure.)

  Matrices are denoted using curly braces in Pure:

  <\verbatim>
    \<gtr\> let x = {1,2,3;4,5,6}; x;

    {1,2,3;4,5,6}
  </verbatim>

  Note that the semicolon is used to separate different rows, while the
  elements inside each row are separated with commas. Thus the above denotes
  a 2x3 matrix (2 rows, 3 columns). The <hlink|<with|font-family|tt|dim>|purelib.tm#dim>
  function lets you check the dimensions, while the
  `<hlink|<with|font-family|tt|#>|purelib.tm##>` operator gives the total
  number of elements:

  <\verbatim>
    \<gtr\> dim x; #x;

    2,3

    6
  </verbatim>

  There's no separate data type for vectors; row and column vectors are
  simply represented as 1 x n and n x 1 matrices, respectively:

  <\verbatim>
    \<gtr\> dim {1,2,3}; dim {1;2;3};

    1,3

    3,1
  </verbatim>

  Singleton and empty matrices can be denoted as follows:

  <\verbatim>
    \<gtr\> dim {1}; dim {};

    1,1

    0,0
  </verbatim>

  The <verbatim|transpose> function turns columns into rows and vice versa;
  in particular, you can also use this to convert between row and column
  vectors:

  <\verbatim>
    \<gtr\> transpose x;

    {1,4;2,5;3,6}

    \<gtr\> transpose {1,2,3}; transpose {1;2;3};

    {1;2;3}

    {1,2,3}
  </verbatim>

  Note that matrices are immutable in Pure, so matrix functions like
  <verbatim|transpose> always return a <em|new> matrix, leaving the original
  matrix unchanged. (If you need to modify matrices in-place for efficiency,
  then you can use the GSL or other C or Fortran functions.)

  You can change the dimensions of a matrix with the
  <hlink|<with|font-family|tt|redim>|purelib.tm#redim> function, provided
  that the size stays the same. So, for instance, we can turn the matrix
  <verbatim|x> into a row vector as follows:

  <\verbatim>
    \<gtr\> redim (1,6) x;

    {1,2,3,4,5,6}
  </verbatim>

  Again, this doesn't change the original matrix, but returns a new matrix
  with the same contents and the requested dimensions. This operation also
  allows you to change the dimensions of an empty matrix which, as we've seen
  above, has dimensions <verbatim|0,0> by default. Of course, this requires
  that either the number of rows or columns is still zero. For instance:

  <\verbatim>
    \<gtr\> redim (3,0) {};

    {}

    \<gtr\> dim ans;

    3,0
  </verbatim>

  Another way to do this is to just construct a zero matrix with zero rows or
  columns directly, see below. (Note that these different kinds of empty
  matrices are needed to represent the corner cases. E.g., a linear mapping
  from 3-dimensional vectors to the zero vector space corresponds to a 0x3
  matrix which yields a 3x0 matrix when transposed.)

  A number of other specific conversion operations are available, such as
  <hlink|<with|font-family|tt|rowvector>|purelib.tm#rowvector> and
  <hlink|<with|font-family|tt|colvector>|purelib.tm#colvector> which convert
  a matrix to a row or column vector, respectively, or
  <hlink|<with|font-family|tt|diag>|purelib.tm#diag> which extracts the main
  diagonal of a matrix:

  <\verbatim>
    \<gtr\> rowvector x;

    {1,2,3,4,5,6}

    \<gtr\> colvector x;

    {1;2;3;4;5;6}

    \<gtr\> diag x;

    {1,5}
  </verbatim>

  You can also extract the rows and columns of a matrix, which yields a list
  of the corresponding row and column vectors, respectively:

  <\verbatim>
    \<gtr\> rows x; cols x;

    [{1,2,3},{4,5,6}]

    [{1;4},{2;5},{3;6}]
  </verbatim>

  There are a number of other operations which convert between matrices and
  different kinds of aggregates; please check the <hlink|<em|Matrix
  Functions>|purelib.tm#matrix-functions> section in the <hlink|<em|Pure
  Library Manual>|purelib.tm> for details.

  Element access uses the index operator `<hlink|<with|font-family|tt|!>|purelib.tm#!/matrix>`.
  You can either specify a pair <verbatim|(i,j)> of row and column indices,
  or a single index <verbatim|i> which treats the entire matrix as a single
  vector in row-major order:

  <\verbatim>
    \<gtr\> x!(0,2);

    3

    \<gtr\> x!3;

    4
  </verbatim>

  Slicing is done with the `<hlink|<with|font-family|tt|!!>|purelib.tm#!!/matrix>`
  operator. The index range can be specified in different ways. First, a pair
  of lists of row and column indices cuts a rectangular slice from the
  matrix:

  <\verbatim>
    \<gtr\> x!!(0..1,1..2);

    {2,3;5,6}
  </verbatim>

  Second, a pair of a list and a row or column index cuts slices from
  individual rows or columns:

  <\verbatim>
    \<gtr\> x!!(0,1..2); x!!(0..1,2);

    {2,3}

    {3;6}
  </verbatim>

  Third, a list of pairs of row and column indices, or a list of element
  indices gives a row vector with all the corresponding elements:

  <\verbatim>
    \<gtr\> x!![(0,2),(1,2)];

    {3,6}

    \<gtr\> x!!(2..3);

    {3,4}
  </verbatim>

  While most of the slices above are contiguous (a case which the prelude
  optimizes for), you can also specify indices in any order, possibly with
  duplicates. So we may not only cut submatrix slices, but also permute
  and/or copy rows and columns of a matrix along the way:

  <\verbatim>
    \<gtr\> x!!([1,0,1],0..2);

    {4,5,6;1,2,3;4,5,6}
  </verbatim>

  Matrices can also be constructed from submatrices by arranging the
  submatrices in rows or columns. In fact, the curly braces accept any
  combination of submatrices and scalars, provided that all dimensions match
  up:

  <\verbatim>
    \<gtr\> {1,{2,3};{4,5},6};

    {1,2,3;4,5,6}

    \<gtr\> {{1;4},{2,3;5,6}};

    {1,2,3;4,5,6}

    \<gtr\> {{1;2;3},{4;5;6}};

    {1,4;2,5;3,6}
  </verbatim>

  The end result <em|must> be a rectangular matrix, however, otherwise you'll
  get an exception indicating a submatrix whose dimensions don't match:

  <\verbatim>
    \<gtr\> {1,{2,3};{4,5}};

    \<less\>stdin\<gtr\>, line 24: unhandled exception 'bad_matrix_value
    {4,5}'

    while evaluating '{1,{2,3};{4,5}}'
  </verbatim>

  This ``splicing'' of submatrices is especially useful when doing linear
  algebra, where matrices are often composed from smaller ``block matrices''
  or vectors; we'll see an example of this later. (Sometimes this behaviour
  also gets in the way, and thus there are ways to disable it; see
  <hlink|Symbolic Matrices|#symbolic-matrices> below.)

  Pure actually provides several different types of
  <with|font-series|bold|numeric matrices>, which correspond to the different
  GSL matrix types for integer, floating point and complex numbers. (Note
  that complex numbers aren't a built-in data type in Pure, but there are
  ways to specify this kind of numbers and perform calculations with them;
  see the <hlink|<with|font-family|tt|math>|purelib.tm#module-math> module
  for details.) Which type of matrix is created by the curly braces depends
  on the element types. Homogeneous matrices which contain only
  <hlink|<with|font-family|tt|int>|#int/type>,
  <hlink|<with|font-family|tt|double>|#double/type> or
  <hlink|<with|font-family|tt|complex>|purelib.tm#complex/type> values yield
  the corresponding type of GSL matrix. Matrices can also hold any other type
  of Pure value or an arbitrary mix of values, in which case they become
  <with|font-series|bold|symbolic matrices>; we'll discuss these later.

  The functions <hlink|<with|font-family|tt|imatrix>|purelib.tm#imatrix>,
  <hlink|<with|font-family|tt|dmatrix>|purelib.tm#dmatrix> and
  <hlink|<with|font-family|tt|cmatrix>|purelib.tm#cmatrix> can be used to
  convert between the different kinds of numeric matrices. For instance:

  <\verbatim>
    \<gtr\> dmatrix {1,2,3;4,5,6};

    {1.0,2.0,3.0;4.0,5.0,6.0}

    \<gtr\> imatrix ans;

    {1,2,3;4,5,6}

    \<gtr\> cmatrix ans;

    {1.0+:0.0,2.0+:0.0,3.0+:0.0;4.0+:0.0,5.0+:0.0,6.0+:0.0}

    \<gtr\> dmatrix ans;

    {1.0,0.0,2.0,0.0,3.0,0.0;4.0,0.0,5.0,0.0,6.0,0.0}
  </verbatim>

  (Note that the latter conversion turns a complex into a double matrix,
  interleaving the real and imaginary parts of the original matrix.)

  The same functions can also be used to construct zero matrices with given
  dimensions:

  <\verbatim>
    \<gtr\> imatrix (2,3);

    {0,0,0;0,0,0}

    \<gtr\> dmatrix (2,2);

    {0.0,0.0;0.0,0.0}

    \<gtr\> cmatrix (1,1);

    {0.0+:0.0}
  </verbatim>

  As already mentioned, this also gives you a direct way to create empty
  matrices with different dimensions. For instance:

  <\verbatim>
    \<gtr\> imatrix (0,3); dim ans;

    {}

    0,3
  </verbatim>

  The prelude offers matrix versions of the common list operations like
  <hlink|<with|font-family|tt|map>|purelib.tm#map>,
  <hlink|<with|font-family|tt|foldl>|purelib.tm#foldl>,
  <hlink|<with|font-family|tt|zip>|purelib.tm#zip> etc., which provide a way
  to implement common matrix operations. E.g., multiplying a matrix
  <verbatim|x> with a scalar <verbatim|a> amounts to mapping the function
  <verbatim|(a*)> to x, which can be done as follows:

  <\verbatim>
    \<gtr\> type scalar x = ~matrixp x;

    \<gtr\> a::scalar * x::matrix = map (a*) x;

    \<gtr\> 2*{1,2,3;4,5,6};

    {2,4,6;8,10,12}
  </verbatim>

  Note that the <hlink|<with|font-family|tt|matrix>|#matrix/type> type tag or
  the <hlink|<with|font-family|tt|matrixp>|purelib.tm#matrixp> predicate can
  be used to restrict a variable to matrix values. (The prelude provides a
  few other types and corresponding predicates for various specific kinds of
  matrices, see the <hlink|<em|Pure Library Manual>|purelib.tm> for details.)
  In addition, we also introduced a convenience type <verbatim|scalar> for
  non-matrix values here, so that we can distinguish scalar from matrix
  multiplication which will be discussed below.

  Matrix addition and other element-wise operations can be realized using
  <hlink|<with|font-family|tt|zipwith>|purelib.tm#zipwith>, which combines
  corresponding elements of two matrices using a given binary function:

  <\verbatim>
    \<gtr\> x::matrix + y::matrix = zipwith (+) x y if dim x == dim y;

    \<gtr\> {1,2,3;4,5,6}+{1,2,1;3,2,3};

    {2,4,4;7,7,9}
  </verbatim>

  Another way to define matrix functions in Pure is to employ a
  <with|font-series|bold|matrix pattern>. The Pure language has built-in
  support for these, so that they work like the other kinds of patterns we've
  already encountered. For instance, to compute the dot product of two 2D
  vectors, you may write something like:

  <\verbatim>
    \<gtr\> {x1,y1}*{x2,y2} = x1*x2+y1*y2;

    \<gtr\> {2,3}*{1,4};

    14
  </verbatim>

  Or, to compute the determinant of a 2x2 matrix:

  <\verbatim>
    \<gtr\> det {a,b;c,d} = a*d-b*c;

    \<gtr\> det {1,2;3,4};

    -2
  </verbatim>

  These patterns are convenient if the dimensions of the involved matrices
  are small and known beforehand. If this isn't the case then it's better to
  use <with|font-series|bold|matrix comprehensions> instead, which work with
  arbitrary dimensions and make it easy to express many simple kinds of
  algorithms which would typically be done using <verbatim|for> loops in
  conventional programming languages.

  Matrix comprehensions work pretty much like list comprehensions, but with a
  special twist: if values are drawn from lists then the generator clauses
  alternate between row and column generation. (More precisely, the last
  generator, which varies most quickly, yields a row, the next-to-last one a
  column of these row vectors, and so on.) This makes matrix comprehensions
  resemble customary mathematical notation very closely. For instance, here
  is how we can define an operation to create a square identity matrix of a
  given dimension (note that the <verbatim|i==j> term is just a Pure idiom
  for the Kronecker symbol):

  <\verbatim>
    \<gtr\> eye n = {i==j \| i = 1..n; j = 1..n};

    \<gtr\> eye 3;

    {1,0,0;0,1,0;0,0,1}
  </verbatim>

  Of course, matrix comprehensions can also draw values from other matrices
  instead of lists. In this case the block layout of the component matrices
  is preserved. For instance:

  <\verbatim>
    \<gtr\> {x,y \| x = {1,2}; y = {a,b;c,d}};

    {(1,a),(1,b),(2,a),(2,b);(1,c),(1,d),(2,c),(2,d)}
  </verbatim>

  Note that a matrix comprehension involving filters may fail because the
  filtered result isn't a rectangular matrix any more. E.g.,
  <verbatim|{2*x\|x={1,2,3,-4};x\>0}> works, as does
  <verbatim|{2*x\|x={-1,2;3,-4};x\>0}>, but
  <verbatim|{2*x\|x={1,2;3,-4};x\>0}> doesn't because the rows of the result
  matrix have different lengths.

  As a slightly more comprehensive example (no pun intended!), here is a
  definition of matrix multiplication in Pure:

  <\verbatim>
    x::matrix * y::matrix = {dot u v \| u = rows x; v = cols y} with

    \ \ dot u v = foldl (+) 0 $ zipwith (*) u (rowvector v);

    end if m==n when _,m = dim x; n,_ = dim y end;
  </verbatim>

  The basic building block in this example is the dot product of two vectors,
  which is defined as a local function. The matrix product is obtained by
  simply calculating the dot product of all the rows of <verbatim|x> with all
  the columns of <verbatim|y>. To make this work, the rows of <verbatim|x>
  should be the same length as the columns of <verbatim|y>, we check this
  condition in the guard of the rule. Let's give it a try:

  <\verbatim>
    \<gtr\> {1,0;0,1}*{1,2;3,4};

    {1,2;3,4}

    \<gtr\> {0,1;1,0}*{1,2;3,4};

    {3,4;1,2}

    \<gtr\> {0,1;1,0;1,1}*{1,2,3;4,5,6};

    {4,5,6;1,2,3;5,7,9}

    \<gtr\> {1,2;3,4}*{1;1};

    {3;7}
  </verbatim>

  Well, that was easy. So let's take a look at a more challenging example,
  Gaussian elimination, which can be used to solve systems of linear
  equations. The algorithm brings a matrix into ``row echelon'' form, a
  generalization of triangular matrices. The resulting system can then be
  solved quite easily using back substitution.

  Here is a Pure implementation of the algorithm. Note that the real meat is
  in the pivoting and elimination step (<verbatim|step> function) which is
  iterated over all columns of the input matrix. In each step, <verbatim|x>
  is the current matrix, <verbatim|i> the current row index, <verbatim|j> the
  current column index, and <verbatim|p> keeps track of the current
  permutation of the row indices performed during pivoting. The algorithm
  returns the updated matrix <verbatim|x>, row index <verbatim|i> and row
  permutation <verbatim|p>.

  <\verbatim>
    gauss_elimination x::matrix = p,x

    when n,m = dim x; p,_,x = foldl step (0..n-1,0,x) (0..m-1) end;

    \;

    // One pivoting and elimination step in column j of the matrix:

    step (p,i,x) j

    = if max_x==0 then p,i,x

    \ \ else

    \ \ \ \ // updated row permutation and index:

    \ \ \ \ transp i max_i p, i+1,

    \ \ \ \ {// the top rows of the matrix remain unchanged:

    \ \ \ \ \ x!!(0..i-1,0..m-1);

    \ \ \ \ \ // the pivot row, divided by the pivot element:

    \ \ \ \ \ {x!(i,l)/x!(i,j) \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| l=0..m-1};

    \ \ \ \ \ // subtract suitable multiples of the pivot row:

    \ \ \ \ \ {x!(k,l)-x!(k,j)*x!(i,l)/x!(i,j) \| k=i+1..n-1; l=0..m-1}}

    when

    \ \ n,m = dim x; max_i, max_x = pivot i (col x j);

    \ \ x = if max_x\<gtr\>0 then swap x i max_i else x;

    end with

    \ \ pivot i x \ \ \ \ \ \ = foldl max (0,0) [j,abs (x!j)\|j=i..#x-1];

    \ \ max (i,x) (j,y) = if x\<less\>y then j,y else i,x;

    end;
  </verbatim>

  Please refer to any good textbook on numerical mathematics for a closer
  description of the algorithm. But here is a brief rundown of what happens
  in each elimination step: First we find the pivot element in column
  <verbatim|j> of the matrix. (We're doing partial pivoting here, i.e., we
  only look for the element with the largest absolute value in column
  <verbatim|j>, starting at row <verbatim|i>. That's usually good enough to
  achieve numerical stability.) If the pivot is zero then we're done (the
  rest of the pivot column is already zeroed out). Otherwise, we bring it
  into the pivot position (swapping row <verbatim|i> and the pivot row),
  divide the pivot row by the pivot, and subtract suitable multiples of the
  pivot row to eliminate the elements of the pivot column in all subsequent
  rows. Finally we update <verbatim|i> and <verbatim|p> accordingly and
  return the result.

  In order to complete the implementation, we still need the following little
  helper functions to swap two rows of a matrix (this is used in the pivoting
  step) and to apply a transposition to a permutation (represented as a
  list):

  <\verbatim>
    swap x i j = x!!(transp i j (0..n-1),0..m-1) when n,m = dim x end;

    transp i j p = [p!tr k \| k=0..#p-1]

    with tr k = if k==i then j else if k==j then i else k end;
  </verbatim>

  Finally, let us define a convenient print representation of double matrices
  a la <hlink|Octave|#octave> (the meaning of the
  <hlink|<with|font-family|tt|__show__>|#--show--> function is explained in
  <hlink|Pretty-Printing|#pretty-printing>):

  <\verbatim>
    using system;

    __show__ x::matrix

    = strcat [printd j (x!(i,j))\|i=0..n-1; j=0..m-1] + "\\n"

    with printd 0 = sprintf "\\n%10.5f"; printd _ = sprintf "%10.5f" end

    when n,m = dim x end if dmatrixp x;
  </verbatim>

  Example:

  <\verbatim>
    \<gtr\> let x = dmatrix {2,1,-1,8; -3,-1,2,-11; -2,1,2,-3};

    \<gtr\> x; gauss_elimination x;

    \ \ \ 2.00000 \ \ 1.00000 \ -1.00000 \ \ 8.00000

    \ \ -3.00000 \ -1.00000 \ \ 2.00000 -11.00000

    \ \ -2.00000 \ \ 1.00000 \ \ 2.00000 \ -3.00000

    [1,2,0],

    \ \ \ 1.00000 \ \ 0.33333 \ -0.66667 \ \ 3.66667

    \ \ \ 0.00000 \ \ 1.00000 \ \ 0.40000 \ \ 2.60000

    \ \ \ 0.00000 \ \ 0.00000 \ \ 1.00000 \ -1.00000
  </verbatim>

  <subsubsection|Symbolic Matrices<label|symbolic-matrices>>

  As already mentioned, matrices may contain not just numbers but any kind of
  Pure values, in which case they become <em|symbolic> matrices. For
  instance:

  <\verbatim>
    \<gtr\> {1,2.0,3L;a,b,c};

    {1,2.0,3L;a,b,c}
  </verbatim>

  The <hlink|<with|font-family|tt|smatrixp>|purelib.tm#smatrixp> predicate
  gives you a quick way to check whether a matrix is a symbolic one:

  <\verbatim>
    \<gtr\> smatrixp ans;

    1
  </verbatim>

  Note that this may not always be obvious. For instance, you can use the
  <hlink|<with|font-family|tt|smatrix>|purelib.tm#smatrix> function to
  explicitly convert a numeric matrix:

  <\verbatim>
    \<gtr\> smatrix {1,2;3,4};

    {1,2;3,4}
  </verbatim>

  This still looks the same as the original matrix, but <verbatim|smatrixp>
  reveals that it's in fact a symbolic matrix:

  <\verbatim>
    \<gtr\> smatrixp ans;

    1
  </verbatim>

  Also note that the empty matrix is by default a symbolic matrix, as are
  matrices containing bigints:

  <\verbatim>
    \<gtr\> smatrixp {};

    1

    \<gtr\> smatrixp {1L,2L;3L,4L};

    1
  </verbatim>

  However, you can easily convert these to a numeric type if needed, e.g.:

  <\verbatim>
    \<gtr\> dmatrix {1L,2L;3L,4L};

    {1.0,2.0;3.0,4.0}
  </verbatim>

  Symbolic matrices are a convenient data structure for storing arbitrary
  collections of values which provides fast random access to its members. In
  particular, they can also be nested, and thus multidimensional tensors or
  arrays of arbitrary dimension can be realized as nested symbolic vectors.
  However, you have to be careful when constructing such values, because the
  <verbatim|{...}> construct normally combines submatrices to larger
  matrices. For instance:

  <\verbatim>
    \<gtr\> {{1,2},{3,4}};

    {1,2,3,4}
  </verbatim>

  One way to inhibit this splicing of the submatrices in a larger matrix is
  to use the quote operator (cf. <hlink|The Quote|#the-quote>):

  <\verbatim>
    \<gtr\> '{{1,2},{3,4}};

    {{1,2},{3,4}}
  </verbatim>

  Note that this result is really different from <verbatim|{1,2;3,4}>. The
  latter is a 2x2 integer matrix, while the former is a symbolic vector
  a.k.a. 1x2 matrix whose elements happen to be two integer vectors. So a
  double index will be required to access the subvector elements:

  <\verbatim>
    \<gtr\> ans!0!1;

    2
  </verbatim>

  You can also match these values with a nested matrix pattern, e.g.:

  <\verbatim>
    \<gtr\> let {{a,b},{c,d}} = '{{1,2},{3,4}};

    \<gtr\> a,b,c,d;

    1,2,3,4
  </verbatim>

  Unfortunately, the quote operator in fact inhibits evaluation of <em|all>
  embedded subterms which may be undesirable if the matrix expression
  contains arithmetic (as in <verbatim|'{{1+1,2*3}}>), so this method works
  best for constant matrices. A more general way to create a symbolic vector
  of matrices is provided by the <hlink|<with|font-family|tt|vector>|purelib.tm#vector>
  function from the prelude, which is applied to a list of the vector
  elements as follows:

  <\verbatim>
    \<gtr\> vector [{1,2},{3,4}];

    {{1,2},{3,4}}
  </verbatim>

  Calls to the <hlink|<with|font-family|tt|vector>|purelib.tm#vector>
  function can be nested to an arbitrary depth to obtain higher-dimensional
  ``arrays'':

  <\verbatim>
    \<gtr\> vector [vector [{1,2}],vector [{3,4}]];

    {{{1,2}},{{3,4}}}
  </verbatim>

  This obviously becomes a bit unwieldy for higher dimensions, but Pure 0.56
  and later provide the following shorthand notation:

  <\verbatim>
    \<gtr\> {\|{1,2},{3,4}\|};

    {{1,2},{3,4}}

    \<gtr\> {\|{\|{1,2}\|},{\|{3,4}\|}\|};

    {{{1,2}},{{3,4}}}
  </verbatim>

  This makes it much more convenient to denote nested vector values. Note
  that the <verbatim|{\|> <verbatim|\|}> construct doesn't use any special
  magic, it's just a standard outfix operator implemented as a Pure macro.
  For more details please check the description of the
  <hlink|<em|non-splicing vector brackets>|purelib.tm#non-splicing> in the
  <hlink|<em|Pure Library Manual>|purelib.tm>.

  <subsubsection|Record Data<label|record-data>>

  Symbolic matrices also provide a means to represent simple record-like
  data, by encoding records as symbolic vectors consisting of ``hash pairs''
  of the form <verbatim|key> <verbatim|=\>> <verbatim|value>. This kind of
  data structure is very convenient to represent aggregates with lots of
  different components. Since the components of records can be accessed by
  indexing with key values, you don't have to remember which components are
  stored in which order, just knowing the keys of the required members is
  enough. In contrast, tuples, lists and other kinds of constructor terms
  quickly become unwieldy for such purposes.

  The keys used for indexing the record data must be either symbols or
  strings, while the corresponding values may be arbitrary Pure values. The
  prelude provides some operations on these special kinds of matrices, which
  let you retrieve vector elements by indexing and perform non-destructive
  updates, see the <hlink|<em|Record Functions>|purelib.tm#record-functions>
  section in the <hlink|<em|Pure Library Manual>|purelib.tm> for details.
  Here are a few examples which illustrate how to create records and work
  with them:

  <\verbatim>
    \<gtr\> let r = {x=\<gtr\>5, y=\<gtr\>12};

    \<gtr\> recordp r, member r x;

    1,1

    \<gtr\> r!y; r!![y,x];

    12

    {12,5}

    \<gtr\> insert r (x=\<gtr\>99);

    {x=\<gtr\>99,y=\<gtr\>12}

    \<gtr\> insert ans (z=\<gtr\>77);

    {x=\<gtr\>99,y=\<gtr\>12,z=\<gtr\>77}

    \<gtr\> delete ans z;

    {x=\<gtr\>99,y=\<gtr\>12}
  </verbatim>

  Records can also be nested:

  <\verbatim>
    \<gtr\> let r = {a =\<gtr\> {b=\<gtr\>1,c=\<gtr\>2}, b =\<gtr\> 2};

    \<gtr\> r!a, r!b, r!a!b;

    {b=\<gtr\>1,c=\<gtr\>2},2,1
  </verbatim>

  Note the use of the ``hash rocket'' <hlink|<with|font-family|tt|=\<gtr\>>|purelib.tm#=\>>
  which denotes the <verbatim|key=\>value> associations in a record. The hash
  rocket is a constructor declared as an infix operator in the prelude, see
  the <hlink|<em|Hash Pairs>|purelib.tm#hash-pairs> section in the
  <hlink|<em|Pure Library Manual>|purelib.tm> for details. There's one caveat
  here, however. Since neither `<verbatim|=\>>` nor `<verbatim|!>` treat
  their key operand in a special way, you'll have to take care that the key
  symbols do not evaluate to something else, as might be the case if they are
  bound to a global or local variable or parameterless function:

  <\verbatim>
    \<gtr\> let u = 99;

    \<gtr\> {u=\<gtr\>u};

    {99=\<gtr\>99}
  </verbatim>

  In the case of global variables and function symbols, you might protect the
  symbol with a quote (see <hlink|The Quote|#the-quote>):

  <\verbatim>
    \<gtr\> {'u=\<gtr\>u};

    {u=\<gtr\>99}

    \<gtr\> ans!'u;

    99
  </verbatim>

  However, even the quote doesn't save you from local variable substitution:

  <\verbatim>
    \<gtr\> {'u=\<gtr\>u} when u = 99 end;

    {99=\<gtr\>99}
  </verbatim>

  In such cases you'll either have to rename the local variable, or use the
  prelude function <hlink|<with|font-family|tt|val>|purelib.tm#val> to quote
  the symbol:

  <\verbatim>
    \<gtr\> {'u=\<gtr\>v} when v = 99 end;

    {u=\<gtr\>99}

    \<gtr\> {val "u"=\<gtr\>u} when u = 99 end;

    {u=\<gtr\>99}
  </verbatim>

  It's also possible to directly use strings as keys instead, which may
  actually be more convenient in some cases:

  <\verbatim>
    \<gtr\> let r = {"x"=\<gtr\>5, "y"=\<gtr\>12};

    \<gtr\> keys r; vals r;

    {"x","y"}

    {5,12}

    \<gtr\> update r "y" (r!"y"+1);

    {"x"=\<gtr\>5,"y"=\<gtr\>13}
  </verbatim>

  You can also mix strings and symbols as keys in the same record (but note
  that strings and symbols are always distinct, so <verbatim|y> and
  <verbatim|"y"> are really two different keys here):

  <\verbatim>
    \<gtr\> insert r (y=\<gtr\>99);

    {"x"=\<gtr\>5,"y"=\<gtr\>12,y=\<gtr\>99}
  </verbatim>

  As records are in fact just special kinds of matrices, the standard matrix
  operations can be used on record values as well. For instance, the matrix
  constructor provides an alternative way to quickly augment a record with a
  collection of new <verbatim|key=\>value> associations:

  <\verbatim>
    \<gtr\> let r = {x=\<gtr\>5, y=\<gtr\>12};

    \<gtr\> let r = {r, x=\<gtr\>7, z=\<gtr\>3}; r;

    {x=\<gtr\>5,y=\<gtr\>12,x=\<gtr\>7,z=\<gtr\>3}

    \<gtr\> r!x, r!z;

    7,3

    \<gtr\> delete r x;

    {x=\<gtr\>5,y=\<gtr\>12,z=\<gtr\>3}

    \<gtr\> ans!x;

    5
  </verbatim>

  As the example shows, this may produce duplicate keys, but these are
  handled gracefully; indexing and updates will always work with the
  <em|last> association for a given key in the record. If necessary, you can
  remove duplicate entries from a record as follows; this will only keep the
  last association for each key:

  <\verbatim>
    \<gtr\> record r;

    {x=\<gtr\>7,y=\<gtr\>12,z=\<gtr\>3}
  </verbatim>

  In fact, the <hlink|<with|font-family|tt|record>|purelib.tm#record>
  operation not only removes duplicates, but also orders the record entries
  by keys. This produces a kind of normalized representation which is useful
  if you want to compare or combine two record values irrespective of the
  ordering of the fields. For instance:

  <\verbatim>
    \<gtr\> record {x=\<gtr\>5, y=\<gtr\>12} === record {y=\<gtr\>12,
    x=\<gtr\>5};

    1
  </verbatim>

  The <hlink|<with|font-family|tt|record>|purelib.tm#record> function can
  also be used to construct a normalized record directly from a list or tuple
  of hash pairs:

  <\verbatim>
    \<gtr\> record [x=\<gtr\>5, x=\<gtr\>7, y=\<gtr\>12];

    {x=\<gtr\>7,y=\<gtr\>12}
  </verbatim>

  Other matrix operations such as <hlink|<with|font-family|tt|map>|purelib.tm#map>,
  <hlink|<with|font-family|tt|foldl>|purelib.tm#foldl>, etc., and matrix
  comprehensions can be applied to records just as easily. This enables you
  to perform bulk updates of record data in a straightforward way. For
  instance, here's how you can define a function <verbatim|maprec> which
  applies a function to all values stored in a record:

  <\verbatim>
    \<gtr\> maprec f = map (\\(u=\<gtr\>v) -\<gtr\> u=\<gtr\>f v);

    \<gtr\> maprec (*2) {x=\<gtr\>5,y=\<gtr\>12};

    {x=\<gtr\>10,y=\<gtr\>24}
  </verbatim>

  Another example: The following <verbatim|ziprec> function collects pairs of
  values stored under common keys in two records (we also normalize the
  result here so that duplicate keys are always removed):

  <\verbatim>
    \<gtr\> ziprec x y = record {u=\<gtr\>(x!u,y!u) \| u = keys x; member y
    u};

    \<gtr\> ziprec {a=\<gtr\>3,x=\<gtr\>5,y=\<gtr\>12}
    {x=\<gtr\>10,y=\<gtr\>24,z=\<gtr\>7};

    {x=\<gtr\>(5,10),y=\<gtr\>(12,24)}
  </verbatim>

  Thus the full power of generic matrix operations is available for records,
  which turns them into a much more versatile data structure than records in
  conventional programming languages, which are usually limited to
  constructing records and accessing or modifying their components.

  Note that since the values stored in records can be arbitrary Pure values,
  you can also have records with mutable components by making use of Pure's
  <hlink|<em|expression references>|purelib.tm#expression-references>. For
  instance:

  <\verbatim>
    \<gtr\> let r = {x=\<gtr\>ref 1,y=\<gtr\>ref 2}; maprec get r;

    {x=\<gtr\>1,y=\<gtr\>2}

    \<gtr\> put (r!x) 99; maprec get r;

    99

    {x=\<gtr\>99,y=\<gtr\>2}
  </verbatim>

  Another interesting application of records are the ``virtual method
  tables'' used in object-oriented programming. Pure has a built-in
  <hlink|<with|font-family|tt|__locals__>|purelib.tm#--locals--> macro which
  captures the environment of local functions at the point of the call and
  returns it as a list of hash pairs of function symbols and the
  corresponding closures. We can readily convert this into a record data
  structure which can be used as a virtual method table. For instance:

  <\verbatim>
    \<gtr\> record __locals__ with f x = x+1 end;

    {f=\<gtr\>f}

    \<gtr\> (ans!f) 99;

    100
  </verbatim>

  Here is a little helper macro that we can use to turn the virtual method
  table into an anonymous function which, when applied to a symbol, returns
  the appropriate closure:

  <\verbatim>
    def obj = (\\x -\<gtr\> vt!x) when

    \ \ vt = record __locals__;

    end;
  </verbatim>

  Continuing our example from <hlink|Local Functions and
  Variables|#local-functions-and-variables>, we can now implement the
  <verbatim|point> object as follows:

  <\verbatim>
    point (x,y) = obj with

    \ \ coords () = get x,get y;

    \ \ move (dx,dy) = put x (get x+dx), put y (get y+dy);

    end when

    \ \ x,y = ref x,ref y;

    end;
  </verbatim>

  Note that <verbatim|obj> really needs to be implemented as a macro so that
  its body is inserted into the <verbatim|point> function and the
  <verbatim|_locals__> call is executed in the context of the local function
  environment there. (A macro is like a function which gets evaluated at
  compile time; see the <hlink|Macros|#macros> section for details.) Also
  note that we changed the <verbatim|coords> ``method'' so that it takes a
  dummy parameter <verbatim|()> now; this prevents premature evaluation of
  the closure. If <verbatim|coords> was a parameterless function then its
  value would be fixed at the time we construct the virtual method table,
  which is not what we want here.

  Now we can write:

  <\verbatim>
    \<gtr\> let p = point (1,2);

    \<gtr\> p coords ();

    1,2

    \<gtr\> p move (2,3);

    3,5

    \<gtr\> p coords ();

    3,5
  </verbatim>

  This provides us with an interesting way to represent stateful objects
  which works very much like object-oriented programming. What's still
  missing here is the inheritance of methods from other objects, but this can
  now be done by just combining virtual method tables using the record
  operations we've already discussed above; we leave this as an exercise for
  the interested reader.

  <subsubsection|The Quote<label|the-quote>>

  We've already seen some uses of the quote in previous examples, so let's
  have a closer look at it now. As described in <hlink|Special
  Forms|#special-forms>, the <hlink|<with|font-family|tt|quote>|#quote>
  operation quotes an expression, so that it can be passed around and
  manipulated freely until its value is needed, in which case you can pass it
  to the <hlink|<with|font-family|tt|eval>|purelib.tm#eval> function to
  obtain its value. For instance:

  <\verbatim>
    \<gtr\> let x = '(2*42+2^12); x;

    2*42+2^12

    \<gtr\> eval x;

    4180.0
  </verbatim>

  Lisp programmers will be well familiar with this operation which enables
  some powerful metaprogramming techniques. However, there are some notable
  differences to Lisp's quote. In particular,
  <hlink|<with|font-family|tt|quote>|#quote> only inhibits the evaluation of
  global variables, <em|local> variables are substituted as usual:

  <\verbatim>
    \<gtr\> (\\x -\<gtr\> '(2*x+1)) 99;

    2*99+1

    \<gtr\> foo x = '(2*x+1);

    \<gtr\> foo 99; foo $ '(7/y);

    2*99+1

    2*(7/y)+1

    \<gtr\> '(x+1) when x = '(2*3) end;

    2*3+1

    \<gtr\> '(2*42+2^n) when n = 12 end;

    2*42+2^12
  </verbatim>

  Local parameterless functions are treated in the same fashion:

  <\verbatim>
    \<gtr\> '(2*42+2^n) with n = 12 end;

    2*42+2^12
  </verbatim>

  Note that, in contrast, for global variables (and functions) we have:

  <\verbatim>
    \<gtr\> let n = 12;

    \<gtr\> '(2*42+2^n);

    2*42+2^n
  </verbatim>

  This discrepancy may come as a surprise (or even annoyance) to real Lisp
  weenies, but it does have its advantages. As illustrated in the examples
  above, local variable substitution makes it easy to fill in the variable
  parts in a quoted ``template'' expression, without any need for an arguably
  complex tool like Lisp's ``quasiquote''. (But note that it is quite easy to
  define the quasiquote in Pure if you want it. See the <hlink|Recursive
  Macros|#recursive-macros> section for a simplified version; a full
  implementation can be found in the Pure library.)

  If you do need to quote a symbol which is already being used as a local
  variable or function in the current context, you can do this by supplying
  the symbol as a string to the prelude function
  <hlink|<with|font-family|tt|val>|purelib.tm#val>:

  <\verbatim>
    \<gtr\> val "x"+x when x = 99 end;

    x+99
  </verbatim>

  Also note that while local functions are always substituted in a quoted
  expression, <em|applications> involving local functions can still be
  quoted:

  <\verbatim>
    \<gtr\> 'foo 99 with foo x = 2*x+1 end;

    foo 99

    \<gtr\> eval ans;

    199
  </verbatim>

  The quote also inhibits evaluation inside matrix expressions, including the
  ``splicing'' of embedded submatrices:

  <\verbatim>
    \<gtr\> '{1,2+3,2*3};

    {1,2+3,2*3}

    \<gtr\> '{1,{2,3},4};

    {1,{2,3},4}
  </verbatim>

  <hlink|Special expressions|#special-expressions> (conditionals, lambda and
  the <hlink|<with|font-family|tt|case>|#case>,
  <hlink|<with|font-family|tt|when>|#when> and
  <hlink|<with|font-family|tt|with>|#with> constructs) can be quoted as well.
  But since these constructs cannot be directly represented at runtime, the
  quote actually produces some ordinary ``placeholder'' terms for these:

  <\verbatim>
    \<gtr\> '(x+1 when x = '(2*3) end);

    x+1 __when__ [x--\<gtr\>'(2*3)]

    \<gtr\> eval ans;

    2*3+1

    \<gtr\> '(2*42+(f 6 with f n = 2^(2*n) end));

    2*42+(f 6 __with__ [f n--\<gtr\>2^(2*n)])

    \<gtr\> eval ans;

    4180.0
  </verbatim>

  Note that these placeholders are in fact special built-in macros which
  reconstruct the special expression when evaluated. Moreover, special
  expressions are implicitly quoted when they occur on the left-hand side of
  an equation or as an argument of a ``<hlink|<em|quoteargs>|#cmdoption-pure-pragma--quoteargs>''
  macro call. This is often used to implement macros which manipulate these
  constructs as literals. For instance, the following macro swaps the
  arguments in a lambda:

  <\verbatim>
    \<gtr\> #! --quoteargs bar

    \<gtr\> def bar (\\x y -\<gtr\> z) = __eval__ ('(\\y x -\<gtr\> z));

    \<gtr\> show bar

    def bar (__lambda__ [x,y] z) = __eval__ ('__lambda__ [y,x] z);

    \<gtr\> baz = bar (\\a b -\<gtr\> a-b);

    \<gtr\> show baz

    baz = \\b a -\<gtr\> a-b;

    \<gtr\> baz 2 3;

    1
  </verbatim>

  The <hlink|Macros|#macros> section explains in detail how this meta
  programming works.

  <subsection|Declarations<label|declarations>>

  Pure is a very terse language by design. Usually you don't declare much
  stuff, you just define it and be done with it. However, there are a few
  constructs which let you declare symbols with special attributes and manage
  programs consisting of several source modules:

  <\itemize>
    <item>symbol declarations determine ``scope'' and ``fixity'' of a symbol;

    <item><hlink|<with|font-family|tt|interface>|#interface> declarations
    specify abstract data types;

    <item><hlink|<with|font-family|tt|extern>|#extern> declarations specify
    external C functions;

    <item><hlink|<with|font-family|tt|using>|#using> clauses let you include
    other scripts in a Pure script;

    <item><hlink|<with|font-family|tt|namespace>|#namespace> declarations let
    you avoid name clashes and thereby make it easier to manage large
    programs consisting of many separate modules.
  </itemize>

  These are toplevel elements (cf. <hlink|Toplevel|#toplevel>):

  <\verbatim>
    item ::= \ symbol_decl \| interface_decl \| extern_decl

    \ \ \ \ \ \ \ \ \ \ \| using_decl \| namespace_decl
  </verbatim>

  We defer the discussion of <hlink|<with|font-family|tt|extern>|#extern>
  declarations to the <hlink|C Interface|#c-interface> section. The other
  kinds of declarations are described in the following subsections.

  <subsubsection|Symbol Declarations<label|symbol-declarations>>

  Symbol declarations declare special attributes of a symbol, such as their
  scope (whether they are ``public'' or ``private'') and their fixity (for
  operator symbols). The syntax of these declarations is as follows:

  <\verbatim>
    symbol_decl ::= \ scope qualified_symbol+ ";"

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| [scope] fixity qualified_symbol+ ";"

    scope \ \ \ \ \ \ ::= \ "public" \| "private"

    fixity \ \ \ \ \ ::= \ "nonfix" \| "outfix"

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| ("infix"\|"infixl"\|"infixr"\|"prefix"\|"postfix")
    precedence

    precedence \ ::= \ integer \| "(" op ")"
  </verbatim>

  Scope declarations take the following form:

  <\description>
    <item*|public symbol ...;>

    <item*|private symbol ...;>
  </description>

  This declares the listed symbols as public or private, respectively. Each
  symbol must either be an identifier or a sequence of punctuation
  characters. The latter kind of symbols <em|must> always be declared before
  use, whereas ordinary identifiers can be used without a prior declaration
  in which case they are declared implicitly and default to public scope,
  meaning that they are visible everywhere in a program. An explicit public
  declaration of ordinary identifiers is thus rarely needed (unless you want
  to declare symbols as members of a specific namespace, see
  <hlink|Namespaces|#namespaces> below). Symbols can also be declared
  private, meaning that the symbol is visible only in the namespace it
  belongs to. This is explained in more detail under <hlink|Private
  Symbols|#private-symbols> in the <hlink|Namespaces|#namespaces> section
  below.

  <with|font-series|bold|Note:> The declared symbols may optionally be
  qualified with a namespace prefix, but since new symbols can only be
  created in the current namespace, the namespace prefix must match the
  current namespace (see <hlink|Namespaces|#namespaces>). Thus the namespace
  prefix isn't really needed, unless you want to declare a symbol which
  happens to be a reserved Pure keyword (cf. <hlink|Lexical
  Matters|#lexical-matters>). In this specific case, it will be necessary to
  use a qualified name so that the symbol isn't mistaken for a keyword.

  Note that to declare several symbols in a single declaration, you can list
  them all with whitespace in between. The same syntax applies to the other
  types of symbol declarations discussed below. (Commas are <em|not> allowed
  as delimiters here, as they may occur as legal symbol constituents in the
  list of symbols.) The <hlink|<with|font-family|tt|public>|#public> and
  <hlink|<with|font-family|tt|private>|#private> keywords can also be used as
  a prefix in any of the special symbol declarations discussed below, to
  specify the scope of the declared symbols (if the scope prefix is omitted,
  it defaults to <hlink|<with|font-family|tt|public>|#public>).

  The following ``fixity'' declarations are available for introducing special
  operator symbols. This changes the way that these symbols are parsed and
  thus provides you with a limited means to extend the Pure language at the
  lexical and syntactical level.

  <\description>
    <item*|infix level symbol ...;>

    <item*|infixl level symbol ...;>

    <item*|infixr level symbol ...;>

    <item*|prefix level symbol ...;>

    <item*|postfix level symbol ...;>
  </description>

  Pure provides you with a theoretically unlimited number of different
  precedence levels for user-defined infix, prefix and postfix operators.
  Precedence levels are numbered starting at 0; larger numbers indicate
  higher precedence. (For practical reasons, the current implementation does
  require that precedence numbers can be encoded as 24 bit unsigned machine
  integers, giving you a range from 0 to 16777215, but this should be large
  enough to incur no real limitations on applications. Also, the operator
  declarations in the prelude have been set up to leave enough ``space''
  between the ``standard'' levels so that you can easily sneak in new
  operator symbols at low, high or intermediate precedences.)

  On each precedence level, you can declare (in order of increasing
  precedence) <hlink|<with|font-family|tt|infix>|#infix> (binary
  non-associative), <hlink|<with|font-family|tt|infixl>|#infixl> (binary
  left-associative), <hlink|<with|font-family|tt|infixr>|#infixr> (binary
  right-associative), <hlink|<with|font-family|tt|prefix>|#prefix> (unary
  prefix) and <hlink|<with|font-family|tt|postfix>|#postfix> (unary postfix)
  operators. For instance, here is a typical excerpt from the prelude (the
  full table can be found in the <hlink|<em|Prelude>|purelib.tm#prelude>
  section of the <hlink|<em|Pure Library Manual>|purelib.tm>):

  <\verbatim>
    infix \ 1800 \<less\> \<gtr\> \<less\>= \<gtr\>= == ~= ;

    infixl 2200 + - ;

    infixl 2300 * / div mod ;

    infixr 2500 ^ ;

    prefix 2600 # ;
  </verbatim>

  <with|font-series|bold|Note:> Unary minus plays a special role in the
  syntax. Like in Haskell and following mathematical tradition, unary minus
  is the only prefix operator symbol which is also used as an infix operator,
  and is always on the same precedence level as binary minus, whose
  precedence may be chosen freely in the prelude. (The minus operator is the
  only symbol which gets that special treatment; all other operators must
  have distinct lexical representations.) Thus, with the standard prelude,
  <verbatim|-x+y> will be parsed as <verbatim|(-x)+y>, whereas
  <verbatim|-x*y> is the same as <verbatim|-(x*y)>. Also note that the
  notation <verbatim|(-)> always denotes the binary minus operator; the unary
  minus operation can be denoted using the built-in <verbatim|neg> function.

  Instead of denoting the precedence by an explicit integer value, you can
  also specify an existing operator symbol enclosed in parentheses. Thus the
  following declaration gives the <verbatim|++> operator the same precedence
  as <verbatim|+>:

  <\verbatim>
    infixl (+) ++ ;
  </verbatim>

  The given symbol may be of a different fixity than the declaration, but it
  must have a proper precedence level (i.e., it must be an infix, prefix or
  postfix symbol). E.g., the following declaration gives <verbatim|^^> the
  same precedence level as the infix <verbatim|^> symbol, but turns it into a
  postfix operator:

  <\verbatim>
    postfix (^) ^^ ;
  </verbatim>

  Pure also provides unary outfix operators, which work like in Wm Leler's
  constraint programming language <hlink|Bertrand|#bertrand>. These can be
  declared as follows:

  <\description>
    <item*|outfix left right ...;>
  </description>

  Outfix operators let you define your own bracket structures. The operators
  must be given as pairs of matching left and right symbols (which must be
  distinct). For instance:

  <\verbatim>
    outfix \|: :\| BEGIN END;
  </verbatim>

  After this declaration you can write bracketed expressions like
  <verbatim|\|:x:\|> or <verbatim|BEGIN> <verbatim|foo,> <verbatim|bar>
  <verbatim|END>. These are always at the highest precedence level (i.e.,
  syntactically they work like parenthesized expressions). Just like other
  operators, you can turn outfix symbols into ordinary functions by enclosing
  them in parentheses, but you have to specify the symbols in matching pairs,
  such as <verbatim|(BEGIN> <verbatim|END)>.

  Pure also has a notation for ``nullary'' operators, that is, ``operators
  without operands''. These are used to denote special literals which simply
  stand for themselves. They are introduced using a
  <hlink|<with|font-family|tt|nonfix>|#nonfix> declaration:

  <\description>
    <item*|nonfix symbol ...;>
  </description>

  For instance:

  <\verbatim>
    nonfix red green blue;
  </verbatim>

  Semantically, nonfix symbols are a kind of ``symbolic constants''. However,
  it is important to note the difference to <em|defined> constants, which are
  symbols bound to a constant value by means of a
  <hlink|<with|font-family|tt|const>|#const> definition. In fact, there are
  some use cases where a symbol may be <em|both> a defined constant and a
  nonfix symbol, see <hlink|Constant Definitions|#constant-definitions> in
  the <hlink|Caveats and Notes|#caveats-and-notes> section for details.

  Syntactically, nonfix symbols work just like ordinary identifiers, so they
  may stand whereever an identifier is allowed (no parentheses are required
  to ``escape'' them). However, just like other kinds of operators, they may
  also consist of punctuation (which isn't allowed in ordinary identifiers).
  The other difference to ordinary identifiers is that nonfix symbols are
  always interpreted as literals, even if they occur in a variable position
  on the left-hand side of a rule. So, with the above declaration, you can
  write something like:

  <\verbatim>
    \<gtr\> foo x = case x of red = green; green = blue; blue = red end;

    \<gtr\> map foo [red,green,blue];

    [green,blue,red]
  </verbatim>

  Thus nonfix symbols are pretty much like nullary constructor symbols in
  languages like Haskell. Non-fixity is just a syntactic attribute, however.
  Pure doesn't enforce that such values are irreducible, so you can still
  write a ``constructor equation'' like the following:

  <\verbatim>
    \<gtr\> red = blue;

    \<gtr\> map foo [red,green,blue];

    [blue,blue,blue]
  </verbatim>

  Examples for all types of symbol declarations can be found in the
  <hlink|<em|prelude>|purelib.tm#prelude> which declares a bunch of standard
  (arithmetic, relational, logical) operator symbols as well as the list and
  pair constructors `<verbatim|:>` and `<verbatim|,>`, and a few nonfix
  symbols (<hlink|<with|font-family|tt|true>|purelib.tm#true> and
  <hlink|<with|font-family|tt|false>|purelib.tm#false>, as well as different
  kinds of exceptions).

  <subsubsection|Interface Types<label|interface-types>>

  Besides the ``concrete'' types already described in the <hlink|Type
  Rules|#type-rules> section, Pure provides another, more abstract way to
  characterize a type through the collection of operations it supports. These
  <with|font-series|bold|interface types> work pretty much like in Google's
  <hlink|Go|#go> programming language. They provide a safe form of
  <hlink|Duck typing|http://en.wikipedia.org/wiki/Duck-typing> in which the
  operations available on a type are stated explicitly, and hence members of
  the type are always known to provide all of the listed operations.

  An interface declaration gives the type name along with a collection of
  patterns, the so-called <with|font-series|bold|signature> which specifies
  the manifest operations of the type:

  <\verbatim>
    interface_decl ::= \ "interface" qualified_identifier

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ "with" interface_item* "end" ";"

    interface_item ::= \ pattern ";"

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| "interface"
    qualified_identifier ";"
  </verbatim>

  Interfaces thus consist of two kinds of items:

  <\itemize>
    <item>The patterns, which indicate which operations are supported by the
    type, and which arguments they expect. This may be anything that can
    occur as the left-hand side of an ordinary function definition, cf.
    <hlink|General Rules|#general-rules>.

    <item>The name of another interface type. This causes the signature of
    the named interface type to be included in the interface type being
    defined, which effectively turns the new interface type into a subtype of
    the existing one.
  </itemize>

  The gist of an interface is in its patterns, more precisely: in the pattern
  variables which have the name of the interface as a type tag. The precise
  meaning of the patterns is as follows:

  <\itemize>
    <item>The patterns are matched against the left-hand sides of ordinary
    function definitions. If a left-hand side matches, any argument pattern
    substituted for a variable tagged with the interface type becomes a
    ``candidate pattern'' of the type.

    <item>The type consists of all candidate patterns which can be matched by
    some candidate pattern of <em|each> interface function. That is,
    candidate patterns which are only supported by some but not all of the
    interface functions, are eliminated.

    <item>Finally, all trivial candidate patterns (<verbatim|x> where
    <verbatim|x> is just a variable without any type tag, which thus matches
    <em|any> value) are eliminated as well.
  </itemize>

  Interface patterns often take a simple form like the following,

  <\verbatim>
    interface foo with foo x::foo y z; end;
  </verbatim>

  specifying the number of arguments of the interface function along with the
  position of the interface type argument. However, general patterns are
  permitted, in order to further restrict the left-hand sides of the function
  definitions to be taken into consideration. Specifically, note that type
  tags other than the interface type must always be matched <em|literally> on
  the left-hand sides of equations. Thus,

  <\verbatim>
    interface foo with foo x::foo y::int; end;
  </verbatim>

  matches any rule of the form

  <\verbatim>
    foo x y::int = ...;
  </verbatim>

  but <em|not>:

  <\verbatim>
    foo x 0 = ...;

    foo x y::bar = ...;
  </verbatim>

  (unless <verbatim|bar> happens to be an alias of the <verbatim|int> type,
  of course). In such cases it is necessary to explicitly add these patterns
  to the interface if you want them to be included.

  Interface patterns may contain the interface type tag any number of times,
  yielding candidate patterns for each occurrence of the interface type tag
  in the pattern. For instance, here is a quick way to determine the type of
  all ``addable'' data structures in the prelude (this uses the interactive
  <verbatim|show> <verbatim|interface> command to list the patterns actually
  matched by an interface type, cf. <hlink|The show
  Command|#the-show-command>):

  <\verbatim>
    \<gtr\> interface addable with x::addable + y::addable; end;

    \<gtr\> show interface addable

    type addable x::int;

    type addable x::double;

    type addable x::bigint;

    type addable s::string;

    type addable [];

    type addable xs@(_:_);
  </verbatim>

  On the other hand, interfaces may also contain ``static'' patterns which do
  not include the interface type as a tag at all, such as:

  <\verbatim>
    interface foo with bar x::bar y; end;
  </verbatim>

  These do not contribute anything to the candidate patterns of the type, but
  do restrict the type just like the other patterns, in that the type will be
  empty unless the static patterns are all ``implemented''. In the example
  above, this means that the <verbatim|foo> type will be empty unless the
  <verbatim|bar> function is defined and takes an element of the
  <verbatim|bar> type as its first argument.

  An interface may also be empty, in which case it matches <em|any> value.
  Thus,

  <\verbatim>
    interface any with end;
  </verbatim>

  is just a fancy way to define the type:

  <\verbatim>
    type any _;
  </verbatim>

  Interfaces can be composed in a piecemeal fashion, by adding more interface
  patterns. Thus,

  <\verbatim>
    interface foo with foo x::foo; end;

    interface foo with bar x::foo; end;
  </verbatim>

  is equivalent to:

  <\verbatim>
    interface foo with foo x::foo; bar x::foo; end;
  </verbatim>

  It is also possible to include one interface in another, which effectively
  establishes a subtype relationship. For instance, here's yet another way to
  define the <verbatim|foo> interface above:

  <\verbatim>
    interface bar with

    \ \ bar x::bar;

    end;

    \;

    interface foo with

    \ \ foo x::foo;

    \ \ interface bar;

    end;
  </verbatim>

  This has the effect of including the signature of <verbatim|bar> in
  <verbatim|foo> (while renaming the interface type tags in the
  <verbatim|bar> signature accordingly):

  <\verbatim>
    \<gtr\> show foo

    interface foo with

    \ \ foo x::foo;

    \ \ bar x::foo;

    end;
  </verbatim>

  <with|font-series|bold|Note:> Including interfaces is a static operation.
  Only the interface patterns known at the point of inclusion become part of
  the including interface; refining the included interface later has no
  effect on the set of included patterns. In particular, this also prevents
  circular interface definitions.

  When composing interfaces in this fashion, it is easy to end up with
  duplicate interface patterns from various sources. The compiler removes
  such duplicates, even if they only match up to the renaming of variables.
  For instance:

  <\verbatim>
    \<gtr\> show bar foo

    interface bar with

    \ \ bar x::bar;

    end;

    interface foo with

    \ \ foo x::foo;

    \ \ bar x::foo;

    end;

    \<gtr\> interface baz with

    \<gtr\> \ \ interface foo; interface bar;

    \<gtr\> \ \ foo y::baz;

    \<gtr\> end;

    \<gtr\> show baz

    interface baz with

    \ \ foo x::baz;

    \ \ bar x::baz;

    end;
  </verbatim>

  Also note that, despite the obvious similarities between interfaces and
  classes in object-oriented programming, they are really different things.
  The former are essentially just signatures of functions living elsewhere,
  whereas the latter also include data layouts and method implementations.
  More on the similarities and differences of interfaces and classes can be
  found in the <hlink|Go FAQ|http://golang.org/doc/go-faq.html#types>.

  Let's now take a look at the example of a stack data structure to see how
  this all works in practice:

  <\verbatim>
    interface stack with

    \ \ push s::stack x;

    \ \ pop s::stack;

    \ \ top s::stack;

    end;
  </verbatim>

  Note the use of the type tag <verbatim|stack> in the operation patterns,
  which marks the positions of <verbatim|stack> arguments of the interface
  operations. The interface tells us that a stack provides three operations
  <verbatim|push>, <verbatim|pop> and <verbatim|top> which each take a stack
  as their first argument; also, <verbatim|push> takes two arguments, while
  <verbatim|pop> and <verbatim|top> just take a single (stack) argument.

  This information is all that the compiler needs to figure out which terms
  are members of the <verbatim|stack> data type. To these ends, the compiler
  looks at existing definitions of <verbatim|push>, <verbatim|pop> and
  <verbatim|top> and extracts the patterns for arguments marked with the
  <verbatim|stack> tag in the interface. The <verbatim|stack> patterns
  implemented by <em|all> of the interface operations make up the
  <verbatim|stack> type; i.e., the members of the type are all the instances
  of these patterns.

  Right now our <verbatim|stack> type doesn't have any members, because we
  didn't implement the interface operations yet, so let's do this now. For
  instance, to implement stacks as lists, we might define:

  <\verbatim>
    push xs@[] x \| push xs@(_:_) x = x:xs;

    pop (x:xs) = xs;

    top (x:xs) = x;
  </verbatim>

  This is also known as ``instantiating'' the type. In addition, we will need
  an operation to create an initial stack value. The following will do for
  our purposes:

  <\verbatim>
    stack xs::list = xs;
  </verbatim>

  This yields a stack with the given initial contents. Let's give it a go:

  <\verbatim>
    \<gtr\> top (push (stack []) 99);

    99
  </verbatim>

  Looks good so far. We can also check the actual definition of the type in
  terms of its <hlink|<with|font-family|tt|type>|#type> rules using the
  <verbatim|show> <verbatim|interface> command:

  <\verbatim>
    \<gtr\> show interface stack

    type stack xs@(_:_);
  </verbatim>

  Wait, something seems to be wrong there. The empty list pattern of the
  <verbatim|push> function is missing, where did it go? Let's restart the
  interpreter with warnings enabled (<hlink|<em|-w>|#cmdoption-pure-w>) and
  retype the above definitions. The compiler then tells us:

  <\verbatim>
    \<gtr\> show interface stack

    warning: interface 'stack' may be incomplete

    warning: function 'pop' might lack a rule for 'xs@[]'

    warning: function 'top' might lack a rule for 'xs@[]'

    type stack xs@(_:_);
  </verbatim>

  See? A pattern is only considered part of the type if it is supported by
  <em|all> the interface operations. Since the <verbatim|pop> and
  <verbatim|top> operations don't have any rules for empty list arguments,
  empty lists are excluded from the type. We can fix this quite easily by
  adding the following ``error rules'' which handle this case:

  <\verbatim>
    \<gtr\> pop [] = throw "empty stack";

    \<gtr\> top [] = throw "empty stack";

    \<gtr\> show interface stack

    type stack xs@[];

    type stack xs@(_:_);
  </verbatim>

  This looks fine now, so let's see how we can put our new stack data
  structure to good use. Operations on the type are defined as usual,
  employing <verbatim|stack> as a type tag for stack arguments so that we can
  be sure that the <verbatim|push>, <verbatim|pop> and <verbatim|top>
  operations are all supported. For instance, let's implement a little RPN
  (``Reverse Polish Notation'') calculator:

  <\verbatim>
    rpn xs::stack ops::list = foldl (call []) xs ops with

    \ \ call ys xs op = push xs (foldl ($) op ys) if nargs op\<less\>=#ys;

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ = call (top xs:ys) (pop xs) op otherwise;

    end;
  </verbatim>

  This takes an initial stack <verbatim|xs> and a list <verbatim|ops> of
  operands and operations as inputs and returns the resulting stack after
  processing <verbatim|ops>. Examples:

  <\verbatim>
    \<gtr\> rpn (stack []) [10,4,3,(+),2,(*),(-)];

    [-4]

    \<gtr\> using math;

    \<gtr\> rpn (stack []) [1,2,ln,(/)];

    [1.44269504088896]

    \<gtr\> rpn (stack []) [4,1,atan,(*)];

    [3.14159265358979]

    \<gtr\> rpn (stack []) [2,(*)];

    \<less\>stdin\<gtr\>, line 5: unhandled exception '"empty stack"' while
    evaluating

    'rpn (stack []) [2,(*)]'
  </verbatim>

  Ok, this is all very nice, but it seems that so far we haven't done much
  more than we could have achieved just as easily with plain lists instead.
  So what are the benefits of having an interface type?

  First, an interface provides a fair amount of
  <with|font-series|bold|safety>. As long as we stick to the interface
  functions, we can be sure that the data is capable of carrying out the
  requested operations. At the same time, the interface also serves as a
  valuable piece of documentation, since it tells us at a glance exactly
  which operations are supported by the type.

  Second, an interface provides <with|font-series|bold|data abstraction>. We
  don't need to know how the interface operations are implemented, and in
  fact functions coded against the interface will work with <em|any>
  implementation of the interface. For instance, suppose that we'd like to
  provide a ``bounded stacks'' data structure, i.e., stacks which don't grow
  beyond a certain limit. These can be implemented as follows:

  <\verbatim>
    push (n,xs@[]) x \| push (n,xs@(_:_)) x =

    \ \ if n\<gtr\>0 then (n-1,x:xs) else throw "full stack";

    pop (n,x:xs) = n+1,xs;

    top (n,x:xs) = x;

    pop (n,[]) = throw "empty stack";

    top (n,[]) = throw "empty stack";
  </verbatim>

  Note that we represent a bounded stack by a pair <verbatim|(n,xs)> here,
  where <verbatim|xs> is the list of elements and <verbatim|n> is the ``free
  space'' (number of elements we still allow to be pushed). We also add a
  function to construct such values:

  <\verbatim>
    bstack n::int xs::list = (n-#xs,xs);
  </verbatim>

  Without any further ado, our little RPN calculator works just fine with the
  new variation of the data structure:

  <\verbatim>
    \<gtr\> rpn (bstack 3 []) [10,4,3,(+),2,(*),(-)];

    2,[-4]

    \<gtr\> rpn (bstack 2 []) [10,4,3,(+),2,(*),(-)];

    \<less\>stdin\<gtr\>, line 7: unhandled exception '"full stack"' while
    evaluating

    'rpn (bstack 2 []) [10,4,3,(+),2,(*),(-)]'
  </verbatim>

  While they're quite useful in general, Pure's interface types also have
  their limitations. In particular, the guarantees provided by an interface
  are of a purely syntactic nature; the signature doesn't tell us anything
  about the actual meaning of the provided operations, so unit testing is
  still needed to ensure certain semantic properties of the implementation.
  Some further issues due to Pure's dynamically typed nature are discussed
  under <hlink|Interfaces|#interfaces> in the <hlink|Caveats and
  Notes|#caveats-and-notes> section.

  <subsubsection|Modules and Imports<label|modules-and-imports>>

  Pure doesn't offer separate compilation, but the following type of
  declaration provides a simple but effective way to assemble a Pure program
  from several source modules.

  <\verbatim>
    using_decl ::= \ "using" name ("," name)* ";"

    name \ \ \ \ \ \ ::= \ qualified_identifier \| string
  </verbatim>

  The <hlink|<with|font-family|tt|using>|#using> declaration takes the
  following form (note that in contrast to symbol declarations, the comma is
  used as a delimiter symbol here):

  <\description>
    <item*|using name, ...;>
  </description>

  This causes each given script to be included in the Pure program at the
  given point (if it wasn't already included before), which makes available
  all the definitions of the included script in your program. Note that each
  included script is loaded only <em|once>, when the first
  <hlink|<with|font-family|tt|using>|#using> clause for the script is
  encountered. Nested imports are allowed, i.e., an imported module may
  itself import other modules, etc. A Pure program then basically is the
  concatenation of all the source modules given as command line arguments,
  with other modules listed in <hlink|<with|font-family|tt|using>|#using>
  clauses inserted at the corresponding source locations.

  (The <hlink|<with|font-family|tt|using>|#using> clause also has an
  alternative form which allows dynamic libraries and LLVM bitcode modules to
  be loaded, this will be discussed in the <hlink|C Interface|#c-interface>
  section.)

  For instance, the following declaration causes the math.pure script from
  the standard library to be included in your program:

  <\verbatim>
    using math;
  </verbatim>

  You can also import multiple scripts in one go:

  <\verbatim>
    using array, dict, set;
  </verbatim>

  Moreover, Pure provides a notation for qualified module names which can be
  used to denote scripts located in specific package directories, e.g.:

  <\verbatim>
    using examples::libor::bits;
  </verbatim>

  In fact this is equivalent to the following
  <hlink|<with|font-family|tt|using>|#using> clause which spells out the real
  filename of the script between double quotes (the <verbatim|.pure> suffix
  can also be omitted in which case it is added automatically):

  <\verbatim>
    using "examples/libor/bits.pure";
  </verbatim>

  Both notations can be used interchangeably; the former is usually more
  convenient, but the latter allows you to denote scripts whose names aren't
  valid Pure identifiers.

  Script identifiers are translated to the corresponding filenames by
  replacing the `<verbatim|::>` symbol with the pathname separator
  `<verbatim|/>` and tacking on the `<verbatim|.pure>` suffix. The following
  table illustrates this with a few examples.

  <tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|l>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|l>|<cwith|1|-1|2|2|cell-rborder|0ln>|<cwith|1|-1|1|-1|cell-valign|c>|<cwith|1|1|1|-1|cell-bborder|1ln>|<table|<row|<cell|Script
  identifier>|<cell|Filename>>|<row|<cell|<verbatim|math>>|<cell|<verbatim|"math.pure">>>|<row|<cell|<verbatim|examples::libor::bits>>|<cell|<verbatim|"examples/libor/bits.pure">>>|<row|<cell|<verbatim|::pure::examples::hello>>|<cell|<verbatim|"/pure/examples/hello.pure">>>>>>

  Note the last example, which shows how an absolute pathname can be denoted
  using a qualifier starting with `<verbatim|::>`.

  Unless an absolute pathname is given, the interpreter performs a search to
  locate the script. The search algorithm considers the following directories
  in the given order:

  <\itemize>
    <item>the directory of the current script, which is the directory of the
    script containing the <hlink|<with|font-family|tt|using>|#using> clause,
    or the current working directory if the clause was read from standard
    input (as is the case, e.g., in an interactive session);

    <item>the directories named in <hlink|<em|-I>|#cmdoption-pure-I> options
    on the command line (in the given order);

    <item>the colon-separated list of directories in
    the<label|index-11><hlink|<with|font-family|tt|PURE_INCLUDE>|#envvar-PURE-INCLUDE>
    environment variable (in the given order);

    <item>finally the directory named by the<label|index-12><hlink|<with|font-family|tt|PURELIB>|#envvar-PURELIB>
    environment variable.
  </itemize>

  Note that the current working directory is not searched by default (unless
  the <hlink|<with|font-family|tt|using>|#using> clause is read from standard
  input), but of course you can force this by adding the option
  <hlink|<em|-I>|#cmdoption-pure-I>. to the command line, or by including `.'
  in the<label|index-13><hlink|<with|font-family|tt|PURE_INCLUDE>|#envvar-PURE-INCLUDE>
  variable.

  The directory of the current script (the first item above) can be skipped
  by specifying the script to be loaded as a filename in double quotes,
  prefixed with the special <verbatim|sys:> tag. The search then starts with
  the ``system'' directories (<hlink|<em|-I>|#cmdoption-pure-I>,<label|index-14><hlink|<with|font-family|tt|PURE_INCLUDE>|#envvar-PURE-INCLUDE>
  and<label|index-15><hlink|<with|font-family|tt|PURELIB>|#envvar-PURELIB>)
  instead. This is useful, e.g., if you want to provide your own custom
  version of a standard library script which in turn imports that library
  script. For instance, a custom version of math.pure might employ the
  following <hlink|<with|font-family|tt|using>|#using> clause to load the
  math.pure script from the Pure library:

  <\verbatim>
    using "sys:math";

    // custom definitions go here

    log2 x = ln x/ln 2;
  </verbatim>

  The interpreter compares script names (to determine whether two scripts are
  actually the same) by using the <em|canonicalized> full pathname of the
  script, following symbolic links to the destination file (albeit only one
  level). Thus different scripts with the same basename, such as
  foo/utils.pure and bar/utils.pure can both be included in the same program
  (unless they link to the same file).

  More precisely, canonicalizing a pathname involves the following steps:

  <\itemize>
    <item>relative pathnames are expanded to absolute ones, using the search
    rules discussed above;

    <item>the directory part of the pathname is normalized to the form
    returned by the <verbatim|getcwd> system call;

    <item>the ''.pure'' suffix is added if needed;

    <item>if the resulting script name is actually a symbolic link, the
    interpreter follows that link to its destination, albeit only one level.
    (This is only done on Unix-like systems.)
  </itemize>

  The directory of the canonicalized pathname is also used when searching
  other scripts included in a script. This makes it possible to have an
  executable script with a shebang line in its own directory, which is then
  executed via a symbolic link placed on the
  system<label|index-16><verbatim|PATH>. In this case the script search
  performed in <hlink|<with|font-family|tt|using>|#using> clauses will use
  the real script directory and thus other required scripts can be located
  there. This is the recommended practice for installing standalone Pure
  applications in source form which are to be run directly from the shell.

  <subsubsection|Namespaces<label|namespaces>>

  To facilitate modular development, Pure also provides namespaces as a means
  to avoid name clashes between symbols, and to keep the global namespace
  tidy and clean. Namespaces serve as containers holding groups of related
  identifiers and other symbols. Inside each namespace, symbols must be
  unique, but the same symbol may be used to denote different objects
  (variables, functions, etc.) in different namespaces. (Pure's namespace
  system was heavily inspired by C++ and works in a very similar fashion. So
  if you know C++ you should feel right at home and skimming this section to
  pick up Pure's syntax of the namespace constructs should be enough to start
  using it.)

  The global namespace is always available. By default, new symbols are
  created in this namespace, which is also called the
  <with|font-series|bold|default namespace>. Additional namespaces can be
  created with the <hlink|<with|font-family|tt|namespace>|#namespace>
  declaration, which also switches to the given namespace (makes it the
  <em|current> namespace), so that new symbols are then created in that
  namespace rather than the default one. The current namespace also applies
  to all kinds of symbol declarations, including operator and nonfix symbol
  declarations, as well as <hlink|<with|font-family|tt|extern>|#extern>
  declarations (the latter are described in the <hlink|C
  Interface|#c-interface> section).

  The syntax of namespace declarations is captured by the following grammar
  rules:

  <\verbatim>
    namespace_decl ::= \ "namespace" [name] [brackets] ";"

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| "namespace" name [brackets]
    "with" item+ "end" ";"

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \| "using" "namespace" [name_spec
    ("," name_spec)*] ";"

    brackets \ \ \ \ \ \ ::= \ "(" left_op right_op ")"

    name_spec \ \ \ \ \ ::= \ name ["(" qualified_symbol+ ")"]
  </verbatim>

  The basic form of the <hlink|<with|font-family|tt|namespace>|#namespace>
  declaration looks as follows (there's also a ``scoped'' form of the
  <hlink|<with|font-family|tt|namespace>|#namespace> declaration which will
  be discussed in <hlink|Scoped Namespaces|#scoped-namespaces> at the end of
  this section):

  <\verbatim>
    namespace name;

    // declarations and definitions in namespace 'name'

    namespace;
  </verbatim>

  The second form switches back to the default namespace. For instance, in
  order to define two symbols with the same print name <verbatim|foo> in two
  different namespaces <verbatim|foo> and <verbatim|bar>, you can write:

  <\verbatim>
    namespace foo;

    foo x = x+1;

    namespace bar;

    foo x = x-1;

    namespace;
  </verbatim>

  We can now refer to the symbols we just defined using
  <with|font-series|bold|qualified symbols> of the form
  <verbatim|namespace::symbol>:

  <\verbatim>
    \<gtr\> foo::foo 99;

    100

    \<gtr\> bar::foo 99;

    98
  </verbatim>

  This avoids any potential name clashes, since the qualified identifier
  notation always makes it clear which namespace the given identifier belongs
  to.

  A namespace can be ``reopened'' at any time to add new symbols and
  definitions to it. This allows namespaces to be created that span several
  source modules. You can also create several different namespaces in the
  same module.

  Similar to the <hlink|<with|font-family|tt|using>|#using> declaration, a
  <hlink|<with|font-family|tt|namespace>|#namespace> declaration accepts
  either identifiers or double-quoted strings as namespace names. E.g., the
  following two declarations are equivalent:

  <\verbatim>
    namespace foo;

    namespace "foo";
  </verbatim>

  The latter form also allows more descriptive labels which aren't
  identifiers, e.g.:

  <\verbatim>
    namespace "Private stuff, keep out!";
  </verbatim>

  Note that the namespace prefix in a qualified identifier must be a legal
  identifier, so it isn't possible to access symbols in namespaces with such
  descriptive labels in a direct fashion. The only way to get at the symbols
  in this case is with <hlink|namespace brackets|#namespace-brackets> or by
  using a <hlink|<with|font-family|tt|namespace>|#namespace> or
  <hlink|<with|font-family|tt|using> <with|font-family|tt|namespace>|#using-namespace>
  declaration (for the latter see <hlink|Using Namespaces|#using-namespaces>
  below).

  <paragraph|Using Namespaces<label|using-namespaces>>

  Since it is rather inconvenient if you always have to write identifiers in
  their qualified form outside of their ``home'' namespace, Pure allows you
  to specify a list of <em|search> namespaces which are used to look up
  symbols not in the default or the current namespace. This is done with the
  <hlink|<with|font-family|tt|using> <with|font-family|tt|namespace>|#using-namespace>
  declaration, which takes the following form:

  <\verbatim>
    using namespace name1, name2, ...;

    // ...

    using namespace;
  </verbatim>

  As with <hlink|<with|font-family|tt|namespace>|#namespace> declarations,
  the second form without any namespace arguments gets you back to the
  default empty list of search namespaces.

  For instance, consider this example:

  <\verbatim>
    namespace foo;

    foo x = x+1;

    namespace bar;

    foo x = x-1;

    bar x = x+1;

    namespace;
  </verbatim>

  The symbols in these namespaces can be accessed unqualified as follows:

  <\verbatim>
    \<gtr\> using namespace foo;

    \<gtr\> foo 99;

    100

    \<gtr\> using namespace bar;

    \<gtr\> foo 99;

    98

    \<gtr\> bar 99;

    100
  </verbatim>

  This method is often to be preferred over opening a namespace with the
  <hlink|<with|font-family|tt|namespace>|#namespace> declaration, since
  <hlink|<with|font-family|tt|using> <with|font-family|tt|namespace>|#using-namespace>
  only gives you ``read access'' to the imported symbols, so you can't
  accidentally mess up the definitions of the namespace you're using. Another
  advantage is that the <hlink|<with|font-family|tt|using>
  <with|font-family|tt|namespace>|#using-namespace> declaration also lets you
  search multiple namespaces at once:

  <\verbatim>
    using namespace foo, bar;
  </verbatim>

  Be warned, however, that this brings up the very same issue of name clashes
  again:

  <\verbatim>
    \<gtr\> using namespace foo, bar;

    \<gtr\> foo 99;

    \<less\>stdin\<gtr\>, line 15: symbol 'foo' is ambiguous here
  </verbatim>

  In such a case you'll have to resort to using namespace qualifiers again,
  in order to resolve the name clash:

  <\verbatim>
    \<gtr\> foo::foo 99;

    100
  </verbatim>

  To avoid this kind of mishap, you can also selectively import just a few
  symbols from a namespace instead. This can be done with a declaration of
  the following form:

  <\verbatim>
    using namespace name1 ( sym1 sym2 ... ), name2 ... ;
  </verbatim>

  As indicated, the symbols to be imported can optionally be placed as a
  whitespace-delimited list inside parentheses, following the corresponding
  namespace name. (As with symbol declarations, the symbols may optionally be
  qualified with a namespace prefix, which must match the imported namespace
  here.) For instance:

  <\verbatim>
    \<gtr\> using namespace foo, bar (bar);

    \<gtr\> foo 99;

    100

    \<gtr\> bar 99;

    100

    \<gtr\> bar::foo 99;

    98
  </verbatim>

  Note that now we have no clash on the <verbatim|foo> symbol any more,
  because we restricted the import from the <verbatim|bar> namespace to the
  <verbatim|bar> symbol, so that <verbatim|bar::foo> has to be denoted with a
  qualified symbol now.

  <paragraph|Symbol Lookup and Creation<label|symbol-lookup-and-creation>>

  Pure's rules for looking up and creating symbols are fairly straightforward
  and akin to those in other languages featuring namespaces. However, there
  are some intricacies involved, because the rewriting rule format of
  definitions allows ``referential'' use of symbols not only in the ``body''
  (right-hand side) of a definition, but also in the left-hand side patterns.
  We discuss this in detail below.

  The compiler searches for symbols first in the current namespace (if any),
  then in the currently active search namespaces (if any), and finally in the
  default (i.e., the global) namespace, in that order. This automatic lookup
  can be bypassed by using an <em|absolute> namespace qualifier of the form
  <verbatim|::foo::bar>. In particular, <verbatim|::bar> always denotes the
  symbol <verbatim|bar> in the default namespace, while <verbatim|::foo::bar>
  denotes the symbol <verbatim|bar> in the <verbatim|foo> namespace.
  (Normally, the latter kind of notation is only needed if you have to deal
  with nested namespaces, see <hlink|Hierarchical
  Namespaces|#hierarchical-namespaces> below.)

  If no existing symbol is found, a new symbol is created automatically, by
  implicitly declaring a public symbol with default attributes. New
  <em|unqualified> symbols are always created in the current namespace, while
  new <em|qualified> symbols are created in the namespace given by the
  namespace prefix of the symbol.

  <with|font-series|bold|Note:> Pure's implicit symbol declarations are a
  mixed blessing. They are convenient, especially in interactive usage, but
  they also let missing or mistyped symbols go unnoticed much too easily. As
  a remedy, in the case of qualified symbols the compiler checks that the
  given namespace prefix matches the current namespace, in order to catch
  typos and other silly mistakes and prevent you from accidentally clobbering
  the contents of other namespaces. For instance:

  <\verbatim>
    \<gtr\> namespace foo;

    \<gtr\> namespace;

    \<gtr\> foo::bar x = 1/x;

    \<less\>stdin\<gtr\>, line 3: undeclared symbol 'foo::bar'
  </verbatim>

  To make these errors go away it's enough to just declare the symbols in
  their proper namespaces.

  In addition, you can run the interpreter with the
  <hlink|<em|-w>|#cmdoption-pure-w> option (see <hlink|Invoking
  Pure|#invoking-pure>) to check your scripts for (non-defining) uses of
  undeclared unqualified function symbols. This is highly recommended. For
  instance, in the following example we forgot to import the
  <hlink|<with|font-family|tt|system>|purelib.tm#module-system> module which
  defines the <hlink|<with|font-family|tt|puts>|purelib.tm#puts> function.
  Running the interpreter with <hlink|<em|-w>|#cmdoption-pure-w> highlights
  such potential errors:

  <\verbatim>
    $ pure -w

    \<gtr\> puts "bla"; // missing import of system module

    \<less\>stdin\<gtr\>, line 1: warning: implicit declaration of 'puts'

    puts "bla"
  </verbatim>

  For legitimate uses (such as forward uses of a symbol which is defined
  later), you can make these warnings go away by declaring the symbol before
  using it.

  New symbols are also created if a global unqualified (and yet undeclared)
  symbol is being ``defined'' in a rewriting rule or
  <hlink|<with|font-family|tt|let>|#let>/<hlink|<with|font-family|tt|const>|#const>
  definition, even if a symbol with the same print name from another
  namespace is already visible in the current scope. To distinguish
  ``defining'' from ``referring'' uses of a global symbol, Pure uses the
  following (purely syntactic) notions:

  <\itemize>
    <item>A <with|font-series|bold|defining occurrence> of a global
    <em|function>, <em|macro> or <em|type symbol> is any occurrence of the
    symbol as the (leftmost) <em|head symbol> on the left-hand side of a
    rewriting rule.

    <item>A <with|font-series|bold|defining occurrence> of a global
    <em|variable> or <em|constant symbol> is any occurrence of the symbol in
    a <em|variable position> (as given by the ``head = function'' rule, cf.
    <hlink|Variables in Equations|#variables-in-equations>) on the left-hand
    side of a <hlink|<with|font-family|tt|let>|#let> or
    <hlink|<with|font-family|tt|const>|#const> definition.

    <item>All other occurrences of global symbols on the left-hand side, as
    well as <em|all> symbol occurrences on the right-hand side of a
    definition are <with|font-series|bold|referring occurrences>. (Note that
    this also subsumes all occurrences of <em|type tags> on the left-hand
    side of an equation.)
  </itemize>

  The following example illustrates these notions:

  <\verbatim>
    namespace foo;

    bar (bar x) = bar x;

    let x,y = 1,2;

    namespace;
  </verbatim>

  Here, the first occurrence of <verbatim|bar> on the left-hand side
  <verbatim|bar> <verbatim|(bar> <verbatim|x)> of the first rule is a
  <em|defining> occurrence, as are the occurrences of <verbatim|x> and
  <verbatim|y> on the left-hand side of the
  <hlink|<with|font-family|tt|let>|#let> definition. Hence these symbols are
  created as new symbols in the namespace <verbatim|foo>. On the other hand,
  the other occurrences of <verbatim|bar> in the first rule, as well as the
  `<verbatim|,>` symbol on the left-hand side of the
  <hlink|<with|font-family|tt|let>|#let> definition are <em|referring>
  occurrences. In the former case, <verbatim|bar> refers to the
  <verbatim|bar> symbol defined by the rule, while in the latter case the
  `<verbatim|,>` operator is actually declared in the prelude and thus
  imported from the global namespace.

  The same rules of lookup also apply to type tags on the left-hand side of
  an equation, but in this case the interpreter will look specifically for
  type symbols, avoiding any other kinds of symbols which might be visible in
  the same context. Thus, in the following example, the type tag
  <verbatim|bar> is correctly resolved to <verbatim|bar::bar>, even though
  the (function) symbol <verbatim|foo::bar> is visible at this point:

  <\verbatim>
    \<gtr\> namespace bar;

    \<gtr\> type bar;

    \<gtr\> namespace foo;

    \<gtr\> public bar;

    \<gtr\> using namespace bar;

    \<gtr\> foo x::bar = bar x;

    \<gtr\> show foo::foo

    foo::foo x :: bar::bar = foo::bar x;
  </verbatim>

  Note that special operator (and nonfix) symbols <em|always> require an
  explicit declaration. This works as already discussed in the <hlink|Symbol
  Declarations|#symbol-declarations> section, except that you first switch to
  the appropriate namespace before declaring the symbols. For instance, here
  is how you can create a new <verbatim|+> operation which multiplies its
  operands rather than adding them:

  <\verbatim>
    \<gtr\> namespace my;

    \<gtr\> infixl 2200 +;

    \<gtr\> x+y = x*y;

    \<gtr\> 5+7;

    35
  </verbatim>

  Note that the new <verbatim|+> operation really belongs to the namespace we
  created. The <verbatim|+> operation in the default namespace works as
  before, and in fact you can use qualified symbols to pick the version that
  you need:

  <\verbatim>
    \<gtr\> namespace;

    \<gtr\> 5+7;

    12

    \<gtr\> 5 ::+ 7;

    12

    \<gtr\> 5 my::+ 7;

    35
  </verbatim>

  Here's what you get if you happen to forget the declaration of the
  <verbatim|+> operator:

  <\verbatim>
    \<gtr\> namespace my;

    \<gtr\> x+y = x*y;

    \<less\>stdin\<gtr\>, line 2: infixl symbol '+' was not declared in this
    namespace
  </verbatim>

  Thus the compiler will never create a new instance of an operator symbol on
  the fly, an explicit declaration is always needed in such cases.

  Note that if you <em|really> wanted to redefine the global <verbatim|+>
  operator, you can do this even while the <verbatim|my> namespace is
  current. You just have to use a qualified identifier in this case, as
  follows:

  <\verbatim>
    \<gtr\> namespace my;

    \<gtr\> x ::+ y = x*y;

    \<gtr\> a+b;

    a*b
  </verbatim>

  This should rarely be necessary (in the above example you might just as
  well enter this rule while in the global namespace), but it can be useful
  in some circumstances. Specifically, you might want to ``overload'' a
  global function or operator with a definition that makes use of private
  symbols of a namespace (which are only visible inside that namespace; see
  <hlink|Private Symbols|#private-symbols> below). For instance:

  <\verbatim>
    \<gtr\> namespace my;

    \<gtr\> private bar;

    \<gtr\> bar x y = x*y;

    \<gtr\> x ::+ y = bar x y;

    \<gtr\> a+b;

    a*b
  </verbatim>

  (The above is a rather contrived example, since the very same functionality
  can be accomplished much easier, but there are some situations where this
  method is needed.)

  <paragraph|Private Symbols<label|private-symbols>>

  Pure also allows you to have private symbols, as a means to hide away
  internal operations which shouldn't be accessed directly outside the
  namespace in which they are declared. The scope of a private symbol is
  confined to its namespace, i.e., the symbol is only visible when its
  ``home'' namespace is current. Symbols are declared private by using the
  <hlink|<with|font-family|tt|private>|#private> keyword in the symbol
  declaration:

  <\verbatim>
    \<gtr\> namespace secret;

    \<gtr\> private baz;

    \<gtr\> // 'baz' is a private symbol in namespace 'secret' here

    \<gtr\> baz x = 2*x;

    \<gtr\> // you can use 'baz' just like any other symbol here

    \<gtr\> baz 99;

    198

    \<gtr\> namespace;
  </verbatim>

  Note that, at this point, <verbatim|secret::baz> is now invisible, even if
  you have <verbatim|secret> in the search namespace list:

  <\verbatim>
    \<gtr\> using namespace secret;

    \<gtr\> // this actually creates a 'baz' symbol in the default namespace:

    \<gtr\> baz 99;

    baz 99

    \<gtr\> secret::baz 99;

    \<less\>stdin\<gtr\>, line 27: symbol 'secret::baz' is private here
  </verbatim>

  The only way to bring the symbol back into scope is to make the
  <verbatim|secret> namespace current again:

  <\verbatim>
    \<gtr\> namespace secret;

    \<gtr\> baz 99;

    198

    \<gtr\> secret::baz 99;

    198
  </verbatim>

  <paragraph|Namespace Brackets<label|namespace-brackets>>

  All the namespace-related constructs we discussed so far only provide a
  means to switch namespaces on a per-rule basis. Sometimes it is convenient
  if you can switch namespaces on the fly inside an expression. This is
  especially useful if you want to embed a domain-specific sublanguage (DSL)
  in Pure. DSLs typically provide their own system of operators which differ
  from the standard Pure operators and thus need to be declared in their own
  namespace.

  To make this possible, Pure allows you to associate a namespace with a
  corresponding pair of outfix symbols. This turns the outfix symbols into
  special <with|font-series|bold|namespace brackets> which can then be used
  to quickly switch namespaces in an expression by just enclosing a
  subexpression in the namespace brackets.

  To these ends, the syntax of <hlink|<with|font-family|tt|namespace>|#namespace>
  declarations allows you to optionally specify a pair of outfix symbols
  inside parentheses after the namespace name. The outfix symbols to be used
  as namespace brackets must have been declared beforehand. For instance:

  <\verbatim>
    outfix \<less\>\<less\> \<gtr\>\<gtr\>;

    namespace foo (\<less\>\<less\> \<gtr\>\<gtr\>);

    infixr (::^) ^;

    x^y = 2*x+y;

    namespace;
  </verbatim>

  The code above introduces a <verbatim|foo> namespace which defines a
  special variation of the <verbatim|(^)> operator. It also associates the
  namespace with the <verbatim|\<\<> <verbatim|\>\>> brackets so that you can
  write:

  <\verbatim>
    \<gtr\> (a+b)^c+10;

    (a+b)^c+10

    \<gtr\> \<less\>\<less\>(a+b)^c\<gtr\>\<gtr\>+10;

    2*(a+b)+c+10
  </verbatim>

  Note the use of the namespace brackets in the second input line. This
  changes the meaning of the <verbatim|^> operator, which now refers to
  <verbatim|foo::^> instead. Also note that the namespace brackets themselves
  are removed from the resulting expression; they are only used to
  temporarily switch the namespace to <verbatim|foo> inside the bracketed
  subexpression. This works pretty much like a
  <hlink|<with|font-family|tt|namespace>|#namespace> declaration (so any
  active search namespaces remain in effect), but is limited in scope to the
  bracketed subexpression and only gives access to the public symbols of the
  namespace (like a <hlink|<with|font-family|tt|using>
  <with|font-family|tt|namespace>|#using-namespace> declaration would do).

  The rules of visibility for the namespace bracket symbols themselves are
  the same as for any other symbols. So they need to be in scope if you want
  to denote them in unqualified form (which is always the case if they are
  declared in the default namespace, as in the example above). If necessary,
  you can also specify them in their qualified form as usual.

  Namespace brackets can be used anywhere inside an expression, even on the
  left-hand side of a rule. So, for instance, we might also have written the
  example above as follows:

  <\verbatim>
    outfix \<less\>\<less\> \<gtr\>\<gtr\>;

    namespace foo (\<less\>\<less\> \<gtr\>\<gtr\>);

    infixr (::^) ^;

    namespace;

    \;

    \<less\>\<less\>x^y\<gtr\>\<gtr\> = 2*x+y;
  </verbatim>

  Note the use of the namespace brackets on the last line. This rule actually
  expands to:

  <\verbatim>
    x foo::^ y \ = 2*x+y;
  </verbatim>

  The special meaning of namespace brackets can be turned off and back on
  again at any time with a corresponding <hlink|<with|font-family|tt|namespace>|#namespace>
  declaration. For instance:

  <\verbatim>
    \<gtr\> namespace (\<less\>\<less\> \<gtr\>\<gtr\>); // turn off the
    special meaning of \<less\>\<less\> \<gtr\>\<gtr\>

    \<gtr\> \<less\>\<less\>(a+b)^c\<gtr\>\<gtr\>+10;

    \<less\>\<less\> (a+b)^c \<gtr\>\<gtr\>+10

    \<gtr\> namespace foo (\<less\>\<less\> \<gtr\>\<gtr\>); // turn it on
    again

    \<gtr\> namespace;

    \<gtr\> \<less\>\<less\>(a+b)^c\<gtr\>\<gtr\>+10;

    2*(a+b)+c+10
  </verbatim>

  (Note that as a side effect these declarations also change the current
  namespace, so that we use the <verbatim|namespace;> declaration in the
  second last line to change back to the default namespace.)

  As shown in the first line of the example above, a namespace brackets
  declaration without a namespace just turns off the special processing of
  the brackets. In order to define a namespace bracket for the <em|default>
  namespace, you need to explicitly specify an empty namespace instead, as
  follows:

  <\verbatim>
    \<gtr\> outfix \<less\>\<less\>: :\<gtr\>\<gtr\>;

    \<gtr\> namespace "" (\<less\>\<less\>: :\<gtr\>\<gtr\>);

    \<gtr\> \<less\>\<less\>(a+b)^\<less\>\<less\>:x^y:\<gtr\>\<gtr\>\<gtr\>\<gtr\>;

    2*(a+b)+x^y
  </verbatim>

  As this example illustrates, namespace brackets can also be nested, which
  is useful, e.g., if you need to combine subexpressions from several DSLs in
  a single expression. In this example we employ the <verbatim|\<\<:x^y:\>\>>
  subexpression to temporarily switch back to the default namespace inside
  the <verbatim|\<\<> <verbatim|\>\>>-bracketed expression which is parsed in
  the <verbatim|foo> namespace.

  <paragraph|Hierarchical Namespaces<label|hierarchical-namespaces>>

  Namespace identifiers can themselves be qualified identifiers in Pure,
  which enables you to introduce a hierarchy of namespaces. This is useful,
  e.g., to group related namespaces together under a common ``umbrella''
  namespace:

  <\verbatim>
    namespace my;

    namespace my::old;

    foo x = x+1;

    namespace my::new;

    foo x = x-1;
  </verbatim>

  Note that the namespace <verbatim|my>, which serves as the parent
  namespace, must be created before the <verbatim|my::old> and
  <verbatim|my::new> namespaces, even if it does not contain any symbols of
  its own. After these declarations, the <verbatim|my::old> and
  <verbatim|my::new> namespaces are part of the <verbatim|my> namespace and
  will be considered in name lookup accordingly, so that you can write:

  <\verbatim>
    \<gtr\> using namespace my;

    \<gtr\> old::foo 99;

    100

    \<gtr\> new::foo 99;

    98
  </verbatim>

  This works pretty much like a hierarchy of directories and files, where the
  namespaces play the role of the directories (with the default namespace as
  the root directory), the symbols in each namespace correspond to the files
  in a directory, and the <hlink|<with|font-family|tt|using>
  <with|font-family|tt|namespace>|#using-namespace> declaration functions
  similar to the shell's<label|index-17><verbatim|PATH> variable.

  Sometimes it is necessary to tell the compiler to use a symbol in a
  specific namespace, bypassing the usual symbol lookup mechanism. For
  instance, suppose that we introduce another <em|global> <verbatim|old>
  namespace and define yet another version of <verbatim|foo> in that
  namespace:

  <\verbatim>
    namespace old;

    foo x = 2*x;

    namespace;
  </verbatim>

  Now, if we want to access that function, with <verbatim|my> still active as
  the search namespace, we cannot simply refer to the new function as
  <verbatim|old::foo>, since this name will resolve to
  <verbatim|my::old::foo> instead. As a remedy, the compiler accepts an
  <with|font-series|bold|absolute> qualified identifier of the form
  <verbatim|::old::foo>. This bypasses name lookup and thus always yields
  exactly the symbol in the given namespace (if it exists; as mentioned
  previously, the compiler will complain about an undeclared symbol
  otherwise):

  <\verbatim>
    \<gtr\> old::foo 99;

    100

    \<gtr\> ::old::foo 99;

    198
  </verbatim>

  Also note that, as a special case of the absolute qualifier notation,
  <verbatim|::foo> always denotes the symbol <verbatim|foo> in the default
  namespace.

  <paragraph|Scoped Namespaces<label|scoped-namespaces>>

  Pure also provides an alternative scoped
  <hlink|<with|font-family|tt|namespace>|#namespace> construct which makes
  nested namespace definitions more convenient. This construct takes the
  following form:

  <\verbatim>
    namespace name with ... end;
  </verbatim>

  The part between <hlink|<with|font-family|tt|with>|#with> and
  <hlink|<with|font-family|tt|end>|#end> may contain arbitrary declarations
  and definitions, using the same syntax as the toplevel. These are processed
  in the context of the given namespace, as if you had written:

  <\verbatim>
    namespace name;

    ...

    namespace;
  </verbatim>

  However, the scoped namespace construct always returns you to the namespace
  which was active before, and thus these declarations may be nested:

  <\verbatim>
    namespace foo with

    \ \ // declarations and definitions in namespace foo

    \ \ namespace bar with

    \ \ \ \ // declarations and definitions in namespace bar

    \ \ end;

    \ \ // more declarations and definitions in namespace foo

    end;
  </verbatim>

  Note that this kind of nesting does not necessarily imply a namespace
  hierarchy as discussed in <hlink|Hierarchical
  Namespaces|#hierarchical-namespaces>. However, you can achieve this by
  using the appropriate qualified namespace names:

  <\verbatim>
    namespace foo with

    \ \ // ...

    \ \ namespace foo::bar with

    \ \ \ \ // ...

    \ \ end;

    \ \ // ...

    end;
  </verbatim>

  Another special feature of the scoped namespace construct is that
  <hlink|<with|font-family|tt|using> <with|font-family|tt|namespace>|#using-namespace>
  declarations are always local to the current namespace scope (and other
  nested namespace scopes inside it). Thus the previous setting is restored
  at the end of each scope:

  <\verbatim>
    using namespace foo;

    namespace foo with

    \ \ // still using namespace foo here

    \ \ using namespace bar;

    \ \ // now using namespace bar

    \ \ namespace bar with

    \ \ \ \ // still using namespace bar here

    \ \ \ \ using namespace foo;

    \ \ \ \ // now using namespace foo

    \ \ end;

    \ \ // back to using namespace bar

    end;

    // back to using namespace foo at toplevel
  </verbatim>

  Finally, here's a more concrete example which shows how scoped namespaces
  might be used to declare two namespaces and populate them with various
  functions and operators:

  <\verbatim>
    namespace foo with

    \ \ infixr (::^) ^;

    \ \ foo x = x+1;

    \ \ bar x = x-1;

    \ \ x^y = 2*x+y;

    end;

    \;

    namespace bar with

    \ \ outfix \<less\>: :\<gtr\>;

    \ \ foo x = x+2;

    \ \ bar x = x-2;

    end;

    \;

    using namespace foo(^ foo), bar(bar \<less\>: :\<gtr\>);

    \;

    // namespace foo

    foo x;

    x^y;

    \;

    // namespace bar

    bar x;

    \<less\>: x,y :\<gtr\>;
  </verbatim>

  Pure's namespaces can thus be used pretty much like ``packages'' or
  ``modules'' in languages like Ada or Modula-2. They provide a structured
  way to describe program components offering collections of related data and
  operations, which can be brought into scope in a controlled way by making
  judicious use of <hlink|<with|font-family|tt|using>
  <with|font-family|tt|namespace>|#using-namespace> declarations. They also
  provide an abstraction barrier, since internal operations and data
  structures can be hidden away employing private symbols.

  Please note that these facilities are not Pure's main focus and thus they
  are somewhat limited compared to programming languages specifically
  designed for big projects and large teams of developers. Nevertheless they
  should be useful if your programs grow beyond a small collection of simple
  source modules, and enable you to manage most Pure projects with ease.

  <subsection|Macros<label|macros>>

  Macros are a special type of functions to be executed as a kind of
  ``preprocessing stage'' at compile time. In Pure these are typically used
  to define custom special forms and to perform inlining of function calls
  and other kinds of source-level optimizations.

  Whereas the macro facilities of most programming languages simply provide a
  kind of textual substitution mechanism, Pure macros operate on symbolic
  expressions and are implemented by the same kind of rewriting rules that
  are also used to define ordinary functions in Pure. This makes them robust
  and easy to use for most common preprocessing purposes.

  Syntactically, a macro definition looks just like a function definition
  with the <hlink|<with|font-family|tt|def>|#def> keyword in front of it.
  Only unconditional rewriting rules are permitted here, i.e., rules without
  guards and multiple right-hand sides. However, multiple left-hand sides can
  be employed as usual to abbreviate a collection of rules with the same
  left-hand side, as described in the <hlink|General Rules|#general-rules>
  section.

  The major difference between function and macro definitions is that the
  latter are processed at compile time rather than run time. To these ends,
  macro calls on the right-hand sides of function, constant and variable
  definitions are evaluated by reducing them to normal form using the
  available macro rules. The resulting expressions are then substituted for
  the macro calls. All macro substitution happens before constant
  substitutions and the actual compilation step. Macros can be defined in
  terms of other macros (also recursively), and are normally evaluated using
  call by value (i.e., macro calls in macro arguments are expanded before the
  macro gets applied to its parameters).

  In the first half of this section we start out with some common uses of
  macros which should cover most aspects of macro programming that the
  average Pure programmer will need. The remainder of this section then
  discusses some more advanced features of Pure's macro system intended for
  power users.

  <subsubsection|Optimization Rules<label|optimization-rules>>

  Let's begin with a simple example of an optimization rule from the prelude,
  which eliminates saturated instances of the right-associative function
  application operator (you can find this near the beginning of
  prelude.pure):

  <\verbatim>
    def f $ x = f x;
  </verbatim>

  Like in Haskell, `<hlink|<with|font-family|tt|$>|purelib.tm#-dollar>` in
  fact just denotes function application, but it is a low-priority operator
  which is handy to write cascading function calls. With the above macro
  rule, these will be ``inlined'' as ordinary function applications
  automatically. Example:

  <\verbatim>
    \<gtr\> foo x = bar $ bar $ 2*x;

    \<gtr\> show foo

    foo x = bar (bar (2*x));
  </verbatim>

  Note that a macro may have the same name as an ordinary Pure function,
  which is essential if you want to inline calls to an existing function.
  (Just like ordinary functions, the number of parameters in each rule for a
  given macro must be the same, but a macro may have a different number of
  arguments than the corresponding function.)

  When running interactively, you can follow the reduction steps the compiler
  performs during macro evaluation. To these ends, you have to set
  ``tracepoints'' on the relevant macros, using the <verbatim|trace> command
  with the <verbatim|-m> option; see <hlink|Interactive
  Commands|#interactive-commands>. (This works even if the interpreter is run
  in non-debugging mode.) Note that since macro expansion is performed at
  compile time, you'll have to do this <em|before> entering the definitions
  in which the macro is used. However, in many cases you can also just enter
  the right-hand side of the equation at the interpreter prompt to see how it
  gets expanded. For instance:

  <\verbatim>
    \<gtr\> trace -m $

    \<gtr\> bar $ bar $ 2*x;

    -- macro ($): bar$2*x --\<gtr\> bar (2*x)

    -- macro ($): bar$bar (2*x) --\<gtr\> bar (bar (2*x))

    bar (bar (2*x))
  </verbatim>

  Now let's see how we can add our own optimization rules. Suppose we'd like
  to expand saturated calls of the <hlink|<with|font-family|tt|succ>|purelib.tm#succ>
  function. This function is defined in the prelude; it just adds 1 to its
  single argument. We can inline such calls as follows:

  <\verbatim>
    \<gtr\> def succ (x+y) = x+(y+1);

    \<gtr\> def succ x = x+1;

    \<gtr\> foo x = succ (succ (succ x));

    \<gtr\> show foo

    foo x = x+3;
  </verbatim>

  Again, let's see exactly what's going on there:

  <\verbatim>
    \<gtr\> trace -m succ

    \<gtr\> succ (succ (succ x));

    -- macro succ: succ x --\<gtr\> x+1

    -- macro succ: succ (x+1) --\<gtr\> x+(1+1)

    -- macro succ: succ (x+(1+1)) --\<gtr\> x+(1+1+1)

    x+3
  </verbatim>

  Note that the contraction of the subterm <verbatim|1+1+1> to the integer
  constant <verbatim|3> is actually done by the compiler after macro
  expansion has been performed. This is also called ``constant folding'', see
  <hlink|Constant Definitions|#constant-definitions> in the <hlink|Caveats
  and Notes|#caveats-and-notes> section for details. It is also the reason
  that we added the first rule for <verbatim|succ>. This rule may seem
  superflous at first sight, but actually it is needed to massage the sum
  into a form which enables constant folding.

  Rules like these can help the compiler generate better code. Of course, the
  above examples are still rather elementary. Pure macros can do much more
  elaborate optimizations, but for this we first need to discuss how to write
  recursive macros, as well as macros which take apart special terms like
  lambdas. After that we'll return to the subject of optimization rules in
  <hlink|Advanced Optimization|#advanced-optimization> below.

  <subsubsection|Recursive Macros<label|recursive-macros>>

  Macros can also be recursive, in which case they usually consist of
  multiple rules and make use of pattern-matching just like ordinary function
  definitions.

  <with|font-series|bold|Note:> Pure macros are just as powerful as
  (unconditional) term rewriting systems and thus they are Turing-complete.
  This implies that a badly written macro may well send the Pure compiler
  into an infinite recursion, which results in a stack overflow at compile
  time.

  As a simple example, let's see how we can inline invocations of the
  <hlink|<with|font-family|tt|#>|purelib.tm##> size operator on list
  constants:

  <\verbatim>
    def #[] = 0;

    def #(x:xs) = #xs+1;
  </verbatim>

  As you can see, the definition is pretty straightforward; exactly the same
  rules might also be used for an ordinary function definition, although the
  standard library actually implements <hlink|<with|font-family|tt|#>|purelib.tm##>
  a bit differently to make good use of tail recursion. Let's check that this
  actually works:

  <\verbatim>
    \<gtr\> foo = #[1,2,3,4];

    \<gtr\> show foo

    foo = 4;
  </verbatim>

  Note that the result of macro expansion is actually <verbatim|0+1+1+1+1>
  here, you can check that by running the macro with <verbatim|trace>
  <verbatim|-m> <verbatim|#>. Constant folding contracts this to <verbatim|4>
  after macro expansion, as explained in the previous subsection.

  This was rather easy. So let's implement a more elaborate example: a basic
  Pure version of Lisp's quasiquote which allows you to create a quoted
  expression from a ``template'' while substituting variable parts of the
  template. (For the sake of brevity, we present a somewhat abridged version
  here which does not cover all corner cases. The full version of this macro
  can be found as lib/quasiquote.pure in the Pure distribution.)

  <\verbatim>
    def quasiquote (unquote x) \ \ \ \ \ = x;

    def quasiquote (f@_ (splice x)) = foldl ($) (quasiquote f) x;

    def quasiquote (f@_ x) \ \ \ \ \ \ \ \ \ = quasiquote f (quasiquote x);

    def quasiquote x \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ = quote x;
  </verbatim>

  (Note the <verbatim|f@_>, which is an anonymous ``as'' pattern forcing the
  compiler to recognize <verbatim|f> as a function variable, rather than a
  literal function symbol. See <hlink|``As'' Patterns|#as-patterns> in the
  <hlink|Caveats and Notes|#caveats-and-notes> section for an explanation of
  this trick.)

  The first rule above takes care of ``unquoting'' embedded subterms. The
  second rule ``splices'' an argument list into an enclosing function
  application. The third rule recurses into subterms of a function
  application, and the fourth and last rule takes care of quoting the
  ``atomic'' subterms. Note that <verbatim|unquote> and <verbatim|splice>
  themselves are just passive constructor symbols, the real work is done by
  <verbatim|quasiquote>, using <hlink|<with|font-family|tt|foldl>|purelib.tm#foldl>
  at runtime to actually perform the splicing. (Putting off the splicing
  until runtime makes it possible to splice argument lists computed at
  runtime.)

  If we want, we can also add some syntactic sugar for Lisp weenies. (Note
  that we cannot have `<verbatim|,>` for unquoting, so we use `<verbatim|,$>`
  instead.)

  <\verbatim>
    prefix 9 ` ,$ ,@ ;

    def `x = quasiquote x; def ,$x = unquote x; def ,@x = splice x;
  </verbatim>

  Examples:

  <\verbatim>
    \<gtr\> `(2*42+2^12);

    2*42+2^12

    \<gtr\> `(2*42+,$(2^12));

    2*42+4096.0

    \<gtr\> `foo 1 2 (,@'[2/3,3/4]) (5/6);

    foo 1 2 (2/3) (3/4) (5/6)

    \<gtr\> `foo 1 2 (,@args) (5/6) when args = '[2/3,3/4] end;

    foo 1 2 (2/3) (3/4) (5/6)
  </verbatim>

  <subsubsection|User-Defined Special Forms<label|user-defined-special-forms>>

  The <verbatim|quasiquote> macro in the preceding subsection also provides
  an example of how you can use macros to define your own special forms. This
  works because the actual evaluation of macro arguments is put off until
  runtime, and thus we can safely pass them to built-in special forms and
  other constructs which defer their evaluation <em|at runtime>. In fact, the
  right-hand side of a macro rule may be an arbitrary Pure expression
  involving conditional expressions, lambdas, binding clauses, etc. These are
  never evaluated during macro substitution, they just become part of the
  macro expansion (after substituting the macro parameters).

  Here is another useful example of a user-defined special form, the macro
  <verbatim|timex> which employs the system function <verbatim|clock> to
  report the cpu time in seconds needed to evaluate a given expression, along
  with the computed result:

  <\verbatim>
    \<gtr\> using system;

    \<gtr\> def timex x = (clock-t0)/CLOCKS_PER_SEC,y when t0 = clock; y = x
    end;

    \<gtr\> sum = foldl (+) 0L;

    \<gtr\> timex $ sum (1L..100000L);

    0.43,5000050000L
  </verbatim>

  Note that the above definition of <verbatim|timex> wouldn't work as an
  ordinary function definition, since by virtue of Pure's basic eager
  evaluation strategy the <verbatim|x> parameter would have been evaluated
  already before it is passed to <verbatim|timex>, making <verbatim|timex>
  always return a zero time value. Try it!

  <subsubsection|Macro Hygiene<label|macro-hygiene>>

  Pure macros are lexically scoped, i.e., the binding of symbols in the
  right-hand-side of a macro definition is determined statically by the text
  of the definition, and macro parameter substitution also takes into account
  binding constructs, such as <hlink|<with|font-family|tt|with>|#with> and
  <hlink|<with|font-family|tt|when>|#when> clauses, in the right-hand side of
  the definition. Macro facilities with these pleasant properties are also
  known as <with|font-series|bold|hygienic macros>. They are not susceptible
  to so-called ``name capture,'' which makes macros in less sophisticated
  languages bug-ridden and hard to use.

  Macro hygiene is a somewhat esoteric topic for most programmers, so let us
  take a brief look at what it's all about. The problem avoided by hygienic
  macros is that of <em|name capture>. There are actually two kinds of name
  capture which may occur in unhygienic macro systems:

  <\itemize>
    <item>A free symbol in the macro <em|body> inadvertently becomes bound to
    the value of a local symbol in the context in which the macro is called.

    <item>A free symbol in the macro <em|call> inadvertently becomes bound to
    the value of a local symbol in the macro body.
  </itemize>

  Pure's hygienic macros avoid both pitfalls. Here is an example for the
  first form of name capture:

  <\verbatim>
    \<gtr\> def G x = x+y;

    \<gtr\> G 10 when y = 99 end;

    10+y
  </verbatim>

  Note that the expansion of the <verbatim|G> macro correctly uses the global
  instance of <verbatim|y>, even though <verbatim|y> is locally defined in
  the context of the macro call. (In some languages this form of name capture
  is sometimes used deliberately in order to make the macro use the binding
  of the symbol which is active at the point of the macro call. Normally,
  this won't work in Pure, although there is a way to force this behaviour in
  Pure as well, see <hlink|Name Capture|#name-capture> in the <hlink|Caveats
  and Notes|#caveats-and-notes> section.)

  In contrast, the second form of name capture is usually not intended, and
  is therefore more dangerous. Consider the following example:

  <\verbatim>
    \<gtr\> def F x = x+y when y = x+1 end;

    \<gtr\> F y;

    y+(y+1)
  </verbatim>

  Pure again gives the correct result here. You'd have to be worried if you
  got <verbatim|(y+1)+(y+1)> instead, which would result from the literal
  expansion <verbatim|y+y> <verbatim|when> <verbatim|y> <verbatim|=>
  <verbatim|y+1> <verbatim|end>, where the (free) variable <verbatim|y>
  passed to <verbatim|F> gets captured by the local binding of <verbatim|y>.
  In fact, that's exactly what you get with C macros:

  <\verbatim>
    #define F(x) { int y = x+1; return x+y; }
  </verbatim>

  Here <verbatim|F(y)> expands to <verbatim|{> <verbatim|int> <verbatim|y>
  <verbatim|=> <verbatim|y+1;> <verbatim|return> <verbatim|y+y;> <verbatim|}>
  which is usually <em|not> what you want.

  This completes our little introduction to Pure's macro facilities. The
  above material should in fact cover all the common uses of macros in Pure.
  However, if you want to become a real Pure macro wizard then read on. In
  the following subsections we're going to discover some more advanced
  features of Pure's macro system which let you write macros for manipulating
  special forms and give you access to Pure's reflection capabilities.

  <subsubsection|Built-in Macros and Special
  Expressions<label|built-in-macros-and-special-expressions>>

  As already mentioned in <hlink|The Quote|#the-quote>, <hlink|special
  expressions|#special-expressions> such as conditionals and lambdas cannot
  be directly represented as runtime data in Pure. But they can be
  <em|quoted> in which case they are replaced by corresponding ``placeholder
  terms''. These placeholder terms are in fact implemented as built-in macros
  which, when evaluated, construct the corresponding specials.

  <\description>
    <item*|<em|macro> __ifelse__ x y z<label|--ifelse-->>This macro expands
    to the conditional expression <verbatim|if> <verbatim|x> <verbatim|then>
    <verbatim|y> <verbatim|else> <verbatim|z> during macro evaluation.
  </description>

  <\description>
    <item*|<em|macro> __lambda__ [x1,...,xn] y<label|--lambda-->>Expands to
    the lambda expression <verbatim|<x1>> <verbatim|...> <verbatim|xn>
    <verbatim|-\>> <verbatim|y>.
  </description>

  <\description>
    <item*|<em|macro> __case__ x [(x1 --\<gtr\> y1),...,(xn --\<gtr\>
    yn)]<label|--case-->>Expands to the <hlink|<with|font-family|tt|case>|#case>
    expression <verbatim|case> <verbatim|x> <verbatim|of> <verbatim|x1>
    <verbatim|=> <verbatim|y1;> <verbatim|...;> <verbatim|xn> <verbatim|=>
    <verbatim|yn> <verbatim|end>. Note that the
    <hlink|<with|font-family|tt|--\<gtr\>>|#--\>> symbol is used to separate
    the left-hand side and the right-hand side of each rule (see below).
  </description>

  <\description>
    <item*|<em|macro> x __when__ [(x1 --\<gtr\> y1),...,(xn --\<gtr\>
    yn)]<label|--when-->>Expands to the <hlink|<with|font-family|tt|when>|#when>
    expression <verbatim|x> <verbatim|when> <verbatim|x1> <verbatim|=>
    <verbatim|y1;> <verbatim|...;> <verbatim|xn> <verbatim|=> <verbatim|yn>
    <verbatim|end>. Here the left-hand side of a rule may be omitted if it is
    just the anonymous variable; i.e., <verbatim|x> <verbatim|__when__>
    <verbatim|[foo> <verbatim|y]> is the same as <verbatim|x>
    <verbatim|__when__> <verbatim|[_> <verbatim|--\>> <verbatim|foo>
    <verbatim|y]>.
  </description>

  <\description>
    <item*|<em|macro> x __with__ [(x1 --\<gtr\> y1),...,(xn --\<gtr\>
    yn)]<label|--with-->>Expands to the <hlink|<with|font-family|tt|with>|#with>
    expression <verbatim|x> <verbatim|with> <verbatim|x1> <verbatim|=>
    <verbatim|y1;> <verbatim|...;> <verbatim|xn> <verbatim|=> <verbatim|yn>
    <verbatim|end>.
  </description>

  Note that the following low-priority infix operators are used to denote
  equations in the <hlink|<with|font-family|tt|__case__>|#--case-->,
  <hlink|<with|font-family|tt|__when__>|#--when--> and
  <hlink|<with|font-family|tt|__with__>|#--with--> macros:

  <\description>
    <item*|<em|constructor> x --\<gtr\> y<label|--\<gtr\>>>Denotes an
    equation <verbatim|x> <verbatim|=> <verbatim|y>.
  </description>

  <\description>
    <item*|<em|constructor> x __if__ y<label|--if-->>Attaches a guard to the
    right-hand side of an equation. That is, <verbatim|x> <verbatim|--\>>
    <verbatim|y> <verbatim|__if__> <verbatim|z> denotes the conditional
    equation <verbatim|x> <verbatim|=> <verbatim|y> <verbatim|if>
    <verbatim|z>. This symbol is only recognized in
    <hlink|<with|font-family|tt|__case__>|#--case--> and
    <hlink|<with|font-family|tt|__with__>|#--with--> calls.
  </description>

  In addition, patterns on the left-hand side of equations or in lambda
  arguments may be decorated with the following constructor terms to indicate
  ``as'' patterns and type tags (these are infix operators with a very high
  priority):

  <\description>
    <item*|<em|constructor> x __as__ y<label|--as-->>Denotes an ``as''
    pattern <verbatim|x> <verbatim|@> <verbatim|y>.
  </description>

  <\description>
    <item*|<em|constructor> x __type__ y<label|--type-->>Denotes a type tag
    <verbatim|x> <verbatim|::> <verbatim|y>.
  </description>

  Note that all these symbols are in fact just constructors which are only
  interpreted in the context of the built-in macros listed above; they aren't
  macros themselves.

  It's good to remember the above when you're doing macro programming.
  However, to see the placeholder term of a special, you can also just type a
  quoted expression in the interpreter:

  <\verbatim>
    \<gtr\> '(\\x-\<gtr\>x+1);

    __lambda__ [x] (x+1)

    \<gtr\> '(f with f x = y when y = x+1 end end);

    f __with__ [f x--\<gtr\>y __when__ [y--\<gtr\>x+1]]
  </verbatim>

  List and matrix comprehensions can also be quoted. These are basically
  syntactic sugar for lambda applications, cf. <hlink|Primary
  Expressions|#primary-expressions>. The compiler expands them to their
  ``unsugared'' form already before macro substitution, so no special kinds
  of built-in macros are needed to represent them. When quoted,
  comprehensions are thus denoted in their unsugared form, which consists of
  a pile of lambda expressions and list or matrix construction functions for
  the generation clauses, and possibly some conditionals for the filter
  clauses of the comprehension. For instance:

  <\verbatim>
    \<gtr\> '[2*x \| x = 1..3];

    listmap (__lambda__ [x] (2*x)) (1..3)
  </verbatim>

  Here's how type tags and ``as'' patterns in quoted specials look like:

  <\verbatim>
    \<gtr\> '(\\x::int-\<gtr\>x+1);

    __lambda__ [x __type__ int] (x+1)

    \<gtr\> '(dup (1..3) with dup xs@(x:_) = x:xs end);

    dup (1..3) __with__ [dup (xs __as__ (x:_))--\<gtr\>x:xs]
  </verbatim>

  Note that the placeholder terms for the specials are quoted here, and hence
  they are not evaluated (quoting inhibits macro expansion, just like it
  prevents the evaluation of ordinary function calls). Evaluating the
  placeholder terms executes the corresponding specials:

  <\verbatim>
    \<gtr\> '(dup (1..3) with dup xs@(x:_) = x:xs end);

    dup (1..3) __with__ [dup (xs __as__ (x:_))--\<gtr\>x:xs]

    \<gtr\> eval ans;

    [1,1,2,3]
  </verbatim>

  Of course, you can also just enter the macros directly (without quoting) to
  have them evaluated:

  <\verbatim>
    \<gtr\> dup (1..3) __with__ [dup (xs __as__ (x:_))--\<gtr\>x:xs];

    [1,1,2,3]

    \<gtr\> __lambda__ [x __type__ int] (x+1);

    #\<less\>closure 0x7f1934158dc8\<gtr\>

    \<gtr\> ans 99;

    100
  </verbatim>

  The <hlink|<with|font-family|tt|__str__>|purelib.tm#--str--> function can
  be used to pretty-print quoted specials:

  <\verbatim>
    \<gtr\> __str__ ('__lambda__ [x __type__ int] (x+1));

    "\\\\x::int -\<gtr\> x+1"

    \<gtr\> __str__ ('(dup (1..3) __with__ [dup (xs __as__
    (x:_))--\<gtr\>x:xs]));

    "dup (1..3) with dup xs@(x:_) = x:xs end"
  </verbatim>

  This is useful to see which expression a quoted special will expand to.
  Note that <hlink|<with|font-family|tt|__str__>|purelib.tm#--str--> can also
  be used to define print representations for quoted specials with
  <hlink|<with|font-family|tt|__show__>|#--show--> (described in
  <hlink|Pretty-Printing|#pretty-printing>) if you always want to have them
  printed that way by the interpreter.

  As quoted specials are just ordinary Pure expressions, they can be
  manipulated by functions just like any other term. For instance, here's how
  you can define a function which takes a quoted lambda and swaps its two
  arguments:

  <\verbatim>
    \<gtr\> swap (__lambda__ [x,y] z) = '(__lambda__ [y,x] z);

    \<gtr\> swap ('(\\a b-\<gtr\>a-b));

    __lambda__ [b,a] (a-b)

    \<gtr\> eval ans 2 3; // same as (\\b a-\<gtr\>a-b) 2 3

    1
  </verbatim>

  For convenience, a literal special expression can also be used on the
  left-hand side of an equation, in which case it actually denotes the
  corresponding placeholder term. So the <verbatim|swap> function can also be
  defined like this (note that we first scratch the previous definition of
  <verbatim|swap> with the <verbatim|clear> command, see <hlink|Interactive
  Commands|#interactive-commands>):

  <\verbatim>
    \<gtr\> clear swap

    \<gtr\> swap (\\x y -\<gtr\> z) = '(\\y x -\<gtr\> z);

    \<gtr\> swap ('(\\a b-\<gtr\>a-b));

    __lambda__ [b,a] (a-b)
  </verbatim>

  This is usually easier to write and improves readability. However, there
  are cases in which you want to work with the built-in macros in a direct
  fashion. In particular, this becomes necessary when writing more generic
  rules which deal, e.g., with lambdas involving a variable number of
  arguments, or if you need real (i.e., unquoted) type tags or ``as''
  patterns in a placeholder pattern. We'll see examples of these later.

  Quoted specials can be manipulated with macros just as well as with
  functions. In fact, this is quite common and thus the macro evaluator has
  some special support to make this more convenient. Specifically, it is
  possible to make a macro quote its arguments in an automatic fashion, by
  means of the <hlink|<em|--quoteargs>|#cmdoption-pure-pragma--quoteargs>
  pragma. To illustrate this, let's redefine <verbatim|swap> as a macro:

  <\verbatim>
    \<gtr\> clear swap

    \<gtr\> #! --quoteargs swap

    \<gtr\> def swap (\\x y -\<gtr\> z) = '(\\y x -\<gtr\> z);

    \<gtr\> swap (\\a b-\<gtr\>a-b);

    __lambda__ [b,a] (a-b)
  </verbatim>

  The <hlink|<em|--quoteargs>|#cmdoption-pure-pragma--quoteargs> pragma makes
  the <verbatim|swap> macro receive its argument unevaluated, as if it was
  quoted (but without a literal quote around it). Therefore the quote on the
  lambda argument of <verbatim|swap> can now be omitted. However, the result
  is still a quoted lambda. It's tempting to just omit the quote on the
  right-hand side of the macro definition as well, in order to get a real
  lambda instead:

  <\verbatim>
    \<gtr\> clear swap

    \<gtr\> def swap (\\x y -\<gtr\> z) = \\y x -\<gtr\> z;

    \<gtr\> swap (\\a b-\<gtr\>a-b);

    #\<less\>closure 0x7f1934156f00\<gtr\>

    \<gtr\> ans 2 3;

    a-b
  </verbatim>

  We got a closure all right, but apparently it's not the right one. Let's
  use <verbatim|trace> <verbatim|-m> to figure out what went wrong:

  <\verbatim>
    \<gtr\> trace -m swap

    \<gtr\> swap (\\a b-\<gtr\>a-b);

    -- macro swap: swap (\\a b -\<gtr\> a-b) --\<gtr\> \\y x -\<gtr\> a-b

    #\<less\>closure 0x7f1934157248\<gtr\>
  </verbatim>

  Ok, so the result is the lambda <verbatim|<y>> <verbatim|x> <verbatim|-\>>
  <verbatim|a-b>, not <verbatim|<b>> <verbatim|a> <verbatim|-\>>
  <verbatim|a-b> as we expected. This happens because we used a literal
  (unquoted) lambda on the right-hand side, which does its own variable
  binding; consequently, the variables <verbatim|x> and <verbatim|y> are
  bound by the lambda in this context, not by the left-hand side of the macro
  rule.

  So just putting an unquoted lambda on the right-hand side doesn't do the
  job. One way to deal with the situation is to just employ the
  <verbatim|__lambda__> macro in a direct way, as we've seen before:

  <\verbatim>
    \<gtr\> clear swap

    \<gtr\> def swap (__lambda__ [x,y] z) = __lambda__ [y,x] z;

    \<gtr\> swap (\\a b-\<gtr\>a-b);

    -- macro swap: swap (\\a b -\<gtr\> a-b) --\<gtr\> __lambda__ [b,a] (a-b)

    -- macro __lambda__: __lambda__ [b,a] (a-b) --\<gtr\> \\b a -\<gtr\> a-b

    #\<less\>closure 0x7f1934156f00\<gtr\>

    \<gtr\> ans 2 3;

    1
  </verbatim>

  This works, but doesn't look very nice. Often it's more convenient to first
  construct a quoted term involving the necessary specials and then have it
  evaluated during macro evaluation. Pure provides yet another built-in macro
  for this purpose:

  <\description>
    <item*|<em|macro> __eval__ x<label|--eval-->>Evaluate <verbatim|x> at
    macro expansion time. This works by stripping one level of (outermost)
    quotes from <verbatim|x> and performing macro expansion on the resulting
    unquoted subexpressions.
  </description>

  Using <hlink|<with|font-family|tt|__eval__>|#--eval-->, we can implement
  the <verbatim|swap> macro as follows:

  <\verbatim>
    \<gtr\> clear swap

    \<gtr\> def swap (\\x y -\<gtr\> z) = __eval__ ('(\\y x -\<gtr\> z));

    \<gtr\> swap (\\a b-\<gtr\>a-b);

    -- macro swap: swap (\\a b -\<gtr\> a-b) --\<gtr\> __eval__ ('__lambda__
    [b,a] (a-b))

    -- macro __lambda__: __lambda__ [b,a] (a-b) --\<gtr\> \\b a -\<gtr\> a-b

    -- macro __eval__: __eval__ ('__lambda__ [b,a] (a-b)) --\<gtr\> \\b a
    -\<gtr\> a-b

    #\<less\>closure 0x7f7e1f867dc8\<gtr\>

    \<gtr\> ans 2 3;

    1
  </verbatim>

  Lisp programmers should note the difference. In Lisp, macros usually yield
  a quoted expression which is evaluated implicitly during macro expansion.
  This is never done automatically in Pure, since many Pure macros work
  perfectly well without it. Instead, quotes in a macro expansion are treated
  as literals, and you'll have to explicitly call <verbatim|__eval__> to
  remove them during macro evaluation.

  A final caveat: Placeholder terms for specials are just simple expressions;
  they don't do any variable binding by themselves. Thus the rules of
  <hlink|macro hygiene|#macro-hygiene> don't apply to them, which makes it
  possible to manipulate lambdas and local definitions in any desired way. On
  the other hand, this means that it is the programmer's responsibility to
  avoid accidental name capture when using these facilities. Most macro code
  will work all right when written in a straightforward way, but there are
  some corner cases which need special attention (cf. <hlink|Name
  Capture|#name-capture>).

  Sometimes the only convenient way to avoid name capture is to create new
  symbols on the fly. This will often be necessary if a macro generates an
  entire block construct (<hlink|<with|font-family|tt|case>|#case>,
  <hlink|<with|font-family|tt|when>|#when>,
  <hlink|<with|font-family|tt|with>|#with> or lambda) from scratch. The
  following built-in macro is provided for this purpose:

  <\description>
    <item*|<em|macro> __gensym__<label|--gensym-->>Create a new unqualified
    symbol which is guaranteed to not exist at the time of the macro call.
    These symbols typically look like <verbatim|__x123__> and can be used for
    any purpose (i.e., as global or local as well as function or variable
    symbols).
  </description>

  For instance, here's how we can implement a macro <verbatim|foo> which
  creates a lambda from a given argument, using
  <hlink|<with|font-family|tt|__gensym__>|#--gensym--> to generate a fresh
  local variable for the lambda argument. This guarantees that variables in
  the argument expression don't get captured by the lambda variable when the
  closure is created with a call to the built-in
  <hlink|<with|font-family|tt|__lambda__>|#--lambda--> macro.

  <\verbatim>
    \<gtr\> def foo x = bar __gensym__ x;

    \<gtr\> def bar x y = __lambda__ [x] (x+y);

    \<gtr\> trace -m foo

    \<gtr\> foo (a*b);

    -- macro foo: foo (a*b) --\<gtr\> bar __gensym__ (a*b)

    -- macro __gensym__: __gensym__ --\<gtr\> __x1__

    -- macro bar: bar __x1__ (a*b) --\<gtr\> __lambda__ [__x1__] (__x1__+a*b)

    -- macro __lambda__: __lambda__ [__x1__] (__x1__+a*b) --\<gtr\> \\__x1__
    -\<gtr\> __x1__+a*b

    #\<less\>closure 0x7f66f6c88db0\<gtr\>

    \<gtr\> ans 77;

    77+a*b
  </verbatim>

  The <hlink|<with|font-family|tt|__gensym__>|#--gensym--> macro returns a
  new variable for each invocation, and always ensures that it doesn't
  accidentally reuse a symbol already introduced by the user (even if it
  looks like a symbol that <hlink|<with|font-family|tt|__gensym__>|#--gensym-->
  might itself create):

  <\verbatim>
    \<gtr\> foo (a*__x2__);

    -- macro foo: foo (a*__x2__) --\<gtr\> bar __gensym__ (a*__x2__)

    -- macro __gensym__: __gensym__ --\<gtr\> __x3__

    -- macro bar: bar __x3__ (a*__x2__) --\<gtr\> __lambda__ [__x3__]
    (__x3__+a*__x2__)

    -- macro __lambda__: __lambda__ [__x3__] (__x3__+a*__x2__) --\<gtr\>
    \\__x3__ -\<gtr\> __x3__+a*__x2__

    #\<less\>closure 0x7f66f6c887e8\<gtr\>

    \<gtr\> ans 77;

    77+a*__x2__
  </verbatim>

  <subsubsection|Advanced Optimization<label|advanced-optimization>>

  We are now in a position to have a look at some of the trickier
  optimization macros defined in the prelude. The following <verbatim|__do__>
  macro can be found near the end of the prelude.pure module; it is used to
  optimize the case of ``throwaway'' list and matrix comprehensions. This is
  useful if a comprehension is evaluated solely for its side effects. To keep
  things simple, we discuss a slightly abridged version of the
  <verbatim|__do__> macro which only deals with list comprehensions and
  ignores some obscure corner cases. You can find this version in the
  examples/do.pure script. Please also check the prelude for the full version
  of this macro.

  Note that we define our own versions of <verbatim|void> and
  <verbatim|__do__> here which are placed into the <verbatim|my> namespace to
  avoid conflicts with the prelude.

  <\verbatim>
    namespace my;

    \;

    void _ = ();

    \;

    #! --quoteargs my::__do__

    \;

    def void [x] = void x;

    def void (catmap f x) \| void (listmap f x) = __do__ f x;

    \;

    // Recurse into embedded generator clauses.

    def __do__ (__lambda__ [x] y@(listmap _ _)) \|

    \ \ \ \ __do__ (__lambda__ [x] y@(catmap _ _)) =

    \ \ \ \ __do__ $ (__lambda__ [x] (void y));

    \;

    // Recurse into embedded filter clauses.

    def __do__ (__lambda__ [x] (__ifelse__ y z [])) =

    \ \ \ \ __do__ $ (__lambda__ [x] (__ifelse__ y (void z) ()));

    \;

    // Eliminate extra calls to 'void' in generator clauses.

    def __do__ (__lambda__ [x] (void y)) = __do__ (__lambda__ [x] y);

    \;

    // Eliminate extra calls to 'void' in filter clauses.

    def __do__ (__lambda__ [x] (__ifelse__ y (void z) ())) =

    \ \ \ \ __do__ (__lambda__ [x] (__ifelse__ y z ()));

    \;

    // Any remaining instances reduce to a plain 'do' (this must come last).

    def __do__ f = do f;
  </verbatim>

  First, note that the <hlink|<with|font-family|tt|void>|purelib.tm#void>
  function simply throws away its argument and returns
  <hlink|<with|font-family|tt|()>|purelib.tm#()> instead. The
  <hlink|<with|font-family|tt|do>|purelib.tm#do> function applies a function
  to every member of a list (like <hlink|<with|font-family|tt|map>|purelib.tm#map>),
  but throws away all intermediate results and just returns
  <hlink|<with|font-family|tt|()>|purelib.tm#()>, which is much more
  efficient if you don't need those results anyway. These are both defined in
  the prelude, but we define our own version of <verbatim|void> here so that
  we can hook it up to our simplified version of the <verbatim|__do__> macro.

  The <verbatim|__do__> macro eventually reduces to just a plain
  <verbatim|do> call, but applies some optimizations along the way. While the
  above rules for <verbatim|__do__> are always valid optimizations for
  <verbatim|do>, it's a good idea to use a separate macro here instead of
  clobbering <verbatim|do> itself, so that these optimizations do not
  interfere with calls to <verbatim|do> in ordinary user code. The prelude
  handles this in an analogous fashion.

  Before we further delve into this example, a few remarks are in order about
  the way list comprehensions are implemented in Pure. As already mentioned,
  list comprehensions are just syntactic sugar; the compiler immediately
  transforms them to an equivalent expression involving only lambdas and a
  few other list operations. The latter are essentially equivalent to piles
  of nested filters and maps, but for various reasons they are actually
  implemented using two special helper operations,
  <hlink|<with|font-family|tt|catmap>|purelib.tm#catmap> and
  <hlink|<with|font-family|tt|listmap>|purelib.tm#listmap>.

  The <hlink|<with|font-family|tt|catmap>|purelib.tm#catmap> operation
  combines <hlink|<with|font-family|tt|map>|purelib.tm#map> and
  <hlink|<with|font-family|tt|cat>|purelib.tm#cat>; this is needed, in
  particular, to accumulate the results of nested generators, such as
  <verbatim|[i,j> <verbatim|\|> <verbatim|i> <verbatim|=> <verbatim|1..n;>
  <verbatim|j> <verbatim|=> <verbatim|1..m]>. The same operation is also used
  to implement filter clauses, you can see this below in the examples.
  However, for efficiency simple generators like <verbatim|[2*i>
  <verbatim|\|> <verbatim|i> <verbatim|=> <verbatim|1..n]> are translated to
  a <hlink|<with|font-family|tt|listmap>|purelib.tm#listmap> instead (which
  is basically just <hlink|<with|font-family|tt|map>|purelib.tm#map>, but
  works with different aggregate types, so that list comprehensions can draw
  values from aggregates other than lists, such as matrices).

  Now let's see how the rules above transform a list comprehension if we
  ``void'' it. (Remember to switch to the <verbatim|my> namespace when trying
  the following examples.)

  <\verbatim>
    \<gtr\> using system;

    \<gtr\> using namespace my;

    \<gtr\> f = [printf "%g\\n" (2^x+1) \| x=1..5; x mod 2];

    \<gtr\> g = void [printf "%g\\n" (2^x+1) \| x=1..5; x mod 2];

    \<gtr\> show f g

    f = catmap (\\x -\<gtr\> if x mod 2 then [printf "%g\\n" (2^x+1)] else
    []) (1..5);

    g = do (\\x -\<gtr\> if x mod 2 then printf "%g\\n" (2^x+1) else ())
    (1..5);
  </verbatim>

  As you can see, the <hlink|<with|font-family|tt|catmap>|purelib.tm#catmap>
  got replaced with a <hlink|<with|font-family|tt|do>|purelib.tm#do>, and the
  list brackets inside the lambda were eliminated as well. These
  optimizations are just what's needed to make this code go essentially as
  fast as a <verbatim|for> loop in traditional programming languages (up to
  constant factors, of course). Here's how it looks like when we run the
  <verbatim|g> function:

  <\verbatim>
    \<gtr\> g;

    3

    9

    33

    ()
  </verbatim>

  It's also instructive to have a look at how the above macro rules work in
  concert to rewrite a ``voided'' comprehension. To these ends, you can rerun
  the right-hand side of <verbatim|g> with some tracing enabled, as follows
  (we omit the tracing output here for brevity):

  <\verbatim>
    \<gtr\> trace -m my::void

    \<gtr\> void [printf "%g\\n" (2^x+1) \| x=1..5; x mod 2];
  </verbatim>

  The above optimization rules also take care of nested list comprehensions,
  since they recurse into the lambda bodies of generator and filter clauses.
  For instance:

  <\verbatim>
    \<gtr\> h = void [puts $ str (x,y) \| x=1..2; y=1..3];

    \<gtr\> show h

    h = do (\\x -\<gtr\> do (\\y -\<gtr\> puts (str (x,y))) (1..3)) (1..2);
  </verbatim>

  Again, you should run this with macro tracing enabled to see how the
  <verbatim|__do__> macro recurses into the outer lambda body of the list
  comprehension. Here's the rule which actually does this:

  <\verbatim>
    def __do__ (__lambda__ [x] y@(catmap _ _)) =

    \ \ \ \ __do__ $ (__lambda__ [x] (void y));
  </verbatim>

  Note that in order to make this work, <verbatim|__do__> is implemented as a
  ``<hlink|<em|quoteargs>|#cmdoption-pure-pragma--quoteargs>'' macro so that
  it can inspect and recurse into the lambda terms in its argument. Also note
  the <hlink|<with|font-family|tt|$>|purelib.tm#-dollar> on the right-hand
  side of this rule; this is also implemented as a macro in the prelude. Here
  the <hlink|<with|font-family|tt|$>|purelib.tm#-dollar> operator is used to
  forcibly evaluate the macro argument <verbatim|__lambda__> <verbatim|[x]>
  <verbatim|(void> <verbatim|y)>, so that the embedded call to the
  <verbatim|void> macro gets expanded. (Without the
  <hlink|<with|font-family|tt|$>|purelib.tm#-dollar> the argument to
  <verbatim|__do__> would be quoted and thus not be evaluated.) A similar
  rule is used to recurse into embedded filter clauses, as in the example of
  the function <verbatim|g> above.

  It should be mentioned that, while our version of the <verbatim|__do__>
  macro will properly handle most list comprehensions, there is a rather
  obscure corner case which it still refuses to optimize: outermost filter
  clauses. For instance, consider:

  <\verbatim>
    \<gtr\> let c = 2;

    \<gtr\> k = void [printf "%g\\n" (2^x+1) \| c\<gtr\>0; x=1..3];

    \<gtr\> show k

    k = my::void (if c\<gtr\>0 then listmap (\\x -\<gtr\> printf "%g\\n"
    (2^x+1)) (1..3) else []);
  </verbatim>

  It's possible to handle this case as well, but we have to go to some
  lengths to achieve that. The complication here is that we don't want to
  mess with calls to <verbatim|void> in ordinary user code, so
  <verbatim|void> itself cannot be a ``<hlink|<em|quoteargs>|#cmdoption-pure-pragma--quoteargs>''
  macro. But the quoted form of <verbatim|void>`s argument is needed to
  detect the ``outermost filter clause'' situation. The interested reader may
  refer to the prelude code to see how the prelude implementation of
  <verbatim|__do__> uses some helper macros to make this work. Another detail
  of the full version of <verbatim|__do__> is the handling of patterns on the
  left-hand side of generator clauses, which requires some special magic to
  filter out unmatched list elements; we also omitted this here for brevity.

  <subsubsection|Reflection<label|reflection>>

  The meta representation of specials discussed in <hlink|Built-in Macros and
  Special Expressions|#built-in-macros-and-special-expressions> is also
  useful to obtain information about the running program and even modify it.
  Pure's runtime provides some built-in operations to implement these
  reflection capabilities, which are comparable in scope to what the Lisp
  programming language offers.

  Specifically, the <hlink|<with|font-family|tt|get_fundef>|purelib.tm#get-fundef>
  function allows you to retrieve the definition of a global Pure function.
  Given the symbol denoting the function,
  <hlink|<with|font-family|tt|get_fundef>|purelib.tm#get-fundef> returns the
  list of rewriting rules implementing the functions, using the same
  <verbatim|lhs> <verbatim|--\>> <verbatim|rhs> format used by the
  <hlink|<with|font-family|tt|__case__>|#--case-->,
  <hlink|<with|font-family|tt|__when__>|#--when--> and
  <hlink|<with|font-family|tt|__with__>|#--with--> macros discussed above.
  For instance:

  <\verbatim>
    \<gtr\> fact n = 1 if n\<less\>=1;

    \<gtr\> \ \ \ \ \ \ \ = n*fact (n-1) otherwise;

    \<gtr\> get_fundef fact;

    [(fact n--\<gtr\>1 __if__ n\<less\>=1),(fact n--\<gtr\>n*fact (n-1))]
  </verbatim>

  Defining a new function or extending an existing function definition can be
  done just as easily, using the <hlink|<with|font-family|tt|add_fundef>|purelib.tm#add-fundef>
  function:

  <\verbatim>
    \<gtr\> add_fundef $ '[(fib n--\<gtr\>1 __if__ n\<less\>=1),(fib
    n--\<gtr\>fib (n-2)+fib (n-1))];

    ()

    \<gtr\> show fib

    fib n = 1 if n\<less\>=1;

    fib n = fib (n-2)+fib (n-1);

    \<gtr\> map fib (0..10);

    [1,1,2,3,5,8,13,21,34,55,89]
  </verbatim>

  Note that, to be on the safe side, we quoted the rule list passed to
  <hlink|<with|font-family|tt|add_fundef>|purelib.tm#add-fundef> to prevent
  premature evaluation of symbols used in the rules. This is necessary
  because <hlink|<with|font-family|tt|add_fundef>|purelib.tm#add-fundef> is
  an ordinary function, not a macro. (Of course, you could easily define a
  macro which would take care of this, if you like. We leave this as an
  exercise to the reader.)

  Also note that <hlink|<with|font-family|tt|add_fundef>|purelib.tm#add-fundef>
  doesn't override existing function definitions. It simply keeps on adding
  rules to the current program, just as if you typed the equations at the
  command prompt of the interpreter. It is possible to delete individual
  equations with <hlink|<with|font-family|tt|del_fundef>|purelib.tm#del-fundef>:

  <\verbatim>
    \<gtr\> del_fundef $ '(fib n--\<gtr\>fib (n-2)+fib (n-1));

    ()

    \<gtr\> show fib

    fib n = 1 if n\<less\>=1;
  </verbatim>

  Moreover, the <hlink|<with|font-family|tt|clearsym>|purelib.tm#clearsym>
  function allows you to completely get rid of an existing function:

  <\verbatim>
    \<gtr\> clearsym fib 0;

    ()

    \<gtr\> show fib

    \<gtr\> fib 9;

    fib 9
  </verbatim>

  There's also a companion function, <hlink|<with|font-family|tt|globsym>|purelib.tm#globsym>,
  which enables you to get a list of defined symbols which match a given glob
  pattern:

  <\verbatim>
    \<gtr\> globsym "fact" 0;

    [fact]

    \<gtr\> globsym "*" 0;

    [(!),(!!),(#),($),($$),...]

    \<gtr\> #globsym "*" 0;

    304
  </verbatim>

  Note that <hlink|<with|font-family|tt|globsym>|purelib.tm#globsym> also
  returns symbols defined as types, macros, variables or constants. But we
  can easily check for a given type of symbol by using the appropriate
  function to retrieve the rules defining the symbol, and filter out symbols
  with an empty rule list:

  <\verbatim>
    \<gtr\> #[sym \| sym = globsym "*" 0; ~null (get_fundef sym)];

    253
  </verbatim>

  Pure also provides the operations <hlink|<with|font-family|tt|get_typedef>|purelib.tm#get-typedef>,
  <hlink|<with|font-family|tt|get_macdef>|purelib.tm#get-macdef>,
  <hlink|<with|font-family|tt|get_vardef>|purelib.tm#get-vardef> and
  <hlink|<with|font-family|tt|get_constdef>|purelib.tm#get-constdef>, which
  are completely analogous to <hlink|<with|font-family|tt|get_fundef>|purelib.tm#get-fundef>,
  but return the definitions of types, macros, (global) variables and
  constants. Note that in the latter two cases the rule list takes the form
  <verbatim|[var--\>val]> if the symbol is defined, <verbatim|[]> if it
  isn't.

  For instance, let's check the definition of the
  <hlink|<with|font-family|tt|$>|purelib.tm#-dollar> macro (cf.
  <hlink|Optimization Rules|#optimization-rules>) and the
  <hlink|<with|font-family|tt|list>|purelib.tm#list/type> type (cf.
  <hlink|Recursive Types|#recursive-types>):

  <\verbatim>
    \<gtr\> get_macdef ($);

    [f$x--\<gtr\>f x]

    \<gtr\> get_typedef list;

    [(list []--\<gtr\>1),(list (_:_)--\<gtr\>1)]
  </verbatim>

  Or let's lists all global variables along with their values:

  <\verbatim>
    \<gtr\> catmap get_vardef (globsym "*" 0);

    [(argc--\<gtr\>0),(argv--\<gtr\>[]),(compiling--\<gtr\>0),

    (sysinfo--\<gtr\>"x86_64-unknown-linux-gnu"),(version--\<gtr\>"0.63")]
  </verbatim>

  The counterparts of <hlink|<with|font-family|tt|add_fundef>|purelib.tm#add-fundef>
  and <hlink|<with|font-family|tt|del_fundef>|purelib.tm#del-fundef> are
  provided as well. Not very surprisingly, they are named
  <hlink|<with|font-family|tt|add_typedef>|purelib.tm#add-typedef>,
  <hlink|<with|font-family|tt|del_typedef>|purelib.tm#del-typedef>, etc. For
  instance:

  <\verbatim>
    \<gtr\> add_vardef ['x--\<gtr\>3*33];

    ()

    \<gtr\> show x

    let x = 99;

    \<gtr\> del_vardef ('x);

    ()

    \<gtr\> show x
  </verbatim>

  The above facilities should cover most metaprogramming needs. For even more
  exotic requirements, you can also use the
  <hlink|<with|font-family|tt|eval>|purelib.tm#eval> and
  <hlink|<with|font-family|tt|evalcmd>|purelib.tm#evalcmd> primitives to
  execute arbitrary Pure code in text form; please see the <hlink|<em|Pure
  Library Manual>|purelib.tm> for details.

  Finally, a word of caution: The use of <hlink|<with|font-family|tt|add_fundef>|purelib.tm#add-fundef>,
  <hlink|<with|font-family|tt|del_fundef>|purelib.tm#del-fundef> and similar
  operations to modify a running program breaks referential transparency and
  hence these functions should be used with care. Moreover, at present the
  JIT compiler doesn't support truly self-modifying code (i.e., functions
  modifying themselves while they're executing); this results in undefined
  behaviour. Also, note that none of the inspection and mutation capabilities
  provided by these operations will work in batch-compiled programs, please
  check the <hlink|Batch Compilation|#batch-compilation> section for details.

  <subsection|Exception Handling<label|exception-handling>>

  Pure also offers a useful exception handling facility. To raise an
  exception, you just invoke the built-in function
  <hlink|<with|font-family|tt|throw>|purelib.tm#throw> with the value to be
  thrown as the argument. Exceptions are caught with the built-in special
  form <hlink|<with|font-family|tt|catch>|#catch> which is invoked as
  follows:

  <\description>
    <item*|catch handler x<label|catch>>Catch an exception. The first
    argument denotes the exception handler (a function to be applied to the
    exception value). The second (call-by-name) argument is the expression to
    be evaluated.
  </description>

  For instance:

  <\verbatim>
    \<gtr\> catch error (throw hello_world);

    error hello_world
  </verbatim>

  Exceptions are also generated by the runtime system if the program runs out
  of stack space, when a guard does not evaluate to a truth value, and when
  the subject term fails to match the pattern in a pattern-matching lambda
  abstraction, or a <hlink|<with|font-family|tt|let>|#let>,
  <hlink|<with|font-family|tt|case>|#case> or
  <hlink|<with|font-family|tt|when>|#when> construct. These types of
  exceptions are reported using the symbols
  <hlink|<with|font-family|tt|stack_fault>|purelib.tm#stack-fault>,
  <hlink|<with|font-family|tt|failed_cond>|purelib.tm#failed-cond> and
  <hlink|<with|font-family|tt|failed_match>|purelib.tm#failed-match>,
  respectively, which are declared as nonfix symbols in the standard prelude.
  You can use <hlink|<with|font-family|tt|catch>|#catch> to handle these
  kinds of exceptions just like any other. For instance:

  <\verbatim>
    \<gtr\> fact n = if n\<gtr\>0 then n*fact(n-1) else 1;

    \<gtr\> catch error (fact foo);

    error failed_cond

    \<gtr\> catch error (fact 1000000);

    error stack_fault
  </verbatim>

  Unhandled exceptions are reported by the interpreter with a corresponding
  error message:

  <\verbatim>
    \<gtr\> fact foo;

    \<less\>stdin\<gtr\>, line 2: unhandled exception 'failed_cond' while
    evaluating 'fact foo'
  </verbatim>

  Note that since the right-hand side of a type definition (cf. <hlink|Type
  Rules|#type-rules>) is just ordinary Pure code, it may be susceptible to
  exceptions, too. Such exceptions are reported or caught just like any
  other. In particular, if you want to make a type definition just fail
  silently in case of an exception, you'll have to wrap it up in a suitable
  <hlink|<with|font-family|tt|catch>|#catch> clause:

  <\verbatim>
    \<gtr\> foo x = throw foo; // dummy predicate which always throws an
    exception

    \<gtr\> type bar x = foo x;

    \<gtr\> type baz x = catch (cst false) (foo x);

    \<gtr\> test_bar x::bar = x;

    \<gtr\> test_baz x::baz = x;

    \<gtr\> test_bar ();

    \<less\>stdin\<gtr\>, line 6: unhandled exception 'foo' while evaluating
    'test_bar ()'

    \<gtr\> test_baz ();

    test_baz ()
  </verbatim>

  Exceptions also provide a way to handle asynchronous signals. Pure's system
  module provides symbolic constants for common POSIX signals and also
  defines the operation <hlink|<with|font-family|tt|trap>|purelib.tm#trap>
  which lets you rebind any signal to a signal exception. For instance, the
  following lets you handle the <verbatim|SIGQUIT> signal:

  <\verbatim>
    \<gtr\> using system;

    \<gtr\> trap SIG_TRAP SIGQUIT;
  </verbatim>

  You can also use <hlink|<with|font-family|tt|trap>|purelib.tm#trap> to just
  ignore a signal or revert to the system's default handler (which might take
  different actions depending on the type of signal, see signal(7) for
  details):

  <\verbatim>
    \<gtr\> trap SIG_IGN SIGQUIT; // signal is ignored

    \<gtr\> trap SIG_DFL SIGQUIT; // reinstalls the default signal handler
  </verbatim>

  Note that when the interpreter runs interactively, for convenience most
  standard termination signals (<verbatim|SIGINT>, <verbatim|SIGTERM>, etc.)
  are already set up to produce corresponding Pure exceptions of the form
  <verbatim|signal> <verbatim|SIG> where <verbatim|SIG> is the signal number.
  If a script is to be run non-interactively then you'll have to do this
  yourself (otherwise most signals will terminate the program).

  While exceptions are normally used to report abnormal error conditions,
  they also provide a way to implement non-local value returns. For instance,
  here's a variation of our n queens algorithm (cf. <hlink|List
  Comprehensions|#list-comprehensions>) which only returns the first
  solution. Note the use of <hlink|<with|font-family|tt|throw>|purelib.tm#throw>
  in the recursive search routine to bail out with a solution as soon as we
  found one. The value thrown there is caught in the main routine. Also note
  the use of <hlink|<with|font-family|tt|void>|purelib.tm#void> in the second
  equation of <verbatim|search>. This effectively turns the list
  comprehension into a simple loop which suppresses the normal list result
  and just returns <verbatim|()> instead. Thus, if no value gets thrown then
  the function regularly returns with <verbatim|()> to indicate that there is
  no solution.

  <\verbatim>
    queens n \ \ \ \ \ \ = catch reverse (search n 1 []) with

    \ \ search n i p = throw p if i\<gtr\>n;

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ = void [search n (i+1) ((i,j):p) \| j =
    1..n; safe (i,j) p];

    \ \ safe (i,j) p = ~any (check (i,j)) p;

    \ \ check (i1,j1) (i2,j2)

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ = i1==i2 \|\| j1==j2 \|\| i1+j1==i2+j2 \|\|
    i1-j1==i2-j2;

    end;
  </verbatim>

  E.g., let's compute a solution for a standard 8x8 board:

  <\verbatim>
    \<gtr\> queens 8;

    [(1,1),(2,5),(3,8),(4,6),(5,3),(6,7),(7,2),(8,4)]
  </verbatim>

  <subsection|Standard Library<label|standard-library>>

  Pure comes with a collection of Pure library modules, which includes the
  standard prelude (loaded automatically at startup time) and some other
  modules which can be loaded explicitly with a
  <hlink|<with|font-family|tt|using>|#using> clause. The prelude offers the
  necessary functions to work with the built-in types (including arithmetic
  and logical operations) and to do most kind of list processing you can find
  in ML- and Haskell-like languages. It also provides a collection of basic
  string and matrix operations. Please refer to the <hlink|<em|Pure Library
  Manual>|purelib.tm> for details on the provided operations. Here is a very
  brief summary of some of the prelude operations which, besides the usual
  arithmetic and logical operators, are probably used most frequently:

  <\description>
    <item*|x+y>The arithmetic <verbatim|+> operation is also used to denote
    list and string concatenation in Pure.
  </description>

  <\description>
    <item*|x:y>This is the list-consing operation. <verbatim|x> becomes the
    head of the list, <verbatim|y> its tail. As
    `<hlink|<with|font-family|tt|:>|purelib.tm#:>` is a constructor symbol,
    you can use it in patterns on the left hand side of rewriting rules.
  </description>

  <\description>
    <item*|x..y>Constructs arithmetic sequences. <verbatim|x:y..z> can be
    used to denote sequences with arbitrary stepsize <verbatim|y-x>. Infinite
    sequences can be constructed using an infinite bound (i.e.,
    <verbatim|inf> or <verbatim|-inf>). E.g., <verbatim|1:3..inf> denotes the
    stream of all odd integers starting at 1.
  </description>

  <\description>
    <item*|x,y>This is the pair constructor, used to create tuples of
    arbitrary sizes. Tuples provide an alternative way to represent aggregate
    values in Pure. In contrast to lists, tuples are always ``flat'', so that
    <verbatim|(x,y),z> and <verbatim|x,(y,z)> denote the same triple
    <verbatim|x,y,z>. (This is explained in more detail in the <hlink|Primary
    Expressions|#primary-expressions> section.)
  </description>

  <\description>
    <item*|#x>The size (number of elements) of the list, tuple, matrix or
    string <verbatim|x>. In addition, <verbatim|dim> <verbatim|x> yields the
    dimensions (number of rows and columns) of a matrix.
  </description>

  <\description>
    <item*|x!y>This is Pure's indexing operation, which applies to lists,
    tuples, matrices and strings. Note that all indices in Pure are
    zero-based, thus <verbatim|x!0> and <verbatim|x!(#x-1)> are the first and
    last element of <verbatim|x>. In the case of matrices, the subscript may
    also be a pair of row and column indices, such as <verbatim|x!(1,2)>.
  </description>

  <\description>
    <item*|x!!ys>This is the ``slicing'' operation, which returns the list,
    tuple, matrix or string of all <verbatim|x!y> while <verbatim|y> runs
    through the elements of the list or matrix <verbatim|ys>. Thus, e.g.,
    <verbatim|x!!(i..j)> returns all the elements between <verbatim|i> and
    <verbatim|j> (inclusive). Indices which fall outside the valid index
    range are quietly discarded. The index range <verbatim|ys> may contain
    any number of indices (also duplicates), in any order. Thus
    <verbatim|x!![0\|i=1..n]> returns the first element of <verbatim|x>
    <verbatim|n> times, and, if <verbatim|ys> is a permutation of the range
    <verbatim|0..#x-1>, then <verbatim|x!!ys> yields the corresponding
    permutation of the elements of <verbatim|x>. In the case of matrices the
    index range may also contain two-dimensional subscripts, or the index
    range itself may be specified as a pair of row/column index lists such as
    <verbatim|x!!(i..j,k..l)>.
  </description>

  The prelude also offers support operations for the implementation of list
  and matrix comprehensions, as well as the customary list operations like
  <hlink|<with|font-family|tt|head>|purelib.tm#head>,
  <hlink|<with|font-family|tt|tail>|purelib.tm#tail>,
  <hlink|<with|font-family|tt|drop>|purelib.tm#drop>,
  <hlink|<with|font-family|tt|take>|purelib.tm#take>,
  <hlink|<with|font-family|tt|filter>|purelib.tm#filter>,
  <hlink|<with|font-family|tt|map>|purelib.tm#map>,
  <hlink|<with|font-family|tt|foldl>|purelib.tm#foldl>,
  <hlink|<with|font-family|tt|foldr>|purelib.tm#foldr>,
  <hlink|<with|font-family|tt|scanl>|purelib.tm#scanl>,
  <hlink|<with|font-family|tt|scanr>|purelib.tm#scanr>,
  <hlink|<with|font-family|tt|zip>|purelib.tm#zip>,
  <hlink|<with|font-family|tt|unzip>|purelib.tm#unzip>, etc., which make list
  programming so much fun in modern FPLs. In Pure, these also work on strings
  as well as matrices, although, for reasons of efficiency, these data
  structures are internally represented as arrays.

  Besides the prelude, Pure's standard library also comprises a growing
  number of additional library modules which we can only mention in passing
  here. In particular, the <hlink|<with|font-family|tt|math>|purelib.tm#module-math>
  module provides additional mathematical functions as well as Pure's complex
  and rational number data types. Common container data structures like sets
  and dictionaries are implemented in the
  <hlink|<with|font-family|tt|set>|purelib.tm#module-set> and
  <hlink|<with|font-family|tt|dict>|purelib.tm#module-dict> modules, among
  others. Moreover, the system interface can be found in the
  <hlink|<with|font-family|tt|system>|purelib.tm#module-system> module. In
  particular, this module also provides operations to do basic C-style I/O,
  including <hlink|<with|font-family|tt|printf>|purelib.tm#printf> and
  <hlink|<with|font-family|tt|scanf>|purelib.tm#scanf>.

  <subsection|C Interface<label|c-interface>>

  Pure makes it very easy to call C functions (as well as functions in a
  number of other languages supported by the GNU compiler collection). To
  call an existing C function, you just need an
  <hlink|<with|font-family|tt|extern>|#extern> declaration of the function,
  as described below. By these means, all functions in the standard C library
  and the Pure runtime are readily available to Pure scripts. Functions can
  also be loaded from dynamic libraries and LLVM bitcode files at runtime. In
  the latter case, you don't even need to write any
  <hlink|<with|font-family|tt|extern>|#extern> declarations, the interpreter
  will do that for you. As of Pure 0.45, you can also add inline C/C++ and
  Fortran code to your Pure scripts and have the Pure interpreter compile
  them on the fly, provided that you have the corresponding compilers from
  the LLVM project installed.

  In some cases you will still have to rely on big and complicated
  third-party and system libraries which aren't readily available in bitcode
  form. It goes without saying that writing all the
  <hlink|<with|font-family|tt|extern>|#extern> declarations for such
  libraries can be a daunting task. Fortunately, there is a utility to help
  with this, by extracting the <hlink|<with|font-family|tt|extern>|#extern>
  declarations automatically from C headers. Please see <hlink|External C
  Functions|#external-c-functions> in the <hlink|Caveats and
  Notes|#caveats-and-notes> section for details.

  <subsubsection|Extern Declarations<label|extern-declarations>>

  To access an existing C function in Pure, you need an
  <hlink|<with|font-family|tt|extern>|#extern> declaration of the function,
  which is a simplified kind of C prototype. The syntax of these declarations
  is described by the following grammar rules:

  <\verbatim>
    extern_decl ::= \ [scope] "extern" prototype ("," prototype) ";"

    prototype \ \ ::= \ c_type identifier "(" [parameters \| "..."] ")" ["="
    identifier]

    parameters \ ::= \ parameter ("," parameter)* ["," "..."]

    parameter \ \ ::= \ c_type [identifier]

    c_type \ \ \ \ \ ::= \ identifier "*"*
  </verbatim>

  Extern functions can be called in Pure just like any other. For instance,
  the following commands, entered interactively in the interpreter, let you
  use the <verbatim|sin> function from the C library (of course you could
  just as well put the <hlink|<with|font-family|tt|extern>|#extern>
  declaration into a script):

  <\verbatim>
    \<gtr\> extern double sin(double);

    \<gtr\> sin 0.3;

    0.29552020666134
  </verbatim>

  An <hlink|<with|font-family|tt|extern>|#extern> declaration can also be
  prefixed with a <hlink|<with|font-family|tt|public>|#public>/<hlink|<with|font-family|tt|private>|#private>
  scope specifier:

  <\verbatim>
    private extern double sin(double);
  </verbatim>

  Multiple prototypes can be given in one
  <hlink|<with|font-family|tt|extern>|#extern> declaration, separating them
  with commas:

  <\verbatim>
    extern double sin(double), double cos(double), double tan(double);
  </verbatim>

  For clarity, the parameter types can also be annotated with parameter names
  (these only serve informational purposes and are for the human reader; they
  are effectively treated as comments by the compiler):

  <\verbatim>
    extern double sin(double x);
  </verbatim>

  Pointer types are indicated by following the name of the element type with
  one or more asterisks, as in C. For instance:

  <\verbatim>
    \<gtr\> extern char* strchr(char *s, int c);

    \<gtr\> strchr "foo bar" (ord "b");

    "bar"
  </verbatim>

  As you can see in the previous example, some pointer types get special
  treatment, allowing you to pass certain kinds of Pure data (such as Pure
  strings as <verbatim|char*> in this example). This is discussed in more
  detail in <hlink|C Types|#c-types> below.

  The interpreter makes sure that the parameters in a call match; if not,
  then by default the call is treated as a normal form expression:

  <\verbatim>
    \<gtr\> extern double sin(double);

    \<gtr\> sin 0.3;

    0.29552020666134

    \<gtr\> sin 0;

    sin 0
  </verbatim>

  This gives you the opportunity to augment the external function with your
  own Pure equations. To make this work, you have to make sure that the
  <hlink|<with|font-family|tt|extern>|#extern> declaration of the function
  comes first. For instance, we might want to extend the <verbatim|sin>
  function with a rule to handle integers:

  <\verbatim>
    \<gtr\> sin x::int = sin (double x);

    \<gtr\> sin 0;

    0.0
  </verbatim>

  Sometimes it is preferable to replace a C function with a wrapper function
  written in Pure. In such a case you can specify an
  <with|font-series|bold|alias> under which the original C function is known
  to the Pure program, so that you can still call the C function from the
  wrapper. An alias is introduced by terminating the extern declaration with
  a clause of the form <verbatim|=> <verbatim|alias>. For instance:

  <\verbatim>
    \<gtr\> extern double sin(double) = c_sin;

    \<gtr\> sin x::double = c_sin x;

    \<gtr\> sin x::int = c_sin (double x);

    \<gtr\> sin 0.3; sin 0;

    0.29552020666134

    0.0
  </verbatim>

  Aliases are just one way to declare a <with|font-series|bold|synonym> of an
  external function. As an alternative, you can also declare the C function
  in a special namespace (cf. <hlink|Namespaces|#namespaces> in the
  <hlink|Declarations|#declarations> section):

  <\verbatim>
    \<gtr\> namespace c;

    \<gtr\> extern double sin(double);

    \<gtr\> c::sin 0.3;

    0.29552020666134
  </verbatim>

  Note that the namespace qualification only affects the Pure side; the
  underlying C function is still called under the unqualified name as usual.
  The way in which such qualified externs are accessed is the same as for
  ordinary qualified symbols. In particular, the
  <hlink|<with|font-family|tt|using> <with|font-family|tt|namespace>|#using-namespace>
  declaration applies as usual, and you can declare such symbols as
  <hlink|<with|font-family|tt|private>|#private> if needed. It is also
  possible to combine a namespace qualifier with an alias:

  <\verbatim>
    \<gtr\> namespace c;

    \<gtr\> extern double sin(double) = mysin;

    \<gtr\> c::mysin 0.3;

    0.29552020666134
  </verbatim>

  In either case, different synonyms of the same external function can be
  declared in slightly different ways, which makes it possible to adjust the
  interpretation of pointer values on the Pure side. This is particularly
  useful for string arguments which, as described below, may be passed both
  as <verbatim|char*> (which implies copying and conversion to or from the
  system encoding) and as <verbatim|void*> (which simply passes through the
  character pointers). For instance:

  <\verbatim>
    \<gtr\> extern char *strchr(char *s, int c) = foo;

    \<gtr\> extern void *strchr(void *s, int c) = bar;

    \<gtr\> foo "foo bar" 98; bar "foo bar" 98;

    "bar"

    #\<less\>pointer 0x12c2f24\<gtr\>
  </verbatim>

  Also note that, as far as Pure is concerned, different synonyms of an
  external function are really different functions. In particular, they can
  each have their own set of augmenting Pure equations. For instance:

  <\verbatim>
    \<gtr\> extern double sin(double);

    \<gtr\> extern double sin(double) = mysin;

    \<gtr\> sin === sin;

    1

    \<gtr\> sin === mysin;

    0

    \<gtr\> sin 1.0; mysin 1.0;

    0.841470984807897

    0.841470984807897

    \<gtr\> sin x::int = sin (double x);

    \<gtr\> sin 1; mysin 1;

    0.841470984807897

    mysin 1
  </verbatim>

  <subsubsection|Variadic C Functions<label|variadic-c-functions>>

  Variadic C functions are declared as usual by terminating the parameter
  list with an ellipsis (<verbatim|...>):

  <\verbatim>
    \<gtr\> extern int printf(char*, ...);

    \<gtr\> printf "Hello, world\\n";

    Hello, world

    13
  </verbatim>

  Note that the variadic prototype is mandatory here, since the compiler
  needs to know about the optional arguments so that it can generate the
  proper code to call the function. However, in Pure a function always has a
  fixed arity, so, as far as Pure is concerned, the function is still treated
  as if it had no extra arguments. Thus the above declaration only allows you
  to call <verbatim|printf> with a single argument.

  To make it possible to pass optional arguments to a variadic function, you
  must explicitly give the (non-variadic) prototypes with which the function
  is to be called. To these ends, the additional prototypes are declared as
  synonyms of the original variadic function. This works because the compiler
  only checks the non-variadic parameters for conformance. For instance:

  <\verbatim>
    \<gtr\> extern int printf(char*, char*) = printf_s;

    \<gtr\> printf_s "Hello, %s\\n" "world";

    Hello, world

    13

    \<gtr\> extern int printf(char*, int) = printf_d;

    \<gtr\> printf_d "Hello, %d\\n" 99;

    Hello, 99

    10
  </verbatim>

  <subsubsection|C Types<label|c-types>>

  As indicated in the previous section, the data types in
  <hlink|<with|font-family|tt|extern>|#extern> declarations are either C type
  names or pointer types derived from these. The special <verbatim|expr*>
  pointer type is simply passed through; this provides a means to deal with
  Pure data in C functions in a direct fashion. For all other C types, Pure
  values are ``marshalled'' (converted) from Pure to C when passed as
  arguments to C functions, and the result returned by the C function is then
  converted back from C to Pure. All of this is handled by the runtime system
  in a transparent way, of course.

  Note that, to keep things simple, Pure does <em|not> provide any notations
  for C structs or function types, although it is possible to represent
  pointers to such objects using <verbatim|void*> or some other appropriate
  pointer types. In practice, this simplified system should cover most kinds
  of calls that need to be done when interfacing to C libraries, but there
  are ways to work around these limitations if you need to access C structs
  or call back from C to Pure, see <hlink|External C
  Functions|#external-c-functions> in the <hlink|Caveats and
  Notes|#caveats-and-notes> section for details.

  <paragraph|Basic C Types<label|basic-c-types>>

  Pure supports the usual range of basic C types: <verbatim|void>,
  <verbatim|bool>, <verbatim|char>, <verbatim|short>, <verbatim|int>,
  <verbatim|long>, <verbatim|float>, <verbatim|double>, and converts between
  these and the corresponding Pure data types (machine ints, bigints and
  double values) in a straightforward way.

  The <verbatim|void> type is only allowed in function results. It is
  converted to the empty tuple <verbatim|()>.

  Both <verbatim|float> and <verbatim|double> are supported as floating point
  types. Single precision <verbatim|float> arguments and return values are
  converted from/to Pure's double precision floating point numbers.

  A variety of C integer types (<verbatim|bool>, <verbatim|char>,
  <verbatim|short>, <verbatim|int>, <verbatim|long>) are provided which are
  converted from/to the available Pure integer types in a straightforward
  way. In addition, the synonyms <verbatim|int8>, <verbatim|int16> and
  <verbatim|int32> are provided for <verbatim|char>, <verbatim|short> and
  <verbatim|int>, respectively, and <verbatim|int64> denotes 64 bit integers
  (a.k.a. ISO C99 <verbatim|long> <verbatim|long>). Note that <verbatim|long>
  is equivalent to <verbatim|int32> on 32 bit systems, whereas it is the same
  as <verbatim|int64> on most 64 bit systems. To make it easier to interface
  to various system routines, there's also a special <verbatim|size_t>
  integer type which usually is 4 bytes on 32 bit and 8 bytes on 64 bit
  systems.

  All integer parameters take both Pure ints and bigints as actual arguments;
  truncation or sign extension is performed as needed, so that the C
  interface behaves as if the argument was ``cast'' to the C target type.
  Returned integers use the smallest Pure type capable of holding the result,
  i.e., int for the C <verbatim|char>, <verbatim|short> and <verbatim|int>
  types, bigint for <verbatim|int64>.

  Pure considers all integers as signed quantities, but it is possible to
  pass unsigned integers as well (if necessary, you can use a bigint to pass
  positive values which are too big to fit into a machine int). Also note
  that when an unsigned integer is returned by a C routine, which is too big
  to fit into the corresponding signed integer type, it will ``wrap around''
  and become negative. In this case, depending on the target type, you can
  use the <hlink|<with|font-family|tt|ubyte>|purelib.tm#ubyte>,
  <hlink|<with|font-family|tt|ushort>|purelib.tm#ushort>,
  <hlink|<with|font-family|tt|uint>|purelib.tm#uint>,
  <hlink|<with|font-family|tt|ulong>|purelib.tm#ulong> and
  <hlink|<with|font-family|tt|uint64>|purelib.tm#uint64> functions provided
  by the prelude to convert the result back to an unsigned quantity.

  <paragraph|Pointer Types<label|pointer-types>>

  The use of pointer types is also fairly straightforward, but Pure has some
  special rules for the conversion of certain pointer types which make it
  easy to pass aggregate Pure data to and from C routines, while also
  following the most common idioms for pointer usage in C. The following
  types of pointers are recognized both as arguments and return values of C
  functions.

  Bidirectional pointer conversions:

  <\itemize>
    <item><verbatim|char*> is used for string arguments and return values
    which are converted from Pure's internal utf-8 based string
    representation to the system encoding and vice versa. (Thus a C routine
    can never modify the raw Pure string data in-place; if this is required
    then you'll have to pass the string argument as a <verbatim|void*>, see
    below.)

    <item><verbatim|void*> is for any generic pointer value, which is simply
    passed through unchanged. When used as an argument, you can also pass
    Pure strings, matrices and bigints. In this case the raw underlying data
    pointer (<verbatim|char*> in the case of strings, <verbatim|int*>,
    <verbatim|double*> or <verbatim|expr*> in the case of numeric and
    symbolic matrices, and the GMP type <verbatim|mpz_t> in the case of
    bigints) is passed, which allows the data to be modified in place (with
    care). In particular, passing bigints as <verbatim|void*> makes it
    possible to call most GMP integer routines directly from Pure.

    <item><verbatim|dmatrix*>, <verbatim|cmatrix*> and <verbatim|imatrix*>
    allow you to pass numeric Pure matrices of the appropriate types (double,
    complex, int). Here a pointer to the underlying GSL matrix structure is
    passed (not just the data itself). This makes it possible to transfer GSL
    matrices between Pure and GSL routines in a direct fashion without any
    overhead. (For convenience, there are also some other pointer conversions
    for marshalling matrix arguments to numeric C vectors, which are
    described in <hlink|Pointers and Matrices|#pointers-and-matrices> below.)

    <item><verbatim|expr*> is for any kind of Pure value. A pointer to the
    expression node is passed to or from the C function. This type is to be
    used for C routines which are prepared to deal with pristine Pure data,
    using the corresponding functions provided by the runtime. You can find
    many examples of this in the standard library.
  </itemize>

  All other pointer types are simply taken at face value, allowing you to
  pass Pure pointer values as is, without any conversions. This also includes
  pointers to arbitrary named types which don't have a predefined meaning in
  Pure, such as <verbatim|FILE*>. As of Pure 0.45, the interpreter keeps
  track of the actual names of all pointer types and checks (at runtime) that
  the types match in an external call, so that you can't accidentally get a
  core dump by passing, say, a <verbatim|FILE*> for a <verbatim|char*>. (The
  call will then simply fail and yield a normal form, which gives you the
  opportunity to hook into the function with your own Pure definitions which
  may supply any desired data conversions.) Typing information about pointer
  values is also available to Pure scripts by means of corresponding library
  functions, please see the <hlink|<em|Tagged
  Pointers>|purelib.tm#tagged-pointers> section in the <hlink|<em|Pure
  Library Manual>|purelib.tm> for details.

  <paragraph|Pointers and Matrices<label|pointers-and-matrices>>

  The following additional pointer conversions are provided to deal with Pure
  matrix values in arguments of C functions, i.e., on the input side. These
  enable you to pass Pure matrices for certain kinds of C vectors. Note that
  in any case, you can also simply pass a suitable plain pointer value
  instead. Also, these types aren't special in return values, where they will
  simply yield a pointer value (with the exception of <verbatim|char*> which
  gets special treatment as explained in the previous subsection). Thus you
  will have to decode such results manually if needed. The standard library
  provides various routines to do this, please see the <hlink|<em|String
  Functions>|purelib.tm#string-functions> and <hlink|<em|Matrix
  Functions>|purelib.tm#matrix-functions> sections in the <hlink|<em|Pure
  Library Manual>|purelib.tm> for details.

  Numeric pointer conversions (input only):

  <\itemize>
    <item><verbatim|char*>, <verbatim|short*>, <verbatim|int*>,
    <verbatim|int64*>, <verbatim|float*>, <verbatim|double*> can be used to
    pass numeric matrices as C vectors. This kind of conversion passes just
    the matrix data (not the GSL matrix structure, as the <verbatim|dmatrix*>
    et al conversions do) and does conversions between integer or floating
    point data of different sizes on the fly. You can either pass an int
    matrix as a <verbatim|char*>, <verbatim|short*> <verbatim|int*> or
    <verbatim|int64*> argument, or a double or complex matrix as a
    <verbatim|float*> or <verbatim|double*> argument (complex values are then
    represented as two separate double numbers, first the real, then the
    imaginary part, for each matrix element).

    <item><verbatim|char**>, <verbatim|short**>, <verbatim|int**>,
    <verbatim|int64**>, <verbatim|float**>, <verbatim|double**> provide yet
    another way to pass numeric matrix arguments. This works analogously to
    the numeric vector conversions above, but here a temporary C vector of
    pointers is passed to the C function, whose elements point to the rows of
    the matrix.
  </itemize>

  Argv-style conversions (input only):

  <\itemize>
    <item><verbatim|char**> and <verbatim|void**> can be used to pass
    <verbatim|argv>-style vectors as arguments to C functions. In this case,
    the Pure argument must be a symbolic vector of strings or generic pointer
    values. <verbatim|char**> converts the string elements to the system
    encoding, whereas <verbatim|void**> passes through character string data
    and other pointers unchanged (and allows in-place modification of the
    data). A temporary C vector of these elements is passed to the C
    function, which is always <hlink|<with|font-family|tt|NULL>|purelib.tm#NULL>-terminated
    and can thus be used for almost any purpose which requires such
    <verbatim|argv>-style vectors.
  </itemize>

  Note that in the numeric pointer conversions, the matrix data is passed
  ``per reference'' to C routines, i.e., the C function may modify the data
  ``in place''. This is true even for target data types such as
  <verbatim|short*> or <verbatim|float**> which involve automatic conversions
  and hence need temporary storage. In this case the data from the temporary
  storage is written back to the original matrix when the function returns,
  to maintain the illusion of in-place modification. Temporary storage is
  also needed when the GSL matrix has the data in non-contiguous storage. You
  may want to avoid this if performance is critical, by always using
  ``packed'' matrices (see <hlink|<with|font-family|tt|pack>|purelib.tm#pack>
  in <hlink|<em|Matrix Functions>|purelib.tm#matrix-functions>) of the
  appropriate types.

  <paragraph|Pointer Examples<label|pointer-examples>>

  Let's finally have a look at some instructive examples to explain some of
  the trickier pointer types.

  First, the matrix pointer types <verbatim|dmatrix*>, <verbatim|cmatrix*>
  and <verbatim|imatrix*> can be used to pass double, complex double and int
  matrices to GSL functions taking pointers to the corresponding GSL types
  (<verbatim|gsl_matrix>, <verbatim|gsl_matrix_complex> and
  <verbatim|gsl_matrix_int>) as arguments or returning them as results. (Note
  that there is no special marshalling of Pure's symbolic matrix type, as
  these aren't supported by GSL anyway.) Also note that matrices are always
  passed by reference. Thus, if you need to pass a matrix as an output
  parameter of a GSL matrix routine, you should either create a zero matrix
  or a copy of an existing matrix to hold the result. The prelude provides
  various operations for that purpose (in particular, see the
  <hlink|<with|font-family|tt|dmatrix>|purelib.tm#dmatrix>,
  <hlink|<with|font-family|tt|cmatrix>|purelib.tm#cmatrix>,
  <hlink|<with|font-family|tt|imatrix>|purelib.tm#imatrix> and
  <hlink|<with|font-family|tt|pack>|purelib.tm#pack> functions in
  matrices.pure). For instance, here is how you can quickly wrap up GSL's
  double matrix addition function in a way that preserves value semantics:

  <\verbatim>
    \<gtr\> using "lib:gsl";

    \<gtr\> extern int gsl_matrix_add(dmatrix*, dmatrix*);

    \<gtr\> x::matrix + y::matrix = gsl_matrix_add x y $$ x when x = pack x
    end;

    \<gtr\> let x = dmatrix {1,2,3}; let y = dmatrix {2,3,2}; x; y; x+y;

    {1.0,2.0,3.0}

    {2.0,3.0,2.0}

    {3.0,5.0,5.0}
  </verbatim>

  Most GSL matrix routines can be wrapped in this fashion quite easily. A
  ready-made GSL interface providing access to all of GSL's numeric functions
  is in the works; please check the Pure website for details.

  For convenience, it is also possible to pass any kind of numeric matrix for
  a <verbatim|char*>, <verbatim|short*>, <verbatim|int*>, <verbatim|int64*>,
  <verbatim|float*> or <verbatim|double*> parameter. This requires that the
  pointer and the matrix type match up; conversions between <verbatim|char>,
  <verbatim|short>, <verbatim|int64> and <verbatim|int> data and, likewise,
  between <verbatim|float> and <verbatim|double> are handled automatically,
  however. For instance, here is how you can call the <verbatim|puts> routine
  from the C library with an int matrix encoding the string
  <verbatim|"Hello,> <verbatim|world!"> as byte values (ASCII codes):

  <\verbatim>
    \<gtr\> extern int puts(char*);

    \<gtr\> puts {72,101,108,108,111,44,32,119,111,114,108,100,33,0};

    Hello, world!

    14
  </verbatim>

  Pure 0.45 and later also support <verbatim|char**>, <verbatim|short**>,
  <verbatim|int**>, <verbatim|int64**>, <verbatim|float**> and
  <verbatim|double**> parameters which encode a matrix as a vector of row
  pointers instead. This kind of matrix representation is often found in
  audio and video processing software (where the rows of the matrix might
  denote different audio channels, display lines or video frames), but it's
  also fairly convenient to do any kind of matrix processing in C. For
  instance, here's how to do matrix multiplication (the naive algorithm):

  <\verbatim>
    void matmult(int n, int l, int m, double **x, double **y, double **z)

    {

    \ \ int i, j, k;

    \ \ for (i = 0; i \<less\> n; i++)

    \ \ \ \ for (j = 0; j \<less\> m; j++) {

    \ \ \ \ \ \ z[i][j] = 0.0;

    \ \ \ \ \ \ for (k = 0; k \<less\> l; k++)

    \ \ \ \ \ \ \ \ z[i][j] += x[i][k]*y[k][j];

    \ \ \ \ }

    }
  </verbatim>

  As you can see, this multiplies a <verbatim|n> times <verbatim|l> matrix
  <verbatim|x> with a <verbatim|l> times <verbatim|m> matrix <verbatim|y> and
  puts the result into the <verbatim|n> times <verbatim|m> matrix
  <verbatim|z>:

  <\verbatim>
    \<gtr\> extern void matmult(int, int, int, double**, double**, double**);

    \<gtr\> let x = {0.11,0.12,0.13;0.21,0.22,0.23};

    \<gtr\> let y = {1011.0,1012.0;1021.0,1022.0;1031.0,1032.0};

    \<gtr\> let z = dmatrix (2,2);

    \<gtr\> matmult 2 3 2 x y z $$ z;

    {367.76,368.12;674.06,674.72}
  </verbatim>

  Also new in Pure 0.45 is the support for passing <verbatim|argv>-style
  vectors as arguments. For instance, here is how you can use <verbatim|fork>
  and <verbatim|execvp> to implement a poor man's version of the C
  <verbatim|system> function. (This is Unix-specific and doesn't do much
  error-checking, but you get the idea.)

  <\verbatim>
    extern int fork();

    extern int execvp(char *path, char **argv);

    extern int waitpid(int pid, int *status, int options);

    \;

    system cmd::string = case fork of

    \ \ // child: execute the program, bail out if error

    \ \ 0 = execvp "/bin/sh" {"/bin/sh","-c",cmd} $$ exit 1;

    \ \ // parent: wait for the child and return its exit code

    \ \ pid = waitpid pid status 0 $$ status!0 \<gtr\>\<gtr\> 8

    \ \ \ \ \ \ \ \ when status = {0} end if pid\<gtr\>=0;

    end;

    \;

    system "echo Hello, world!";

    system "ls -l *.pure";

    system "exit 1";
  </verbatim>

  <subsubsection|Importing Dynamic Libraries<label|importing-dynamic-libraries>>

  By default, external C functions are resolved by the LLVM runtime, which
  first looks for the symbol in the C library and Pure's runtime library (or
  the interpreter executable, if the interpreter was linked statically). Thus
  all C library and Pure runtime functions are readily available in Pure
  programs. Other functions can be provided by adding them to the runtime, or
  by linking them into the runtime or the interpreter executable. Better yet,
  you can just ``dlopen'' shared libraries at runtime with a special form of
  the <hlink|<with|font-family|tt|using>|#using> clause:

  <\verbatim>
    using "lib:libname[.ext]";
  </verbatim>

  For instance, if you want to call the functions from library libxyz
  directly from Pure:

  <\verbatim>
    using "lib:libxyz";
  </verbatim>

  After this declaration the functions from the given library will be ready
  to be imported into your Pure program by means of corresponding
  <hlink|<with|font-family|tt|extern>|#extern> declarations.

  Shared libraries opened with using clauses are searched for in the same way
  as source scripts (see section <hlink|Modules and
  Imports|#modules-and-imports> above), using the
  <hlink|<em|-L>|#cmdoption-pure-L> option and
  the<label|index-18><hlink|<with|font-family|tt|PURE_LIBRARY>|#envvar-PURE-LIBRARY>
  environment variable in place of <hlink|<em|-I>|#cmdoption-pure-I>
  and<label|index-19><hlink|<with|font-family|tt|PURE_INCLUDE>|#envvar-PURE-INCLUDE>.
  If the library isn't found by these means, the interpreter will also
  consider other platform-specific locations searched by the dynamic linker,
  such as the system library directories and<label|index-20><verbatim|LD_LIBRARY_PATH>
  on Linux. The necessary filename suffix (e.g., .so on Linux or .dll on
  Windows) will be supplied automatically when needed. Of course you can also
  specify a full pathname for the library if you prefer that. If a library
  file cannot be found, or if an <hlink|<with|font-family|tt|extern>|#extern>
  declaration names a function symbol which cannot be resolved, an
  appropriate error message is printed.

  <subsubsection|Importing LLVM Bitcode<label|importing-llvm-bitcode>>

  As of Pure 0.44, the interpreter also provides a direct way to import LLVM
  bitcode modules in Pure scripts. The main advantage of this method over the
  ``plain'' C interface explained above is that the bitcode loader knows all
  the call interfaces and generates the necessary
  <hlink|<with|font-family|tt|extern>|#extern> declarations automatically.
  This is more than just a convenience, as it also eliminates at least some
  of the mistakes in <hlink|<with|font-family|tt|extern>|#extern>
  declarations that may arise when importing functions manually from dynamic
  libraries.

  <with|font-series|bold|Note:> The facilities described below require that
  you have an LLVM-capable C/C++ compiler installed. The available options
  right now are <hlink|clang|#clang>, <hlink|llvm-gcc|#llvm-gcc> and
  <hlink|dragonegg|#dragonegg>. Please check the Pure <hlink|<em|installation
  instructions>|install.tm> on how to get one of these (or all of them) up
  and running. Note that clang and llvm-gcc are standalone compilers, while
  dragonegg is supplied as a gcc plugin which hooks into your existing system
  compiler (gcc 4.5 or later is required for that). Any of these enable you
  to compile C/C++ source to LLVM assembler or bitcode. The clang compiler is
  recommended for C/C++ development, as it offers faster compilation times
  and has much better diagnostics than gcc. On the other hand, llvm-gcc and
  dragonegg have the advantage that they also support alternative frontends
  so that you can compile Fortran and Ada code as well. (But note that, as of
  LLVM 3.x, llvm-gcc is not supported any more.)

  LLVM bitcode is loaded in a Pure script using the following special format
  of the <hlink|<with|font-family|tt|using>|#using> clause:

  <\verbatim>
    using "bc:modname[.bc]";
  </verbatim>

  (Here the <verbatim|bc> tag indicates a bitcode file, and the default
  <verbatim|.bc> bitcode filename extension is supplied automatically. Also,
  the bitcode file is searched for on the usual library search path.)

  That's it, no explicit <hlink|<with|font-family|tt|extern>|#extern>
  declarations are required on the Pure side. The Pure interpreter
  automatically creates <hlink|<with|font-family|tt|extern>|#extern>
  declarations (in the current namespace) for all the external functions
  defined in the LLVM bitcode module, and generates the corresponding
  wrappers to make the functions callable from Pure. (This also works when
  batch-compiling a Pure script. In this case, the bitcode file actually gets
  linked into the output code, so the loaded bitcode module only needs to be
  present at compile time.)

  By default the imported symbols will be public. You can also specify the
  desired scope of the symbols explicitly, by placing the
  <hlink|<with|font-family|tt|public>|#public> or
  <hlink|<with|font-family|tt|private>|#private> keyword before the module
  name. For instance:

  <\verbatim>
    using private "bc:modname";
  </verbatim>

  You can also import the same bitcode module several times, possibly in
  different namespaces. This will not actually reload the module, but it will
  create synonyms for the external functions in different namespaces:

  <\verbatim>
    namespace foo;

    using "bc:modname";

    namespace bar;

    using private "bc:modname";
  </verbatim>

  You can load any number of bitcode modules along with shared libraries in a
  Pure script, in any order. The JIT will try to satisfy external references
  in modules and libraries from other loaded libraries and bitcode modules.
  This is deferred until the code is actually JIT-compiled, so that you can
  make sure beforehand that all required libraries and bitcode modules have
  been loaded. If the JIT fails to resolve a function, the interpreter will
  print its name and also raise an exception at runtime when the function is
  being called from other C code. (You can then run your script in the
  debugger to locate the external visible in Pure from which the unresolved
  function is called.)

  Let's take a look at a concrete example to see how this actually works.
  Consider the following C code which defines a little function to compute
  the greatest common divisor of two (machine) integers:

  <\verbatim>
    int mygcd(int x, int y)

    {

    \ \ if (y == 0)

    \ \ \ \ return x;

    \ \ else

    \ \ \ \ return mygcd(y, x%y);

    }
  </verbatim>

  Let's say that this code is in the file <verbatim|mygcd.c>, then you'd
  compile it to a bitcode module using <hlink|clang|#clang> as follows:

  <\verbatim>
    clang -emit-llvm -c mygcd.c -o mygcd.bc
  </verbatim>

  Note that the <verbatim|-emit-llvm> <verbatim|-c> options instruct clang to
  build an LLVM bitcode module. Of course, you can also add optimizations and
  other options to the compile command as desired.

  Using <hlink|dragonegg|#dragonegg> is somewhat more involved, as it doesn't
  provide a direct way to produce a bitcode file yet. However, you can create
  an LLVM assembler file which can then be translated to bitcode using the
  llvm-as program as follows:

  <\verbatim>
    gcc -fplugin=dragonegg -flto -S mygcd.c -o mygcd.ll

    llvm-as mygcd.ll -o mygcd.bc
  </verbatim>

  (Note that the <verbatim|-fplugin> option instructs gcc to use the
  dragonegg plugin, which in conjunction with the <verbatim|-flto> flag
  switches it to LLVM output. Please check the dragonegg website for
  details.)

  In either case, you can now load the resulting bitcode module and run the
  <verbatim|mygcd> function in the Pure interpreter simply as follows:

  <\verbatim>
    \<gtr\> using "bc:mygcd";

    \<gtr\> mygcd 75 105;

    15
  </verbatim>

  To actually see the generated <hlink|<with|font-family|tt|extern>|#extern>
  declaration of the imported function, you can use the interactive
  <verbatim|show> command:

  <\verbatim>
    \<gtr\> show mygcd

    extern int mygcd(int, int);
  </verbatim>

  Some more examples showing how to use the bitcode interface can be found in
  the Pure sources. In particular, the interface also works with Fortran
  (using llvm-gfortran or gfortran with dragonegg), and there is special
  support for interfacing to Grame's functional DSP programming language
  <hlink|Faust|#faust> (the latter uses a special variant of the bitcode
  loader, which is selected with the <verbatim|dsp> tag in the
  <hlink|<with|font-family|tt|using>|#using> clause). Further details about
  these can be found below.

  Please note that at this time the LLVM bitcode interface is still somewhat
  experimental, and there are some known limitations:

  <\itemize>
    <item>LLVM doesn't distinguish between <verbatim|char*> and
    <verbatim|void*> in bitcode, so all <verbatim|void*> parameters and
    return values in C code will be promoted to <verbatim|char*> on the Pure
    side. Also, pointers to types which neither have a predefined meaning in
    Pure nor a proper type name in the bitcode file, will become a generic
    pointer type (<verbatim|void*>, <verbatim|void**>, etc.) in Pure. If this
    is a problem then you can just redeclare the corresponding functions
    under a synonym <em|after> loading the bitcode module, giving the proper
    argument and result types (see <hlink|Extern
    Declarations|#extern-declarations> above). For instance:

    <\verbatim>
      \<gtr\> using "bc:foo";

      \<gtr\> show foo

      extern char* foo(char*);

      \<gtr\> extern void *foo(void*) = myfoo;

      \<gtr\> show myfoo

      extern void* foo(void*) = myfoo;
    </verbatim>

    <item>The bitcode interface is limited to the same range of C types as
    Pure's plain C interface. In practice, this should cover most C code, but
    it's certainly possible that you run into unsupported types for arguments
    and return values. The compiler will then print a warning; the affected
    functions will still be linked in, but they will not be callable from
    Pure. Also note that calling conventions for passing C structs <em|by
    value> depend on the host ABI, so you should have a look at the resulting
    <hlink|<with|font-family|tt|extern>|#extern> declaration (using
    <verbatim|show>) to determine how the function is actually to be called
    from Pure.
  </itemize>

  <subsubsection|Inline Code<label|inline-code>>

  Instead of manually compiling source files to bitcode modules, you can also
  just place the source code into a Pure script, enclosing it in
  <verbatim|%\<> <verbatim|...> <verbatim|%\>>. (Optionally, the opening
  brace may also be preceded with a <hlink|<with|font-family|tt|public>|#public>
  or <hlink|<with|font-family|tt|private>|#private> scope specifier, which is
  used in the same way as the scope specifier following the
  <hlink|<with|font-family|tt|using>|#using> keyword when importing bitcode
  files.)

  For instance, here is a little script showing inline code for the
  <verbatim|mygcd> function from the previous subsection:

  <\verbatim>
    %\<less\>

    int mygcd(int x, int y)

    {

    \ \ if (y == 0)

    \ \ \ \ return x;

    \ \ else

    \ \ \ \ return mygcd(y, x%y);

    }

    %\<gtr\>

    \;

    mygcd 75 105;
  </verbatim>

  The interpreter automatically compiles the inlined code to LLVM bitcode
  which is then loaded as usual. (Of course, this will only work if you have
  the corresponding LLVM compilers installed.) This method has the advantage
  that you don't have to write a Makefile and you can create self-contained
  Pure scripts which include all required external functions. The downside is
  that the inline code sections will have to be recompiled every time you run
  the script with the interpreter which may considerably increase startup
  times. If this is a problem then it's usually better to import a separate
  bitcode module instead (see <hlink|Importing LLVM
  Bitcode|#importing-llvm-bitcode>), or batch-compile your script to an
  executable (see <hlink|Batch Compilation|#batch-compilation>).

  At present, C, C++, Fortran, ATS and Faust are supported as foreign source
  languages, with clang, clang++, gfortran (with the dragonegg plugin),
  patscc and faust as the corresponding (default) compilers. C is the default
  language. The desired source language can be selected by placing an
  appropriate tag into the inline code section, immediately after the opening
  brace. (The tag is removed before the code is submitted to compilation.)
  For instance:

  <\verbatim>
    %\<less\> -*- Fortran90 -*-

    function fact(n) result(p)

    \ \ integer n, p

    \ \ p = 1

    \ \ do i = 1, n

    \ \ \ \ \ p = p*i

    \ \ end do

    end function fact

    %\<gtr\>

    \;

    fact n::int = fact_ {n};

    map fact (1..10);
  </verbatim>

  As indicated, the language tag takes the form <verbatim|-*->
  <verbatim|lang> <verbatim|-*-> where <verbatim|lang> can currently be any
  of <verbatim|c>, <verbatim|c++>, <verbatim|fortran>, <verbatim|ats> and
  <verbatim|dsp> (the latter indicates the Faust language). Case is
  insignificant here, so you can also write <verbatim|C>, <verbatim|C++>,
  <verbatim|Fortran>, <verbatim|ATS>, <verbatim|DSP> etc. For the
  <verbatim|fortran> tag, you may also have to specify the appropriate
  language standard, such as <verbatim|fortran90> which is used in the
  example above. The language tag can also be followed by a module name,
  using the format <verbatim|-*-> <verbatim|lang:name> <verbatim|-*->. This
  is optional for all languages except Faust (where the module name specifies
  the namespace for the interface routines of the Faust module; see
  <hlink|Interfacing to Faust|#interfacing-to-faust> below). So, e.g., a
  Faust DSP named <verbatim|test> would be specified with a
  <verbatim|dsp:test> tag. Case is <em|significant> in the module name.

  The Pure interpreter has some built-in knowledge on how to invoke the LLVM
  compilers to produce a working bitcode file ready to be loaded by the
  interpreter, so the examples above should work out of the box if you have
  the required compilers installed on your<label|index-21><verbatim|PATH>.
  However, there are also some environment variables you can set for
  customization purposes. Specifically,<label|index-22><verbatim|PURE_CC> is
  the command to invoke the C compiler. This variable lets you specify the
  exact name of the executable along with any debugging and optimization
  options that you may want to add. Likewise,<label|index-23><verbatim|PURE_CXX>,<label|index-24><verbatim|PURE_FC>,<label|index-25><verbatim|PURE_ATS>
  and<label|index-26><verbatim|PURE_FAUST> are used for the C++, Fortran, ATS
  and Faust compilers, respectively.

  For instance, if you prefer to use <hlink|llvm-gcc|#llvm-gcc> as your C
  compiler, and you'd like to invoke it with the <verbatim|-O3> optimization
  option, you would set<label|index-27><verbatim|PURE_CC> to
  <verbatim|"llvm-gcc> <verbatim|-O3">. (To verify the settings you made, you
  can have the interpreter echo the compilation commands which are actually
  executed, by running Pure with the <verbatim|-v0100> option, see
  <hlink|Verbosity and Debugging Options|#verbosity-and-debugging-options>.
  Also note that the options necessary to produce LLVM bitcode will be added
  automatically, so you don't have to specify these.)

  Beginning with Pure 0.48, the <hlink|dragonegg|#dragonegg> gcc plugin is
  also fully supported. To make this work, you need to explicitly specify the
  name of the plugin in the compilation command, so that the Pure interpreter
  can add the proper set of options needed for bitcode compilation. For
  instance:

  <\verbatim>
    PURE_CC="gcc -fplugin=dragonegg -O3"
  </verbatim>

  Some further details on the bitcode support for specific target languages
  can be found in the subsections below.

  <subsubsection|Interfacing to C++<label|interfacing-to-c>>

  Interfacing to C++ code requires additional preparations because of the
  name mangling performed by C++ compilers. Usually, you won't be able to
  call C++ functions and methods directly, so you'll have to expose the
  required functionality using functions with C binding (<verbatim|extern>
  <verbatim|"C">). For instance, the following example shows how to work with
  STL maps from Pure.

  <\verbatim>
    %\<less\> -*- C++ -*-

    \;

    #include \<less\>pure/runtime.h\<gtr\>

    #include \<less\>string\<gtr\>

    #include \<less\>map\<gtr\>

    \;

    // An STL map mapping strings to Pure expressions.

    \;

    using namespace std;

    typedef map\<less\>string,pure_expr*\<gtr\> exprmap;

    \;

    // Since we can't directly deal with C++ classes in Pure, provide some C

    // functions to create, destroy and manipulate these objects.

    \;

    extern "C" exprmap *map_create()

    {

    \ \ return new exprmap;

    }

    \;

    extern "C" void map_add(exprmap *m, const char *key, pure_expr *x)

    {

    \ \ exprmap::iterator it = m-\<gtr\>find(string(key));

    \ \ if (it != m-\<gtr\>end()) pure_free(it-\<gtr\>second);

    \ \ (*m)[key] = pure_new(x);

    }

    \;

    extern "C" void map_del(exprmap *m, const char *key)

    {

    \ \ exprmap::iterator it = m-\<gtr\>find(key);

    \ \ if (it != m-\<gtr\>end()) {

    \ \ \ \ pure_free(it-\<gtr\>second);

    \ \ \ \ m-\<gtr\>erase(it);

    \ \ }

    }

    \;

    extern "C" pure_expr *map_get(exprmap *m, const char *key)

    {

    \ \ exprmap::iterator it = m-\<gtr\>find(key);

    \ \ return (it != m-\<gtr\>end())?it-\<gtr\>second:0;

    }

    \;

    extern "C" pure_expr *map_keys(exprmap *m)

    {

    \ \ size_t i = 0, n = m-\<gtr\>size();

    \ \ pure_expr **xs = new pure_expr*[n];

    \ \ for (exprmap::iterator it = m-\<gtr\>begin(); it != m-\<gtr\>end();
    ++it)

    \ \ \ \ xs[i++] = pure_string_dup(it-\<gtr\>first.c_str());

    \ \ pure_expr *x = pure_listv(n, xs);

    \ \ delete[] xs;

    \ \ return x;

    }

    \;

    extern "C" void map_destroy(exprmap *m)

    {

    \ \ for (exprmap::iterator it = m-\<gtr\>begin(); it != m-\<gtr\>end();
    ++it)

    \ \ \ \ pure_free(it-\<gtr\>second);

    \ \ delete m;

    }

    \;

    %\<gtr\>

    \;

    // Create the STL map and add a sentry so that it garbage-collects
    itself.

    let m = sentry map_destroy map_create;

    \;

    // Populate the map with some arbitrary Pure data.

    do (\\(x=\<gtr\>y) -\<gtr\> map_add m x y) ["foo"=\<gtr\>99,
    "bar"=\<gtr\>bar 4711L, "baz"=\<gtr\>1..5];

    \;

    // Query the map.

    map_keys m; // =\<gtr\> ["bar","baz","foo"]

    map (map_get m) (map_keys m); // =\<gtr\> [bar 4711L,[1,2,3,4,5],99]

    \;

    // Delete an element.

    map_del m "foo";

    map_keys m; // =\<gtr\> ["bar","baz"]

    map (map_get m) (map_keys m); // =\<gtr\> [bar 4711L,[1,2,3,4,5]]
  </verbatim>

  <subsubsection|Interfacing to ATS<label|interfacing-to-ats>>

  <hlink|ATS|#ats> is a statically typed functional programming language
  somewhat similar to ML, which also offers imperative and concurrent
  programming features. One of ATS's most unusual and interesting aspects is
  its highly expressive Applied Type System, which gives the language its
  name. ATS has a very elaborate <hlink|C
  interface|http://ats-lang.sourceforge.net/DOCUMENT/INT2PROGINATS/HTML/c1995.html>
  which lets you expose functions written in the language using C linkage.
  This makes it easy to call ATS functions from Pure via Pure's C interface.

  Here is a simple example which illustrates how to implement the factorial
  in ATS and call that function from Pure:

  <\verbatim>
    %\<less\> -*- ATS -*-

    \;

    #include "share/atspre_staload.hats"

    \;

    // A recursive definition of the factorial relation.

    // FACT (n, r) means `the factorial of n equals r'.

    // MUL (i, j, k) means `the product of i and j equals k'.

    dataprop FACT (int, int) =

    \ \ \| FACT_base (0, 1)

    \ \ \| {n : nat} {r1, r : int}

    \ \ \ \ FACT_induction (n, r) of

    \ \ \ \ \ \ (FACT (n-1, r1), MUL (n, r1, r))

    \;

    // Declare ifact as an ATS function that is referred to in C by the

    // name `ifact_nonneg'. The `ifact_nonneg' function returns an integer

    // equal to r, where r satisfies the relation FACT (n, r).

    extern fun ifact :

    \ \ \ \ {n : nat} (int n) -\<less\>\<gtr\> [r : int] (FACT (n, r) \| int
    r) =

    \ \ \ \ \ \ "ext#ifact_nonneg"

    \;

    implement ifact (n) =

    \ \ let

    \ \ \ \ fun fact {n : nat} .\<less\>n\<gtr\>. (n : int n)
    :\<less\>\<gtr\>

    \ \ \ \ \ \ \ \ [r : int] (FACT (n, r) \| int r) =

    \ \ \ \ \ \ begin

    \ \ \ \ \ \ \ \ if n \<gtr\> 0 then

    \ \ \ \ \ \ \ \ \ \ let

    \ \ \ \ \ \ \ \ \ \ \ \ val (pf1 \| r1) = ifact (n - 1)

    \ \ \ \ \ \ \ \ \ \ \ \ val (pfmul \| r) = g1int_mul2 (n, r1)

    \ \ \ \ \ \ \ \ \ \ in

    \ \ \ \ \ \ \ \ \ \ \ \ (FACT_induction (pf1, pfmul) \| r)

    \ \ \ \ \ \ \ \ \ \ end

    \ \ \ \ \ \ \ \ else

    \ \ \ \ \ \ \ \ \ \ (FACT_base () \| 1)

    \ \ \ \ \ \ end

    \ \ in

    \ \ \ \ fact n

    \ \ end

    \;

    %\<gtr\>

    \;

    ifact n::int = ifact_nonneg n if 0 \<less\>= n;

    \;

    map ifact (0..9);
  </verbatim>

  To make this work in Pure, you need to have ATS2 (the current version of
  the ATS compiler) installed. ATS2 in turn needs a suitable C compiler for
  generating LLVM bitcode. By default, Pure uses clang for that purpose. If
  you have gcc's dragonegg plugin installed, you can also use gcc as the C
  compiler instead, by setting the<label|index-28><verbatim|PURE_ATS>
  environment variable to <verbatim|patscc> <verbatim|-fplugin=dragonegg>.
  Also make sure that you have the<label|index-29><verbatim|PATSHOME>
  environment variable set to ATS's library directory, as explained in the
  <hlink|ATS installation instructions|http://www.ats-lang.org/Downloads.html#Install-source-compile>.

  More information about ATS, as well as sources and binary packages of the
  ATS compiler can be found on the <hlink|ATS
  website|http://www.ats-lang.org/>.

  <subsubsection|Interfacing to Faust<label|interfacing-to-faust>>

  <hlink|Faust|#faust> is a functional dsp (digital signal processing)
  programming language developed at Grame, which is tailored to the task of
  generating and transforming streams of numeric data at the sample level. It
  is typically used to program sound synthesis and audio effect units, but
  can in fact be employed to process any kind of numeric vector and matrix
  data. The Faust compiler is capable of generating very efficient code for
  such tasks which is comparable in performance with carefully handcrafted C
  routines. Pure's Faust interface lets you use these capabilities in order
  to process sample data stored in Pure matrices.

  Pure's LLVM bitcode loader has some special knowledge about Faust built
  into it, which makes interfacing to Faust programs simple and efficient. At
  present, you'll need a special LLVM-capable version of Faust to make this
  work, which is available under the ``faust2'' branch in Faust's git
  repository. Some information on how to get this up and running can be found
  on the <hlink|LLVM backend for Faust|https://bitbucket.org/purelang/pure-lang/wiki/Faust2>
  website.

  <with|font-series|bold|Note:> There's also an alternative interface to
  Faust which is available as a separate package and works with either Faust2
  or the stable Faust version. Please check the
  <hlink|<em|pure-faust>|pure-faust.tm> package for details. This package
  also provides the <hlink|<with|font-family|tt|faust2>|pure-faust.tm#module-faust2>
  compatibility module which implements the pure-faust API on top of Pure's
  built-in Faust interface, so that you can also use the operations of this
  module instead. (The pure-faust API can in fact be more convenient to use
  in some cases, especially if you want to load a lot of different Faust
  modules dynamically at runtime.)

  The <verbatim|-lang> <verbatim|llvm> option instructs the Faust compiler to
  output LLVM bitcode. Also, you want to add the <verbatim|-double> option to
  make the compiled Faust module use double precision floating point values
  for samples and control values. So you'd compile an existing Faust module
  in the source file example.dsp as follows:

  <\verbatim>
    faust -double -lang llvm example.dsp -o example.bc
  </verbatim>

  The <verbatim|-double> option isn't strictly necessary, but it makes
  interfacing between Pure and Faust easier and more efficient, since Pure
  uses <verbatim|double> as its native floating point format.

  Alternatively, you can also use the Faust <verbatim|pure.c> architecture
  (included in recent Faust2 revisions and also in the
  <hlink|<em|pure-faust>|pure-faust.tm> package) to compile a Faust program
  to corresponding C source which can then be fed into an LLVM-capable C
  compiler to produce bitcode which is compatible with Pure's Faust bitcode
  loader. This is useful, in particular, if you want to make use of special
  optimization options provided by the C compiler, or if the Faust module
  needs to be linked against additional C/C++ code. For instance:

  <\verbatim>
    faust -double -a pure.c -lang c example.dsp -o example.c

    clang -emit-llvm -O3 -c example.c -o example.bc
  </verbatim>

  A third possibility is to just inline Faust code in a Pure script, as
  described in the <hlink|Inline Code|#inline-code> section. The compilation
  step is then handled by the Pure compiler and the <verbatim|-double> option
  is added automatically. The<label|index-30><verbatim|PURE_FAUST>
  environment variable can be used to specify a custom Faust command to be
  invoked by the Pure interpreter. This is useful if you'd like to invoke the
  Faust compiler with some special options, e.g.:

  <\verbatim>
    PURE_FAUST="faust -single -vec"
  </verbatim>

  (Note that you do not have to include the <verbatim|-lang> <verbatim|llvm>
  option; the inline compiler will supply it automatically.)

  Moreover, you can also set the<label|index-31><verbatim|FAUST_OPT>
  environment variable to specify any needed postprocessing of the output of
  the Faust compiler; this is typically used to invoke the LLVM
  <verbatim|opt> utility in a pipeline, in order to have some additional
  optimizations performed on the Faust-generated code:

  <\verbatim>
    FAUST_OPT="\| opt -O3"
  </verbatim>

  After loading or inlining the Faust module, the Pure compiler makes the
  interface routines of the Faust module available in its own namespace.
  Thus, e.g., the interface routines for the example.dsp module will end up
  in the <verbatim|example> namespace.

  Pure's Faust interface offers another useful feature not provided by the
  general bitcode interface, namely the ability to reload Faust modules on
  the fly. If you repeat the import clause for a Faust module, the compiler
  checks whether the module was modified and, if so, replaces the old module
  with the new one. Retyping an inline Faust code section has the same
  effect. This is mainly intended as a convenience for interactive usage, so
  that you can test different versions of a Faust module without having to
  restart the Pure interpreter. But it is also put to good use in addon
  packages like <hlink|<em|pd-faust>|pd-faust.tm> which allows Faust dsps to
  be reloaded at runtime.

  For instance, consider the following little Faust program, which takes a
  stereo audio signal as input, mixes the two channels and multiplies the
  resulting mono signal with a gain value given by a corresponding Faust
  control variable:

  <\verbatim>
    gain = nentry("gain", 0.3, 0, 10, 0.01);

    process = + : *(gain);
  </verbatim>

  The interface routines of this Faust module look as follows on the Pure
  side:

  <\verbatim>
    \<gtr\> show -g example::*

    extern void buildUserInterface(struct_dsp_example*, struct_UIGlue*) =
    example::buildUserInterface;

    extern void classInit(int) = example::classInit;

    extern void compute(struct_dsp_example*, int, double**, double**) =
    example::compute;

    extern void delete(struct_dsp_example*) = example::delete;

    extern void destroy(struct_dsp_example*) = example::destroy;

    extern int getNumInputs(struct_dsp_example*) = example::getNumInputs;

    extern int getNumOutputs(struct_dsp_example*) = example::getNumOutputs;

    extern int getSampleRate(struct_dsp_example*) = example::getSampleRate;

    extern expr* info(struct_dsp_example*) = example::info;

    extern void init(struct_dsp_example*, int) = example::init;

    extern void instanceInit(struct_dsp_example*, int) =
    example::instanceInit;

    extern expr* meta() = example::meta;

    extern void metadata(struct_MetaGlue*) = example::metadata;

    extern struct_dsp_example* new() = example::new;

    extern struct_dsp_example* newinit(int) = example::newinit;
  </verbatim>

  The most important interface routines are <verbatim|new>, <verbatim|init>
  and <verbatim|delete> (used to create, initialize and destroy an instance
  of the dsp) and <verbatim|compute> (used to apply the dsp to a given block
  of samples). Some useful convenience functions are added by the Pure
  compiler:

  <\itemize>
    <item><verbatim|newinit> combines <verbatim|new> and <verbatim|init>;

    <item><verbatim|info> yields pertinent information about the dsp as a
    Pure tuple containing the number of input and output channels and the
    Faust control descriptions;

    <item><verbatim|meta> yields metadata about the dsp, as declared in the
    Faust source.
  </itemize>

  The latter two are provided in a symbolic format ready to be used in Pure;
  more about that below.

  Note that there's usually no need to explicitly invoke the
  <verbatim|delete> routine in Pure programs; the Pure compiler makes sure
  that this routine is added automatically as a finalizer (see
  <hlink|<with|font-family|tt|sentry>|purelib.tm#sentry>) to all dsp pointers
  created through the <verbatim|new> and <verbatim|newinit> routines so that
  dsp instances are destroyed automatically when the corresponding Pure
  objects are garbage-collected. (If you prefer to do the finalization
  manually then you must also remove the sentry from the dsp object, so that
  it doesn't get deleted twice.)

  Another point worth mentioning here is that the Pure compiler always
  generates code that ensures that the Faust dsp instances (the
  <verbatim|struct_dsp> pointers) are fully typechecked at runtime. Thus it
  is only possible to pass a dsp struct pointer to the interface routines of
  the Faust module it was created with.

  Let's have a brief look at how we can actually run a Faust module in Pure
  to process some audio samples.

  <with|font-series|bold|Step 1: Load the Faust dsp.> This assumes that the
  Faust source has already been compiled to a bitcode file, as shown above.
  You can then load the module in Pure as follows:

  <\verbatim>
    \<gtr\> using "dsp:example";
  </verbatim>

  Note that the .bc bitcode extension is supplied automatically. Also note
  the special <verbatim|dsp> tag; this tells the compiler that this is a
  Faust-generated module, so that it does some Faust-specific processing
  while linking the module.

  Alternatively, you can also just inline the code of the Faust module. For
  the example above, the inline code section looks as follows:

  <\verbatim>
    %\<less\> -*- dsp:example -*-

    gain = nentry("gain", 0.3, 0, 10, 0.01);

    process = + : *(gain);

    %\<gtr\>
  </verbatim>

  You can either add this code to a Pure script, or just type it directly in
  the Pure interpreter.

  Finally, you may want to verify that the module has been properly loaded by
  typing <verbatim|show> <verbatim|-g> <verbatim|example::*>. The output
  should look like the listing above.

  <with|font-series|bold|Step 2: Create and initialize a dsp instance.> After
  importing the Faust module you can now create an instance of the Faust
  signal processor using the <verbatim|newinit> routine, and assign it to a
  Pure variable as follows:

  <\verbatim>
    \<gtr\> let dsp = example::newinit 44100;
  </verbatim>

  Note that the constant 44100 denotes the desired sample rate in Hz. This
  can be an arbitrary integer value, which is available in the Faust program
  by means of the <verbatim|SR> variable. It's completely up to the dsp
  whether it actually uses this value in some way (our example doesn't, but
  we need to specify a value anyway).

  The dsp is now fully initialized and we can use it to compute some samples.
  But before we can do this, we'll need to know how many channels of audio
  data the dsp consumes and produces, and which control variables it
  provides. This information can be extracted with the <verbatim|info>
  function, and be assigned to some Pure variables as follows:

  <\verbatim>
    \<gtr\> let k,l,ui = example::info dsp;
  </verbatim>

  (We'll have a closer look at the contents of the <verbatim|ui> variable
  below.)

  In a similar fashion, the <verbatim|meta> function provides some
  ``metadata'' about the Faust dsp, as a list of <verbatim|key=\>val> string
  pairs. This is static data which doesn't belong to any particular dsp
  instance, so it can be extracted without actually creating an instance. In
  our case the metadata will be empty, since we didn't supply any in the
  Faust program. If needed, we can add some metadata as follows:

  <\verbatim>
    declare descr \ \ "Faust Hello World";

    declare author \ "Faust Guru";

    declare version "1.0";

    gain = nentry("gain", 0.3, 0, 10, 0.01);

    process = + : *(gain);
  </verbatim>

  If we now reload the Faust dsp, we'll get:

  <\verbatim>
    \<gtr\> test::meta;

    ["descr"=\<gtr\>"Faust Hello World","author"=\<gtr\>"Faust
    Guru","version"=\<gtr\>"1.0"]
  </verbatim>

  <with|font-series|bold|Step 3: Prepare input and output buffers.> Pure's
  Faust interface allows you to pass Pure double matrices as sample buffers,
  which makes this step quite convenient. For given numbers k and l of input
  and output channels, respectively, we'll need a k x n matrix for the input
  and a l x n matrix for the output, where n is the desired block size (the
  number of samples to be processed per channel in one go). Note that the
  matrices have one row per input or output channel. Here's how we can create
  some suitable input and output matrices using a Pure matrix comprehension
  and the <verbatim|dmatrix> function available in the standard library:

  <\verbatim>
    \<gtr\> let n = 10; // the block size

    \<gtr\> let in \ = {i*10.0+j \| i = 1..k; j = 1..n};

    \<gtr\> let out = dmatrix (l,n);
  </verbatim>

  In our example, k=2 and l=1, thus we obtain the following matrices:

  <\verbatim>
    \<gtr\> in;

    {11.0,12.0,13.0,14.0,15.0,16.0,17.0,18.0,19.0,20.0;

    21.0,22.0,23.0,24.0,25.0,26.0,27.0,28.0,29.0,30.0}

    \<gtr\> out;

    {0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0}
  </verbatim>

  <with|font-series|bold|Step 4: Apply the dsp to compute some samples.> With
  the <verbatim|in> and <verbatim|out> matrices as given above, we can now
  apply the dsp by invoking its <verbatim|compute> routine:

  <\verbatim>
    \<gtr\> example::compute dsp n in out;
  </verbatim>

  This takes the input samples specified in the <verbatim|in> matrix and
  stores the resulting output in the <verbatim|out> matrix. The output matrix
  now looks as follows:

  <\verbatim>
    \<gtr\> out;

    {9.6,10.2,10.8,11.4,12.0,12.6,13.2,13.8,14.4,15.0}
  </verbatim>

  Note that the <verbatim|compute> routine also modifies the internal state
  of the dsp instance so that a subsequent call will continue with the output
  stream where the previous call left off. (This isn't relevant in this
  specific example, but in general a Faust dsp may contain delays and similar
  constructions which need a memory of past samples to be maintained between
  different invocations of <verbatim|compute>.) Thus we can now just keep on
  calling <verbatim|compute> (possibly with different <verbatim|in> buffers)
  to compute as much of the output signal as we need.

  <with|font-series|bold|Step 5: Inspecting and modifying control variables.>
  Recall that our sample dsp also has a Faust control variable
  <verbatim|gain> which lets us change the amplification of the output
  signal. We've already assigned the corresponding information to the
  <verbatim|ui> variable, let's have a look at it now:

  <\verbatim>
    \<gtr\> ui;

    vgroup [] ("test",[nentry #\<less\>pointer 0x1611f00\<gtr\> []
    ("gain",0.3,0.0,10.0,0.01)])
  </verbatim>

  In general, this data structure takes the form of a tree which corresponds
  to the hierarchical layout of the control groups and values in the Faust
  program. In this case, we just have one toplevel group containing a single
  <verbatim|gain> parameter, which is represented as a Pure term containing
  the relevant information about the type, name, initial value, range and
  stepsize of the control, along with a double pointer which can be used to
  inspect and modify the control value. While it's possible to access this
  information in a direct fashion, there's also a faustui.pure module in the
  standard library which makes this easier. First we extract the mapping of
  control variable names to the corresponding double pointers as follows:

  <\verbatim>
    \<gtr\> using faustui;

    \<gtr\> let ui = control_map $ controls ui; ui;

    {"gain"=\<gtr\>#\<less\>pointer 0xd81820\<gtr\>}
  </verbatim>

  The result is a record value indexed by control names, thus the pointer
  which belongs to our <verbatim|gain> control can now be obtained with
  <verbatim|ui!"gain">. The faustui.pure module also provides convenience
  functions to inspect a control and change its value:

  <\verbatim>
    \<gtr\> let gain = ui!"gain";

    \<gtr\> get_control gain;

    0.3

    \<gtr\> put_control gain 1.0;

    ()

    \<gtr\> get_control gain;

    1.0
  </verbatim>

  Let's rerun <verbatim|compute> to get another block of samples from the
  same input data, using the new <verbatim|gain> value:

  <\verbatim>
    \<gtr\> example::compute dsp n in out;

    \<gtr\> out;

    {32.0,34.0,36.0,38.0,40.0,42.0,44.0,46.0,48.0,50.0}
  </verbatim>

  Faust also allows metadata to be attached to individual controls and
  control groups, which is available in the same form of a list of
  <verbatim|key=\>val> string pairs that we have seen already with the
  <verbatim|meta> operation. This metadata is used to provide auxiliary
  information about a control to specific applications. It's completely up to
  the application how to interpret this metadata. Typical examples are style
  hints about GUI renderings of a control, or the assignment of external
  ``MIDI'' controllers. (<with|font-series|bold|MIDI> is the ``Musical
  Instruments Digital Interface'', a standardized hardware and software
  interface for electronic music instruments and other digital multimedia
  equipment.)

  In our example these metadata lists are all empty. Control metadata is
  specified in a Faust program in the labels of the controls using the syntax
  <verbatim|[key:val]>, please see the Faust documentation for details. For
  instance, if we'd like to assign MIDI controller 7 (usually the ``volume
  controller'' on MIDI keyboards) to our <verbatim|gain> control, this might
  be done as follows:

  <\verbatim>
    gain = nentry("gain [midi:ctrl 7]", 0.3, 0, 10, 0.01);
  </verbatim>

  After reloading the dsp and creating a new instance, this metadata is
  available in the <verbatim|ui> structure and can be extracted with the
  <verbatim|control_meta> function of the faustui module as follows:

  <\verbatim>
    \<gtr\> let dsp = test::newinit SR;

    \<gtr\> let k,l,ui = example::info dsp;

    \<gtr\> controls ui!0;

    nentry #\<less\>pointer 0x1c97070\<gtr\> ["midi"=\<gtr\>"ctrl 7"]
    ("gain",0.3,0.0,10.0,0.01)

    \<gtr\> control_meta ans;

    ["midi"=\<gtr\>"ctrl 7"]
  </verbatim>

  As you can see, all these steps are rather straightforward. Of course, in a
  real program we would probably run <verbatim|compute> in a loop which reads
  some samples from an audio device or sound file, applies the dsp, and
  writes back the resulting samples to another audio device or file. We might
  also have to process MIDI controller input and change the control variables
  accordingly. This can all be done quite easily using the appropriate addon
  modules available on the Pure website.

  We barely scratched the surface here, but it should be apparent that the
  programming techniques sketched out in this section open the door to the
  realm of sophisticated multimedia and signal processing applications. More
  Faust-related examples can be found in the Pure distribution. Also, have a
  look at the <hlink|<em|pd-pure>|pd-pure.tm> and
  <hlink|<em|pd-faust>|pd-faust.tm> packages to see how these facilities can
  be used in Pd modules written in Pure.

  <subsection|Interactive Usage<label|interactive-usage>>

  In interactive mode, the interpreter reads definitions and expressions and
  processes them as usual. You can use the <hlink|<em|-i>|#cmdoption-pure-i>
  option to force interactive mode when invoking the interpreter with some
  script files. Additional scripts can be loaded interactively using either a
  <hlink|<with|font-family|tt|using>|#using> declaration or the interactive
  <verbatim|run> command (see the description of the <verbatim|run> command
  below for the differences between these). Or you can just start typing
  away, entering your own definitions and expressions to be evaluated.

  The input language is mostly the same as for source scripts, and hence
  individual definitions and expressions must be terminated with a semicolon
  before they are processed. For instance, here is a simple interaction which
  defines the factorial and then uses that definition in some evaluations.
  Input lines begin with ``\<gtr\> '', which is the interpreter's default
  command prompt:

  <\verbatim>
    \<gtr\> fact 1 = 1;

    \<gtr\> fact n = n*fact (n-1) if n\<gtr\>1;

    \<gtr\> let x = fact 10; x;

    3628800

    \<gtr\> map fact (1..10);

    [1,2,6,24,120,720,5040,40320,362880,3628800]
  </verbatim>

  As indicated, in interactive mode the normal forms of toplevel expressions
  are printed after each expression is entered. This is also commonly known
  as the <with|font-series|bold|read-eval-print loop>. Normal form
  expressions are usually printed in the same form as you'd enter them.
  However, there are a few special kinds of objects like anonymous closures,
  thunks (``lazy'' values to be evaluated when needed) and pointers which
  don't have a textual representation in the Pure syntax and will be printed
  in the format <verbatim|#\<><em|object description><verbatim|\>> by
  default. It is also possible to override the print representation of any
  kind of expression by means of the <hlink|<with|font-family|tt|__show__>|#--show-->
  function, see <hlink|Pretty-Printing|#pretty-printing> below for details.

  A number of other special features of Pure's command line interface are
  discussed in the following subsections.

  <subsubsection|Command Syntax<label|command-syntax>>

  Besides Pure definitions and expressions, the interpreter also understands
  a number of special interactive commands for performing basic maintenance
  tasks, such as loading source scripts, exiting and restarting the
  interpreter, changing the working directory, escaping to the shell, getting
  help and displaying definitions. In contrast to the normal input language,
  the command language is line-oriented; it consists of special command words
  to be typed at the beginning of an input line, which may be followed by
  some parameters as required by the command. The command language is
  intended solely for interactive purposes and thus doesn't offer any
  programming facilities of its own. However, it can be extended with
  user-defined commands implemented as ordinary Pure functions; this is
  described in the <hlink|User-Defined Commands|#user-defined-commands>
  section below.

  In fact, as of Pure 0.56 the interpreter actually provides two slightly
  different command syntaxes, which we'll refer to as ``default'' and
  ``escape mode''. The manual assumes that you're running the interpreter in
  its traditional <with|font-series|bold|default mode> where interactive
  commands are typed simply as they are shown in the following subsections,
  with the command word at the very beginning of the line. However, this mode
  has its pitfalls, especially for beginners. As most of the commands look
  just like ordinary identifiers, you may run into situations where the
  beginning of an expression or definition to be typed at the prompt can be
  mistaken for a command word. In such cases the default mode requires that
  you insert one or more spaces at the beginning of the line, so that the
  interpreter reads the line as normal Pure code. Unfortunately, it's much
  too easy to forget this if you're not familiar with the command language.

  Therefore there is an alternative <with|font-series|bold|escape mode>
  available which handles special command input more like some other popular
  programming language interpreters. In escape mode <em|all> interactive
  commands have to be escaped by prefixing them with a special character at
  the very beginning of the line. The command itself must follow the prefix
  character, without any intervening whitespace. Any line not prefixed with
  the prefix character will then be considered normal Pure code. This mode
  can be enabled with the <hlink|<em|--escape>|#cmdoption-pure--escape>
  option, which takes the desired prefix character as an argument, or you can
  just set the<label|index-32><hlink|<with|font-family|tt|PURE_ESCAPE>|#envvar-PURE-ESCAPE>
  variable in your environment to enable escape mode by default.

  For example, to set the escape character to `<verbatim|:>` you'll invoke
  the interpreter as follows:

  <\verbatim>
    $ pure --escape=':'
  </verbatim>

  Alternatively, you could also set the<label|index-33><hlink|<with|font-family|tt|PURE_ESCAPE>|#envvar-PURE-ESCAPE>
  environment variable like this (using Bourne shell syntax):

  <\verbatim>
    $ export PURE_ESCAPE=':'
  </verbatim>

  Note that specifying the prefix character with the
  <hlink|<em|--escape>|#cmdoption-pure--escape> option overrides the value of
  the environment variable, and only the initial character in the value of
  <hlink|<em|--escape>|#cmdoption-pure--escape>
  or<label|index-34><hlink|<with|font-family|tt|PURE_ESCAPE>|#envvar-PURE-ESCAPE>
  will be used. If the specified value is empty, the interpreter reverts to
  the default mode. The following prefix characters can be used:
  <verbatim|!$%&*,:\<\>@\\\|>. Note that these all belong to 7 bit ASCII, and
  only some of the ASCII punctuation characters are permitted in order to
  prevent conflicts with ordinary Pure code. In any case, all of these
  characters <em|can> also occur in ordinary Pure code, so you should use a
  prefix that you aren't likely to type at the beginning of a line in your
  usual coding style.

  Many Pure programmers prefer escape mode, and in fact we recommend it for
  Pure novices even though it's not the default (yet). Others may prefer
  default mode because it's less effort to type. For the manual we stick to
  the default mode syntax. This means that if you're running the interpreter
  in escape mode then you'll have to do the necessary translation of the
  command syntax yourself. For instance, if the manual tells you to type the
  following command,

  <\verbatim>
    \<gtr\> show foldl
  </verbatim>

  and you are using `<verbatim|:>` as the command prefix, then you will have
  to type this in escape mode instead:

  <\verbatim>
    \<gtr\> :show foldl
  </verbatim>

  Note that in this case `<verbatim|!>` continues to serve as a shell escape:

  <\verbatim>
    \<gtr\> ! find . '*.pure'
  </verbatim>

  This will not work, however, if you use `<verbatim|!>` as your command
  prefix. In this case you will have to type <em|two> exclamation marks
  instead (the same caveat applies if you escape a shell command in the
  debugger, cf. <hlink|Debugging|#debugging>):

  <\verbatim>
    \<gtr\> !! find . '*.pure'
  </verbatim>

  This should be rather straightforward, so in the following we just use the
  default mode command syntax throughout without further notice.

  <with|font-series|bold|Note:> Escape mode only applies to the interactive
  command line. It doesn't affect the <hlink|<with|font-family|tt|evalcmd>|purelib.tm#evalcmd>
  function in any way, so interactive commands in the string argument of
  <hlink|<with|font-family|tt|evalcmd>|purelib.tm#evalcmd> are always
  specified without the escape character prefix no matter which mode the
  interpreter is running in.

  <subsubsection|Online Help<label|online-help>>

  Online help is available in the interpreter with the interactive
  <verbatim|help> command, which gives you access to all the available
  documentation in html format; this includes the present manual, the
  <hlink|<em|Pure Library Manual>|purelib.tm>, as well as all manuals of the
  addon modules available from the Pure website.

  You need to have a html browser installed to make this work. By default,
  the <verbatim|help> command uses <with|font-series|bold|w3m>, but you can
  change this by setting either the<label|index-35><hlink|<with|font-family|tt|PURE_HELP>|#envvar-PURE-HELP>
  or the<label|index-36><hlink|<with|font-family|tt|BROWSER>|#envvar-BROWSER>
  environment variable accordingly.

  When invoked without arguments, the <verbatim|help> command displays an
  overview of the available documentation, from which you can follow the
  links to the provided manuals:

  <\verbatim>
    \<gtr\> help
  </verbatim>

  (If the interpreter gives you an error message when you do this then you
  haven't installed the documentation yet. The complete set of manuals is
  provided as a separate package at the Pure website, please see the Pure
  installation instructions for details.)

  The <verbatim|help> command also accepts a parameter which lets you specify
  a search term which is looked up in the global index, e.g.:

  <\verbatim>
    \<gtr\> help foldl
  </verbatim>

  Besides Pure functions, macros, variables and constants described in the
  manual you can also look up program options and environment variables,
  e.g.:

  <\verbatim>
    \<gtr\> help -x

    \<gtr\> help pure-gen -x

    \<gtr\> help PURE_STACK
  </verbatim>

  (Note that you can specify the program name to disambiguate between options
  for different utilities, such as the <verbatim|-x> option which is accepted
  both by the Pure interpreter and the <verbatim|pure-gen> program.)

  If the search term doesn't appear in the index, it is assumed to be a topic
  (a link target, usually a section title) in the Pure manual. Note that the
  <hlink|docutils|http://docutils.sourceforge.net/> tools used to generate
  the html source of the Pure documentation mangle the section titles so that
  they are in lowercase and blanks are replaced with hyphens. So to look up
  the present section in this manual you'd have to type:

  <\verbatim>
    \<gtr\> help online-help
  </verbatim>

  The help files are in html format and located in the docs subdirectory of
  the Pure library directory (i.e., /usr/local/lib/pure/docs by default). You
  can look up topics in any of the help files with a command like the
  following:

  <\verbatim>
    \<gtr\> help pure-gsl#matrices
  </verbatim>

  Here <verbatim|pure-gsl> is the basename of the help file (library path and
  .html suffix are supplied automatically), and <verbatim|matrices> is a link
  target in that document. To just read the pure-gsl.html file without
  specifying a target, type the following:

  <\verbatim>
    \<gtr\> help pure-gsl#
  </verbatim>

  (Note that just <verbatim|help> <verbatim|pure-gsl> won't work, since it
  would look for a search term in the index or a topic in the Pure manual.)

  Last but not least, you can also point the help browser to any html
  document (either a local file or some website) denoted by a proper URL,
  provided that your browser program can handle these. For instance:

  <\verbatim>
    \<gtr\> help file:mydoc.html#foo

    \<gtr\> help http://purelang.bitbucket.org
  </verbatim>

  <subsubsection|Interactive Commands<label|interactive-commands>>

  The following built-in commands are always understood by the interpreter.
  (In addition, you can define your own commands for frequently-used
  operations; see <hlink|User-Defined Commands|#user-defined-commands>
  below.)

  <\description>
    <item*|! command><label|index-37>Shell escape.
  </description>

  <\description>
    <item*|break [symbol ...]><label|index-38>Sets breakpoints on the given
    function or operator symbols. All symbols must be specified in fully
    qualified form, see the remarks below. If invoked without arguments,
    prints all currently defined breakpoints. This requires that the
    interpreter was invoked with the <hlink|<em|-g>|#cmdoption-pure-g> option
    to enable debugging support. See <hlink|Debugging|#debugging> below for
    details.
  </description>

  <\description>
    <item*|bt><label|index-39>Prints a full backtrace of the call sequence of
    the most recent evaluation, if that evaluation ended with an unhandled
    exception. This requires that the interpreter was invoked with the
    <hlink|<em|-g>|#cmdoption-pure-g> option to enable debugging support. See
    <hlink|Debugging|#debugging> below for details.
  </description>

  <\description>
    <item*|cd dir><label|index-40>Change the current working dir.
  </description>

  <\description>
    <item*|clear [option ...] [symbol ...]><label|index-41>Purge the
    definitions of the given symbols (functions, macros, constants or global
    variables). All symbols must be specified in fully qualified form, see
    the remarks below. If invoked as <verbatim|clear> <verbatim|ans>, clears
    the <hlink|<with|font-family|tt|ans>|purelib.tm#ans> value (see
    <hlink|Last Result|#last-result> below). When invoked without any
    arguments, <verbatim|clear> purges all definitions at the current
    interactive ``level'' (after confirmation) and returns you to the
    previous level, if any. (It might be a good idea to first check your
    current definitions with <verbatim|show> or back them up with
    <verbatim|dump> before you do that.) The desired level can be specified
    with the <verbatim|-t> option. See the description of the <verbatim|save>
    command and <hlink|Definition Levels|#definition-levels> below for
    further details. A description of the common options accepted by the
    <verbatim|clear>, <verbatim|dump> and <verbatim|show> commands can be
    found in <hlink|Specifying Symbol Selections|#specifying-symbol-selections>
    below.
  </description>

  <\description>
    <item*|del [-b\|-m\|-t] [symbol ...]><label|index-42>Deletes breakpoints
    and tracepoints on the given function or operator symbols. If the
    <verbatim|-b> option is specified then only breakpoints are deleted;
    similarly, <verbatim|del> <verbatim|-t> only deletes tracepoints. If none
    of these are specified then both breakpoints and tracepoints are deleted.
    All symbols must be specified in fully qualified form, see the remarks
    below. If invoked without non-option arguments, <verbatim|del> clears
    <em|all> currently defined breakpoints and/or tracepoints (after
    confirmation); see <hlink|Debugging|#debugging> below for details.

    The <verbatim|-m> option works similarly to <verbatim|-t>, but deletes
    macro rather than function tracepoints, see the description of the
    <verbatim|trace> command below.
  </description>

  <\description>
    <item*|dump [-n filename] [option ...] [symbol ...]><label|index-43>Dump
    a snapshot of the current function, macro, constant and variable
    definitions in Pure syntax to a text file. All symbols must be specified
    in fully qualified form, see the remarks below. This works similar to the
    <verbatim|show> command (see below), but writes the definitions to a
    file. The default output file is .pure in the current directory, which is
    then reloaded automatically the next time the interpreter starts up in
    interactive mode in the same directory. This provides a quick-and-dirty
    way to save an interactive session and have it restored later, but note
    that this isn't perfect. In particular, declarations of
    <hlink|<with|font-family|tt|extern>|#extern> symbols won't be saved
    unless they're specified explicitly, and some objects like closures,
    thunks and pointers don't have a textual representation from which they
    could be reconstructed. To handle these, you'll probably have to prepare
    a corresponding .purerc file yourself, see <hlink|Interactive
    Startup|#interactive-startup> below.

    A different filename can be specified with the <verbatim|-n> option,
    which expects the name of the script to be written in the next argument,
    e.g: <verbatim|dump> <verbatim|-n> <verbatim|myscript.pure>. You can then
    edit that file and use it as a starting point for an ordinary script or a
    .purerc file, or you can just run the file with the <verbatim|run>
    command (see below) to restore the definitions in a subsequent
    interpreter session.
  </description>

  <\description>
    <item*|help [topic]><label|index-44>Display online documentation. If a
    topic is given, it is looked up in the index. Alternatively, you can also
    specify a link target in any of the installed help files, or any other
    html document denoted by a proper URL. Please see <hlink|Online
    Help|#online-help> above for details.
  </description>

  <\description>
    <item*|ls [args]><label|index-45>List files (shell
    <with|font-series|bold|ls> command).
  </description>

  <\description>
    <item*|mem><label|index-46>Print current memory usage. This reports the
    number of expression cells currently in use by the program, along with
    the size of the freelist (the number of allocated but currently unused
    expression cells). Note that the actual size of the expression storage
    may be somewhat larger than this, since the runtime always allocates
    expression memory in bigger chunks. Also, this figure does not reflect
    other heap-allocated memory in use by the program, such as strings or
    malloc'ed pointers.
  </description>

  <\description>
    <item*|override><label|index-47>Enter ``override'' mode. This allows you
    to add equations ``above'' existing definitions in the source script,
    possibly overriding existing equations. See <hlink|Definition
    Levels|#definition-levels> below for details.
  </description>

  <\description>
    <item*|pwd><label|index-48>Print the current working dir (shell
    <with|font-series|bold|pwd> command).
  </description>

  <\description>
    <item*|quit><label|index-49>Exits the interpreter.
  </description>

  <\description>
    <item*|run [-g\|script]><label|index-50>When invoked without arguments or
    with the <verbatim|-g> option, <verbatim|run> does a ``cold'' restart of
    the interpreter, with the scripts and options given on the interpreter's
    original command line. If just <verbatim|-g> is specified as the
    argument, the interpreter is run with debugging enabled. Otherwise the
    interpreter is invoked without debugging support. (This overrides the
    corresponding option from the interpreter's command line.) This command
    provides a quick way to rerun the interpreter after changes in some of
    the loaded script files, or if you want to enable or disable debugging on
    the fly (which requires a restart of the interpreter). You'll also loose
    any definitions that you entered interactively in the interpreter, so you
    may want to back them up with <verbatim|dump> beforehand.

    When invoked with a script name as argument, <verbatim|run> loads the
    given script file and adds its definitions to the current environment.
    This works more or less like a <hlink|<with|font-family|tt|using>|#using>
    clause, but only searches for the script in the current directory and
    places the definitions in the script at the current temporary level, so
    that <verbatim|clear> can be used to remove them again. Also note that
    namespace and pragma settings of scripts loaded with <verbatim|run> stick
    around after loading the script. This allows you to quickly set up your
    environment by just running a script containing the necessary namespace
    declarations and compiler directives. (Alternatively, you can also use
    the interpreter's startup files for that purpose, see <hlink|Interactive
    Startup|#interactive-startup> below.)
  </description>

  <\description>
    <item*|save><label|index-51>Begin a new level of temporary definitions. A
    subsequent <verbatim|clear> command (see above) will purge the
    definitions made since the most recent <verbatim|save> command. See
    <hlink|Definition Levels|#definition-levels> below for details.
  </description>

  <\description>
    <item*|show [option ...] [symbol ...]><label|index-52>Show the
    definitions of symbols in various formats. See <hlink|The show
    Command|#the-show-command> below for details. All symbols must be
    specified in fully qualified form, see the remarks below. A description
    of the common options accepted by the <verbatim|clear>, <verbatim|dump>
    and <verbatim|show> commands can be found in <hlink|Specifying Symbol
    Selections|#specifying-symbol-selections> below.
  </description>

  <\description>
    <item*|stats [-m] [on\|off]><label|index-53>Enables (default) or disables
    ``stats'' mode, in which some statistics are printed after an expression
    has been evaluated. Invoking just <verbatim|stats> or <verbatim|stats>
    <verbatim|on> only prints the cpu time in seconds for each evaluation. If
    the <verbatim|-m> option is specified, memory usage is printed along with
    the cpu time, which indicates the maximum amount of expression memory (in
    terms of expression cells) used during the computation. Invoking
    <verbatim|stats> <verbatim|off> disables stats mode, while
    <verbatim|stats> <verbatim|-m> <verbatim|off> just disables the printing
    of the memory usage statistics.
  </description>

  <\description>
    <item*|trace [-a] [-m] [-r] [-s] [symbol ...]><label|index-54>Sets
    tracepoints on the given function or operator symbols. Without the
    <verbatim|-m> option, this works pretty much like the <verbatim|break>
    command (see above) but only prints rule invocations and reductions
    without actually interrupting the evaluation; see
    <hlink|Debugging|#debugging> below for details.

    The <verbatim|-m> option allows you to trace macro (rather than function)
    calls. If this option is specified, the compiler prints reduction
    sequences involving the given macro symbol, which is useful when
    debugging macros; see the <hlink|Macros|#macros> section for details and
    examples. Note that macro tracing works even if the interpreter was
    invoked without debugging mode.

    If the <verbatim|-a> option is specified, tracepoints are set on <em|all>
    global function or macro symbols, respectively (in this case the symbol
    arguments are ignored). This is convenient if you want to see any and all
    reductions performed in a computation.

    Tracing can actually be performed in two different modes, <em|recursive>
    mode in which the trace is triggered by any of the active tracepoints and
    continues until the corresponding call is finished, or <em|skip> mode in
    which <em|only> calls by the active tracepoints are reported. The former
    is usually more helpful and is the default. The <verbatim|-s> option
    allows you to switch to skip mode, while the <verbatim|-r> option
    switches back to recursive mode.

    Finally, if neither symbols nor any of the <verbatim|-a>, <verbatim|-r>
    and <verbatim|-s> options are specified then the currently defined
    tracepoints are printed. Note that, as with the <verbatim|break> command,
    existing tracepoints can be deleted with the <verbatim|del> command (see
    above).
  </description>

  <\description>
    <item*|underride><label|index-55>Exits ``override'' mode. This returns
    you to the normal mode of operation, where new equations are added
    ``below'' previous rules of an existing function. See <hlink|Definition
    Levels|#definition-levels> below for details.
  </description>

  Commands that accept options generally also understand the <verbatim|-h>
  (help) option which prints a brief summary of the command syntax and the
  available options.

  Note that symbols (identifiers, operators etc.) must always be specified in
  fully qualified form. No form of namespace lookup is performed by commands
  like <verbatim|break>, <verbatim|clear>, <verbatim|show> etc. Thus the
  specified symbols always work the same no matter what <verbatim|namespace>
  and <verbatim|using> <verbatim|namespace> declarations are currently in
  effect.

  Besides the commands listed above, the interpreter also provides some
  special commands for the benefit of other programs such as
  <with|font-series|bold|emacs> driving the interpreter; currently these are
  <verbatim|completion_matches>, <verbatim|help_matches> and
  <verbatim|help_index>. These aren't supposed to be invoked directly by the
  user, although they may sometimes be useful to implement custom
  functionality, see <hlink|User-Defined Commands|#user-defined-commands>.

  <subsubsection|Specifying Symbol Selections<label|specifying-symbol-selections>>

  The <verbatim|clear>, <verbatim|dump> and <verbatim|show> commands all
  accept the following options for specifying a subset of symbols and
  definitions on which to operate. All symbols must be specified in fully
  qualified form. Options may be combined, thus, e.g., <verbatim|show>
  <verbatim|-mft> is the same as <verbatim|show> <verbatim|-m> <verbatim|-f>
  <verbatim|-t>. Some options specify optional numeric parameters; these must
  follow immediately behind the option character if present, as in
  <verbatim|-t0>.

  -c Select defined constants.

  -f Select defined functions.

  -g Indicates that the following symbols are actually shell glob patterns
  and that all matching symbols should be selected.

  -m Select defined macros.

  -pflag Select only private symbols if <em|flag> is nonzero (the default),
  otherwise (<em|flag> is zero) select only public symbols. If this option is
  omitted then both private and public symbols are selected.

  -tlevel Select symbols and definitions at the given ``level'' of
  definitions and above. This is described in more detail below. Briefly, the
  executing program and all imported modules (including the prelude) are at
  level 0, while ``temporary'' definitions made interactively in the
  interpreter are at level 1 and above. Thus a level of 1 restricts the
  selection to all temporary definitions, whereas 0 indicates all definitions
  (i.e., everything, including the prelude). If <em|level> is omitted, it
  defaults to the current definitions level.

  -v Select defined variables.

  -y Select defined types. In addition, the <verbatim|-h> option prints a
  short help message describing all available options of the command at hand.

  If none of the <verbatim|-c>, <verbatim|-f>, <verbatim|-m>, <verbatim|-v>
  and <verbatim|-y> options are specified, then all kinds of symbols
  (constants, functions, macros, variables and types) are selected, otherwise
  only the specified categories will be considered.

  A reasonable default is used if the <verbatim|-t> option is omitted. By
  default, if no symbols are specified, only temporary definitions are
  considered, which corresponds to <verbatim|-t1>. Otherwise the command
  applies to all corresponding definitions, no matter whether they belong to
  the executing program, the prelude, or some temporary level, which has the
  same effect as <verbatim|-t0>. This default choice can be overridden by
  specifying the desired level explicitly.

  As a special case, just <verbatim|clear> (without any other options or
  symbol arguments) always backs out to the previous definitions level
  (instead of level #1). This is inconsistent with the rules set out above,
  but is implemented this way for convenience and backward compatibility.
  Thus, if you really want to delete all your temporary definitions, use
  <verbatim|clear> <verbatim|-t1> instead. When used in this way, the
  <verbatim|clear> command will only remove temporary definitions; if you
  need to remove definitions at level #0, you must specify those symbols
  explicitly.

  Note that <verbatim|clear> <verbatim|-g> <verbatim|*> will have pretty much
  the same disastrous consequences as the Unix command <verbatim|rm>
  <verbatim|-rf> <verbatim|*>, so don't do that. Also note that a macro or
  function symbol may well have defining equations at different levels, in
  which case a command like <verbatim|clear> <verbatim|-tn> <verbatim|foo>
  might only affect some part of <verbatim|foo>`s definition. The
  <verbatim|dump> and <verbatim|show> commands work analogously (albeit less
  destructively). See <hlink|Definition Levels|#definition-levels> below for
  some examples.

  <subsubsection|The show Command<label|the-show-command>>

  The <verbatim|show> command can be used to obtain information about defined
  symbols in various formats. Besides the common selection options discussed
  above, this command recognizes the following additional options for
  specifying the content to be listed and the format to use.

  -a Disassembles pattern matching automata. Works like the <verbatim|-v4>
  option of the interpreter.

  -d Disassembles LLVM IR, showing the generated LLVM assembler code of a
  function. Works like the <verbatim|-v8> option of the interpreter.

  -e Annotate printed definitions with lexical environment information (de
  Bruijn indices, subterm paths). Works like the <verbatim|-v2> option of the
  interpreter.

  -l Long format, prints definitions along with the summary symbol
  information. This implies <verbatim|-s>.

  -s Summary format, print just summary information about listed symbols.
  Symbols are always listed in lexicographic order. Note that some of the
  options (in particular, <verbatim|-a> and <verbatim|-d>) may produce
  excessive amounts of information. By setting
  the<label|index-56><hlink|<with|font-family|tt|PURE_MORE>|#envvar-PURE-MORE>
  environment variable, you can specify a shell command to be used for
  paging, usually <with|font-series|bold|more> or
  <with|font-series|bold|less>.

  For instance, to list all temporary definitions made in an interactive
  session, simply say:

  <\verbatim>
    \<gtr\> show
  </verbatim>

  You can also list a specific symbol, no matter whether it comes from the
  interactive command line, the executing script or the prelude:

  <\verbatim>
    \<gtr\> show foldl

    foldl f a x::matrix = foldl f a (list x);

    foldl f a s::string = foldl f a (chars s);

    foldl f a [] = a;

    foldl f a (x:xs) = foldl f (f a x) xs;
  </verbatim>

  Wildcards can be used with the <verbatim|-g> option, which is useful if you
  want to print an entire family of related functions, e.g.:

  <\verbatim>
    \<gtr\> show -g foldl*

    foldl f a x::matrix = foldl f a (list x);

    foldl f a s::string = foldl f a (chars s);

    foldl f a [] = a;

    foldl f a (x:xs) = foldl f (f a x) xs;

    foldl1 f x::matrix = foldl1 f (list x);

    foldl1 f s::string = foldl1 f (chars s);

    foldl1 f (x:xs) = foldl f x xs;
  </verbatim>

  Or you can just specify multiple symbols as follows (this also works with
  multiple glob patterns when you add the <verbatim|-g> option):

  <\verbatim>
    \<gtr\> show min max

    max x y = if x\<gtr\>=y then x else y;

    min x y = if x\<less\>=y then x else y;
  </verbatim>

  You can also select symbols by category. E.g., the following command shows
  summary information about all the variable symbols along with their current
  values (using the ``long'' format):

  <\verbatim>
    \<gtr\> show -lvg *

    argc \ \ \ \ \ \ var \ argc = 0;

    argv \ \ \ \ \ \ var \ argv = [];

    compiling \ var \ compiling = 0;

    sysinfo \ \ \ var \ sysinfo = "x86_64-unknown-linux-gnu";

    version \ \ \ var \ version = "0.63";

    5 variables
  </verbatim>

  Or you can list just private symbols of the namespace <verbatim|foo>, as
  follows:

  <\verbatim>
    \<gtr\> show -pg foo::*
  </verbatim>

  The following command will list each and every symbol that's currently
  defined (instead of <verbatim|-g> <verbatim|*> you can also use the
  <verbatim|-t0> option):

  <\verbatim>
    \<gtr\> show -g *
  </verbatim>

  This usually produces a lot of output and is rarely needed, unless you'd
  like to browse through an entire program including all library imports. (In
  that case you might consider to use the <verbatim|dump> command instead,
  which writes the definitions to a file which can then be loaded into a text
  editor for easier viewing. This may occasionally be useful for debugging
  purposes.)

  The <verbatim|show> command also has the following alternate forms which
  are used for special purposes:

  <\itemize>
    <item><verbatim|show> <verbatim|interface> lists the actual
    <hlink|<with|font-family|tt|type>|#type> rules for an interface type.
    This is useful if you want to verify which patterns will be matched by an
    interface type, see <hlink|Interface Types|#interface-types> for details.
    For instance:

    <\verbatim>
      \<gtr\> interface stack with

      \<gtr\> \ \ push xs::stack x;

      \<gtr\> \ \ pop xs::stack;

      \<gtr\> \ \ top xs::stack;

      \<gtr\> end;

      \<gtr\> push xs@[] x \|

      \<gtr\> push xs@(_:_) x = x:xs;

      \<gtr\> pop (x:xs) = xs;

      \<gtr\> top (x:xs) = x;

      \<gtr\> show interface stack

      type stack xs@(_:_);

      \<gtr\> pop [] = throw "empty stack";

      \<gtr\> top [] = throw "empty stack";

      \<gtr\> show interface stack

      type stack xs@[];

      type stack xs@(_:_);
    </verbatim>

    <item><verbatim|show> <verbatim|namespace> lists the current and search
    namespaces, while <verbatim|show> <verbatim|namespaces> lists all
    declared namespaces. These come in handy if you have forgotten what
    namespaces are currently active and which other namespaces are available
    in your program. For instance:

    <\verbatim>
      \<gtr\> show namespace

      \<gtr\> show namespaces

      namespace C;

      namespace matrix;

      \<gtr\> using namespace C;

      \<gtr\> namespace my;

      \<gtr\> show namespace

      namespace my;

      using namespace C;
    </verbatim>
  </itemize>

  <subsubsection|Definition Levels<label|definition-levels>>

  To help with incremental development, the interpreter offers some commands
  to manipulate the current set of definitions interactively. To these ends,
  definitions are organized into different subsets called
  <with|font-series|bold|levels>. As already mentioned, the prelude, as well
  as other source programs specified when invoking the interpreter, are
  always at level 0, while the interactive environment starts at level 1.
  Each <verbatim|save> command introduces a new temporary level, and each
  subsequent <verbatim|clear> command (without any arguments) ``pops'' the
  definitions on the current level and returns you to the previous one (if
  any). This gives you a ``stack'' of temporary environments which enables
  you to ``plug and play'' in a (more or less) safe fashion, without
  affecting the rest of your program.

  For all practical purposes, this stack is unlimited, so that you can create
  as many levels as you like. However, this facility also has its
  limitations. The interpreter doesn't really keep a full history of
  everything you entered interactively, it only records the level a variable,
  constant, and function or macro rule belongs to so that the corresponding
  definitions can be removed again when the level is popped. On the other
  hand, intermediate changes in variable values are not recorded anywhere and
  cannot be undone. Moreover, global declarations (which encompasses
  <hlink|<with|font-family|tt|using>|#using> clauses,
  <hlink|<with|font-family|tt|extern>|#extern> declarations and special
  symbol declarations) always apply to all levels, so they can't be undone
  either.

  That said, the temporary levels can still be pretty useful when you're
  playing around with the interpreter. Here's a little example which shows
  how to use <verbatim|clear> to quickly get rid of a definition that you
  entered interactively:

  <\verbatim>
    \<gtr\> foo (x:xs) = x+foo xs;

    \<gtr\> foo [] = 0;

    \<gtr\> show

    foo (x:xs) = x+foo xs;

    foo [] = 0;

    \<gtr\> foo (1..10);

    55

    \<gtr\> clear

    This will clear all temporary definitions at level #1.

    Continue (y/n)? y

    \<gtr\> show

    \<gtr\> foo (1..10);

    foo [1,2,3,4,5,6,7,8,9,10]
  </verbatim>

  We've seen already that normally, if you enter a sequence of equations,
  they will be recorded in the order in which they were written. However, it
  is also possible to override definitions in lower levels with the
  <verbatim|override> command:

  <\verbatim>
    \<gtr\> foo (x:xs) = x+foo xs;

    \<gtr\> foo [] = 0;

    \<gtr\> show

    foo (x:xs) = x+foo xs;

    foo [] = 0;

    \<gtr\> foo (1..10);

    55

    \<gtr\> save

    save: now at temporary definitions level #2

    \<gtr\> override

    \<gtr\> foo (x:xs) = x*foo xs;

    \<gtr\> show

    foo (x:xs) = x*foo xs;

    foo (x:xs) = x+foo xs;

    foo [] = 0;

    \<gtr\> foo (1..10);

    warning: rule never reduced: foo (x:xs) = x+foo xs;

    0
  </verbatim>

  Note that the equation <verbatim|foo> <verbatim|(x:xs)> <verbatim|=>
  <verbatim|x*foo> <verbatim|xs> was inserted before the previous rule
  <verbatim|foo> <verbatim|(x:xs)> <verbatim|=> <verbatim|x+foo>
  <verbatim|xs>, which is at level #1. (The latter equation is now
  ``shadowed'' by the rule we just entered, hence the compiler warns us that
  this rule can't be reduced any more.)

  Even in override mode, new definitions will be added after other
  definitions at the <em|current> level. This allows us to just continue
  adding more high-priority definitions overriding lower-priority ones:

  <\verbatim>
    \<gtr\> foo [] = 1;

    \<gtr\> show

    foo (x:xs) = x*foo xs;

    foo [] = 1;

    foo (x:xs) = x+foo xs;

    foo [] = 0;

    \<gtr\> foo (1..10);

    warning: rule never reduced: foo (x:xs) = x+foo xs;

    warning: rule never reduced: foo [] = 0;

    3628800
  </verbatim>

  Again, the new equation was inserted above the existing lower-priority
  rules, but below our previous equation <verbatim|foo> <verbatim|(x:xs)>
  <verbatim|=> <verbatim|x*foo> <verbatim|xs> entered at the same level. As
  you can see, we have now effectively replaced our original definition of
  <verbatim|foo> with a version that calculates list products instead of
  sums, but of course we can easily go back one level to restore the previous
  definition:

  <\verbatim>
    \<gtr\> clear

    This will clear all temporary definitions at level #2.

    Continue (y/n)? y

    clear: now at temporary definitions level #1

    clear: override mode is on

    \<gtr\> show

    foo (x:xs) = x+foo xs;

    foo [] = 0;

    \<gtr\> foo (1..10);

    55
  </verbatim>

  Note that <verbatim|clear> reminded us that override mode is still enabled
  (<verbatim|save> will do the same if override mode is on while pushing a
  new definitions level). To turn it off again, use the <verbatim|underride>
  command. This will revert to the normal behaviour of adding new equations
  below existing ones:

  <\verbatim>
    \<gtr\> underride
  </verbatim>

  It's also possible to use <verbatim|clear> to back out multiple levels at
  once, if you specify the target level to be cleared with the -t option. For
  instance:

  <\verbatim>
    \<gtr\> save

    save: now at temporary definitions level #2

    \<gtr\> let bar = 99;

    \<gtr\> show

    let bar = 99;

    foo (x:xs) = x+foo xs;

    foo [] = 0;

    \<gtr\> // this scraps all our scribblings!

    \<gtr\> clear -t1

    This will clear all temporary definitions at level #1 and above.

    Continue (y/n)? y

    clear: now at temporary definitions level #1

    \<gtr\> show

    \<gtr\>
  </verbatim>

  The facilities described above are also available to Pure programs, as the
  <verbatim|save> and <verbatim|clear> commands can also be executed under
  program control using the <hlink|<with|font-family|tt|evalcmd>|purelib.tm#evalcmd>
  primitive. Conversely, the library provides its own functions for
  inspecting and manipulating the source program, which may also be useful in
  custom command definitions; see the <hlink|<em|Pure Library
  Manual>|purelib.tm> for details.

  <subsubsection|Debugging<label|debugging>>

  The interpreter provides a simple but reasonably convenient symbolic
  debugging facility when running interactively. To make this work, you have
  to specify the <hlink|<em|-g>|#cmdoption-pure-g> option when invoking the
  interpreter (<verbatim|pure> <verbatim|-g>). If you're already at the
  interpreter's command line, you can also use the <verbatim|run>
  <verbatim|-g> command to enable the debugger. The <verbatim|-g> option
  disables tail call optimization (see <hlink|Stack Size and Tail
  Recursion|#stack-size-and-tail-recursion>) to make it easier to debug
  programs. It also causes special debugging code to be generated which will
  make your program run <em|much> slower. Therefore the
  <hlink|<em|-g>|#cmdoption-pure-g> option should only be used if you
  actually need the debugger.

  One common use of the debugger is ``post mortem'' debugging after an
  evaluation ended with an unhandled exception. In such a case, the
  <verbatim|bt> command of the interpreter prints a backtrace of the call
  sequence which caused the exception. Note that this only works if debugging
  mode was enabled. For instance:

  <\verbatim>
    \<gtr\> [1,2]!3;

    \<less\>stdin\<gtr\>, line 2: unhandled exception 'out_of_bounds' while
    evaluating '[1,2]!3'

    \<gtr\> bt

    \ \ \ [1] (!): (x:xs)!n::int = xs!(n-1) if n\<gtr\>0;

    \ \ \ \ \ n = 3; x = 1; xs = [2]

    \ \ \ [2] (!): (x:xs)!n::int = xs!(n-1) if n\<gtr\>0;

    \ \ \ \ \ n = 2; x = 2; xs = []

    \ \ \ [3] (!): []!n::int = throw out_of_bounds;

    \ \ \ \ \ n = 1

    \<gtr\>\<gtr\> [4] throw: extern void pure_throw(expr*) = throw;

    \ \ \ \ \ x1 = out_of_bounds
  </verbatim>

  The last call, which is also marked with the <verbatim|\>\>> symbol, is the
  call that raised the exception. The format is similar to the <verbatim|p>
  command of the debugger, see below, but <verbatim|bt> always prints a full
  backtrace. (As with the <verbatim|show> command of the interpreter, you can
  set the<label|index-57><hlink|<with|font-family|tt|PURE_MORE>|#envvar-PURE-MORE>
  environment variable to pipe the output through the corresponding command,
  or use <hlink|<with|font-family|tt|evalcmd>|purelib.tm#evalcmd> to capture
  the output of <verbatim|bt> in a string.)

  The debugger can also be used interactively. To these ends, you can set
  breakpoints on functions with the <verbatim|break> command. The debugger
  then gets invoked as soon as a rule for one of the given functions is
  executed. Example:

  <\verbatim>
    \<gtr\> fact n::int = if n\<gtr\>0 then n*fact (n-1) else 1;

    \<gtr\> break fact

    \<gtr\> fact 1;

    ** [1] fact: fact n::int = if n\<gtr\>0 then n*fact (n-1) else 1;

    \ \ \ \ \ n = 1

    (Type 'h' for help.)

    :

    ** [2] fact: fact n::int = if n\<gtr\>0 then n*fact (n-1) else 1;

    \ \ \ \ \ n = 0

    :

    ++ [2] fact: fact n::int = if n\<gtr\>0 then n*fact (n-1) else 1;

    \ \ \ \ \ n = 0

    \ \ \ \ \ --\<gtr\> 1

    ** [2] (*): x::int*y::int = x*y;

    \ \ \ \ \ x = 1; y = 1

    :

    ++ [2] (*): x::int*y::int = x*y;

    \ \ \ \ \ x = 1; y = 1

    \ \ \ \ \ --\<gtr\> 1

    ++ [1] fact: fact n::int = if n\<gtr\>0 then n*fact (n-1) else 1;

    \ \ \ \ \ n = 1

    \ \ \ \ \ --\<gtr\> 1

    1
  </verbatim>

  Lines beginning with <verbatim|**> indicate that the evaluation was
  interrupted to show the rule (or external) which is currently being
  considered, along with the current depth of the call stack, the invoked
  function and the values of parameters and other local variables in the
  current lexical environment. In contrast, the prefix <verbatim|++> denotes
  reductions which were actually performed during the evaluation and the
  results that were returned by the function call (printed as <verbatim|--\>>
  <verbatim|return> <verbatim|value>).

  Sometimes you might also see funny symbols like <verbatim|#\<closure\>>,
  <verbatim|#\<case\>> or <verbatim|#\<when\>> instead of the function name.
  These indicate lambdas and the special variable-binding environments, which
  are all implemented as anonymous closures in Pure. Also note that the
  debugger doesn't know about the argument names of external functions (which
  are optional in Pure and not recorded anywhere), so it will display the
  generic names <verbatim|x1>, <verbatim|x2> etc. instead.

  At the debugger prompt `<verbatim|:>` you can enter various special
  debugger commands, or just keep on hitting the carriage return key to walk
  through an evaluation step by step, as we did in the example above.
  (Command line editing works as usual at the debugger prompt, if it is
  enabled.) The usual commands are provided to walk through an evaluation,
  print and navigate the call stack, step over the current call, or continue
  the evaluation unattended until you hit another breakpoint. If you know
  other source level debuggers like <with|font-series|bold|gdb> then you
  should feel right at home. You can type <verbatim|h> at the debugger prompt
  to print the following list:

  <\verbatim>
    : h

    Debugger commands:

    a \ \ \ \ \ \ auto: step through the entire program, run unattended

    c [f] \ \ continue until next breakpoint, or given function f

    h \ \ \ \ \ \ help: print this list

    n \ \ \ \ \ \ next step: step over reduction

    p [n] \ \ print rule stack (n = number of frames)

    r \ \ \ \ \ \ run: finish evaluation without debugger

    s \ \ \ \ \ \ single step: step into reduction

    t, b \ \ \ move to the top or bottom of the rule stack

    u, d \ \ \ move up or down one level in the rule stack

    x \ \ \ \ \ \ exit the interpreter (after confirmation)

    . \ \ \ \ \ \ reprint current rule

    ! cmd \ \ execute interpreter command

    ? expr \ evaluate expression

    \<less\>cr\<gtr\> \ \ \ single step (same as 's')

    \<less\>eof\<gtr\> \ \ step through program, run unattended (same as 'a')
  </verbatim>

  <with|font-series|bold|Note:> If you specified an
  <hlink|<em|--escape>|#cmdoption-pure--escape> prefix other than
  `<verbatim|!>` (cf. <hlink|Command Syntax|#command-syntax>), that prefix
  will be used to execute interpreter commands instead, see below. The help
  message will tell you which command prefix is in effect.

  The command syntax is very simple. Besides the commands listed above you
  can also enter comment lines (<verbatim|//> <verbatim|comment>
  <verbatim|text>) which will just be ignored. Extra arguments on commands
  which don't expect any will generally be ignored as well. The single letter
  commands all have to be separated from any additional parameters with
  whitespace, whereas the `<verbatim|!>`, `<verbatim|?>` and `<verbatim|.>`
  commands count as word delimiters and can thus be followed immediately by
  an argument. For convenience, the `<verbatim|?>` command can also be
  omitted if the expression to be evaluated doesn't start with a single
  letter or one of the special punctuation commands.

  The debugger can be exited or suspended in the following ways:

  <\itemize>
    <item>You can type <verbatim|c> to continue the evaluation until the next
    breakpoint, or <verbatim|c> <verbatim|foo> in order to proceed until the
    debugger hits an invocation of the function <verbatim|foo>.

    <item>You can type <verbatim|r> to run the rest of the evaluation without
    the debugger.

    <item>The <verbatim|a> (``auto'') command single-steps through the rest
    of the evaluation, running unattended. This command can also be entered
    by just hitting the end-of-file key (<verbatim|Ctrl-d> on Unix systems)
    at the debugger prompt.

    <item>You can also type <verbatim|x> to exit from the debugger <em|and>
    the interpreter immediately (after confirmation).
  </itemize>

  In addition, you can use the <verbatim|!> command (or whatever command
  prefix has been set with the <hlink|<em|--escape>|#cmdoption-pure--escape>
  option) to run any interpreter command while in the debugger. For instance:

  <\verbatim>
    : !ls
  </verbatim>

  This is particularly useful to invoke the <verbatim|break> and
  <verbatim|del> commands to change breakpoints. Note that you can actually
  escape any valid input to the interpreter that way, not just the special
  interactive commands. However, you shouldn't try to modify the program
  while you're debugging it. This may work in some cases, but will have nasty
  consequences if you happen to change a function which is currently being
  executed.

  The interpreter's shell escape can also be used from the debugger. In
  default mode or when using <verbatim|!> as the
  <hlink|<em|--escape>|#cmdoption-pure--escape> prefix, you'll have to escape
  shell commands with <verbatim|!!>, otherwise a single <verbatim|!>
  suffices.

  At the debugger prompt, you can use the <verbatim|u> (``up''), <verbatim|d>
  (``down''), <verbatim|t> (``top'') and <verbatim|b> (``bottom'') commands
  to move around on the current call stack. The <verbatim|p> command prints a
  range of the call stack centered around the currently selected stack frame,
  which is indicated with the <verbatim|\>\>> tag, whereas <verbatim|**>
  denotes the current bottom of the stack (which is the rule to be executed
  with the single step command). The <verbatim|p> command can also be
  followed by a numeric argument which indicates the number of stack frames
  to be printed (this will then become the default for subsequent invocations
  of <verbatim|p>). The <verbatim|n> command steps over the call selected
  with the stack navigation commands. For instance:

  <\verbatim>
    \<gtr\> fact 3;

    ** [1] fact: fact n::int = if n\<gtr\>0 then n*fact (n-1) else 1;

    \ \ \ \ \ n = 3

    : c *

    ** [4] (*): x::int*y::int = x*y;

    \ \ \ \ \ x = 1; y = 1

    : p

    \ \ \ [1] fact: fact n::int = if n\<gtr\>0 then n*fact (n-1) else 1;

    \ \ \ \ \ n = 3

    \ \ \ [2] fact: fact n::int = if n\<gtr\>0 then n*fact (n-1) else 1;

    \ \ \ \ \ n = 2

    \ \ \ [3] fact: fact n::int = if n\<gtr\>0 then n*fact (n-1) else 1;

    \ \ \ \ \ n = 1

    ** [4] (*): x::int*y::int = x*y;

    \ \ \ \ \ x = 1; y = 1

    : u

    \<gtr\>\<gtr\> [3] fact: fact n::int = if n\<gtr\>0 then n*fact (n-1)
    else 1;

    \ \ \ \ \ n = 1

    : u

    \<gtr\>\<gtr\> [2] fact: fact n::int = if n\<gtr\>0 then n*fact (n-1)
    else 1;

    \ \ \ \ \ n = 2

    : p

    \ \ \ [1] fact: fact n::int = if n\<gtr\>0 then n*fact (n-1) else 1;

    \ \ \ \ \ n = 3

    \<gtr\>\<gtr\> [2] fact: fact n::int = if n\<gtr\>0 then n*fact (n-1)
    else 1;

    \ \ \ \ \ n = 2

    \ \ \ [3] fact: fact n::int = if n\<gtr\>0 then n*fact (n-1) else 1;

    \ \ \ \ \ n = 1

    ** [4] (*): x::int*y::int = x*y;

    \ \ \ \ \ x = 1; y = 1

    : n

    ++ [2] fact: fact n::int = if n\<gtr\>0 then n*fact (n-1) else 1;

    \ \ \ \ \ n = 2

    \ \ \ \ \ --\<gtr\> 2

    ** [2] (*): x::int*y::int = x*y;

    \ \ \ \ \ x = 3; y = 2

    :
  </verbatim>

  If you ever get lost, you can reprint the current rule with the
  `<verbatim|.>` command:

  <\verbatim>
    : .

    ** [2] (*): x::int*y::int = x*y;

    \ \ \ \ \ x = 3; y = 2
  </verbatim>

  Another useful feature is the <verbatim|?> command which lets you evaluate
  any Pure expression, with the local variables of the current rule bound to
  their corresponding values. Like the <verbatim|n> command, <verbatim|?>
  applies to the current stack frame as selected with the stack navigation
  commands. The expression must be entered on a single line, and the trailing
  semicolon is optional. For instance:

  <\verbatim>
    \<gtr\> fact 3;

    ** [1] fact: fact n::int = if n\<gtr\>0 then n*fact (n-1) else 1;

    \ \ \ \ \ n = 3

    : c *

    ** [4] (*): x::int*y::int = x*y;

    \ \ \ \ \ x = 1; y = 1

    : ?x+y

    2

    : u

    \<gtr\>\<gtr\> [3] fact: fact n::int = if n\<gtr\>0 then n*fact (n-1)
    else 1;

    \ \ \ \ \ n = 1

    : n\<gtr\>0, fact n

    1,1
  </verbatim>

  A third use of the debugger is to trace function calls. For that the
  interpreter provides the <verbatim|trace> command which works similarly to
  <verbatim|break>, but sets so-called ``tracepoints'' which only print rule
  invocations and reductions instead of actually interrupting the evaluation.
  For instance, assuming the same example as above, let's first remove the
  breakpoint on <verbatim|fact> (using the <verbatim|del> command) and then
  set it as a tracepoint instead:

  <\verbatim>
    \<gtr\> del fact

    \<gtr\> trace fact

    \<gtr\> fact 1;

    ** [1] fact: fact n::int = if n\<gtr\>0 then n*fact (n-1) else 1;

    \ \ \ \ \ n = 1

    ** [2] fact: fact n::int = if n\<gtr\>0 then n*fact (n-1) else 1;

    \ \ \ \ \ n = 0

    ++ [2] fact: fact n::int = if n\<gtr\>0 then n*fact (n-1) else 1;

    \ \ \ \ \ n = 0

    \ \ \ \ \ --\<gtr\> 1

    ** [2] (*): x::int*y::int = x*y;

    \ \ \ \ \ x = 1; y = 1

    ++ [2] (*): x::int*y::int = x*y;

    \ \ \ \ \ x = 1; y = 1

    \ \ \ \ \ --\<gtr\> 1

    ++ [1] fact: fact n::int = if n\<gtr\>0 then n*fact (n-1) else 1;

    \ \ \ \ \ n = 1

    \ \ \ \ \ --\<gtr\> 1

    1
  </verbatim>

  The <verbatim|break> and <verbatim|trace> commands can also be used in
  concert if you want to debug some functions while only tracing others.

  Note that the <verbatim|trace> command can actually be run in two different
  modes: <em|recursive> mode in which the trace is triggered by any of the
  active tracepoints and continues until the corresponding call is finished,
  or <em|skip> mode in which <em|only> calls by the active tracepoints are
  reported. The former is the default and is often preferable, because it
  gives you a complete transcript of the reductions performed during a
  function call.

  If you don't need that much detail, you can also switch to skip mode by
  invoking the <verbatim|trace> command with the <verbatim|-s> option. This
  allows you to see a quick summary of the computation which only shows
  reductions by rules directly involving the active tracepoints. For
  instance:

  <\verbatim>
    \<gtr\> trace -s

    \<gtr\> fact 1;

    ** [1] fact: fact n::int = if n\<gtr\>0 then n*fact (n-1) else 1;

    \ \ \ \ \ n = 1

    ** [2] fact: fact n::int = if n\<gtr\>0 then n*fact (n-1) else 1;

    \ \ \ \ \ n = 0

    ++ [2] fact: fact n::int = if n\<gtr\>0 then n*fact (n-1) else 1;

    \ \ \ \ \ n = 0

    \ \ \ \ \ --\<gtr\> 1

    ++ [1] fact: fact n::int = if n\<gtr\>0 then n*fact (n-1) else 1;

    \ \ \ \ \ n = 1

    \ \ \ \ \ --\<gtr\> 1

    1
  </verbatim>

  Moreover, the <verbatim|trace> command can also be invoked with the
  <verbatim|-a> option to trace all function calls, which is convenient to
  quickly obtain a full transcript of a reduction sequence. The same options
  also work in an analogous fashion with macro calls, see the
  <hlink|Macros|#macros> section for some examples.

  The current sets of breakpoints and tracepoints can be changed with the
  <verbatim|break>, <verbatim|trace> and <verbatim|del> commands, as shown
  above, and just <verbatim|break> or <verbatim|trace> without any arguments
  lists the currently defined breakpoints or tracepoints, respectively.
  Please see <hlink|Interactive Commands|#interactive-commands> above for
  details. Also note that these are really interpreter commands, so to invoke
  them in the debugger you have to escape them with the <verbatim|!> command
  (or whatever other <hlink|<em|--escape>|#cmdoption-pure--escape> prefix you
  specified).

  The debugger can also be triggered programmatically with the built-in
  parameter-less functions <hlink|<with|font-family|tt|__break__>|purelib.tm#--break-->
  and <hlink|<with|font-family|tt|__trace__>|purelib.tm#--trace-->. This
  gives you much better control over the precise location and the conditions
  under which the debugger should be invoked. Just place a call to
  <hlink|<with|font-family|tt|__break__>|purelib.tm#--break--> or
  <hlink|<with|font-family|tt|__trace__>|purelib.tm#--trace--> near the point
  where you'd like to start debugging or tracing; this can be done either
  with the sequencing operator `<hlink|<with|font-family|tt|$$>|#-dollar-dollar>`
  or with a <hlink|<with|font-family|tt|when>|#when> clause. The debugger
  will then be invoked at the next opportunity (usually when a function is
  called or a reduction is completed). For instance:

  <\verbatim>
    \<gtr\> fact n::int = if n\<gtr\>0 then __break__ $$ n*fact (n-1) else 1;

    \<gtr\> fact 10;

    ++ [2] __break__: extern void pure_break() = __break__;

    \ \ \ \ \ --\<gtr\> ()

    ** [2] fact: fact n::int = if n\<gtr\>0 then __break__$$n*fact (n-1) else
    1;

    \ \ \ \ \ n = 9

    :
  </verbatim>

  Here the debugger is invoked right after the call to
  <hlink|<with|font-family|tt|__break__>|purelib.tm#--break-->, when the
  <verbatim|n*fact> <verbatim|(n-1)> expression in the
  <hlink|<with|font-family|tt|then>|#then> branch is about to be evaluated.
  The debugger thus stops at the recursive invocation of <verbatim|fact>
  <verbatim|9>. Tracing works in a similar fashion, using
  <hlink|<with|font-family|tt|__trace__>|purelib.tm#--trace--> in lieu of
  <hlink|<with|font-family|tt|__break__>|purelib.tm#--break-->, and continues
  until the current stack frame is exited. One major advantage of this method
  is that it is possible to invoke <hlink|<with|font-family|tt|__break__>|purelib.tm#--break-->
  or <hlink|<with|font-family|tt|__trace__>|purelib.tm#--trace--> only under
  certain conditions, so that you can focus on interesting ``events'' during
  evaluation, which can make debugging much less tedious. In our example, in
  order to stop when <verbatim|n> becomes <verbatim|1>, we might invoke
  <hlink|<with|font-family|tt|__break__>|purelib.tm#--break--> as follows:

  <\verbatim>
    \<gtr\> fact n::int = if n\<gtr\>0 then n\<gtr\>1\|\|__break__ $$ n*fact
    (n-1) else 1;

    \<gtr\> fact 3;

    ++ [4] __break__: extern void pure_break() = __break__;

    \ \ \ \ \ --\<gtr\> ()

    ** [4] fact: fact n::int = if n\<gtr\>0 then
    n\<gtr\>1\|\|__break__$$n*fact (n-1) else 1;

    \ \ \ \ \ n = 0

    : p

    \ \ \ [1] fact: fact n::int = if n\<gtr\>0 then
    n\<gtr\>1\|\|__break__$$n*fact (n-1) else 1;

    \ \ \ \ \ n = 3

    \ \ \ [2] fact: fact n::int = if n\<gtr\>0 then
    n\<gtr\>1\|\|__break__$$n*fact (n-1) else 1;

    \ \ \ \ \ n = 2

    \ \ \ [3] fact: fact n::int = if n\<gtr\>0 then
    n\<gtr\>1\|\|__break__$$n*fact (n-1) else 1;

    \ \ \ \ \ n = 1

    ** [4] fact: fact n::int = if n\<gtr\>0 then
    n\<gtr\>1\|\|__break__$$n*fact (n-1) else 1;

    \ \ \ \ \ n = 0

    :
  </verbatim>

  <subsubsection|Last Result<label|last-result>>

  Another convenience for interactive usage is the
  <hlink|<with|font-family|tt|ans>|purelib.tm#ans> function, which retrieves
  the most recent result printed in interactive mode. For instance:

  <\verbatim>
    \<gtr\> fact n = if n\<less\>=1 then 1 else n*fact (n-1);

    \<gtr\> map fact (1..10);

    [1,2,6,24,120,720,5040,40320,362880,3628800]

    \<gtr\> scanl (+) 0 ans;

    [0,1,3,9,33,153,873,5913,46233,409113,4037913]
  </verbatim>

  Note that <hlink|<with|font-family|tt|ans>|purelib.tm#ans> is just an
  ordinary function, defined in the prelude, not a special command. However,
  there is a special <verbatim|clear> <verbatim|ans> command which purges the
  <verbatim|ans> value. This is useful, e.g., if you got a huge result which
  you want to erase from memory before starting the next computation.

  <\verbatim>
    \<gtr\> clear ans

    \<gtr\> ans;

    ans
  </verbatim>

  <subsubsection|Pretty-Printing<label|pretty-printing>>

  The interpreter provides the following ``hook'' to override the print
  representations of expressions. This works in a fashion similar to
  Haskell's <verbatim|show> function.

  <\description>
    <item*|__show__ x<label|--show-->>The programmer may define this function
    to supply custom print representations for certain expressions.
  </description>

  <hlink|<with|font-family|tt|__show__>|#--show--> is just an ordinary Pure
  function expected to return a string with the desired custom representation
  of a normal form value given as the function's single argument. The
  interpreter prints the strings returned by
  <hlink|<with|font-family|tt|__show__>|#--show--> just as they are. It will
  not check whether they conform to Pure syntax and/or semantics, or modify
  them in any way. Also, the library doesn't define this function anywhere,
  so you are free to add any rules that you want.

  Custom print representations are most useful for interactive purposes, if
  you're not happy with the default print syntax of some kinds of objects.
  One particularly useful application of <hlink|<with|font-family|tt|__show__>|#--show-->
  is to change the format of numeric values. Here are some examples:

  <\verbatim>
    \<gtr\> using system;

    \<gtr\> __show__ x::double = sprintf "%0.6f" x;

    \<gtr\> 1/7;

    0.142857

    \<gtr\> __show__ x::int = sprintf "0x%0x" x;

    \<gtr\> 1786;

    0x6fa

    \<gtr\> using math;

    \<gtr\> __show__ (x::double +: y::double) = sprintf "%0.6f+%0.6fi" (x,y);

    \<gtr\> cis (-pi/2);

    0.000000+-1.000000i
  </verbatim>

  The prelude function <hlink|<with|font-family|tt|str>|purelib.tm#str>,
  which returns the print representation of any Pure expression, calls
  <hlink|<with|font-family|tt|__show__>|#--show--> as well:

  <\verbatim>
    \<gtr\> str (1/7);

    "0.142857"
  </verbatim>

  Conversely, you can call the <hlink|<with|font-family|tt|str>|purelib.tm#str>
  function from <hlink|<with|font-family|tt|__show__>|#--show-->, but in this
  case it always returns the default representation of an expression. This
  prevents the expression printer from going recursive, and allows you to
  define your custom representation in terms of the default one. E.g., the
  following rule removes the <verbatim|L> suffixes from bigint values:

  <\verbatim>
    \<gtr\> __show__ x::bigint = init (str x);

    \<gtr\> fact n = foldl (*) 1L (1..n);

    \<gtr\> fact 30;

    265252859812191058636308480000000
  </verbatim>

  Of course, your definition of <hlink|<with|font-family|tt|__show__>|#--show-->
  can also call <hlink|<with|font-family|tt|__show__>|#--show--> itself
  recursively to determine the custom representation of an object.

  One case which needs special consideration are thunks (futures). The
  printer will <em|never> use <hlink|<with|font-family|tt|__show__>|#--show-->
  for those, to prevent them from being forced inadvertently. In fact, you
  <em|can> use <hlink|<with|font-family|tt|__show__>|#--show--> to define
  custom representations for thunks, but only in the context of a rule for
  other kinds of objects, such as lists. For instance:

  <\verbatim>
    \<gtr\> nonfix ...;

    \<gtr\> __show__ (x:xs) = str (x:...) if thunkp xs;

    \<gtr\> 1:2:(3..inf);

    1:2:3:...
  </verbatim>

  Another case which needs special consideration are numeric matrices. For
  efficiency, the expression printer will always use the default
  representation for these, unless you override the representation of the
  matrix as a whole. E.g., the following rule for double matrices mimics
  Octave's default output format (for the sake of simplicity, this isn't
  perfect, but you get the idea):

  <\verbatim>
    \<gtr\> __show__ x::matrix =

    \<gtr\> \ \ strcat [printd j (x!(i,j))\|i=0..n-1; j=0..m-1] + "\\n"

    \<gtr\> with printd 0 = sprintf "\\n%10.5f"; printd _ = sprintf "%10.5f"
    end

    \<gtr\> when n,m = dim x end if dmatrixp x;

    \<gtr\> {1.0,1/2;1/3,4.0};

    \ \ \ 1.00000 \ \ 0.50000

    \ \ \ 0.33333 \ \ 4.00000
  </verbatim>

  Finally, by just purging the definition of the
  <hlink|<with|font-family|tt|__show__>|#--show--> function you can easily go
  back to the standard print syntax:

  <\verbatim>
    \<gtr\> clear __show__

    \<gtr\> 1/7; 1786; cis (-pi/2);

    0.142857142857143

    1786

    6.12303176911189e-17+:-1.0
  </verbatim>

  Note that if you have a set of definitions for the
  <hlink|<with|font-family|tt|__show__>|#--show--> function which should
  always be loaded at startup, you can put them into the interpreter's
  interactive startup files, see <hlink|Interactive
  Startup|#interactive-startup> below.

  <subsubsection|User-Defined Commands<label|user-defined-commands>>

  It is possible to extend the interpreter with your own interactive
  commands. To these ends, all you have to do is provide some corresponding
  public function definitions in the special <verbatim|__cmd__> namespace
  (cf. <hlink|Namespaces|#namespaces>). These definitions are typically
  placed in one of the interpreter's startup files (see <hlink|Interactive
  Startup|#interactive-startup> below) so that they are always available when
  running the interpreter interactively.

  A command function is invoked with one string argument which contains the
  rest of the command line (with leading and trailing whitespace stripped
  off). It may return a string result which is printed on standard output
  (appending a newline if needed). Thus a simple command which just prints
  its arguments as is can be implemented as follows:

  <\verbatim>
    \<gtr\> namespace __cmd__;

    \<gtr\> echo s = s;

    \<gtr\> echo Hello, world!

    Hello, world!
  </verbatim>

  You can split arguments and do any required processing of the arguments
  with the usual string processing functions. For instance, let's change our
  <verbatim|echo> command so that it prints each whitespace-delimited token
  on a line of its own:

  <\verbatim>
    \<gtr\> clear __cmd__::echo

    \<gtr\> echo s = join "\\n" args when

    \<gtr\> \ \ args = [a \| a = split " " s; ~null a];

    \<gtr\> end;

    \<gtr\> echo Hello, world!

    Hello,

    world!
  </verbatim>

  A command function may in fact return any kind of value. However, only
  string results are printed by the interpreter, other results are silently
  ignored. Thus we might implement the <verbatim|echo> command in a direct
  fashion, using the C <verbatim|puts> function:

  <\verbatim>
    \<gtr\> clear __cmd__::echo

    \<gtr\> private extern int puts(char*);

    \<gtr\> echo s = puts s;

    \<gtr\> echo Hello, world!

    Hello, world!
  </verbatim>

  Note that we declared <verbatim|puts> as a private symbol here. In general,
  the interpreter only exposes public functions in the <verbatim|__cmd__>
  namespace as commands, private symbols are hidden. On the other hand, we
  might also just expose the external function <verbatim|puts> itself under
  the (public) alias <verbatim|echo>, so here's yet another possible
  implementation of the <verbatim|echo> command:

  <\verbatim>
    \<gtr\> clear __cmd__::echo

    \<gtr\> extern int puts(char*) = echo;

    warning: external 'echo' shadows previous undefined use of this symbol

    \<gtr\> echo Hello, world!

    Hello, world!
  </verbatim>

  Instead of returning a result, a command function may also throw an
  exception. If the exception value is a string, it will be printed as an
  error message on standard error, using the same format as the built-in
  commands:

  <\verbatim>
    \<gtr\> error s = throw s;

    \<gtr\> error Hello, world!

    error: Hello, world!
  </verbatim>

  You can also override a built-in command in order to provide custom
  functionality. In this case, the original builtin can still be executed by
  escaping the command name with a leading `<verbatim|^>`. The same syntax
  works with the <hlink|<with|font-family|tt|evalcmd>|purelib.tm#evalcmd>
  function, so that a custom command can be defined in terms of the builtin
  that it replaces. E.g., if we always want to invoke the <verbatim|ls>
  command with the <verbatim|-l> option, we can redefine the <verbatim|ls>
  command as follows:

  <\verbatim>
    \<gtr\> ls examples/*.c

    examples/poor.c \ examples/sort.c

    \<gtr\> \ \ ls s = evalcmd $ "^ls -l "+s;

    \<gtr\> ls examples/*.c

    -rw-r--r-- 1 ag users 1883 2011-01-07 16:35 examples/poor.c

    -rw-r--r-- 1 ag users 3885 2011-01-07 16:35 examples/sort.c
  </verbatim>

  (Note that since we entered the definition of the <verbatim|ls> function
  interactively, we need to escape the second input line above with leading
  whitespace, so that it's not mistaken for an invocation of the built-in
  <verbatim|ls> command. This isn't necessary if you're using the alternative
  ``escape'' command syntax described in <hlink|Command
  Syntax|#command-syntax>.)

  To do more interesting things, you should take a look at the reflection
  capabilities discussed in the <hlink|Macros|#macros> section, which open up
  endless possibilities for commands to inspect and manipulate the running
  program in an interactive fashion. For instance, let's define a variation
  of the built-in <verbatim|clear> command which allows us to delete a
  specific rule rather than an entire function definition:

  <\verbatim>
    namespace __cmd__;

    \;

    clr s = case val $ "'(0 with "+s+" end)" of

    \ \ '(0 __with__ [r]) = del_fundef r;

    \ \ _ = throw "bad rule syntax";

    end;
  </verbatim>

  Note that we employ a little trick here to have
  <hlink|<with|font-family|tt|val>|purelib.tm#val> do all the hard work of
  parsing the rule specified as argument to the command, in order to
  translate the Pure rule syntax to the special meta representation used by
  <hlink|<with|font-family|tt|del_fundef>|purelib.tm#del-fundef>. The
  following example shows our <verbatim|clr> command in action:

  <\verbatim>
    \<gtr\> namespace;

    \<gtr\> fact n = 1 if n\<less\>=0;

    \<gtr\> \ \ \ \ \ \ \ = n*fact (n-1) otherwise;

    \<gtr\> show fact

    fact n = 1 if n\<less\>=0;

    fact n = n*fact (n-1);

    \<gtr\> clr fact n = 1 if n\<less\>=0;

    \<gtr\> show fact

    fact n = n*fact (n-1);
  </verbatim>

  Here's another useful command <verbatim|apropos> which quickly summarizes
  the information available on a given symbol (as reported by the
  <verbatim|show> and <verbatim|help_index> commands):

  <\verbatim>
    namespace __cmd__;

    \;

    apropos s = case catmap descr $ split "\\n" $ evalcmd $ "show -s "+s of

    \ \ [] = throw $ "undefined symbol '"+s+"'";

    \ \ info = s+" is a "+join " and a " info+". \\

    Type 'show "+s+"' for more information."+

    (if null (evalcmd $ "help_index "+s) then "" else

    "\\nDocumentation for this symbol is available. Type 'help "+s+"'.");

    end with

    \ \ descr info = case [x \| x = split " " info; ~null x] of

    \ \ \ \ t:c:_ = [symtypes!c] if s==t when

    \ \ \ \ \ \ symtypes = {"fun"=\<gtr\>"function","mac"=\<gtr\>"macro","var"=\<gtr\>"variable",

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ "cst"=\<gtr\>"constant"};

    \ \ \ \ end;

    \ \ \ \ _ = [];

    \ \ end;

    end;
  </verbatim>

  This command can be used as follows:

  <\verbatim>
    \<gtr\> apropos foldl

    foldl is a function. Type 'show foldl' for more information.

    Documentation for this symbol is available. Type 'help foldl'.

    \<gtr\> apropos $

    $ is a macro and a function. Type 'show $' for more information.

    Documentation for this symbol is available. Type 'help $'.

    \<gtr\> let x = 11;

    \<gtr\> apropos x

    x is a variable. Type 'show x' for more information.

    \<gtr\> apropos y

    apropos: undefined symbol 'y'
  </verbatim>

  More examples can be found in the sample.purerc file distributed with the
  Pure interpreter.

  <subsubsection|Interactive Startup<label|interactive-startup>>

  In interactive mode, the interpreter runs some additional scripts at
  startup, after loading the prelude and the scripts specified on the command
  line. This lets you tailor the interactive environment to your liking.

  The interpreter first looks for a .purerc file in the user's home directory
  (as given by the<label|index-58><verbatim|HOME> environment variable) and
  then for a .purerc file in the current working directory. These are just
  ordinary Pure scripts which may contain any additional definitions
  (including command definitions, as described in the previous section) that
  you need. The .purerc file in the home directory is for global definitions
  which should always be available when running interactively, while the
  .purerc file in the current directory can be used for project-specific
  definitions.

  Finally, you can also have a .pure initialization file in the current
  directory, which is usually created with the <verbatim|dump> command (see
  above). This file is loaded after the .purerc files if it is present.

  The interpreter processes all these files in the same way as with the
  <verbatim|run> command (see <hlink|Interactive
  Commands|#interactive-commands> above). When invoking the interpreter, you
  can specify the <hlink|<em|--norc>|#cmdoption-pure--norc> option on the
  command line if you wish to skip these initializations.

  <subsection|Batch Compilation<label|batch-compilation>>

  The interpreter's <hlink|<em|-c>|#cmdoption-pure-c> option provides a means
  to turn Pure scripts into standalone executables. This feature is still a
  bit experimental. In particular, note that the compiled executable is
  essentially a <em|static snapshot> of your program which is executed on the
  ``bare metal'', without a hosting interpreter. Only a minimal runtime
  system is provided. This considerably reduces startup times, but also
  implies some quirks and limitations as detailed below.

  First and foremost, the batch compiler always reorders the code so that all
  toplevel expressions and <hlink|<with|font-family|tt|let>|#let> bindings
  are evaluated <em|after> all functions have been defined. This is done to
  reduce the size of the output executable, so that there's only a
  <em|single> snapshot of each function which will be used by all toplevel
  expressions and global variable definitions invoking the function.
  Therefore you should avoid code like the following:

  <\verbatim>
    let x = foo 99;

    foo x = x+1;

    let y = foo 99;
  </verbatim>

  Note that if you run this through the interpreter, <verbatim|x> and
  <verbatim|y> are bound to <verbatim|foo> <verbatim|99> and <verbatim|100>,
  respectively, because expressions and variable definitions are executed
  immediately, as the program is being processed. In contrast, if the same
  program is batch-compiled, <em|both> variables will be defined <em|after>
  the definition of <verbatim|foo> and thus refer to the same value
  <verbatim|100> instead. This will rarely be a problem in practice (the
  above example is really rather pathological and won't usually occur in
  real-world programs), but to avoid these semantic differences, you'll have
  to make sure that expressions are evaluated <em|after> all functions used
  in the evaluation have been defined completely. (However, the batch
  compiler currently doesn't check this condition and will happily generate
  code for programs which violate it.)

  Plain toplevel expressions won't be of much use in a batch-compiled
  program, unless, of course, they are evaluated for their side-effects. Your
  program will have to include at least one of these to play the role of the
  ``main program'' in your script. In most cases these expressions are best
  placed after all the function and variable definitions, at the end of your
  program.

  Also note that during a batch compilation, the compiled program is actually
  executed as usual, i.e., the script is also run <em|at compile time>. This
  might first seem to be a big annoyance, but it actually opens the door for
  some powerful programming techniques like <hlink|partial
  evaluation|http://en.wikipedia.org/wiki/Partial-evaluation>. It is also a
  necessity because of Pure's highly dynamic nature. For instance, Pure
  allows you to define constants by evaluating an arbitrary expression (cf.
  <hlink|Constant Definitions|#constant-definitions>), and using
  <hlink|<with|font-family|tt|eval>|purelib.tm#eval> a program can easily
  modify itself in even more unforeseeable ways. Therefore pretty much
  anything in your program can actually depend on previous computations
  performed while the program is being executed. To make this work in
  batch-compiled scripts, the batch compiler thus executes the script as
  usual. The <hlink|<with|font-family|tt|compiling>|#compiling> variable can
  be used to check whether the script is being batch-compiled, so you can
  adjust to that by selectively enabling or disabling parts of the code. For
  instance, you will usually want to skip execution of the ``main program''
  during batch compilation.

  Last but not least, note that some parts of Pure's metaprogramming
  capabilities and other compile time features are disabled in batch-compiled
  programs:

  <\itemize>
    <item>The <hlink|<with|font-family|tt|eval>|purelib.tm#eval> function can
    only be used to evaluate plain toplevel expressions. You can define local
    functions and variables in <hlink|<with|font-family|tt|with>|#with> and
    <hlink|<with|font-family|tt|when>|#when> clauses inside an expression,
    but you can't use <hlink|<with|font-family|tt|eval>|purelib.tm#eval> to
    define new global variables and functions. In other words, anything which
    changes the executing program is ``verboten''. Moreover, the
    introspective capabilities provided by
    <hlink|<with|font-family|tt|evalcmd>|purelib.tm#evalcmd> and similar
    operations (discussed under <hlink|Reflection|#reflection> in the
    <hlink|Macros|#macros> section) are all disabled. If you need any of
    these capabilities, you have to run your program with the interpreter.

    <item>Constant and macro definitions, being compile time features, aren't
    available in the compiled program. If you need to use these with
    <hlink|<with|font-family|tt|eval>|purelib.tm#eval> at run time, you have
    to provide them through variable and function definitions instead. Also,
    the compiler usually strips unused functions from the output code, so
    that only functions which are actually called somewhere in the static
    program text are available to <hlink|<with|font-family|tt|eval>|purelib.tm#eval>.
    (The <hlink|<em|-u>|#cmdoption-pure-u> option and the
    <hlink|<em|--required>|#cmdoption-pure-pragma--required> pragma can be
    used to avoid this, see <hlink|Options Affecting Code
    Size|#options-affecting-code-size> below.)

    <item>Code which gets executed to compute constant values at compile time
    will generally <em|not> be executed in the compiled executable, so your
    program shouldn't rely on side-effects of such computations (this would
    be bad practice anyway). There is an exception to this rule, however,
    namely if a constant value contains run time data such as pointers and
    local functions which requires an initialization at run time, then the
    batch compiler will generate code for that. (The same happens if the
    <hlink|<em|--noconst>|#cmdoption-pure--noconst> option is used to force
    computation of constant values at run time, see <hlink|Options Affecting
    Code Size|#options-affecting-code-size>.)
  </itemize>

  What this boils down to is that in the batch-compiled program you will have
  to avoid anything which requires the compile time or interactive facilities
  of the interpreter. These restrictions only apply at run time, of course.
  At compile time the program <em|is> being executed by the full version of
  the interpreter so you can use <hlink|<with|font-family|tt|eval>|purelib.tm#eval>
  and <hlink|<with|font-family|tt|evalcmd>|purelib.tm#evalcmd> in any desired
  way.

  For most kinds of scripts, the above restrictions aren't really that much
  of an obstacle, or can easily be worked around. For the few scripts which
  actually need the full dynamic capabilities of Pure you'll just have to run
  the script with the interpreter. This isn't a big deal either, only the
  startup will be somewhat slower because the script is compiled on the fly.
  Once the JIT has done its thing the ``interpreted'' script will run every
  bit as fast as the ``compiled'' one, since in fact <em|both> are compiled
  (only at different times) to exactly the same code!

  <subsubsection|Example<label|example>>

  For the sake of a concrete example, consider the following little script:

  <\verbatim>
    using system;

    \;

    fact n = if n\<gtr\>0 then n*fact (n-1) else 1;

    \;

    main n = do puts ["Hello, world!", str (map fact (1..n))];

    \;

    if argc\<less\>=1 then () else main (sscanf (argv!1) "%d");
  </verbatim>

  When invoked from the command line, with the number <verbatim|n> as the
  first parameter, this program will print the string <verbatim|"Hello,>
  <verbatim|world!"> and the list of the first <verbatim|n> factorials:

  <\verbatim>
    $ pure hello.pure 10

    Hello, world!

    [1,2,6,24,120,720,5040,40320,362880,3628800]
  </verbatim>

  Note the condition on <verbatim|argc> in the last line of the script. This
  prevents the program from producing an exception if no command line
  parameters are specified, so that the program can also be run
  interactively:

  <\verbatim>
    $ pure -i -q hello.pure

    \<gtr\> main 10;

    Hello, world!

    [1,2,6,24,120,720,5040,40320,362880,3628800]

    ()

    \<gtr\> quit
  </verbatim>

  To turn the script into an executable, we just invoke the Pure interpreter
  with the <hlink|<em|-c>|#cmdoption-pure-c> option, using the
  <hlink|<em|-o>|#cmdoption-pure-o> option to specify the desired output file
  name:

  <\verbatim>
    $ pure -c hello.pure -o hello

    $ ./hello 10

    Hello, world!

    [1,2,6,24,120,720,5040,40320,362880,3628800]
  </verbatim>

  Next suppose that we'd like to supply the value <verbatim|n> at
  <em|compile> rather than run time. To these ends we want to turn the value
  passed to the <verbatim|main> function into a compile time constant, which
  can be done as follows:

  <\verbatim>
    const n = if argc\<gtr\>1 then sscanf (argv!1) "%d" else 10;
  </verbatim>

  (Note that we provide <verbatim|10> as a default if <verbatim|n> isn't
  specified on the command line.)

  Moreover, in such a case we usually want to skip the execution of the main
  function at compile time. To these ends, the predefined
  <hlink|<with|font-family|tt|compiling>|#compiling> variable holds a truth
  value indicating whether the program is actually running under the auspices
  of the batch compiler, so that it can adjust accordingly. In our example,
  the evaluation of <verbatim|main> becomes:

  <\verbatim>
    if compiling then () else main n;
  </verbatim>

  Our program now looks as follows:

  <\verbatim>
    using system;

    \;

    fact n = if n\<gtr\>0 then n*fact (n-1) else 1;

    \;

    main n = do puts ["Hello, world!", str (map fact (1..n))];

    \;

    const n = if argc\<gtr\>1 then sscanf (argv!1) "%d" else 10;

    if compiling then () else main n;
  </verbatim>

  This script ``specializes'' <verbatim|n> to the first (compile time)
  parameter when being batch-compiled, and it still works as before when we
  run it through the interpreter in both batch and interactive mode, too:

  <\verbatim>
    $ pure -i -q hello.pure

    Hello, world!

    [1,2,6,24,120,720,5040,40320,362880,3628800]

    \<gtr\> main 5;

    Hello, world!

    [1,2,6,24,120]

    ()

    \<gtr\> quit

    \;

    $ pure hello.pure 7

    Hello, world!

    [1,2,6,24,120,720,5040]

    \;

    $ pure -o hello -c -x hello.pure 7

    \;

    $ ./hello

    Hello, world!

    [1,2,6,24,120,720,5040]
  </verbatim>

  In addition, there's also a <em|compile time> check analogous to the
  <hlink|<with|font-family|tt|compiling>|#compiling> variable, which
  indicates whether the source script is being run normally or in a batch
  compilation; see <hlink|Conditional Compilation|#conditional-compilation>.
  We might employ this as follows, replacing the last line of the script with
  this:

  <\verbatim>
    #! --if compiled

    if compiling then () else main n;

    #! --else

    if argc\<gtr\>1 then main n else puts "Try 'main n' where n is a
    number.";

    #! --endif
  </verbatim>

  The code in the <verbatim|--if> <verbatim|compiled> section, which is the
  same as before, is now only executed during batch compilation and in the
  compiled executable. If we run the script normally, in the interpreter, the
  code in the <verbatim|--else> section, which just prints a welcome message
  if no arguments are given on the command line, is executed instead. So we
  now actually have <em|four> different code paths, depending on whether the
  script is run normally, with or without arguments, or in a batch
  compilation, or as a native executable. This kind of setup is useful if the
  script is to be run both interactively and non-interactively in the
  interpreter while developing it, but once the script is finished it gets
  compiled and installed as a native executable.

  <\verbatim>
    $ pure -i -q hello.pure

    Try 'main n' where n is a number.

    \<gtr\> main 5;

    Hello, world!

    [1,2,6,24,120]

    ()

    \<gtr\> quit

    \;

    $ pure hello.pure 7

    Hello, world!

    [1,2,6,24,120,720,5040]

    \;

    $ pure -o hello -c hello.pure

    \;

    $ ./hello

    Hello, world!

    [1,2,6,24,120,720,5040,40320,362880,3628800]
  </verbatim>

  You'll rarely need an elaborate setup like this, most of the time something
  like our simple first example will do the trick. But, as you've seen, Pure
  can easily do it.

  <subsubsection|Options Affecting Code Size<label|options-affecting-code-size>>

  By default, the batch compiler strips unused functions from the output
  code, to keep the code size small. You can disable this with the
  <hlink|<em|-u>|#cmdoption-pure-u> option, in which case the output code
  includes <em|all> functions defined in the compiled program, the prelude
  and any other module imported with a <hlink|<with|font-family|tt|using>|#using>
  clause, even if they don't seem to be used anywhere. This considerably
  increases compilation times and makes the compiled executable much larger.
  For instance, on a 64 bit Linux systems with ELF binaries the executable of
  our hello.pure example is about thrice as large:

  <\verbatim>
    $ pure -o hello -c -x hello.pure 7 && ls -l hello

    -rwxr-xr-x 1 ag users 178484 2010-01-12 06:21 hello

    $ pure -o hello -c -u -x hello.pure 7 && ls -l hello

    -rwxr-xr-x 1 ag users 541941 2010-01-12 06:21 hello
  </verbatim>

  (Note that even the stripped executable is fairly large when compared to
  compiled C code, as it still contains the symbol table of the entire
  program, which is needed by the runtime environment.)

  Stripped executables should be fine for most purposes, but you have to be
  careful when using <hlink|<with|font-family|tt|eval>|purelib.tm#eval> in
  your compiled program. The compiler only does a <em|static> analysis of
  which functions might be reached from the initialization code (i.e.,
  toplevel expressions and <hlink|<with|font-family|tt|let>|#let> bindings).
  It does <em|not> take into account code run via the
  <hlink|<with|font-family|tt|eval>|purelib.tm#eval> routine. Thus, functions
  used only in <hlink|<with|font-family|tt|eval>|purelib.tm#eval>ed code will
  be stripped from the executable, as if they were never defined at all. If
  such a function is then being called using
  <hlink|<with|font-family|tt|eval>|purelib.tm#eval> at runtime, it will
  evaluate to a plain constructor symbol.

  If this is a problem then you can either use the
  <hlink|<em|-u>|#cmdoption-pure-u> option to produce an unstripped
  executable, or you can force specific functions to be included in the
  stripped executable with the <hlink|<em|--required>|#cmdoption-pure-pragma--required>
  pragma (cf. <hlink|Code Generation Options|#code-generation-options>). For
  instance:

  <\verbatim>
    #! --required foo

    foo x = bar (x-1);

    eval "foo 99";
  </verbatim>

  There is another code generation option which may have a substantial effect
  on code size, namely the <hlink|<em|--noconst>|#cmdoption-pure--noconst>
  option. Normally, constant values defined in a
  <hlink|<with|font-family|tt|const>|#const> definition are precomputed at
  compile time and then stored in the generated executable; this reduces
  startup times but may increase the code size considerably if your program
  contains big constant values such as lists. If you prefer smaller
  executables then you can use the <hlink|<em|--noconst>|#cmdoption-pure--noconst>
  option to force the value of the constant to be recomputed at run time
  (which effectively turns the constant into a kind of read-only variable).
  For instance:

  <\verbatim>
    #! --noconst

    const xs = 1L..100000L;

    sum = foldl (+) 0;

    \;

    using system;

    puts $ str $ sum xs;
  </verbatim>

  On my 64 bit Linux system this produces a 187115 bytes executable. Without
  <hlink|<em|--noconst>|#cmdoption-pure--noconst> the code becomes almost an
  order of magnitude larger in this case (1788699 bytes). On the other hand,
  the smaller executable also takes a little longer to run since it must
  first recompute the value of the list constant at startup. So you have to
  consider the tradeoffs in a given situation. Usually big executables aren't
  much of a problem on modern operating systems, but if your program contains
  a lot of big constants then this may become an important consideration.
  However, if a constant value takes a long time to compute then you'll be
  better off with the default behaviour of precomputing the value at compile
  time.

  <subsubsection|Other Output Code Formats<label|other-output-code-formats>>

  Note that while the batch compiler generates native executables by default,
  it can just as well create object files which can be linked into other
  C/C++ programs and libraries:

  <\verbatim>
    $ pure -o hello.o -c -x hello.pure 7
  </verbatim>

  The .o extension tells the compiler that you want an object file. When
  linking the object module, you also need to supply an initialization
  routine which calls the <verbatim|__pure_main__> function in hello.o to
  initialize the compiled module. This routine is declared in C/C++ code as
  follows:

  <\verbatim>
    extern "C" void __pure_main__(int argc, char** argv);
  </verbatim>

  As indicated, <verbatim|__pure_main__> is to be invoked with two
  parameters, the argument count and <hlink|<with|font-family|tt|NULL>|purelib.tm#NULL>-terminated
  argument vector which become the <verbatim|argc> and the <verbatim|argv> of
  the Pure program, respectively. (You can also just pass 0 for both
  arguments if you don't need to supply command line parameters.) The purpose
  of <verbatim|__pure_main__> is to initialize a shell instance of the Pure
  interpreter which provides the minimal runtime support necessary to execute
  the Pure program, and to invoke all ``initialization code'' (variable
  definitions and toplevel expressions) of the program itself.

  A minimal C <verbatim|main> function which does the job of initializing the
  Pure module looks as follows:

  <\verbatim>
    extern void __pure_main__(int argc, char** argv);

    \;

    int main(int argc, char** argv)

    {

    \ \ __pure_main__(argc, argv);

    \ \ return 0;

    }
  </verbatim>

  If you link the <verbatim|main> routine with the Pure module, don't forget
  to also pull in the Pure runtime library. Assuming that the above C code is
  in pure_main.c:

  <\verbatim>
    $ gcc -c pure_main.c -o pure_main.o

    $ g++ -o hello hello.o pure_main.o -lpure

    $ ./hello

    Hello, world!

    [1,2,6,24,120,720,5040]
  </verbatim>

  (The C++ compiler is used as the linker here so that the standard C++
  library gets linked in, too. This is necessary because Pure's runtime
  library is actually written in C++.)

  In fact, this is pretty much what <verbatim|pure> <verbatim|-c> actually
  does for you when creating an executable.

  If your script loads dynamic libraries (<verbatim|using>
  <verbatim|"lib:...";>) then you'll also have to link with those; <em|all>
  external references have to be resolved at compile time. This is taken care
  of automatically when creating executables. Otherwise it is a good idea to
  run <verbatim|pure> <verbatim|-c> with the <verbatim|-v0100> verbosity
  option so that it prints the libraries to be linked (in addition to the
  commands which are invoked in the compilation process):

  <\verbatim>
    $ pure -v0100 -c hello.pure -o hello.o

    opt -f -std-compile-opts hello.o.bc \| llc -f -o hello.o.s

    gcc -c hello.o.s -o hello.o

    Link with: g++ hello.o -lpure
  </verbatim>

  Well, we already knew that, so let's consider a slightly more interesting
  example from Pure's ODBC module:

  <\verbatim>
    $ pure -v0100 -c pure-odbc/examples/menagerie.pure -o menagerie.o

    opt -f -std-compile-opts menagerie.o.bc \| llc -f -o menagerie.o.s

    gcc -c menagerie.o.s -o menagerie.o

    Link with: g++ menagerie.o /usr/local/lib/pure/odbc.so -lpure

    $ g++ -shared -o menagerie.so menagerie.o /usr/local/lib/pure/odbc.so
    -lpure
  </verbatim>

  Note that the listed link options are necessary but might not be
  sufficient; <verbatim|pure> <verbatim|-c> just makes a best guess based on
  the Pure source. On most systems this will be good enough, but if it isn't,
  you can just add options to the linker command as needed to pull in
  additional required libraries.

  As this last example shows, you can also create shared libraries from Pure
  modules. However, on some systems (most notably x86_64), this requires that
  you pass the <hlink|<em|-fPIC>|#cmdoption-pure-fPIC> option when
  batch-compiling the module, so that position-independent code is generated:

  <\verbatim>
    $ pure -c -fPIC pure-odbc/examples/menagerie.pure -o menagerie.o
  </verbatim>

  Note that even when building a shared module, you'll have to supply an
  initialization routine which calls <verbatim|__pure_main__> somewhere.

  Also note that since Pure doesn't support separate compilation in the
  present implementation, if you create different shared modules like this,
  each will contain their own copy all the required Pure functions from the
  prelude and other imported Pure modules. This becomes a problem when trying
  to link several separate batch-compiled modules into the same executable or
  library, because you'll get many name clashes for routines present in
  different modules (including the <verbatim|__pure_main__> entry point). To
  prevent this, the batch compiler can be invoked with the
  <hlink|<em|--main>|#cmdoption-pure--main> option to explicitly set a name
  for the main entry point. For instance:

  <\verbatim>
    $ pure -c hello.pure -o hello.o --main __hello_main__
  </verbatim>

  This has two effects. First, the main entry point will be called whatever
  you specified with <hlink|<em|--main>|#cmdoption-pure--main>, so you have
  to call this function instead of <verbatim|__pure_main__> to initialize the
  module. Second, if <hlink|<em|--main>|#cmdoption-pure--main> is specified,
  then all Pure functions in the module will be changed to internal linkage
  (like <verbatim|static> functions in C) to prevent any possible name
  clashes between different modules. (Alas, this also makes it impossible to
  employ <verbatim|pure_funcall> to call Pure functions directly from C, as
  described in the following section, so you'll have to use other runtime
  routines such as <verbatim|pure_eval> or <verbatim|pure_appl> to achieve
  this in an indirect way.)

  The batch compiler also lets you pass some special options to the llc
  program when creating a native assembler or object file. The present
  implementation understands options of the form
  <verbatim|-m><em|opt><verbatim|=><em|val> which can be used to select the
  desired target architecture and cpu type. For instance:

  <\verbatim>
    $ pure -march=x86-64 -mcpu=generic -c hello.pure -o hello
  </verbatim>

  This is useful, in particular, in cross compilation and if you need to
  select a specific processor variant. If you do not specify these options,
  llc will pick a suitable default based on the characteristics of the host
  system on which the code is compiled. Please check the documentation of the
  llc program for further information.

  For more elaborate uses not covered by the options discussed above,
  <verbatim|pure> <verbatim|-c> can also generate just plain LLVM assembler
  code:

  <\verbatim>
    pure -c hello.pure -o hello.ll
  </verbatim>

  Note the .ll extension; this tells the compiler that you want an LLVM
  assembler file. An LLVM bitcode file can be created just as easily:

  <\verbatim>
    pure -c hello.pure -o hello.bc
  </verbatim>

  In these cases you'll have to have to handle the rest of the compilation
  yourself. This gives you the opportunity, e.g., to play with more advanced
  optimization and code generation options provided by the LLVM toolchain.
  Please refer to the <hlink|LLVM documentation|http://llvm.org/docs/> (in
  particular, the description of the opt and llc programs) for details.

  <subsubsection|Calling Pure Functions From
  C<label|calling-pure-functions-from-c>>

  Another point worth mentioning here is that you can't just call Pure
  functions in a batch-compiled module directly. That's because in order to
  call a Pure function, at least in the current implementation, you have to
  set up a Pure stack frame for the function. However, there's a convenience
  function called <verbatim|pure_funcall> in the runtime API to handle this.
  This function takes a pointer to the Pure function, the argument count and
  the arguments themselves (as <verbatim|pure_expr*> objects) as parameters.
  For instance, here is a pure_main.c module which can be linked against the
  hello.pure program from above, which calls the <verbatim|fact> function
  from the Pure program:

  <\verbatim>
    #include \<less\>stdio.h\<gtr\>

    #include \<less\>pure/runtime.h\<gtr\>

    \;

    extern void __pure_main__(int argc, char** argv);

    extern pure_expr *fact(pure_expr *x);

    \;

    int main()

    {

    \ \ int n = 10, m;

    \ \ __pure_main__(0, NULL);

    \ \ if (pure_is_int(pure_funcall(fact, 1, pure_int(n)), &m))

    \ \ \ \ printf("fact %d = %d\\n", n, m);

    \ \ return 0;

    }
  </verbatim>

  And here's how you can compile, link and run this program:

  <\verbatim>
    $ pure -o hello.o -c -x hello.pure 7

    $ gcc -o pure_main.o -c pure_main.c

    $ g++ -o myhello hello.o pure_main.o -lpure

    $ ./myhello

    Hello, world!

    [1,2,6,24,120,720,5040]

    fact 10 = 3628800
  </verbatim>

  Note that the first two lines are output from the Pure program; the last
  line is what gets printed by the <verbatim|main> routine in pure_main.c.

  <subsection|Caveats and Notes<label|caveats-and-notes>>

  This section is a grab bag of casual remarks, useful tips and tricks, and
  information on common pitfalls, quirks and limitations of the current
  implementation and how to deal with them.

  <subsubsection|Etymology<label|etymology>>

  People keep asking me what's so ``pure'' about Pure. The long and
  apologetic answer is that Pure tries to stay as close as possible to the
  spirit of term rewriting without sacrificing practicality. Pure's term
  rewriting core is in fact purely functional. It's thus possible and in fact
  quite easy to write purely functional programs in Pure, and you're
  encouraged to do so whenever this is reasonable. On the other hand, Pure
  doesn't get in your way if you want to call external operations with side
  effects; after all, it does allow you to call any C function at any point
  in a Pure program.

  The short answer is that I simply liked the name, and there wasn't any
  programming language named ``Pure'' yet (quite a feat nowadays), so there's
  one now. If you insist on a (recursive) backronym, just take ``Pure'' to
  stand for the ``Pure universal rewriting engine''.

  <subsubsection|Backward Compatibility<label|backward-compatibility>>

  Pure is based on the author's earlier <hlink|Q|#q> language, but it offers
  many new and powerful features and programs run much faster than their Q
  equivalents. The language also went through a thorough facelift in order to
  modernize the syntax and make it more similar to other modern-style
  functional languages, in particular <hlink|Miranda|#miranda> and
  <hlink|Haskell|#haskell>. Thus porting Q scripts to Pure often involves a
  substantial amount of manual work, but it can (and has) been done.

  Since its modest beginnings in April 2008, Pure has gone through a lot of
  major and minor revisions which raise various backward compatibility
  issues. We document these in the following, in order to facilitate the
  porting of older Pure scripts. (Note that this isn't intended to be a full
  history of Pure development, so you may want to consult the NEWS and
  ChangeLog files included in the distribution for more details.)

  Pure 0.7 introduced built-in matrix structures, which called for some minor
  changes in the syntax of comprehensions and arithmetic sequences.
  Specifically, the template expression and generator/filter clauses of a
  comprehension are now separated with <verbatim|\|> instead of <verbatim|;>.
  Moreover, arithmetic sequences with arbitrary stepsize are now written
  <verbatim|x:y..z> instead of <verbatim|x,y..z>, and the `<verbatim|..>`
  operator now has a higher precedence than the `<verbatim|,>` operator. This
  makes writing matrix slices like <verbatim|x!!(i..j,k..l)> much more
  convenient.

  In Pure 0.13 the naming of the logical and bitwise operations was changed,
  so that these are now called <verbatim|~>, <verbatim|&&>, <verbatim|\|\|>
  and <verbatim|not>/<verbatim|and>/<verbatim|or>, respectively. (Previously,
  <verbatim|~> was used for bitwise, <verbatim|not> for logical negation,
  which was rather inconsistent, albeit compatible with the naming of the
  <verbatim|not> operation in Haskell and ML.) Also, to stay in line with
  this naming scheme, inequality was renamed to <verbatim|~=> (previously
  <verbatim|!=>).

  Pure 0.14 introduced the namespaces feature. Consequently, the scope of
  private symbols is now confined to a namespace rather than a source module;
  scripts making use of private symbols need to be adapted accordingly. Also
  note that syntax like <verbatim|foo::int> may now also denote a qualified
  symbol rather than a tagged variable, if <verbatim|foo> has been declared
  as a namespace. You can work around such ambiguities by renaming the
  variable, or by placing spaces around the `<verbatim|::>` delimiter (these
  aren't permitted in a qualified symbol, so the construct <verbatim|foo>
  <verbatim|::> <verbatim|int> is always interpreted as a tagged variable, no
  matter whether <verbatim|foo> is also a valid namespace).

  Pure 0.26 extended the namespaces feature to add support for hierarchical
  namespaces. This means that name lookup works in a slightly different
  fashion now (see <hlink|Hierarchical Namespaces|#hierarchical-namespaces>
  for details), but old code which doesn't use the new feature should
  continue to work unchanged.

  Pure 0.26 also changed the <verbatim|nullary> keyword to
  <hlink|<with|font-family|tt|nonfix>|#nonfix>, which is more consistent with
  the other kinds of fixity declarations. Moreover, the parser was enhanced
  so that it can cope with a theoretically unbounded number of precedence
  levels, and the system of standard operators in the prelude was modified so
  that it becomes possible to sneak in new operator symbols with ease;
  details can be found in the <hlink|Symbol
  Declarations|#symbol-declarations> section.

  Pure 0.41 added support for optimization of indirect tail calls, so that
  any previous restrictions on the use of tail recursion in indirect function
  calls and mutually recursive globals have been removed. Moreover, the
  logical operators <verbatim|&&> and <verbatim|\|\|> are now tail-recursive
  in their second operand and can also be extended with user-defined
  equations, just like the other builtins. Note that this implies that the
  values returned by <verbatim|&&> and <verbatim|\|\|> aren't normalized to
  the values 0 and 1 any more (this isn't possible with tail call semantics).
  If you need this then you'll have to make sure that either the operands are
  already normalized, or you'll have to normalize the result yourself.

  Also, as of Pure 0.41 the batch compiler produces stripped executables by
  default. To create unstripped executables you now have to use the
  <hlink|<em|-u>|#cmdoption-pure-u> option, see <hlink|Options Affecting Code
  Size|#options-affecting-code-size> for details. The <em|-s> option to
  produce stripped executables is still provided for backward compatibility,
  but it won't have any effect unless you use it to override a previous
  <hlink|<em|-u>|#cmdoption-pure-u> option.

  Pure 0.43 changed the rules for looking up symbols in user-defined
  namespaces. Unqualified symbols are now created in the current (rather than
  the global) namespace by default, see <hlink|Symbol Lookup and
  Creation|#symbol-lookup-and-creation> for details. The
  <hlink|<em|-w>|#cmdoption-pure-w> option can be used to get warnings about
  unqualified symbols which are resolved to a different namespace than
  previously. It also provides a means to check your scripts for implicit
  declarations which might indicate missing or mistyped function symbols.

  Pure 0.45 added support for checking arbitrary pointer types in the C
  interface, so that you don't have to worry about passing the wrong kinds of
  pointers to system and library routines any more. Moreover, the
  interpretation of numeric pointer arguments (<verbatim|int*> etc.) was
  changed to bring them in line with the other new numeric matrix conversions
  (<verbatim|int**> etc.). In particular, the matrix data can now be modified
  in-place and type checking is more strict (<verbatim|int*> requires an int
  matrix, etc.). Also, there's now support for <verbatim|argv>-style vector
  arguments (<verbatim|char**> and <verbatim|void**>). Please see the
  <hlink|C Types|#c-types> section for details.

  Pure 0.47 added a bunch of new features which have been on the wishlist for
  the forthcoming 1.0 release:

  <\itemize>
    <item>You can now define your own interactive commands by placing
    suitable function definitions in the special <verbatim|__cmd__>
    namespace; see <hlink|User-Defined Commands|#user-defined-commands> for
    details.

    <item>The syntax used to denote <hlink|inline code|#inline-code> sections
    was changed from <verbatim|%{...%}> to <verbatim|%\<...%\>>. This
    resolves an ambiguity in the syntax (note that <verbatim|%{> is legal
    Pure syntax; it could denote a <verbatim|%> operator followed by a matrix
    value), and also makes it easier to properly support this construct in
    Emacs Pure mode.

    <item>It is now possible to declare variadic externs, so that functions
    like <verbatim|printf> can be called without much ado; see
    <hlink|Variadic C Functions|#variadic-c-functions>.

    <item>Support for simple kinds of matrix <hlink|patterns|#patterns> like
    <verbatim|{x,y}>, <verbatim|{x::int,y}>, <verbatim|{x,y;z,t}>,
    <verbatim|{{x,y},z}> was added.

    <item>The meaning of quoted specials such as lambdas and local
    definitions was changed. Previously these would be evaluated even in the
    middle of a quoted expression. Now they will produce a special meta
    representation in terms of built-in macros, in order to support the
    advanced metaprogramming capabilities discussed in <hlink|Built-in Macros
    and Special Expressions|#built-in-macros-and-special-expressions> and
    <hlink|Reflection|#reflection>.

    <item>Last but not least, Pure 0.47 sports a new, more flexible type tag
    feature which defines type tags as unary predicates implemented using
    normal rewriting rules; cf. section <hlink|Type Rules|#type-rules> for
    details. To these ends, a new keyword
    <hlink|<with|font-family|tt|type>|#type> was added (if you used this as
    an ordinary identifier, you will have to rename these). Note that the
    old-style type tags, which were just a syntactic shortcut for ``as''
    patterns involving unary constructor symbols, aren't supported any more,
    so you'll have to fix up your old scripts accordingly. To assist with
    this, the Pure interpreter can be run with the
    <hlink|<em|-w>|#cmdoption-pure-w> option in order to identify occurrences
    of undefined (presumably old-style) type tags. You should either change
    these to the corresponding ``as'' pattern (i.e., <verbatim|x::foo> to
    <verbatim|x@(foo> <verbatim|_)>), or just add a proper type definition
    for the tag (like <verbatim|type> <verbatim|foo> <verbatim|(foo>
    <verbatim|_);>).
  </itemize>

  Pure 0.48 moved pointer arithmetic and the regex functions into separate
  <hlink|<with|font-family|tt|pointers>|purelib.tm#module-pointers> and
  <hlink|<with|font-family|tt|regex>|purelib.tm#module-regex> modules, so you
  now have to import these modules if you need this functionality. It also
  introduced the <hlink|<em|--defined>|#cmdoption-pure-pragma--defined>
  pragma which lets you have ``defined'' functions in Pure which throw an
  exception if they can't be applied, e.g., because they are invoked with the
  wrong arguments.

  Pure 0.49 introduced the <hlink|conditional
  compilation|#conditional-compilation> pragmas, so that simple version and
  system dependencies can now be handled in a more convenient way.

  Pure 0.50 introduced the declaration of <hlink|interface
  types|#interface-types>, which make it possible to create the definition of
  a type from a description of its operations. To these ends, a new keyword
  <hlink|<with|font-family|tt|interface>|#interface> was added to the
  language.

  Pure 0.55 changed the default compilers for inline C, C++ and Fortran code
  to clang, clang++ and gfortran (with the dragonegg plugin), respectively.
  This was done in order to support LLVM 3.x which does not have llvm-gcc
  (the previous default) any more. If you're still running an older LLVM
  version and would like to keep using llvm-gcc, you will have to set some
  environment variables; please see the <hlink|<em|installation
  instructions>|install.tm> for details.

  Pure 0.56 fixed the meaning of patterns in comprehensions so that unmatched
  elements are now filtered out automatically, like in Haskell. The previous
  behaviour of raising an exception in such cases offered no real benefits
  and was in fact very inconvenient in most situations. Pure 0.56 also
  enables stack checks by default (see <hlink|Stack Size and Tail
  Recursion|#stack-size-and-tail-recursion> for details), and interactive
  commands can optionally be escaped by prefixing them with a special
  character (see <hlink|Command Syntax|#command-syntax>). The
  <hlink|<with|font-family|tt|true>|purelib.tm#true> and
  <hlink|<with|font-family|tt|false>|purelib.tm#false> constants are now
  declared as <hlink|<with|font-family|tt|nonfix>|#nonfix> symbols in the
  prelude so that they can be used in patterns.

  Pure 0.58 made the <hlink|<em|-x>|#cmdoption-pure-x> option optional, so
  that a script can now be invoked with arguments simply as <verbatim|pure>
  <verbatim|script> <verbatim|arg1> <verbatim|arg2> <verbatim|...>, which
  matches the default behaviour of most other command language interpreters.
  This also has the advantage that shebangs like <verbatim|#!/usr/bin/env>
  <verbatim|pure> can now be used without any caveats. If you do want to
  execute multiple script files in batch mode then you now have to explicitly
  indicate this with the new <hlink|<em|-b>|#cmdoption-pure-b> option; please
  see <hlink|Invoking Pure|#invoking-pure> for details. Pure 0.58 also adds
  two new code generation options <hlink|<em|--symbolic>|#cmdoption-pure--symbolic>
  and <hlink|<em|--nosymbolic>|#cmdoption-pure--nosymbolic> to set the
  default evaluation mode of global functions; these are discussed in
  <hlink|Defined Functions|#defined-functions> below.

  <subsubsection|Error Recovery<label|error-recovery>>

  The parser uses a fairly simplistic panic mode error recovery which tries
  to catch syntax errors at the toplevel only. This seems to work reasonably
  well, but might catch some errors much too late. Unfortunately, Pure's
  terseness makes it rather difficult to design a better scheme. As a remedy,
  the parser accepts an empty definition (just <verbatim|;> by itself) at the
  toplevel only. Thus, in interactive usage, if the parser seems to eat away
  your input without doing anything, entering an extra semicolon or two
  should break the spell, putting you back at the toplevel where you can
  start typing the definition again.

  <subsubsection|Splicing Tuples and Matrices<label|splicing-tuples-and-matrices>>

  The ``splicing'' of tuples and matrices is probably one of Pure's most
  controversial features. By this we mean that tuples and matrices get
  flattened out when they are combined. For instance:

  <\verbatim>
    \<gtr\> (1,2,3),4,(5,6);

    1,2,3,4,5,6

    \<gtr\> {{1,2,3},4,{5,6}};

    {1,2,3,4,5,6}

    \<gtr\> {{a,b;c,d},{x;y}}

    {a,b,x;c,d,y}
  </verbatim>

  This kind of behaviour is also known from Perl and MATLAB/Octave. Users
  familiar with these languages often find it convenient, but it certainly
  gets in the way if you want to nest these structures. Fortunately, there
  are some remedies for the most common cases where you'd want to do this.
  Specifically, for the case of vectors the prelude defines the
  <hlink|<em|non-splicing vector brackets>|purelib.tm#non-splicing> which
  make it easy to construct nested vectors; these are often used to represent
  multi-dimensional indexable collections in Pure. For instance:

  <\verbatim>
    \<gtr\> {\|{1,2,3},4,{5,6}\|};

    {{1,2,3},4,{5,6}}

    \<gtr\> {\|{a,b;c,d},{x;y}\|};

    {{a,b;c,d},{x;y}}

    \<gtr\> ans!0!(1,1);

    d
  </verbatim>

  Nothing like this is available for tuples, though, so you'll have to use
  lists instead if you need nestability. Note that the deeper reason behind
  the non-nestability of tuples is the right-recursive nature of tuples
  combined with the fact that there aren't any real 1-tuples in Pure
  (<verbatim|(x)> is just <verbatim|x>). This implies that you can't have a
  nested tuple in the last component of a tuple, no matter how hard you try
  to prevent the splicing, e.g., by quoting. <verbatim|x,(y,z)> is always
  just the triple <verbatim|x,y,z>.

  One might consider this a defect in Pure's tuple data structure. But Pure
  already has a nestable kind of tuples (lists), so it would be rather
  pointless to have yet another isomorphic data structure with just slightly
  different syntax. Instead Pure gives you the choice between two kinds of
  list-like data structures, one which nests, and one which doesn't but has
  other interesting properties.

  <subsubsection|With and when<label|with-and-when>>

  Another common source of confusion is that Pure provides two different
  constructs to bind local function and variable symbols, respectively. This
  distinction is necessary because Pure does not segregate defined functions
  and constructors, and thus there is no magic to figure out whether an
  equation like <verbatim|foo> <verbatim|x> <verbatim|=> <verbatim|y> by
  itself is meant as a definition of a function <verbatim|foo> with formal
  parameter <verbatim|x> and return value <verbatim|y>, or a pattern binding
  defining the local variable <verbatim|x> by matching the pattern
  <verbatim|foo> <verbatim|x> against the value of <verbatim|y>. The
  <hlink|<with|font-family|tt|with>|#with> construct does the former,
  <hlink|<with|font-family|tt|when>|#when> the latter.

  Also note that the function definitions in a
  <hlink|<with|font-family|tt|with>|#with> clause are all done simultaneously
  (and can thus be mutually recursive), while the individual variable
  definitions and expressions in a <hlink|<with|font-family|tt|when>|#when>
  clause are executed in order. This works in exactly the same fashion as
  <verbatim|letrec> and <verbatim|let> in Scheme. (As a mnemonic, consider
  that <hlink|<with|font-family|tt|when>|#when> conveys a sense of time, so
  its parts are ``executed in sequence''.)

  The sequential execution aspect of <hlink|<with|font-family|tt|when>|#when>
  is rather important in Pure, because it enables you to do a series of
  ``actions'' (variable bindings and expression evaluations) in sequence by
  simply enclosing it in a <hlink|<with|font-family|tt|when>|#when> clause.
  This provides the Pure programmer with a useful and familiar bit of
  imperative ``look and feel'' (even though the
  <hlink|<with|font-family|tt|when>|#when> clause itself works in a purely
  functional way). For instance, suppose that we'd like to define a function
  which opens a file, checks that the file was opened successfully and throws
  an exception otherwise, outputs a message to indicate which file was
  opened, and finally returns the contents of the file as a string. The
  easiest way to do this in Pure is as follows:

  <\verbatim>
    using system;

    \;

    read_file name::string = s when

    \ \ fp = fopen name "r";

    \ \ pointerp fp \|\| throw (sprintf "%s: %s" (name,strerror errno));

    \ \ printf "opened file %s\\n" name;

    \ \ s = fget fp;

    end;
  </verbatim>

  Another bit of syntax that may take getting used to is that
  <hlink|<with|font-family|tt|with>|#with> and
  <hlink|<with|font-family|tt|when>|#when> clauses are tacked on to the end
  of the expression they belong to. This mimics mathematical language and
  supposedly makes it easier to read and understand a definition, because
  you're told right up front <em|what> is to be computed, before going into
  the details of <em|how> the computation is performed. Unfortunately, this
  style differs considerably from other block-structured programming
  languages, which often place local definitions in front of the code they
  apply to. Pure doesn't offer any special syntax for this, but note that you
  can always write a <hlink|<with|font-family|tt|when>|#when> or
  <hlink|<with|font-family|tt|with>|#with> clause in the following style
  which places the ``body'' at the bottom:

  <\verbatim>
    result when

    \ \ y = foo (x+1);

    \ \ z = bar y;

    \ \ result = baz z;

    end;
  </verbatim>

  This can be read and written more or less like a <verbatim|let> expression
  in Scheme or ML, except that the name of the result is given explicitly at
  the beginning. However, this style doesn't really save you either if you
  need several sections with both local functions and variables. In this case
  you'll just have to bite the bullet and arrange the
  <hlink|<with|font-family|tt|with>|#with> and
  <hlink|<with|font-family|tt|when>|#when> clauses the way that Pure wants
  them. That is, first come the local variables used in the right-hand side,
  then the local functions needed to compute those variables, then maybe
  another section with local variables needed by those functions, etc. When
  looking at such a complicated series of definitions, it sometimes helps to
  read the <hlink|<with|font-family|tt|with>|#with> and
  <hlink|<with|font-family|tt|when>|#when> blocks ``in reverse'', i.e., from
  bottom to top, which is the order in which they will actually be executed.

  <subsubsection|Non-Linear Patterns<label|non-linear-patterns>>

  As explained in section <hlink|Patterns|#patterns>, Pure allows multiple
  occurrences of the same variable in a pattern (so-called non-linearities):

  <\verbatim>
    foo x x = x;
  </verbatim>

  This rule will only be matched if both occurrences of <verbatim|x> are
  bound to the same value. More precisely, the two instances of <verbatim|x>
  will checked for syntactic equality during pattern matching, using the
  <hlink|<with|font-family|tt|same>|purelib.tm#same> primitive provided by
  the prelude. This may need time proportional to the sizes of both argument
  terms, and thus become quite costly for big terms. In fact,
  <hlink|<with|font-family|tt|same>|purelib.tm#same> might not even terminate
  at all if the compared terms are both infinite lazy data structures, such
  as in <verbatim|foo> <verbatim|(1..inf)> <verbatim|(1..inf)>. So you have
  to be careful to avoid such uses.

  When using non-linearities in conjunction with ``as'' patterns, you also
  have to make sure that the ``as'' variable does not occur inside the
  corresponding subpattern. Thus a definition like the following is illegal:

  <\verbatim>
    \<gtr\> foo xs@(x:xs) = x;

    \<less\>stdin\<gtr\>, line 1: error in pattern (recursive variable 'xs')
  </verbatim>

  The explanation is that such a pattern couldn't possibly be matched by a
  finite list anyway. Indeed, the only match for <verbatim|xs@(x:xs)> would
  be an infinite list of <verbatim|x>`s, and there's no way that this
  condition could be verified in a finite amount of time. Therefore the
  interpreter reports a ``recursive variable'' error in such situations.

  <subsubsection|``As'' Patterns<label|as-patterns>>

  In the current implementation, ``as'' patterns cannot be placed on the
  ``spine'' of a function definition. Thus rules like the following, which
  have the pattern somewhere in the head of the left-hand side, will all
  provoke an error message from the compiler:

  <\verbatim>
    a@foo x y \ \ = a,x,y;

    a@(foo x) y = a,x,y;

    a@(foo x y) = a,x,y;
  </verbatim>

  This is because the spine of a function application is not available when
  the function is called at runtime. ``As'' patterns in pattern bindings
  (<hlink|<with|font-family|tt|let>|#let>,
  <hlink|<with|font-family|tt|const>|#const>,
  <hlink|<with|font-family|tt|case>|#case>,
  <hlink|<with|font-family|tt|when>|#when>) are not affected by this
  restriction since the entire value to be matched is available at runtime.
  For instance:

  <\verbatim>
    \<gtr\> case bar 99 of y@(bar x) = y,x+1; end;

    bar 99,100
  </verbatim>

  <subsubsection|``Head = Function'' Pitfalls<label|head-function-pitfalls>>

  <hlink|The ``head = function'' rule|#the-head-function-rule> stipulates
  that the head symbol <verbatim|f> of an application <verbatim|f>
  <verbatim|x1> <verbatim|...> <verbatim|xn> occurring on (or inside) the
  left-hand side of an equation, variable binding, or pattern-matching lambda
  expression, is always interpreted as a literal function symbol (not a
  variable). This implies that you cannot match the ``function'' component of
  an application against a variable, at least not directly. An anonymous
  ``as'' pattern like <verbatim|f@_> does the trick, however, since the
  anonymous variable is always recognized, even if it occurs as the head
  symbol of a function application. Here's a little example which
  demonstrates how you can convert a function application to a list
  containing the function and all arguments:

  <\verbatim>
    \<gtr\> foo x = a [] x with a xs (x@_ y) = a (y:xs) x; a xs x = x:xs end;

    \<gtr\> foo (a b c d);

    [a,b,c,d]
  </verbatim>

  This may seem a little awkward, but as a matter of fact the ``head =
  function'' rule is quite convenient, since it covers the common cases
  without forcing the programmer to declare variable or constructor symbols
  (other than nonfix symbols). On the other hand, generic rules operating on
  arbitrary function applications are not all that common, so having to
  ``escape'' a variable using the anonymous ``as'' pattern trick is a small
  price to pay for that convenience.

  Sometimes you may also run into the complementary problem, i.e., to match a
  function argument against a given function. Consider this code fragment:

  <\verbatim>
    foo x = x+1;

    foop f = case f of foo = 1; _ = 0 end;
  </verbatim>

  You might expect <verbatim|foop> to return true for <verbatim|foo>, and
  false on all other values, but in reality <verbatim|foop> will always
  return true! In fact, the Pure compiler will warn you about the second rule
  of the <hlink|<with|font-family|tt|case>|#case> expression not being used
  at all:

  <\verbatim>
    \<gtr\> foop 99;

    warning: rule never reduced: _ = 0;

    1
  </verbatim>

  This is again due to the ``head = function'' rule; <verbatim|foo> is
  neither the head symbol of a function application nor a
  <hlink|<with|font-family|tt|nonfix>|#nonfix> symbol here, so it is
  considered a variable, even though it is defined as a global function
  elsewhere. (As a matter of fact, this is rather useful, since otherwise a
  rule like <verbatim|f> <verbatim|g> <verbatim|=> <verbatim|g+1> would
  suddenly change meaning if you happen to add a definition like <verbatim|g>
  <verbatim|x> <verbatim|=> <verbatim|x-1> somewhere else in your program,
  which certainly isn't desirable.)

  A possible workaround is to ``escape'' the function symbol using an empty
  namespace qualifier:

  <\verbatim>
    foop f = case f of ::foo = 1; _ = 0 end;
  </verbatim>

  This trick works in <hlink|<with|font-family|tt|case>|#case> expressions
  and function definitions, but fails in circumstances in which qualified
  variable symbols are permitted (i.e., in variable and constant
  definitions). A better solution is to employ the syntactic equality
  operator <verbatim|===> defined in the prelude to match the target value
  against the function symbol. This allows you to define the <verbatim|foop>
  predicate as follows:

  <\verbatim>
    \<gtr\> foop f = f===foo;

    \<gtr\> foop foo, foop 99;

    1,0
  </verbatim>

  Another way to deal with the situation would be to just declare
  <verbatim|foo> as a nonfix symbol. However, this makes the <verbatim|foo>
  symbol ``precious'', i.e., after such a declaration it cannot be used as a
  local variable anymore. It's usually a good idea to avoid that kind of
  thing, at least for generic symbols, so the above solution is preferred in
  this case.

  <subsubsection|Defined Functions<label|defined-functions>>

  As explained in <hlink|Definitions and Expression
  Evaluation|#definitions-and-expression-evaluation>, Pure doesn't really
  distinguish ``constructors'' from ``defined functions'' and thus allows any
  function symbol to become part of a normal form expression yielded by an
  evaluation. This behaviour follows the usual semantics of (typeless) term
  rewriting and is essential if you also want to evaluate expressions
  symbolically.

  However, this becomes a nuisance if you really expect the given function to
  reduce to something else, and just accidentally supplied the wrong
  arguments to the function. Especially annoying in this respect are
  functions involving side effects:

  <\verbatim>
    \<gtr\> using system;

    \<gtr\> puts 99;

    puts 99
  </verbatim>

  Here we accidentally specified a number (rather than a string) as the
  argument of the <hlink|<with|font-family|tt|puts>|purelib.tm#puts>
  function. This kind of error can easily be spotted if the function is
  invoked interactively, but it may well go unnoticed if the call is buried
  deeply in a big program which runs unattended (in batch mode).

  As a remedy, Pure 0.48 introduces the <hlink|<em|--defined>|#cmdoption-pure-pragma--defined>
  pragma (cf. <hlink|Code Generation Options|#code-generation-options>) which
  allows you to explicitly declare a function symbol as a ``defined''
  function, so that it will raise a proper exception when the defining
  equations (or, as it were, the external definition) of the function are not
  applicable to the subject expression:

  <\verbatim>
    \<gtr\> #! --defined puts

    \<gtr\> puts 99;

    \<less\>stdin\<gtr\>, line 4: unhandled exception 'failed_match' while
    evaluating 'puts 99'
  </verbatim>

  This is the same kind of <hlink|<with|font-family|tt|failed_match>|purelib.tm#failed-match>
  exception that you'll get, e.g., if the subject term fails to match all
  patterns in a <hlink|<with|font-family|tt|case>|#case> construct, cf.
  <hlink|Exception Handling|#exception-handling>.

  Note that the <hlink|<em|--defined>|#cmdoption-pure-pragma--defined> pragma
  only has an effect on global functions; local functions in a
  <hlink|<with|font-family|tt|with>|#with> expression will always be
  evaluated in Pure's default symbolic mode. Thus, if you need the above
  behaviour with a local function then you'll either have to add the
  exception handling yourself or turn the local function into a global one.

  Also note that an exception will only be generated if the symbol actually
  has any defining equations, so a ``pure constructor'' (i.e., a symbol
  without defining equations) will still return a normal form even if it is
  also declared <hlink|<em|--defined>|#cmdoption-pure-pragma--defined>:

  <\verbatim>
    \<gtr\> #! --defined foo

    \<gtr\> foo bar;

    foo bar
  </verbatim>

  Nevertheless, the <hlink|<em|--defined>|#cmdoption-pure-pragma--defined>
  pragma will be recorded and take effect as soon as you add an equation for
  the function:

  <\verbatim>
    \<gtr\> foo x::int = x+1;

    \<gtr\> foo bar;

    \<less\>stdin\<gtr\>, line 4: unhandled exception 'failed_match' while
    evaluating 'foo bar'
  </verbatim>

  There's also a <hlink|<em|--nodefined>|#cmdoption-pure-pragma--nodefined>
  pragma which reverts the function to the default behaviour of returning
  normal forms:

  <\verbatim>
    \<gtr\> #! --nodefined foo

    \<gtr\> foo bar;

    foo bar
  </verbatim>

  As indicated, the <hlink|<em|--defined>|#cmdoption-pure-pragma--defined>
  and <hlink|<em|--nodefined>|#cmdoption-pure-pragma--nodefined> pragmas can
  be invoked freely at any time, and the interpreter takes care that the
  affected function is recompiled automatically as needed.

  Pure 0.58 and later also provide a <hlink|<em|--nosymbolic>|#cmdoption-pure--nosymbolic>
  compilation option which lets you switch the interpreter to the
  non-symbolic mode of operation, so that <em|every> global function with
  equations becomes a defined function. This option is most commonly used as
  a pragma to delineate code sections with defined functions, so that you
  don't have to write out the <hlink|<em|--defined>|#cmdoption-pure-pragma--defined>
  pragmas for each function. The <hlink|<em|--symbolic>|#cmdoption-pure--symbolic>
  pragma is then used to switch back to the default symbolic mode. For
  instance:

  <\verbatim>
    \<gtr\> run

    \<gtr\> #! --nosymbolic

    \<gtr\> extern int puts(char*);

    \<gtr\> foo x::int = x+1;

    \<gtr\> puts 99;

    \<less\>stdin\<gtr\>, line 4: unhandled exception 'failed_match' while
    evaluating 'puts 99'

    \<gtr\> foo bar;

    \<less\>stdin\<gtr\>, line 5: unhandled exception 'failed_match' while
    evaluating 'foo bar'

    \<gtr\> #! --symbolic

    \<gtr\> bar x::int = x-1;

    \<gtr\> bar foo;

    bar foo
  </verbatim>

  Note that these pragmas only adjust the default behaviour of functions. It
  is still possible to change the status of individual functions with the
  <hlink|<em|--defined>|#cmdoption-pure-pragma--defined> and
  <hlink|<em|--nodefined>|#cmdoption-pure-pragma--nodefined> pragmas:

  <\verbatim>
    \<gtr\> #! --nodefined foo

    \<gtr\> foo bar;

    foo bar

    \<gtr\> #! --defined bar

    \<gtr\> bar foo;

    \<less\>stdin\<gtr\>, line 12: unhandled exception 'failed_match' while
    evaluating 'bar foo'
  </verbatim>

  You can even invoke the interpreter with the
  <hlink|<em|--nosymbolic>|#cmdoption-pure--nosymbolic> command line option
  so that the non-symbolic mode becomes the global default. However, this
  affects <em|all> functions in a program, including the library functions
  used by your program. It isn't really advisable to do this, because at the
  time of this writing many library modules still assume Pure's default mode
  of symbolic evaluation, and so a global switch to
  <hlink|<em|--nosymbolic>|#cmdoption-pure--nosymbolic> may well break some
  of these functions.

  At this time, the <hlink|<em|--defined>|#cmdoption-pure-pragma--defined>
  and <hlink|<em|--nosymbolic>|#cmdoption-pure--nosymbolic> pragmas are still
  considered experimental. They interfere with Pure's symbolic evaluation
  capabilities, so they aren't currently used in the standard library and we
  recommend that programmers shouldn't use them in a careless fashion either.
  However, while most error conditions stemming from unexpected normal forms
  can also be caught with diligent unit testing, these pragmas can save you
  time and trouble, especially when testing programs which are to be executed
  mostly in batch mode. Future versions of the interpreter might also make
  good use of these pragmas for static checks and optimization purposes.

  <subsubsection|Stack Size and Tail Recursion<label|stack-size-and-tail-recursion>>

  Pure programs may need a considerable amount of stack space to handle
  recursive function and macro calls, and the interpreter itself also takes
  its toll. So you should configure your system accordingly (8 MB of stack
  space is recommended for 32 bit systems, systems with 64 bit pointers
  probably need more). The interpreter automatically performs advisory stack
  checks on function entry and raises a Pure exception if the current stack
  size exceeds a given limit. A reasonable default for the stack limit is
  defined by the implementation, please check the description of
  the<label|index-59><hlink|<with|font-family|tt|PURE_STACK>|#envvar-PURE-STACK>
  environment variable for details.

  You can also change this limit if needed, by setting
  the<label|index-60><hlink|<with|font-family|tt|PURE_STACK>|#envvar-PURE-STACK>
  environment variable accordingly. The value
  of<label|index-61><hlink|<with|font-family|tt|PURE_STACK>|#envvar-PURE-STACK>
  should be the maximum stack size in kilobytes. Please note that this is
  only an advisory limit which does not change the program's physical stack
  size, so you can set this to any value that seems appropriate. (You can
  also set<label|index-62><hlink|<with|font-family|tt|PURE_STACK>|#envvar-PURE-STACK>
  to zero to completely disable the checks, but this isn't recommended.) Your
  operating system should supply you with a command such as ulimit(1) to set
  the real process stack size. (The<label|index-63><hlink|<with|font-family|tt|PURE_STACK>|#envvar-PURE-STACK>
  limit should be a little less than that, to account for temporary stack
  usage by the interpreter itself.)

  Like Scheme, Pure does proper tail calls (if LLVM provides that feature on
  the platform at hand), so tail-recursive definitions should work fine in
  limited stack space. For instance, the following little program will loop
  forever if your platform supports the required optimizations:

  <\verbatim>
    loop with loop = loop end;
  </verbatim>

  This also works if your definition involves function parameters, guards and
  multiple equations, of course. Moreover, conditional expressions
  (<hlink|<with|font-family|tt|if>|#if>-<hlink|<with|font-family|tt|then>|#then>-<hlink|<with|font-family|tt|else>|#else>)
  are tail-recursive in both branches, and the logical operators
  <hlink|<with|font-family|tt|&&>|#-amp-amp/special> and
  <hlink|<with|font-family|tt|\|\|>|#\|\|/special>, as well as the sequence
  operator <hlink|<with|font-family|tt|$$>|#-dollar-dollar>, are
  tail-recursive in their second operand.

  In addition, the Pure compiler also does a specialized form of tail
  recursion optimization for type definition rules. Due to the special way in
  which type tags are processed, however, the amount of optimization
  performed in this case is somewhat limited; see <hlink|Recursive
  Types|#recursive-types> below.

  Finally, note that tail call optimization is <em|always> disabled if the
  debugger is enabled (-g). This makes it much easier to debug programs, but
  means that you may run into stack overflows when debugging a program that
  does deep tail recursion.

  <subsubsection|Handling of Asynchronous
  Signals<label|handling-of-asynchronous-signals>>

  As described in section <hlink|Exception Handling|#exception-handling>,
  signals delivered to the process can be caught and handled with Pure's
  exception handling facilities. This has its limitations, however. Since
  Pure code cannot be executed directly from a C signal handler, checks for
  pending signals are only done on function entry. This means that in certain
  situations (such as the execution of an external C routine), delivery of a
  signal may be delayed by an arbitrary amount of time. Moreover, if more
  than one signal arrives between two successive signal checks, only the last
  one will be reported in the current implementation.

  When delivering a signal which has been remapped to a Pure exception, the
  corresponding exception handler (if any) will be invoked as usual. Further
  signals are blocked while the exception handler is being executed.

  A fairly typical case is that you have to handle signals in a
  tail-recursive function. This can be done with code like the following:

  <\verbatim>
    using system;

    \;

    // Remap some common POSIX signals.

    do (trap SIG_TRAP) [SIGHUP, SIGINT, SIGTERM];

    \;

    loop = catch handler process $$ loop

    with handler (signal k) = printf "Hey, I got signal %d.\\n" k end;

    process = sleep 1; // do something
  </verbatim>

  Running the above <verbatim|loop> function enters an endless loop reporting
  all signals delivered to the process. Note that to make this work, the
  tail-recursive invocation of <verbatim|loop> must immediately follow the
  signal-handling code, so that signals don't escape the exception handler.

  Of course, in a real application you'd probably want the <verbatim|loop>
  function to carry around some data to be processed by the
  <verbatim|process> routine, which then returns an updated value for the
  next iteration. This can be implemented as follows:

  <\verbatim>
    loop x = loop (catch handler (process x))

    with handler (signal k) = printf "Hey, I got signal %d.\\n" k $$ 0 end;

    process x = printf "counting: %d\\n" x $$ sleep 1 $$ x+1;
  </verbatim>

  <subsubsection|Recursive Types<label|recursive-types>>

  Using the facilities described in <hlink|Type Rules|#type-rules>, type tags
  can easily be defined in a recursive fashion. In simple cases, the compiler
  can optimize such definitions so that they are executed in constant stack
  space, just like ordinary tail-recursive functions. The main difference
  here is that the recursion already takes place during <em|matching>, i.e.,
  on the <em|left-hand> side of a rule, since this is where type predicates
  are normally invoked. This also limits the amount of tail recursion
  optimization available on type rules, as detailed below.

  For instance, the following <hlink|<with|font-family|tt|rlist>|purelib.tm#rlist/type>
  type from the prelude is defined in such a way that it only matches
  ``proper'' lists which have list values in all their tails (and are thus
  terminated by the empty list).

  <\verbatim>
    type rlist [] \| rlist (x : xs::rlist);
  </verbatim>

  Note that this type definition recurses in the <em|last>
  <hlink|<with|font-family|tt|rlist>|purelib.tm#rlist/type> tag of the
  <em|last> rule of the type. If tail calls are supported by the host
  implementation (cf. <hlink|Stack Size and Tail
  Recursion|#stack-size-and-tail-recursion>), the compiler makes sure that
  such definitions are safe to use even if the recursion may go arbitrarily
  deep. For instance:

  <\verbatim>
    \<gtr\> typep rlist (1..10000000);

    1
  </verbatim>

  The precise rules for tail-recursive type definitions are as follows:

  <\itemize>
    <item>The <em|last> rule of the type must have a trivial right-hand side
    (either just <hlink|<with|font-family|tt|true>|purelib.tm#true> or
    missing) and must be <em|directly> recursive in the <em|last> type tag on
    the left-hand side of the rule.

    <item>The rule may not contain any non-linearities. (That's because these
    are always checked <em|after> the type guards for efficiency.)
  </itemize>

  While these are rather strict requirements, they work reasonably well for
  simple recursive types such as the recursive list type above. More general
  recursion in types will not be optimized by the compiler, however, and may
  thus be subject to stack overflows. For instance, consider the following
  binary tree type:

  <\verbatim>
    nonfix nil;

    type tree nil \| tree (bin x l::tree r::tree);
  </verbatim>

  This is a perfectly legal type definition, and the recursion in the last
  <verbatim|tree> tag of the second rule will indeed be optimized away.
  However, the second rule also recurses on the <em|first> <verbatim|tree>
  tag which will cause trouble if there are long chains of left branches in a
  tree. For instance:

  <\verbatim>
    \<gtr\> mktree xs = foldr (\\x t-\<gtr\>bin x t nil) nil xs;

    \<gtr\> mktree [];

    nil

    \<gtr\> mktree [1,2,3];

    bin 1 (bin 2 (bin 3 nil nil) nil) nil

    \<gtr\> typep tree (mktree []);

    1

    \<gtr\> typep tree (mktree [1,2,3]);

    1

    \<gtr\> typep tree (mktree (1..10000));

    \<less\>stdin\<gtr\>, line 6: unhandled exception 'stack_fault' while
    evaluating

    'typep tree (mktree (1..10000))'
  </verbatim>

  To avoid deep recursion in such cases it is necessary to implement the type
  using a general predicate, which handles the recursion by transforming it
  into a tail-recursive form using a technique like <hlink|continuation
  passing|http://en.wikipedia.org/wiki/Continuation-passing-style>.

  There's yet another important issue with recursive type definitions, namely
  the <em|time> it takes to check the definition. In the above example,
  checking <hlink|<with|font-family|tt|rlist>|purelib.tm#rlist/type> takes
  <puredoc-image|_images/math/6c57aa00a4239462db1583967b78dccfa03de09a.png|66%|66%||>
  time, where n is the size of the list. This will have dire consequences if
  you do this check repeatedly while traversing a list, as in the following
  <verbatim|sum> function:

  <\verbatim>
    sum xs::rlist = if null xs then 0 else head xs+sum (tail xs);
  </verbatim>

  As this function repeatedly checks its entire argument, the total time it
  takes to compute the sum of a list this way becomes
  <puredoc-image|_images/math/225cf199c9568a1a204e4c364ebed6a991b6a00d.png|66%|66%||>.
  To see how slow this function is, just try it on successively larger lists
  <verbatim|1..1000>, <verbatim|1..2000>, etc. One way to work around this is
  to write a ``wrapper'' function which simply checks the type of its
  argument in advance and then invokes a ``worker'' function to do the actual
  computation:

  <\verbatim>
    sum xs::rlist = sum xs with

    \ \ sum xs = if null xs then 0 else head xs+sum (tail xs);

    end;
  </verbatim>

  This ``wrapper-worker'' design is quite common and useful in many
  situations, but it is a bit cumbersome in this specific case. An easier way
  is to just do the type checking in a piecemeal fashion, as the list is
  being traversed. To these ends, the prelude also provides a basic
  <hlink|<with|font-family|tt|list>|purelib.tm#list/type> type which is
  defined as follows:

  <\verbatim>
    type list [] \| list (x:xs);
  </verbatim>

  Note that the recursion is missing here and thus this type can always be
  checked in <puredoc-image|_images/math/62d0effd6477f4244d585fc25f46a645378a4ceb.png|66%|66%||>
  time, performing just a single pattern match, which is efficient. Hence, if
  we replace <hlink|<with|font-family|tt|rlist>|purelib.tm#rlist/type> with
  the <hlink|<with|font-family|tt|list>|purelib.tm#list/type> type in our
  original definition then <verbatim|sum> will now run in
  <puredoc-image|_images/math/6c57aa00a4239462db1583967b78dccfa03de09a.png|66%|66%||>
  time, as desired. On the other hand, this approach also has its drawbacks.
  For instance, consider:

  <\verbatim>
    \<gtr\> sum xs::list = if null xs then 0 else head xs+sum (tail xs);

    \<gtr\> sum (1:2:3);

    1+(2+sum 3)
  </verbatim>

  In contrast, our wrapper-worker definition of <verbatim|sum> from above
  returns a somewhat prettier normal form instead:

  <\verbatim>
    \<gtr\> clear sum

    \<gtr\> sum xs::rlist = sum xs with

    \<gtr\> \ \ sum xs = if null xs then 0 else head xs+sum (tail xs);

    \<gtr\> end;

    \<gtr\> sum (1:2:3);

    sum (1:2:3)
  </verbatim>

  Thus the wrapper-worker approach also has its merits, and whether to use
  one or the other depends on the situation. Similar techniques and tradeoffs
  also apply to other recursive types such as trees.

  <subsubsection|Interfaces<label|interfaces>>

  Pure's implementation of <hlink|interface types|#interface-types> has some
  notable differences to interfaces in a statically typed language like
  <hlink|Go|#go>. These are mostly due to Pure's dynamically typed nature.

  <\itemize>
    <item>Nothing is known about the <em|return type> of an interface
    operation, but this is no real impediment since Pure types are all about
    restricting the kind of <em|arguments> which can be passed to a function,
    not their result types, so return types are irrelevant to Pure's
    interface types anyway.

    <item>Pure interfaces aren't based on the notion of ``methods'' and
    therefore don't provide any kind of ``method dispatch''. Interface
    operations are just ordinary Pure functions which rely on Pure's usual
    pattern-matching mechanism to do the dynamic dispatch.

    <item>Membership in interface types is decided by considering the
    left-hand sides of the definitions of the interface functions only.
    Guards are not taken into account, and thus there's no real guarantee
    that a member of an interface type will always be valid input to an
    interface function.

    <item>Interface types work best if all interface operations are
    completely defined on the target data domain. This may sometimes force
    you to add default or error rules raising exceptions, as shown in the
    <hlink|Interface Types|#interface-types> section, which may interfere
    with symbolic evaluation (cf. <hlink|Exception
    Handling|#exception-handling> and <hlink|Defined
    Functions|#defined-functions>). If this is not desirable, you can also
    just include the missing members manually. To these ends, Pure allows an
    interface type to be augmented with ordinary type rules as described in
    <hlink|Type Rules|#type-rules>. For instance, we might also have
    implemented the stack type discussed in the <hlink|Interface
    Types|#interface-types> section as follows:

    <\verbatim>
      interface stack with

      \ \ push s::stack x;

      \ \ pop s::stack;

      \ \ top s::stack;

      end;

      \;

      type stack [];

      \;

      push xs@[] x \| push xs@(_:_) x = x:xs;

      pop (x:xs) = xs;

      top (x:xs) = x;
    </verbatim>
  </itemize>

  Pure's interface types are really a compromise between theoretical
  soundness and practicality. From the theoretical point of view, we'd like
  an interface type to be the <em|intersection> of the interface types for
  the individual interface functions. Unfortunately, the pattern set for such
  an intersection type might well be exponential in size. Hence the approach
  taken in Pure is to eliminate those candidate patterns which aren't
  supported by all interface functions. This can be done much more
  efficiently, but will in general only produce a subtype of the intersection
  type. (On the other hand, this method also has the advantage that the
  compiler can warn about potentially missing rules in some of the interface
  operations. We've seen in the <hlink|Interface Types|#interface-types>
  section that this can be fairly useful at times.)

  Another issue arises with interface operations which allow the interface
  type in multiple arguments. A typical example are operators:

  <\verbatim>
    interface addable with x::addable + y::addable; end;
  </verbatim>

  In the present implementation, the pattern set will be the <em|union> of
  the pattern sets for each argument, so the above definition is in fact
  equivalent to:

  <\verbatim>
    interface addable with x::addable + y; x + y::addable; end;
  </verbatim>

  This makes sense in many situations, but of course this depends on the
  particular operation. In some cases, you might have to decide on which
  argument you want to place the interface type tag, or even have different
  types for each possible argument position.

  <subsubsection|Numeric Calculations<label|numeric-calculations>>

  If possible, you should decorate numeric variables on the left-hand sides
  of function definitions with the appropriate type tags, like <verbatim|int>
  or <verbatim|double>. This often helps the compiler to generate better code
  and makes your programs run faster. The <verbatim|\|> syntax makes it easy
  to add the necessary specializations of existing rules to your program.
  E.g., taking the polymorphic implementation of the factorial as an example,
  you only have to add a left-hand side with the appropriate type tag to make
  that definition go as fast as possible for the special case of machine
  integers:

  <\verbatim>
    fact n::int \ \ \ \|

    fact n \ \ \ \ \ \ \ \ = n*fact(n-1) if n\<gtr\>0;

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ = 1 otherwise;
  </verbatim>

  (This obviously becomes unwieldy if you have to deal with several numeric
  arguments of different types, however, so in this case it is usually better
  to just use a polymorphic rule.)

  Also note that int (the machine integers), bigint (the GMP ``big''
  integers) and double (floating point numbers) are all different kinds of
  objects. While they can be used in mixed operations (such as multiplying an
  int with a bigint which produces a bigint, or a bigint with a double which
  produces a double), the <verbatim|int> tag will only ever match a machine
  int, <em|not> a bigint or a double. Likewise, <verbatim|bigint> only
  matches bigints (never int or double values), and <verbatim|double> only
  doubles. Thus, if you want to define a function operating on different
  kinds of numbers, you'll also have to provide equations for all the types
  that you need (or a polymorphic rule which catches them all). This also
  applies to equations matching against constant values of these types. In
  particular, a small integer constant like <verbatim|0> only matches machine
  integers, not bigints; for the latter you'll have to use the ``big L''
  notation <verbatim|0L>. Similarly, the constant <verbatim|0.0> only matches
  doubles, but not ints or bigints.

  <subsubsection|Constant Definitions<label|constant-definitions>>

  Constants differ from variables in that they cannot be redefined (that's
  their main purpose after all) so that their values, once defined, can be
  substituted into other definitions which use them. For instance:

  <\verbatim>
    \<gtr\> const c = 2;

    \<gtr\> foo x = c*x;

    \<gtr\> show foo

    foo x = 2*x;

    \<gtr\> foo 99;

    198
  </verbatim>

  While a variable can be rebound to a new value at any time, you will get an
  error message if you try to do this with a constant:

  <\verbatim>
    \<gtr\> const c = 3;

    \<less\>stdin\<gtr\>, line 5: symbol 'c' is already defined as a constant
  </verbatim>

  Note that in interactive mode you can work around this by purging the old
  definition with the <verbatim|clear> command. However, this won't affect
  any earlier uses of the symbol:

  <\verbatim>
    \<gtr\> clear c

    \<gtr\> const c = 3;

    \<gtr\> bar x = c*x;

    \<gtr\> show foo bar

    bar x = 3*x;

    foo x = 2*x;
  </verbatim>

  (You'll also have to purge any existing definition of a variable if you
  want to redefine it as a constant, or vice versa, since Pure won't let you
  redefine an existing constant or variable as a different kind of symbol.
  The same also holds if a symbol is currently defined as a function or a
  macro.)

  Constants can also be used in patterns (i.e., on the left-hand side of a
  rule in a definition or a <hlink|<with|font-family|tt|case>|#case>
  expression), but only if they're also declared as
  <hlink|<with|font-family|tt|nonfix>|#nonfix>. The prelude already does this
  for the truth values <hlink|<with|font-family|tt|true>|purelib.tm#true> and
  <hlink|<with|font-family|tt|false>|purelib.tm#false> (which are in fact
  just <verbatim|1> and <verbatim|0>), so that you can write, e.g.:

  <\verbatim>
    \<gtr\> check false = "no"; check true = "yes";

    \<gtr\> show check

    check 0 = "no";

    check 1 = "yes";

    \<gtr\> check (5\<gtr\>0);

    "yes"
  </verbatim>

  Note that if <hlink|<with|font-family|tt|true>|purelib.tm#true> and
  <hlink|<with|font-family|tt|false>|purelib.tm#false> weren't
  <hlink|<with|font-family|tt|nonfix>|#nonfix>, the above definition of
  <verbatim|check> wouldn't work as intended, because the
  <hlink|<with|font-family|tt|true>|purelib.tm#true> and
  <hlink|<with|font-family|tt|false>|purelib.tm#false> symbols on the
  left-hand side of the two equations would be interpreted as local
  variables. Also note that <hlink|<with|font-family|tt|true>|purelib.tm#true>
  and <hlink|<with|font-family|tt|false>|purelib.tm#false> are really an
  exceptional case; they aren't likely to be used as variables, so the
  prelude can make them <hlink|<with|font-family|tt|nonfix>|#nonfix> by
  default. In most cases the standard library refrains from declaring
  constant symbols as <hlink|<with|font-family|tt|nonfix>|#nonfix>, so that
  they don't accidentally clobber variables in user code. This is the case,
  in particular, for constants in the <hlink|<with|font-family|tt|math>|purelib.tm#module-math>
  module such as <hlink|<with|font-family|tt|e>|purelib.tm#e>,
  <hlink|<with|font-family|tt|pi>|purelib.tm#pi> and
  <hlink|<with|font-family|tt|i>|purelib.tm#i> which are much more likely to
  be used as variable symbols.

  As the value of a constant is known at compile time, the compiler can apply
  various optimizations to uses of such values. In particular, the Pure
  compiler inlines constant scalars (numbers, strings and pointers) by
  literally substituting their values into the output code. It also
  precomputes simple constant expressions involving only (machine) integer
  and double values. (The latter is called <with|font-series|bold|constant
  folding> and can also be disabled, see the description of the
  <hlink|<em|--fold>|#cmdoption-pure--fold> and
  <hlink|<em|--nofold>|#cmdoption-pure--nofold> pragmas for details.)
  Example:

  <\verbatim>
    \<gtr\> extern double atan(double);

    \<gtr\> const pi = 4*atan 1.0;

    \<gtr\> show pi

    const pi = 3.14159265358979;

    \<gtr\> foo x = 2*pi*x;

    \<gtr\> show foo

    foo x = 6.28318530717959*x;
  </verbatim>

  Constant folding also works with conditional expressions. E.g., consider:

  <\verbatim>
    const win = index sysinfo "mingw32" \<gtr\>= 0;

    check boy = if win then bad boy else good boy;
  </verbatim>

  On a Linux system, this gives:

  <\verbatim>
    \<gtr\> show check

    check boy = good boy;
  </verbatim>

  By these means, you can employ a constant to configure your code for
  different environments, without any runtime penalties. Note that this only
  works with conditional expressions, not with guarded equations. However, in
  the latter case the LLVM backend still eliminates dead code automatically,
  so the <verbatim|check> function from above could also be defined as
  follows:

  <\verbatim>
    check boy = bad boy if win;

    \ \ \ \ \ \ \ \ \ \ = good boy otherwise;
  </verbatim>

  In this case the code for one of the branches of <verbatim|check> will be
  completely eliminated, depending on the outcome of the configuration check.
  (The interpreter will still print both equations if you type
  <verbatim|show> <verbatim|check>, but only one of the branches will
  actually be present in the assembler code of the function; you can verify
  this with <verbatim|show> <verbatim|-d> <verbatim|check>.)

  For efficiency, constant aggregates (lists, tuples, matrices and other
  kinds of non-scalar terms) receive special treatment. Here, the constant is
  computed once and stored in a read-only variable which then gets looked up
  at runtime, just like an ordinary global variable. However, there's an
  important difference: If a script is batch-compiled (cf. <hlink|Batch
  Compilation|#batch-compilation>), the constant value is normally computed
  <em|at compile time only>; when running the compiled executable, the
  constant value is simply reconstructed, which is often much more efficient
  than recomputing its value. For instance, you might use this to precompute
  a large table whose computation may be costly or involve functions with
  side effects:

  <\verbatim>
    const table = [foo x \| x = 1..1000000];

    process table;
  </verbatim>

  Note that this only works with <hlink|<with|font-family|tt|const>|#const>
  values which are completely determined at compile time. If a constant
  contains run time objects such as (non-null) pointers and (local)
  functions, this is impossible, and the batch compiler will instead create
  code to recompute the value of the constant at run time. For instance,
  consider:

  <\verbatim>
    const p = malloc 100;

    foo p;
  </verbatim>

  Here, the value of the pointer <verbatim|p> of course critically depends on
  its computation (involving a side effect which sets aside a corresponding
  chunk of memory). It would become unusable without actually executing the
  initialization, so the compiler generates the appropriate run time
  initialization code in this case. For all practical purposes, this turns
  the constant into a read-only variable. (There's also a code generation
  option to force this behaviour even for ``normal'' constants for which it's
  not strictly necessary, in order to create smaller executables; see
  <hlink|Options Affecting Code Size|#options-affecting-code-size> for
  details.)

  <subsubsection|External C Functions<label|external-c-functions>>

  The interpreter always takes your <hlink|<with|font-family|tt|extern>|#extern>
  declarations of C routines at face value. It will not go and read any C
  header files to determine whether you actually declared the function
  correctly! So you have to be careful to give the proper declarations,
  otherwise your program might well give a segfault when calling the
  function. This problem can to some extent be alleviated by using the
  bitcode interface, see <hlink|Importing LLVM
  Bitcode|#importing-llvm-bitcode> and <hlink|Inline Code|#inline-code> in
  the <hlink|C Interface|#c-interface> section. However, you always have to
  be careful when calling <hlink|variadic C functions|#variadic-c-functions>,
  as the compiler has no way of checking which combinations of extra
  parameters a function like <verbatim|printf> is to be invoked with. (As a
  remedy, the standard library provides safe implementations of
  <hlink|<with|font-family|tt|printf>|purelib.tm#printf> and other commonly
  used variadic functions from the C library, see the <hlink|<em|Pure Library
  Manual>|purelib.tm> for details.)

  Another limitation of the C interface is that it does not offer any special
  support for C structs and C function parameters. However, an optional addon
  module is available which interfaces to the
  <hlink|libffi|http://sourceware.org/libffi/> library to provide that kind
  of functionality, please see <hlink|<em|pure-ffi>|pure-ffi.tm> for details.

  Last but not least, to make it easier to create Pure interfaces to large C
  libraries, there's a separate pure-gen program available at the Pure
  website. This program takes a C header (.h) file and creates a
  corresponding Pure module with definitions and
  <hlink|<with|font-family|tt|extern>|#extern> declarations for the constants
  and functions declared in the header. Please refer to <hlink|<em|pure-gen:
  Pure interface generator>|pure-gen.tm> for details.

  <subsubsection|Calling Special Forms<label|calling-special-forms>>

  Special forms are recognized at compile time only. Thus the
  <hlink|<with|font-family|tt|catch>|#catch> function, as well as
  <hlink|<with|font-family|tt|quote>|#quote> and the operators
  <hlink|<with|font-family|tt|&&>|#-amp-amp/special>,
  <hlink|<with|font-family|tt|\|\|>|#\|\|/special>,
  <hlink|<with|font-family|tt|$$>|#-dollar-dollar> and
  <hlink|<with|font-family|tt|&>|#-amp>, are only treated as special forms in
  direct (saturated) calls. They can still be used if you pass them around as
  function values or in partial applications, but in this case they lose all
  their special call-by-name argument processing.

  <subsubsection|Laziness<label|laziness>>

  Pure does lazy evaluation in the same way as <hlink|Alice ML|#alice-ml>,
  providing an explicit operation (<hlink|<with|font-family|tt|&>|#-amp>) to
  defer evaluation and create a ``future'' which is called by need. However,
  note that like any language with a basically eager evaluation strategy,
  Pure cannot really support lazy evaluation in a fully automatic way. That
  is, coding an operation so that it works with infinite data structures
  usually requires additional thought, and sometimes special code will be
  needed to recognize futures in the input and handle them accordingly. This
  can be hard, but of course in the case of the prelude operations this work
  has already been done for you, so as long as you stick to these, you'll
  never have to think about these issues. (It should be noted here that lazy
  evaluation has its pitfalls even in fully lazy FPLs, such as hidden memory
  leaks and other kinds of subtle inefficiencies or non-termination issues
  resulting from definitions being too lazy or not lazy enough. You can read
  about that in any good textbook on Haskell.)

  The prelude goes to great lengths to implement all standard list operations
  in a way that properly deals with streams (a.k.a. lazy lists). What this
  all boils down to is that all list operations which can reasonably be
  expected to operate in a lazy way on streams, will do so. (Exceptions are
  inherently eager operations such as <hlink|<with|font-family|tt|#>|purelib.tm##>,
  <hlink|<with|font-family|tt|reverse>|purelib.tm#reverse> and
  <hlink|<with|font-family|tt|foldl>|purelib.tm#foldl>.) Only those portions
  of an input stream will be traversed which are strictly required to produce
  the result. For most purposes, this works just like in fully lazy FPLs such
  as Haskell. However, there are some notable differences:

  <\itemize>
    <item>Since Pure uses dynamic typing, some of the list functions may have
    to peek ahead one element in input streams to check their arguments for
    validity, meaning that these functions will be slightly more eager than
    their Haskell counterparts.

    <item>Pure's list functions never produce truly cyclic list structures
    such as the ones you get, e.g., with Haskell's <verbatim|cycle>
    operation. (This is actually a good thing, because the current
    implementation of the interpreter cannot garbage-collect cyclic
    expression data; please see the corresponding remarks in
    <hlink|<em|Expression References>|purelib.tm#expression-references> for
    details.) Cyclic streams such as <verbatim|cycle> <verbatim|[1]> or
    <verbatim|fix> <verbatim|(1:)> will of course work as expected, but,
    depending on the algorithm, memory usage may increase linearly as they
    are traversed.

    <item>Pattern matching is always refutable (and therefore eager) in Pure.
    If you need something like Haskell's irrefutable matches, you'll have to
    code them explicitly using futures. See the definition of the
    <hlink|<with|font-family|tt|unzip>|purelib.tm#unzip> function in the
    prelude for an example showing how to do this.
  </itemize>

  There are two other pitfalls with lazy data structures that you should be
  aware of:

  <\itemize>
    <item>Laziness and side effects don't go well together, as most of the
    time you can't be sure when a given thunk will be executed. So as a
    general guideline you should avoid side effects in thunked data
    structures. If you can't avoid them, then at least make sure that all
    accesses to the affected resources are done through a single instance of
    the thunked data structure. E.g., the following definition lets you
    create a stream of random numbers:

    <\verbatim>
      \<gtr\> using math;

      \<gtr\> let xs = [random \| _ = 1..inf];
    </verbatim>

    This works as expected if only a single stream created with
    <hlink|<with|font-family|tt|random>|purelib.tm#random> exists in your
    program. However, as the <hlink|<with|font-family|tt|random>|purelib.tm#random>
    function in the <hlink|<with|font-family|tt|math>|purelib.tm#module-math>
    module modifies an internal data structure to produce a sequence of
    pseudorandom numbers, using two or more such streams in your program will
    in fact modify the same underlying data structure and thus produce two
    disjoint subsequences of the same underlying pseudorandom sequence which
    might not be distributed uniformly any more.

    <item>You should avoid keeping references to potentially big (or even
    infinite) thunked data structures when traversing them (unless you
    specifically need to memoize the entire data structure). In particular,
    if you assign such a data structure to a local variable, the traversal of
    the data structure should then be invoked as a tail call. If you fail to
    do this, it forces the entire memoized part of the data structure to stay
    in main memory while it is being traversed, leading to rather nasty
    memory leaks. Please see the <verbatim|all_primes> function in
    <hlink|Lazy Evaluation and Streams|#lazy-evaluation-and-streams> for an
    example.
  </itemize>

  <subsubsection|Name Capture<label|name-capture>>

  As explained in the <hlink|Macro Hygiene|#macro-hygiene> section, Pure
  macros are lexically scoped and thus ``hygienic''. So in principle Pure
  macros are not susceptible to name capture. However, this principle only
  applies to ``real'' block constructs, not their quoted ``placeholder''
  representations described in <hlink|Built-in Macros and Special
  Expressions|#built-in-macros-and-special-expressions>. One (rather obscure)
  case which deserves special attention is the case of macros involving free
  variables which are being called inside quoted block constructs. Note that
  this corresponds to the ``mild'' first form of name capture described in
  the <hlink|Macro Hygiene|#macro-hygiene> section. For instance, consider
  the following example:

  <\verbatim>
    \<gtr\> def G x = x+y;

    \<gtr\> '(G 10 when y = 99 end);

    G 10 __when__ [y--\<gtr\>99]

    \<gtr\> eval ans;

    109
  </verbatim>

  Here the free <verbatim|y> variable of the macro <verbatim|G> got captured
  by the quoted <hlink|<with|font-family|tt|when>|#when> clause when the
  quoted expression is evaluated. This happens because, using call by value,
  the call <verbatim|G> <verbatim|10> gets evaluated before the
  <hlink|<with|font-family|tt|__when__>|#--when--> macro. So the behaviour of
  the macro evaluator in this case is in fact correct; the only remedy here
  is to avoid macros involving free variables inside a quoted block
  construct. The same applies to ``<hlink|<em|quoteargs>|#cmdoption-pure-pragma--quoteargs>''
  macros which quote their arguments automatically, as described in
  <hlink|Built-in Macros and Special Expressions|#built-in-macros-and-special-expressions>.
  On the other hand, the described behaviour might even be useful at times,
  to forcibly rebind a free macro variable. The following little helper macro
  illustrates this trick:

  <\verbatim>
    \<gtr\> #! --quoteargs invoke

    \<gtr\> def invoke x = x;

    \<gtr\> foo = invoke (G 10 when y = 99 end);

    \<gtr\> show foo

    foo = 10+y when y = 99 end;

    \<gtr\> foo;

    109
  </verbatim>

  Besides the above form of real name capture in quoted specials, there's
  also a case of apparent name capture in the expression printer which isn't
  actually real name capture, but just looks like it was. The reason for this
  is that the expression printer currently doesn't check for different
  bindings of the same variable identifier when it prints a (compile time)
  expression. For instance, consider:

  <\verbatim>
    \<gtr\> def F x = x+y when y = x+1 end;

    \<gtr\> foo y = F y;

    \<gtr\> show foo

    foo y = y+y when y = y+1 end;
  </verbatim>

  This <em|looks> as if <verbatim|y> got captured, but in fact it's not, it's
  just the <verbatim|show> command which displays the definition in an
  incorrect way. You can add the <verbatim|-e> option to <verbatim|show>
  which prints the deBruijn indices of locally bound symbols, then you see
  that the actual bindings are all right anyway:

  <\verbatim>
    \<gtr\> show -e foo

    foo y/*0:1*/ = y/*1:1*/+y/*0:*/ when y/*0:*/ = y/*0:1*/+1 end;
  </verbatim>

  Note that the number before the colon is the actual deBruijn index, the
  sequence of bits behind it is the subterm path. Thus the first instance of
  <verbatim|y> in <verbatim|y+y> (which has a deBruijn index of 1, indicating
  ``one environment up'') actually refers to the <verbatim|y> in the
  left-hand side <verbatim|foo> <verbatim|y>, while the second instance
  refers to the local binding <verbatim|y> <verbatim|=> <verbatim|y+1> in the
  <hlink|<with|font-family|tt|when>|#when> clause.

  Alas, this means that if you use <verbatim|dump> to write such a definition
  to a text file and read it back with <verbatim|run> later, then the
  apparent name capture becomes a real one and you'll get the wrong
  definition. This is an outright bug in the expression printer which will
  hopefully be fixed some time. But for the time being you will have to
  correct such glitches manually.

  <subsection|Author<label|author>>

  Albert Gräf \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>,
  Dept. of Computer Music, Johannes Gutenberg University of Mainz, Germany.

  <subsection|Acknowledgements<label|acknowledgements>>

  Pure wouldn't be what it is without its users and other people interested
  in the language. In particular, I'd like to thank Scott E. Dillard, Rooslan
  S. Khayrov, Jim Pryor, Eddie Rucker, Libor Spacek, Jiri Spitz, Peter
  Summerland and Sergei Winitzki for their significant contributions of code,
  patches and documentation. Thanks are also due to Björn Lindig, Michel
  Salim, Ryan Schmidt and Zhihao Yuan who maintain the Arch Linux, Fedora,
  OSX and FreeBSD packages and ports, as well as to Vili Aapro, Jason E.
  Aten, Alvaro Castro Castilla, John Cowan, Chris Double, Tim Haynes, Wm
  Leler, John Lunney, Roman Neuhauser and Max Wolf for suggesting
  improvements and pointing out shortcomings, misfeatures and outright bugs.
  If it wasn't for all these people and others who contribute to the lively
  discussions on the mailing list, this project probably wouldn't have got
  anywhere.

  Last but not least, a big thank you goes to Chris Lattner and the entire
  LLVM team. <hlink|LLVM|#llvm> really changed the game for us compiler
  writers, as we can now stop worrying about all the nitty-gritty details of
  code generation and concentrate on the design and implementation of the
  programming language at hand.

  <subsection|Copying<label|copying>>

  (The following explanations are not legal advice. Please read the full text
  of the licenses and consult qualified professional counsel for an
  interpretation of the license terms as they apply to you.)

  Pure comes with a fairly liberal license which lets you distribute your own
  Pure programs and extensions under a license of your choice and permits
  linking of commercial applications against the Pure runtime and the Pure
  standard library without requiring special permission. The Pure interpreter
  (the <verbatim|pure> main program), the Pure runtime library
  (<verbatim|libpure>) and the Pure standard library (the Pure scripts in the
  <verbatim|lib> folder distributed with the software) are distributed as
  free software, and you are welcome to modify and redistribute them under
  the appropriate license terms, as detailed below.

  The <em|Pure interpreter> is free software: you can redistribute it and/or
  modify it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or (at your
  option) any later version.

  The <em|Pure runtime library> and the <em|Pure standard library> are also
  free software: you can redistribute them and/or modify them under the terms
  of the GNU <em|Lesser> General Public License as published by the Free
  Software Foundation, either version 3 of the License, or (at your option)
  any later version.

  Pure is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.

  One thing to note here is that the interpreter program is distributed under
  the <hlink|GNU General Public License|http://www.gnu.org/copyleft/gpl.html>
  and is thus subject to stricter license terms than the runtime library and
  the standard library which are licensed under the <hlink|GNU Lesser General
  Public License|http://www.gnu.org/copyleft/lgpl.html>. The main reason for
  these conditions is that the interpreter program includes support for the
  readline library which is GPL-licensed software. If this is a problem for
  your application then you're welcome to use pure_norl.cc instead. This is a
  readline-free replacement for the interpreter main program included in the
  distribution, which is licensed under a 3-clause BSD-style license.

  Please see the <hlink|GNU General Public
  License|http://www.gnu.org/copyleft/gpl.html> and the <hlink|GNU Lesser
  General Public License|http://www.gnu.org/copyleft/lgpl.html> for the
  precise license terms. You can also find the license conditions in the
  COPYING and COPYING.LESSER files accompanying the software. Also, please
  see the source code for the copyright and license notes pertaining to
  individual source files which are part of this software.

  Third party software licensing notes:

  Pure uses <hlink|LLVM|#llvm> as its compiler backend. LLVM is under
  Copyright (c) 2003-2012 by the University of Illinois at Urbana-Champaign,
  and is licensed under a 3-clause BSD-style license, please read
  COPYING.LLVM included in the distribution for the exact licensing terms.
  You can also find the LLVM license at the <hlink|LLVM|#llvm> website.

  <subsection|References and Links<label|references-and-links>>

  <\description>
    <item*|Aardappel<label|aardappel>>Wouter van Oortmerssen's functional
    programming language based on term rewriting,
    <hlink|http://wouter.fov120.com/aardappel|http://wouter.fov120.com/aardappel>.
  </description>

  <\description>
    <item*|Alice ML<label|alice-ml>>A version of ML (see below) from which
    Pure borrows its model of lazy evaluation,
    <hlink|http://www.ps.uni-sb.de/alice|http://www.ps.uni-sb.de/alice>.
  </description>

  <\description>
    <item*|ATS<label|ats>>``Applied Type System'', a statically typed,
    ML-like programming language which unifies implementation with formal
    specification, <hlink|http://www.ats-lang.org/|http://www.ats-lang.org/>.
  </description>

  <\description>
    <item*|Franz Baader and Tobias Nipkow<label|baader-and-nipkow>><em|Term
    Rewriting and All That.> Cambridge University Press, Cambridge, 1998.
  </description>

  <\description>
    <item*|Bertrand<label|bertrand>>Wm Leler's constraint programming
    language based on term rewriting, <hlink|http://groups.google.com/group/bertrand-constraint|http://groups.google.com/group/bertrand-constraint>.
    See Wm Leler: <em|Constraint Programming Languages: Their Specification
    and Generation.> Addison-Wesley, 1988.
  </description>

  <\description>
    <item*|Clang<label|clang>>The new C/C++/Objective C compiler designed
    specifically to work on top of LLVM, <hlink|http://clang.llvm.org|http://clang.llvm.org>.
    Clang provides a comparatively light-weight alternative to gcc which is
    faster and has better and more friendly diagnostics.
  </description>

  <\description>
    <item*|DragonEgg<label|dragonegg>>An LLVM backend for gcc 4.5 and later,
    <hlink|http://dragonegg.llvm.org|http://dragonegg.llvm.org>. In contrast
    to <hlink|llvm-gcc|#llvm-gcc>, DragonEgg is implemented as a plugin which
    hooks into your system compiler.
  </description>

  <\description>
    <item*|Faust<label|faust>>Grame's functional DSP programming language,
    <hlink|http://faust.grame.fr|http://faust.grame.fr>.
  </description>

  <\description>
    <item*|GNU Multiprecision Library<label|gmp>>Free library for arbitrary
    precision arithmetic, <hlink|http://gmplib.org|http://gmplib.org>.
  </description>

  <\description>
    <item*|GNU Octave<label|octave>>A popular high-level language for numeric
    applications and free MATLAB replacement,
    <hlink|http://www.gnu.org/software/octave|http://www.gnu.org/software/octave>.
  </description>

  <\description>
    <item*|GNU Scientific Library<label|gsl>>A free software library for
    numeric applications, can be used with Pure's numeric matrices,
    <hlink|http://www.gnu.org/software/gsl|http://www.gnu.org/software/gsl>.
  </description>

  <\description>
    <item*|Go<label|go>>Google's Go programming language,
    <hlink|http://golang.org|http://golang.org>.
  </description>

  <\description>
    <item*|Haskell<label|haskell>>A popular non-strict FPL,
    <hlink|http://www.haskell.org|http://www.haskell.org>.
  </description>

  <\description>
    <item*|LLVM<label|llvm>>The LLVM code generator framework,
    <hlink|http://llvm.org|http://llvm.org>.
  </description>

  <\description>
    <item*|LLVM-GCC<label|llvm-gcc>>An LLVM-capable compiler based on gcc,
    see <hlink|http://llvm.org|http://llvm.org>. This is based on a fairly
    old gcc version (4.2) and has been replaced by the
    <hlink|DragonEgg|#dragonegg> plugin in the LLVM 3.x series.
  </description>

  <\description>
    <item*|Miranda<label|miranda>>David Turner's non-strict FPL,
    <hlink|http://miranda.org.uk|http://miranda.org.uk>. Miranda was fairly
    successful in its time and one of the forerunners of
    <hlink|Haskell|#haskell>.
  </description>

  <\description>
    <item*|ML<label|ml>>A popular strict FPL. See Robin Milner, Mads Tofte,
    Robert Harper, D. MacQueen: <em|The Definition of Standard ML (Revised).>
    MIT Press, 1997.
  </description>

  <\description>
    <item*|Michael O'Donnell<label|michael-o-donnell>><em|Equational Logic as
    a Programming Language.> Series in the Foundations of Computing. MIT
    Press, Cambridge, Mass., 1985.
  </description>

  <\description>
    <item*|Q<label|q>>Another term rewriting language by yours truly,
    <hlink|http://q-lang.sf.net|http://q-lang.sf.net>.
  </description>

  <\description>
    <item*|TeXmacs<label|texmacs>>A powerful editor for scientific documents.
    With the appropriate plugin (inluded in the Pure distribution as of Pure
    0.56) it can also run Pure sessions. See
    <hlink|http://www.texmacs.org|http://www.texmacs.org>.
  </description>

  <subsubsection*|<hlink|Table Of Contents|index.tm><label|pure-toc>>

  <\itemize>
    <item><hlink|The Pure Manual|#>

    <\itemize>
      <item><hlink|Introduction|#introduction>

      <\itemize>
        <item><hlink|Further Reading|#further-reading>

        <item><hlink|Typographical Conventions|#typographical-conventions>
      </itemize>

      <item><hlink|Invoking Pure|#invoking-pure>

      <\itemize>
        <item><hlink|Options|#options>

        <item><hlink|Overview of Operation|#overview-of-operation>

        <item><hlink|Compiling Scripts|#compiling-scripts>

        <item><hlink|Tagging Scripts|#tagging-scripts>

        <item><hlink|Running Interactively|#running-interactively>

        <item><hlink|Verbosity and Debugging
        Options|#verbosity-and-debugging-options>

        <item><hlink|Compilation Options|#compilation-options>

        <\itemize>
          <item><hlink|Code Generation Options|#code-generation-options>

          <item><hlink|Conditional Compilation|#conditional-compilation>

          <item><hlink|Warning Options|#warning-options>
        </itemize>

        <item><hlink|Startup Files|#startup-files>

        <item><hlink|Environment|#environment>
      </itemize>

      <item><hlink|Pure Overview|#pure-overview>

      <\itemize>
        <item><hlink|Lexical Matters|#lexical-matters>

        <item><hlink|Definitions and Expression
        Evaluation|#definitions-and-expression-evaluation>

        <\itemize>
          <item><hlink|Variables in Equations|#variables-in-equations>
        </itemize>

        <item><hlink|Expression Syntax|#expression-syntax>

        <\itemize>
          <item><hlink|Primary Expressions|#primary-expressions>

          <item><hlink|Simple Expressions|#simple-expressions>

          <item><hlink|Special Expressions|#special-expressions>
        </itemize>

        <item><hlink|Special Forms|#special-forms>

        <item><hlink|Toplevel|#toplevel>

        <item><hlink|Scoping Rules|#scoping-rules>
      </itemize>

      <item><hlink|Rule Syntax|#rule-syntax>

      <\itemize>
        <item><hlink|Patterns|#patterns>

        <\itemize>
          <item><hlink|The ``Head = Function'' Rule|#the-head-function-rule>

          <item><hlink|Constant Patterns|#constant-patterns>

          <item><hlink|The Anonymous Variable|#the-anonymous-variable>

          <item><hlink|Non-Linear Patterns and Syntactic
          Equality|#non-linear-patterns-and-syntactic-equality>

          <item><hlink|Special Patterns|#special-patterns>
        </itemize>

        <item><hlink|Type Tags|#type-tags>

        <item><hlink|General Rules|#general-rules>

        <item><hlink|Simple Rules|#simple-rules>

        <item><hlink|Type Rules|#type-rules>
      </itemize>

      <item><hlink|Examples|#examples>

      <\itemize>
        <item><hlink|Hello, World|#hello-world>

        <\itemize>
          <item><hlink|Passing Parameters|#passing-parameters>

          <item><hlink|Executable Scripts|#executable-scripts>

          <item><hlink|Compiled Scripts|#compiled-scripts>
        </itemize>

        <item><hlink|Running the Interpreter|#running-the-interpreter>

        <item><hlink|Basic Examples|#basic-examples>

        <item><hlink|Defining Functions|#defining-functions>

        <item><hlink|Pattern Matching|#pattern-matching>

        <item><hlink|Local Functions and Variables|#local-functions-and-variables>

        <item><hlink|Data Types|#data-types>

        <item><hlink|Recursion|#recursion>

        <\itemize>
          <item><hlink|A Numeric Root Finder|#a-numeric-root-finder>

          <item><hlink|The Same-Fringe Problem|#the-same-fringe-problem>
        </itemize>

        <item><hlink|Higher-Order Functions|#higher-order-functions>

        <item><hlink|List Processing|#list-processing>

        <item><hlink|String Processing|#string-processing>

        <item><hlink|List Comprehensions|#list-comprehensions>

        <item><hlink|Lazy Evaluation and Streams|#lazy-evaluation-and-streams>

        <item><hlink|Matrices and Vectors|#matrices-and-vectors>

        <item><hlink|Symbolic Matrices|#symbolic-matrices>

        <item><hlink|Record Data|#record-data>

        <item><hlink|The Quote|#the-quote>
      </itemize>

      <item><hlink|Declarations|#declarations>

      <\itemize>
        <item><hlink|Symbol Declarations|#symbol-declarations>

        <item><hlink|Interface Types|#interface-types>

        <item><hlink|Modules and Imports|#modules-and-imports>

        <item><hlink|Namespaces|#namespaces>

        <\itemize>
          <item><hlink|Using Namespaces|#using-namespaces>

          <item><hlink|Symbol Lookup and Creation|#symbol-lookup-and-creation>

          <item><hlink|Private Symbols|#private-symbols>

          <item><hlink|Namespace Brackets|#namespace-brackets>

          <item><hlink|Hierarchical Namespaces|#hierarchical-namespaces>

          <item><hlink|Scoped Namespaces|#scoped-namespaces>
        </itemize>
      </itemize>

      <item><hlink|Macros|#macros>

      <\itemize>
        <item><hlink|Optimization Rules|#optimization-rules>

        <item><hlink|Recursive Macros|#recursive-macros>

        <item><hlink|User-Defined Special Forms|#user-defined-special-forms>

        <item><hlink|Macro Hygiene|#macro-hygiene>

        <item><hlink|Built-in Macros and Special
        Expressions|#built-in-macros-and-special-expressions>

        <item><hlink|Advanced Optimization|#advanced-optimization>

        <item><hlink|Reflection|#reflection>
      </itemize>

      <item><hlink|Exception Handling|#exception-handling>

      <item><hlink|Standard Library|#standard-library>

      <item><hlink|C Interface|#c-interface>

      <\itemize>
        <item><hlink|Extern Declarations|#extern-declarations>

        <item><hlink|Variadic C Functions|#variadic-c-functions>

        <item><hlink|C Types|#c-types>

        <\itemize>
          <item><hlink|Basic C Types|#basic-c-types>

          <item><hlink|Pointer Types|#pointer-types>

          <item><hlink|Pointers and Matrices|#pointers-and-matrices>

          <item><hlink|Pointer Examples|#pointer-examples>
        </itemize>

        <item><hlink|Importing Dynamic Libraries|#importing-dynamic-libraries>

        <item><hlink|Importing LLVM Bitcode|#importing-llvm-bitcode>

        <item><hlink|Inline Code|#inline-code>

        <item><hlink|Interfacing to C++|#interfacing-to-c>

        <item><hlink|Interfacing to ATS|#interfacing-to-ats>

        <item><hlink|Interfacing to Faust|#interfacing-to-faust>
      </itemize>

      <item><hlink|Interactive Usage|#interactive-usage>

      <\itemize>
        <item><hlink|Command Syntax|#command-syntax>

        <item><hlink|Online Help|#online-help>

        <item><hlink|Interactive Commands|#interactive-commands>

        <item><hlink|Specifying Symbol Selections|#specifying-symbol-selections>

        <item><hlink|The show Command|#the-show-command>

        <item><hlink|Definition Levels|#definition-levels>

        <item><hlink|Debugging|#debugging>

        <item><hlink|Last Result|#last-result>

        <item><hlink|Pretty-Printing|#pretty-printing>

        <item><hlink|User-Defined Commands|#user-defined-commands>

        <item><hlink|Interactive Startup|#interactive-startup>
      </itemize>

      <item><hlink|Batch Compilation|#batch-compilation>

      <\itemize>
        <item><hlink|Example|#example>

        <item><hlink|Options Affecting Code
        Size|#options-affecting-code-size>

        <item><hlink|Other Output Code Formats|#other-output-code-formats>

        <item><hlink|Calling Pure Functions From
        C|#calling-pure-functions-from-c>
      </itemize>

      <item><hlink|Caveats and Notes|#caveats-and-notes>

      <\itemize>
        <item><hlink|Etymology|#etymology>

        <item><hlink|Backward Compatibility|#backward-compatibility>

        <item><hlink|Error Recovery|#error-recovery>

        <item><hlink|Splicing Tuples and Matrices|#splicing-tuples-and-matrices>

        <item><hlink|With and when|#with-and-when>

        <item><hlink|Non-Linear Patterns|#non-linear-patterns>

        <item><hlink|``As'' Patterns|#as-patterns>

        <item><hlink|``Head = Function'' Pitfalls|#head-function-pitfalls>

        <item><hlink|Defined Functions|#defined-functions>

        <item><hlink|Stack Size and Tail Recursion|#stack-size-and-tail-recursion>

        <item><hlink|Handling of Asynchronous
        Signals|#handling-of-asynchronous-signals>

        <item><hlink|Recursive Types|#recursive-types>

        <item><hlink|Interfaces|#interfaces>

        <item><hlink|Numeric Calculations|#numeric-calculations>

        <item><hlink|Constant Definitions|#constant-definitions>

        <item><hlink|External C Functions|#external-c-functions>

        <item><hlink|Calling Special Forms|#calling-special-forms>

        <item><hlink|Laziness|#laziness>

        <item><hlink|Name Capture|#name-capture>
      </itemize>

      <item><hlink|Author|#author>

      <item><hlink|Acknowledgements|#acknowledgements>

      <item><hlink|Copying|#copying>

      <item><hlink|References and Links|#references-and-links>
    </itemize>
  </itemize>

  Previous topic

  <hlink|Pure Language and Library Documentation|index.tm>

  Next topic

  <hlink|Pure Library Manual|purelib.tm>

  <hlink|toc|#pure-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|purelib.tm> \|
  <hlink|previous|index.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2014, Albert Gräf et al. Last updated on Oct
  23, 2014. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
