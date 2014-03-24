<TeXmacs|1.0.7.20>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-doc-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-ffi.tm> \|
  <hlink|previous|pure-bonjour.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|pure-doc<label|pure-doc>>

  Version 0.7, March 24, 2014

  Albert Graef \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  pure-doc is a simple utility for literate programming and documenting
  source code written in the Pure programming language. It is designed to be
  used with the excellent <hlink|docutils|http://docutils.sourceforge.net>
  tools and the gentle markup format supported by these, called
  <hlink|RST|http://docutils.sourceforge.net/rst.html> a.k.a.
  ``reStructuredText'', usually pronounced ``rest''.

  The basic idea is that you just comment your code as usual, but using RST
  markup instead of plain text. In addition, you can also designate literate
  programming fragments in your code, which will be translated to RST literal
  blocks automatically. You then run pure-doc on your source files to extract
  all marked up comments and the literate code blocks. The resulting RST
  source can then be processed with the docutils utilities like rst2html.py
  and rst2latex.py to create the documentation in a variety of formats.

  <subsection|Copying<label|copying>>

  Copyright (c) 2009-2010 by Albert Graef.

  pure-doc is free software: you can redistribute it and/or modify it under
  the terms of the GNU General Public License as published by the Free
  Software Foundation, either version 3 of the License, or (at your option)
  any later version.

  pure-doc is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
  details.

  You should have received a copy of the GNU General Public License along
  with this program. If not, see \<less\><hlink|http://www.gnu.org/licenses/|http://www.gnu.org/licenses/>\<gtr\>.

  <subsection|Installation<label|installation>>

  Get the latest source from <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-doc-0.7.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-doc-0.7.tar.gz>.

  Unpack and do the customary <verbatim|make> <verbatim|&&> <verbatim|sudo>
  <verbatim|make> <verbatim|install>. This only needs flex and a
  standards-compliant C++ compiler.

  <subsection|Usage<label|usage>>

  First, see the description of the <hlink|RST|http://docutils.sourceforge.net/rst.html>
  format. RST is a very simple markup format, almost like plain text (in
  fact, you're looking at RST right now, this document is written in it!).
  You can learn enough of it to start marking up your source in about five
  minutes.

  Second, you'll have to mark up your source comments. pure-doc recognizes
  comments in RST format by looking at the first non-empty line of the
  comment. A comment (either <verbatim|/*> <verbatim|...> <verbatim|*/> or a
  contiguous sequence of <verbatim|//> line comments) is assumed to contain
  RST format if the first non-empty line starts with <verbatim|:>,
  <verbatim|..> or <verbatim|__>. Other comments are taken to be plain text
  and are ignored by pure-doc.

  Notes:

  <\itemize>
    <item>pure-doc makes no other assumption about the contents of marked up
    comments, so you can include whatever you want: titles, section headers,
    fields, admonitions, plain text, whatever. Just make sure that the
    comment starts with one of the special tokens listed above. (You can
    always put just <verbatim|..> at the beginning of the comment to force it
    to be recognized, this will be treated as a comment by the docutils
    tools.)

    <item>Also, pure-doc makes very few assumptions about the source; in
    fact, any source files with a C/C++-like comment and string syntax should
    work. So you could also use it to document your C/C++ programs, or even
    plain text files like this one, as long as they adhere to these
    standards.

    <item>Indentation in extracted comments is preserved (assuming tabs = 8
    spaces by default, you can change this with the <verbatim|-t> option).
    This is important because indentation conveys document structure in RST.
  </itemize>

  For instance, here is a sample RST-formatted comment:

  <\verbatim>
    /* :Name: ``rand`` - compute random numbers

    \ \ \ :Synopsis: ``rand``

    \ \ \ :Description: Computes a (pseudo) random number. Takes no
    parameters.

    \ \ \ :Example: Here is how you can call ``rand`` in Pure:

    \ \ \ \ \ ::

    \;

    \ \ \ \ \ \ \ \<gtr\> extern int rand();

    \ \ \ \ \ \ \ \<gtr\> rand;

    \ \ \ \ \ \ \ 1804289383

    \;

    \ \ \ :See Also: rand(3) */
  </verbatim>

  This will be rendered as follows:

  <\quote-env>
    Name: <verbatim|rand> - compute random numbers

    Synopsis: <verbatim|rand>

    Description: Computes a (pseudo) random number. Takes no parameters.

    Example: Here is how you can call <verbatim|rand> in Pure:

    <\verbatim>
      \<gtr\> extern int rand();

      \<gtr\> rand;

      1804289383
    </verbatim>

    See Also: rand(3)
  </quote-env>

  Finally, to extract the documentation you run pure-doc on your source files
  as follows:

  <\verbatim>
    pure-doc source-files ...
  </verbatim>

  If no input files are specfied then the source is read from standard input.
  Otherwise all input files are read and processed in the indicated order.
  The output is written to stdout, so that you can directly pipe it into one
  of the docutils programs:

  <\verbatim>
    pure-doc source-files ... \| rst2html.py
  </verbatim>

  If you prefer to write the output to a file, you can do that as follows:

  <\verbatim>
    pure-doc source-files ... \<gtr\> rst-file
  </verbatim>

  pure-doc also understands the following options. These must come before any
  file arguments.

  -h Print a short help message.

  -i Automatic index creation (see below).

  -s Generate Sphinx-compatible output (see below).

  -twidth Set the tab width to the given number of spaces. There are no other
  options. By its design pure-doc is just a plain simple ``docstring
  scraping'' utility with no formatting knowledge of its own. All actual
  formatting is handled by the docutils programs which offer plenty of
  options to change the appearance of the generated output; please refer to
  the <hlink|docutils|http://docutils.sourceforge.net> documentation for
  details.

  Note that since Pure 0.46, all Pure documentation is usually formatted
  using <hlink|Sphinx|http://sphinx.pocoo.org>, the RST formatter used by the
  Python project which provides cross-document indexing and referencing, and
  even more elaborate formatting options and prettier output than docutils.
  pure-doc versions since 0.6 support this by adding the <verbatim|-s> option
  which makes its output compatible with Sphinx. (At present this option
  actually has any effect only when combined with the <verbatim|-i> index
  generation option, see <hlink|Hyperlink Targets and Index
  Generation|#hyperlink-targets-and-index-generation> below.)

  <subsection|Literate Programming<label|literate-programming>>

  pure-doc also recognizes literate code delimited by comments which, besides
  the comment delimiters and whitespace, contain nothing but the special
  start and end ``tags'' <verbatim|\>\>\>> and <verbatim|\<\<\<>. Code
  between these delimiters (including all comments) is extracted from the
  source and output as a RST literal code block.

  For instance:

  <\verbatim>
    /* ..

    \;

    \ \ \ pure-doc supports literate programming, too. */

    \;

    // \<gtr\>\<gtr\>\<gtr\>

    \;

    // This is a literate comment.

    /* .. This too! */

    \;

    extern int rand();

    rand;

    \;

    // \<less\>\<less\>\<less\>
  </verbatim>

  This will be rendered as follows:

  <\quote-env>
    pure-doc supports literate programming, too.

    <\verbatim>
      // This is a literate comment.

      /* .. This too! */

      \;

      extern int rand();

      rand;
    </verbatim>
  </quote-env>

  Try it now! You can scrape all the sample ``documentation'' from this file
  and format it as html, as follows:

  <\verbatim>
    pure-doc README \| rst2html.py --no-doc-title --no-doc-info \<gtr\>
    test.html
  </verbatim>

  <subsection|Hyperlink Targets and Index
  Generation<label|hyperlink-targets-and-index-generation>>

  <with|font-series|bold|Note:> This feature is now largely obsolete as Pure
  uses Sphinx for formatting its documentation these days. Thus, as of
  version 0.6, the indexing feature must be enabled explicitly with the
  <verbatim|-i> option.

  When run with the <verbatim|-i> option, pure-doc supplements the normal
  hyperlink target processing by the docutils tools, by recognizing explicit
  hyperlink targets of the form <verbatim|..> <verbatim|_target:> and
  automatically creating raw html targets (<verbatim|\<a>
  <verbatim|name=...\>>) for them. This works around the docutils name
  mangling (which is undesirable if you're indexing, say, function names). It
  also resolves a quirk with some w3m versions which don't pick up all
  <verbatim|id> attributes in the docutils-generated html source.

  In addition, you can also have pure-doc generate an index from all explicit
  targets. To these ends, just add the following special directive at the
  place where you want the index to appear:

  <\verbatim>
    .. makeindex::
  </verbatim>

  The directive will be replaced with a list of references to all targets
  collected <em|up to that point>, sorted alphabetically. This also resets
  the list of collected targets, so that you can have multiple smaller
  indices in your document instead of one big one.

  It goes without saying that this facility is rather simplistic, but it may
  be useful when you are working with plain docutils which does not provide
  its own indexing facility. Note, however, that docutils doesn't allow
  multiple explicit targets with the same name, so you should take that into
  consideration when devising your index terms.

  Also note that in Sphinx compatibility mode (<verbatim|-s>), pure-doc will
  generate the appropriate Sphinx markup for index entries
  (<verbatim|index::>) instead, and the <verbatim|makeindex::> directive will
  be ignored. You should then use Sphinx to generate the index.

  Finally, if the <verbatim|-i> option isn't specified, then all this special
  processing is disabled and the <verbatim|makeindex::> directive won't be
  recognized at all. This is the recommended way to process Pure
  documentation files which have been fully converted to Sphinx.

  <subsection|Generating and Installing Local
  Documentation<label|generating-and-installing-local-documentation>>

  <with|font-series|bold|Note:> This section only applies to 3rd party
  packages with their own bundled documentation which isn't part of the
  ``official'' Pure documentation. In this case it is possible to use
  docutils or some other RST formatting software to generate additional
  documentation files for use with the Pure interpreter. Please note that the
  method sketched out in this section doesn't provide full integration with
  the rest of Pure's documentation, but at least it makes it possible to read
  the local documentation in the interpreter.

  If you're generating some library documentation for which you have to
  process a bigger collection of source files, then it is often convenient to
  have a few Makefile rules to automatize the process. To these ends, simply
  add rules similar to the following to your Makefile (the following assumes
  GNU make and that you're using docutils to format the documentation):

  <\verbatim>
    # The sources. Order matters here. The generated documentation will have
    the

    # comments from each source file in the indicated order.

    sources = foo.pure bar.pure

    \;

    # The basename of the documentation files to be generated.

    target = foo

    \;

    .PHONY: html tex pdf

    \;

    html: $(target).html

    tex: $(target).tex

    pdf: $(target).pdf

    \;

    $(target).txt: $(sources)

    \ \ \ \ \ \ \ \ pure-doc $(sources) \<gtr\> $@

    \;

    # This requires that you have docutils installed.

    \;

    %.html: %.txt

    \ \ \ \ \ \ \ \ rst2html.py $\<less\> $@

    \;

    %.tex: %.txt

    \ \ \ \ \ \ \ \ rst2latex.py $\<less\> $@

    \;

    # This also requires that you have TeX installed.

    \;

    %.pdf: %.tex

    \ \ \ \ \ \ \ \ pdflatex $\<less\>

    \ \ \ \ \ \ \ \ rm -f *.aux *.log *.out

    \;

    clean:

    \ \ \ \ \ \ \ \ rm -f *.html *.tex *.pdf
  </verbatim>

  You might want to add <verbatim|-i> to the pure-doc command line if you
  want to enable the indexing feature described in the previous section. If
  you want to use some other RST formatting software, please check the
  corresponding documentation for information on how to format your documents
  and adjust the above rules for the html, tex and pdf targets accordingly.

  Now you can just type <verbatim|make> <verbatim|html> to generate the
  documentation in html format, and <verbatim|make> <verbatim|tex> or
  <verbatim|make> <verbatim|pdf> to generate the other formats. The
  <verbatim|clean> target removes the generated files.

  Having generated the documentation files in html format, you can install
  them in the docs subdirectory of the Pure library directory to make it
  known to the Pure interpreter, so that you can read your documentation with
  the <verbatim|help> command of the interpreter. (When doing this, name your
  documentation files in such a manner that you don't overwrite any of the
  Pure documentation files there.) The following Makefile rule automatizes
  this process. Add this to the Makefile in the previous section:

  <\verbatim>
    # Try to guess the installation prefix (this needs GNU make):

    prefix = $(patsubst %/bin/pure,%,$(shell which pure 2\<gtr\>/dev/null))

    ifeq ($(strip $(prefix)),)

    # Fall back to /usr/local.

    prefix = /usr/local

    endif

    \;

    libdir = $(prefix)/lib

    docsdir = $(libdir)/pure/docs

    \;

    install:

    \ \ \ \ \ \ \ \ test -d "$(DESTDIR)$(docsdir)" \|\| mkdir -p
    "$(DESTDIR)$(docsdir)"

    \ \ \ \ \ \ \ \ cp $(target).html "$(DESTDIR)$(docsdir)"
  </verbatim>

  After a <verbatim|make> <verbatim|install> your documentation should now
  end up in the appropriate place in the Pure library directory and you can
  read it in the Pure interpreter using a command like the following:

  <\verbatim>
    \<gtr\> help foo#
  </verbatim>

  Note the hash character. This tells the <verbatim|help> command that this
  is an auxiliary documentation file, rather than a search term to be looked
  up in the Pure documentation. You can also look up a specific section in
  your manual as follows:

  <\verbatim>
    \<gtr\> help foo#section-name
  </verbatim>

  Please also refer to <hlink|<em|The Pure Manual>|pure.tm> for more
  information on how to use the interpreter's online help.

  <subsection|Formatting Tips<label|formatting-tips>>

  If you're generating documentation in pdf format using plain docutils, you
  might have to fiddle with the formatting to get results suitable for
  publication purposes. Newer versions of the rts2latex.py program provide
  some options which let you adjust the formatting of various document
  elements. Here are the options that the author found particularly helpful:

  <\itemize>
    <item>The table of contents that RST produces isn't all that useful in
    printed documentation, since it lacks page numbers. As a remedy, you can
    invoke rst2latex with <verbatim|--use-latex-toc> to have LaTeX handle the
    formatting of the table of contents, which looks much nicer.

    <item>Similarly, <verbatim|--use-latex-docinfo> can be used to tell
    rst2latex that you want the title information (author and date) to be
    formatted the LaTeX way.

    <item>If you need specific LaTeX document options, these can be specified
    with <verbatim|--documentoptions>, e.g.:
    <verbatim|--documentoptions="11pt">.

    <item>For more comprehensive formatting changes which require special
    LaTeX code and/or packages, you can use the <verbatim|--stylesheet>
    option. E.g., <verbatim|--stylesheet=preamble.tex> will cause a
    preamble.tex file with your own definitions to be included in the
    preamble of the generated document.

    <item>To format literal code blocks using an alternative environment
    instead of the default verbatim environment, use the
    <verbatim|--literal-block-env> option. E.g.,
    <verbatim|--literal-block-env=lstlisting> will use the highlighted code
    environment from the listings package. (Note that in this case you'll
    also need a preamble which loads the corresponding package.).
  </itemize>

  To learn more about this, please consult the rts2latex.py documentation at
  the docutils website.

  In addition, the pure-doc package contains a little GNU awk script called
  fixdoc, which attempts to improve the LaTeX output produced by older svn
  versions of rst2latex in various ways. (This isn't necessary for the latest
  rst2latex versions, or if you use Sphinx.)

  <subsubsection*|<hlink|Table Of Contents|index.tm><label|pure-doc-toc>>

  <\itemize>
    <item><hlink|pure-doc|#>

    <\itemize>
      <item><hlink|Copying|#copying>

      <item><hlink|Installation|#installation>

      <item><hlink|Usage|#usage>

      <item><hlink|Literate Programming|#literate-programming>

      <item><hlink|Hyperlink Targets and Index
      Generation|#hyperlink-targets-and-index-generation>

      <item><hlink|Generating and Installing Local
      Documentation|#generating-and-installing-local-documentation>

      <item><hlink|Formatting Tips|#formatting-tips>
    </itemize>
  </itemize>

  Previous topic

  <hlink|pure-bonjour: Pure Bonjour Interface|pure-bonjour.tm>

  Next topic

  <hlink|pure-ffi|pure-ffi.tm>

  <hlink|toc|#pure-doc-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-ffi.tm> \|
  <hlink|previous|pure-bonjour.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2014, Albert Gräf et al. Last updated on Mar
  24, 2014. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
