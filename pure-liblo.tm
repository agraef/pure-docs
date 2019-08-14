<TeXmacs|1.99.11>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-liblo-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-lilv.tm> \|
  <hlink|previous|pure-faust.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|pure-liblo><label|module-lo><label|module-osc><label|module-lo>

  Version 0.9, April 11, 2018

  Albert Gräf \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  <subsection|Copying><label|copying>

  Copyright (c) 2009 by Albert Graef.

  pure-liblo is free software: you can redistribute it and/or modify it under
  the terms of the GNU Lesser General Public License as published by the Free
  Software Foundation, either version 3 of the License, or (at your option)
  any later version.

  pure-liblo is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License
  for more details.

  You should have received a copy of the GNU Lesser General Public License
  along with this program. If not, see \<less\><hlink|http://www.gnu.org/licenses/|http://www.gnu.org/licenses/>\<gtr\>.

  <subsection|Description><label|description>

  This is a quick and dirty Pure wrapper for the
  <hlink|liblo|http://liblo.sourceforge.net/> library by Steve Harris and
  others, which implements Berkeley's <hlink|Open Sound
  Control|http://opensoundcontrol.org/> (OSC) protocol.

  OSC is a protocol for exchanging data between multimedia devices and
  software across the network (TCP, UDP and UNIX domain sockets are supported
  as the transport layer). It is also useful as a general communication
  mechanism for both hard- and software. In difference to the plain socket
  interface (on which it builds), OSC provides you with an efficient means to
  send around binary data packets along with the corresponding type and
  timing information, which makes it well-suited for both realtime and
  non-realtime applications.

  The OSC protocol is <hlink|standardized|http://opensoundcontrol.org/spec-1-0>
  and is supported by an abundance of different
  <hlink|implementations|http://opensoundcontrol.org/implementations>, which
  includes controller hardware of all sorts and computer music software like
  CSound, Pd and SuperCollider. Lots of implementations exist for different
  programming languages. liblo aims to provide a lightweight and ubiquitous
  OSC implementation for the C programming language.

  The <verbatim|lo.pure> module provides a fairly straight wrapper of the C
  library. A more high-level and Purified interface is available in
  <verbatim|osc.pure>. Most of the time, you'll want to use the latter for
  convenience, but if you need utmost flexibility then it is worth having a
  look at <verbatim|lo.pure>, too.

  <\itemize>
    <item>Get the latest source from <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-liblo-0.9.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-liblo-0.9.tar.gz>.

    <item>To install, run <verbatim|make> and <verbatim|sudo> <verbatim|make>
    <verbatim|install>. This will try to guess your Pure installation
    directory; if it guesses wrong, you can set the <verbatim|prefix>
    variable accordingly, see the Makefile for details.

    <item>You can also regenerate the wrapper by running <verbatim|make>
    <verbatim|generate>; this requires the <verbatim|pure-gen> utility and
    the liblo headers. The present version was generated from liblo 0.26. If
    your liblo version differs from that then it's always a good idea to run
    <verbatim|make> <verbatim|generate>.

    <item>Have a look at <verbatim|lo.pure> and <verbatim|osc.pure> for a
    description of the API provided to Pure programmers.

    <item>The <verbatim|examples> folder contains some Pure code which
    illustrates how to use these modules.
  </itemize>

  <subsubsection*|<hlink|Table Of Contents|index.tm>><label|pure-liblo-toc>

  <\itemize>
    <item><hlink|pure-liblo|#>

    <\itemize>
      <item><hlink|Copying|#copying>

      <item><hlink|Description|#description>
    </itemize>
  </itemize>

  Previous topic

  <hlink|pure-faust|pure-faust.tm>

  Next topic

  <hlink|pure-lilv: Pure Lilv Interface|pure-lilv.tm>

  <hlink|toc|#pure-liblo-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-lilv.tm> \|
  <hlink|previous|pure-faust.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2019, Albert Gräf et al. Last updated on Aug
  14, 2019. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
