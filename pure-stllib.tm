<TeXmacs|1.0.7.20>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-stllib-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-stlmap.tm> \|
  <hlink|previous|pure-stldict.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|pure-stllib<label|pure-stllib>>

  Version 0.6, September 17, 2014

  Peter Summerland \<less\><hlink|p.summerland@gmail.com|mailto:p.summerland@gmail.com>\<gtr\>

  <hlink|<em|pure-stllib>|> is an ``umbrella'' package that contains a pair
  of Pure addons, <hlink|<em|pure-stlvec>|pure-stlvec.tm> and
  <hlink|<em|pure-stlmap>|pure-stlmap.tm>. These addons provide
  <hlink|Pure|http://purelang.bitbucket.org> interfaces to a selection of
  containers provided by the <hlink|C++ Standard
  Library|http://en.cppreference.com/w/cpp>, specialized to hold pointers to
  arbitrary Pure expressions. <hlink|<em|pure-stlvec>|pure-stlvec.tm> is a
  Pure interface to C++'s vector and the STL algorithms that act on them.
  <hlink|<em|pure-stlmap>|pure-stlmap.tm> is an interface to six (of the
  eight) of C++'s associative containers: map, set, multimap, multiset,
  unordered_map and unordered_set.

  <subsection|Copying<label|copying>>

  Copyright (c) 2011-2012 by Peter Summerland
  \<less\><hlink|p.summerland@gmail.com|mailto:p.summerland@gmail.com>\<gtr\>.

  All rights reserved.

  <hlink|<em|pure-stllib>|> is distributed in the hope that it will be
  useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

  <hlink|<em|pure-stllib>|> is distributed under a BSD-style license, see the
  COPYING file for details.

  <subsection|Installation<label|installation>>

  pure-stllib-0.6 requires at least Pure 0.50. The latest version of Pure is
  available at <hlink|http://code.google.com/p/pure-lang/downloads/list|http://code.google.com/p/pure-lang/downloads/list>.

  The latest version of the source code for <hlink|<em|pure-stllib>|> can be
  downloaded from <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-stllib-0.6.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-stllib-0.6.tar.gz>.

  To install pure-stllib-0.6 (on Linux), extract the source code (e.g., tar
  -xzf pure-stllib-0.6.tar.gz), cd to the pure-stllib-0.6 directory, and run
  <verbatim|make>. After this you can (and should) also run <verbatim|make>
  <verbatim|check> to run a few unit tests to make sure that
  <hlink|<em|pure-stlvec>|pure-stlvec.tm> and
  <hlink|<em|pure-stlmap>|pure-stlmap.tm> work properly on your system. If
  <verbatim|make> <verbatim|check> works, run <verbatim|sudo> <verbatim|make>
  <verbatim|install> to install <hlink|<em|pure-stlvec>|pure-stlvec.tm> and
  <hlink|<em|pure-stlmap>|pure-stlmap.tm>. Run <verbatim|sudo>
  <verbatim|make> <verbatim|uninstall> to remove them.

  <verbatim|make> tries to guess your Pure installation directory and
  platform-specific setup. If it gets this wrong, you can set some variables
  manually. In particular, <verbatim|make> <verbatim|install>
  <verbatim|prefix=/usr> sets the installation prefix. Please see the
  Makefile for details.

  <subsection|Usage<label|usage>>

  <hlink|<em|pure-stlvec>|pure-stlvec.tm> provides functions that act on a
  single mutable container, stlvec, which is a wrapper around C++'s vector,
  specialized to hold Pure expressions. It also provides functions that
  correspond to C++'s STL algorithms specialized to act on stlvecs.

  <hlink|<em|pure-stlmap>|pure-stlmap.tm> provides functions that act on six
  mutable containers, ``stlmap'', ``stlset'', ``stlmmap'', ``stlmset'',
  ``stlhmap'' and ``stlhset'', that are thin wrappers around the
  corresponding associative containers provided by C++, map, set, multimap,
  multiset, unordered_map and unordered_set, specialized to hold Pure
  expressions.

  The functions provided by <hlink|<em|pure-stlvec>|pure-stlvec.tm> and
  <hlink|<em|pure-stlmap>|pure-stlmap.tm> are made available by importing one
  or more of the following modules.

  <\quote-env>
    <hlink|<with|font-family|tt|stlvec>|pure-stlvec.tm#module-stlvec> -
    support for stlvecs

    <hlink|<with|font-family|tt|stlvec::algorithms>|pure-stlvec.tm#module-stlvec::algorithms>
    - STL algorithms specialized to act on stlvecs

    <hlink|<with|font-family|tt|stlmap>|pure-stlmap.tm#module-stlmap> -
    support for stlmap and stlset

    <hlink|<with|font-family|tt|stlmmap>|pure-stlmap.tm#module-stlmmap> -
    support for stlmmap and stlmset

    <hlink|<with|font-family|tt|stlhmap>|pure-stlmap.tm#module-stlhmap> -
    support for stlhmap and stlhset
  </quote-env>

  <subsection|Documentation<label|documentation>>

  Please see the documentation for <hlink|<em|pure-stlvec>|pure-stlvec.tm>
  and <hlink|<em|pure-stlmap>|pure-stlmap.tm>.

  For the impatient, the functions that act on containers provided by the
  <hlink|<with|font-family|tt|stlmap>|pure-stlmap.tm#module-stlmap>,
  <hlink|<with|font-family|tt|stlmmap>|pure-stlmap.tm#module-stlmmap>,
  <hlink|<with|font-family|tt|stlhmap>|pure-stlmap.tm#module-stlhmap> and
  <hlink|<with|font-family|tt|stlvec>|pure-stlvec.tm#module-stlvec> modules
  are summarized in a rudimentary cheatsheet, pure-stllib-cheatsheet.pdf,
  which can be found in the pure-stllib/doc directory.

  <subsection|Changes<label|changes>>

  Version 0.1 - Bundle pure-stlvec-0.3 and pure-stlmap-0.1.

  Version 0.2 - Bundle pure-stlvec-0.3 and pure-stlmap-0.2.

  Version 0.3 - Bundle pure-stlvec-0.4 and pure-stlmap-0.3.

  <subsubsection*|<hlink|Table Of Contents|index.tm><label|pure-stllib-toc>>

  <\itemize>
    <item><hlink|pure-stllib|#>

    <\itemize>
      <item><hlink|Copying|#copying>

      <item><hlink|Installation|#installation>

      <item><hlink|Usage|#usage>

      <item><hlink|Documentation|#documentation>

      <item><hlink|Changes|#changes>
    </itemize>
  </itemize>

  Previous topic

  <hlink|pure-stldict|pure-stldict.tm>

  Next topic

  <hlink|pure-stlmap|pure-stlmap.tm>

  <hlink|toc|#pure-stllib-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-stlmap.tm> \|
  <hlink|previous|pure-stldict.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2014, Albert Gräf et al. Last updated on Sep
  17, 2014. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
