<TeXmacs|1.99.5>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-readline-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-sockets.tm> \|
  <hlink|previous|pure-gen.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <label|module-readline><section*|pure-readline><label|pure-readline><label|pure-readline>

  Version 0.3, February 24, 2017

  Albert Graef \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  Get the latest source from <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-readline-0.3.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-readline-0.3.tar.gz>.

  This is a trivial wrapper around GNU readline, which gives Pure scripts
  access to the most important facilities of the readline interface. This
  includes support for the <verbatim|readline> function itself (without
  custom completion at present) and basic history management. The wrapper can
  also be used with the BSD editline a.k.a. libedit library, a readline
  replacement licensed under the 3-clause BSD license. You can find these at:

  <\itemize>
    <item>GNU readline: <hlink|http://tiswww.tis.case.edu/<math|\<sim\>>chet/readline/rltop.html|http://tiswww.tis.case.edu/-tildechet/readline/rltop.html>

    <item>BSD editline/libedit: <hlink|http://www.thrysoee.dk/editline|http://www.thrysoee.dk/editline>
  </itemize>

  We recommend GNU readline because it's easier to use and has full UTF-8
  support, but in some situations BSD editline/libedit may be preferable for
  license reasons or because it's what the operating system provides. Note
  that in either case Pure programs using this module are subject to the
  license terms of the library that you use (GPLv3+ in case of GNU readline,
  BSD license in the case of BSD editline/libedit).

  Normally, you should choose the same library that you use with the Pure
  interpreter, to avoid having two different versions of the library linked
  into your program. (This doesn't matter if you only use this module with
  batch-compiled scripts, though, since the Pure runtime doesn't depend on
  readline in any way.) By default, the module will be built with GNU
  readline. To select editline/libedit instead, you only have to uncomment a
  line at the beginning of the Makefile. Also, you might want to check the
  beginning of readline.c for the proper location of the corresponding header
  files.

  The module provides the following functions:

  <\description>
    <item*|readline prompt<label|readline>>Read a line of input from the
    user, with prompting and command line editing. Returns the input line
    (with the trailing newline removed), or
    <hlink|<with|font-family|tt|NULL>|purelib.tm#NULL> when reaching end of
    file.
  </description>

  <\description>
    <item*|add_history line<label|add-history>>Adds the given line (a string)
    to the command history.
  </description>

  <\description>
    <item*|clear_history<label|clear-history>>Clears the command history.
  </description>

  <\description>
    <item*|read_history fname<label|read-history>>Reads the command history
    from the given file. Note that this in fact <em|adds> the contents of the
    history file to the current history, so you may want to call
    <hlink|<with|font-family|tt|clear_history>|#clear-history> beforehand if
    this function is called multiple times.
  </description>

  <\description>
    <item*|write_history fname<label|write-history>>Writes the current
    command history to the given file.
  </description>

  Example:

  <\verbatim>
    \;

    \<gtr\> using readline;

    \<gtr\> readline "input\<gtr\> ";

    input\<gtr\> Hello, world!

    "Hello, world!"

    \<gtr\> add_history ans;

    ()

    \<gtr\> readline "input\<gtr\> ";

    input\<gtr\> \<less\>EOF\<gtr\>

    #\<less\>pointer 0x0\<gtr\>

    \<gtr\> write_history "history"; // save the history

    0

    \<gtr\> clear_history;

    \<gtr\> read_history "history"; // read the history

    0

    \;
  </verbatim>

  Previous topic

  <hlink|pure-gen: Pure interface generator|pure-gen.tm>

  Next topic

  <hlink|pure-sockets: Pure Sockets Interface|pure-sockets.tm>

  <hlink|toc|#pure-readline-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-sockets.tm> \|
  <hlink|previous|pure-gen.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2017, Albert Gräf et al. Last updated on Feb
  24, 2017. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
