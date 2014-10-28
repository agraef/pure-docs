<TeXmacs|1.0.7.20>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-ffi-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-gen.tm> \|
  <hlink|previous|pure-doc.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|pure-ffi<label|module-ffi>>

  Version 0.14, October 28, 2014

  Albert Graef \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  The libffi library provides a portable, high level programming interface to
  various calling conventions. This allows a programmer to call any function
  specified by a call interface description at run time. libffi should be
  present on most gcc-based systems, but it is also available as a standalone
  package at <hlink|http://sourceware.org/libffi/|http://sourceware.org/libffi/>.

  This module provides an interface to libffi which enables you to call C
  functions from Pure and vice versa. It goes beyond Pure's built-in C
  interface in that it also handles C structs and makes Pure functions
  callable from C. Moreover, depending on the libffi implementation, it may
  also be possible to call foreign languages other than C.

  <subsection|Copying<label|copying>>

  Copyright (c) 2008, 2009 by Albert Graef.

  pure-ffi is free software: you can redistribute it and/or modify it under
  the terms of the GNU Lesser General Public License as published by the Free
  Software Foundation, either version 3 of the License, or (at your option)
  any later version.

  pure-ffi is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for
  more details.

  You should have received a copy of the GNU Lesser General Public License
  along with this program. If not, see \<less\><hlink|http://www.gnu.org/licenses/|http://www.gnu.org/licenses/>\<gtr\>.

  <subsection|Installation<label|installation>>

  Get the latest source from <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-ffi-0.14.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-ffi-0.14.tar.gz>.

  Run <verbatim|make> to compile the module and <verbatim|make>
  <verbatim|install> (as root) to install it in the Pure library directory.
  This requires GNU make, and of course you need to have Pure and libffi
  installed.

  <verbatim|make> tries to guess your Pure installation directory and
  platform-specific setup. If it gets this wrong, you can set some variables
  manually. In particular, <verbatim|make> <verbatim|install>
  <verbatim|prefix=/usr> sets the installation prefix, and <verbatim|make>
  <verbatim|PIC=-fPIC> or some similar flag might be needed for compilation
  on 64 bit systems. Please see the Makefile for details.

  NOTE: This module requires libffi 3.x (3.0.8 has been tested). Old libffi
  versions (2.x) do not appear to work (closures are broken). Patches are
  welcome.

  <subsection|Usage<label|usage>>

  The module exposes a simplified interface to libffi tailored to the Pure
  language. Call interfaces are described using the desired ABI, return type
  and tuple of argument types. The ABI is specified using one of the
  <verbatim|FFI_*> constants defined by the module; for most purposes,
  <verbatim|FFI_DEFAULT_ABI> is all that's needed. C types are specified
  using special descriptors <verbatim|void_t>, <verbatim|uint_t> etc., see
  ffi.pure for details. You can also get a list of these values using
  <verbatim|show> <verbatim|-g> <verbatim|FFI_*> <verbatim|*_t> after
  importing the ffi module.

  The primary interface for calling C from Pure and vice versa is as follows:

  <\description>
    <item*|fcall name abi rtype atypes<label|fcall>>Creates a Pure function
    from a C function with the given name, specified as a string. This makes
    the C function callable in Pure, no matter whether it is already declared
    as an <verbatim|extern> or not. But note that if the function resides in
    a shared library, you still have to import that library using a Pure
    <verbatim|using> declaration, see the Pure manual for details.
  </description>

  <\description>
    <item*|fclos fn abi rtype atypes<label|fclos>>Creates a pointer to a C
    function from the given Pure function <verbatim|fn>. The resulting
    pointer can then be passed to other C functions expecting functions as
    arguments. This allows you to create C callbacks from Pure functions
    without writing a single line of C code. (This functionality might not be
    available on some platforms.)
  </description>

  Note that in difference to <hlink|<with|font-family|tt|extern>|pure.tm#extern>
  functions, arguments to functions created with libffi are always passed in
  uncurried form, as a Pure tuple. E.g.:

  <\verbatim>
    \<gtr\> using ffi;

    \<gtr\> let fmod = fcall "fmod" FFI_DEFAULT_ABI double_t
    (double_t,double_t);

    \<gtr\> fmod (5.3,0.7);

    0.4
  </verbatim>

  C structs are fully supported and are passed in a type-safe manner, see
  ffi.pure for details. Note that these are to be used for passing structs by
  value. (When passing a pointer to a struct, you must use
  <verbatim|pointer_t> instead.) For instance:

  <\verbatim>
    \<gtr\> let complex_t = struct_t (double_t,double_t);

    \<gtr\> let cexp = fcall "cexp" FFI_DEFAULT_ABI complex_t (complex_t);

    \<gtr\> members (cexp (struct complex_t (0.0,1.0)));

    0.54030230586814,0.841470984807897
  </verbatim>

  See the examples folder in the sources for more examples.

  <subsection|TODO<label|todo>>

  The API isn't perfect yet. In particular, one might consider to implement
  type descriptors as structs instead of raw pointers, and support for typed
  pointers would be useful. Contributions and suggestions are welcome.

  <subsubsection*|<hlink|Table Of Contents|index.tm><label|pure-ffi-toc>>

  <\itemize>
    <item><hlink|pure-ffi|#>

    <\itemize>
      <item><hlink|Copying|#copying>

      <item><hlink|Installation|#installation>

      <item><hlink|Usage|#usage>

      <item><hlink|TODO|#todo>
    </itemize>
  </itemize>

  Previous topic

  <hlink|pure-doc|pure-doc.tm>

  Next topic

  <hlink|pure-gen: Pure interface generator|pure-gen.tm>

  <hlink|toc|#pure-ffi-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-gen.tm> \|
  <hlink|previous|pure-doc.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2014, Albert Gräf et al. Last updated on Oct
  28, 2014. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
