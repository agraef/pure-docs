<TeXmacs|1.99.7>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-gtk-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-tk.tm> \|
  <hlink|previous|pure-gl.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|Pure GTK+ Bindings><label|pure-gtk-bindings>

  Version 0.13, April 11, 2018

  Albert Graef \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  pure-gtk is a collection of bindings to use the GTK+ GUI toolkit version
  2.x with Pure, see <hlink|http://www.gtk.org|http://www.gtk.org>. The
  bindings include the gtk (+gdk), glib, atk, cairo and pango libraries, each
  in their own Pure module.

  At present these are just straight 1-1 wrappers of the C libraries, created
  with pure-gen. So they still lack some convenience, but they are perfectly
  usable already, and a higher-level API for accessing all the functionality
  will hopefully become available in time. In fact <em|you> can help make
  that happen. :) So please let me know if you'd like to give a helping hand
  in improving pure-gtk.

  <subsection|Copying><label|copying>

  Copyright (c) 2008-2011 by Albert Graef.

  pure-gtk is free software: you can redistribute it and/or modify it under
  the terms of the GNU Lesser General Public License as published by the Free
  Software Foundation, either version 3 of the License, or (at your option)
  any later version.

  pure-gtk is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for
  more details.

  You should have received a copy of the GNU Lesser General Public License
  along with this program. If not, see \<less\><hlink|http://www.gnu.org/licenses/|http://www.gnu.org/licenses/>\<gtr\>.

  <subsection|Installation><label|installation>

  You can get the latest source from <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-gtk-0.13.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-gtk-0.13.tar.gz>.

  For Windows users, a ready-made package in msi format is available from
  <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-gtk-0.13.msi|https://bitbucket.org/purelang/pure-lang/downloads/pure-gtk-0.13.msi>.

  To install from source, do the usual <verbatim|make> <verbatim|&&>
  <verbatim|sudo> <verbatim|make> <verbatim|install> (see the Makefile for
  further options). This needs Pure and the GTK header files and libraries.
  You'll also need <hlink|<em|pure-ffi>|pure-ffi.tm> for running the
  examples.

  NOTE: The source release was prepared with GTK+ 2.24.4 on Ubuntu 11.04. If
  you're seeing a lot of warnings and/or errors when compiling or loading the
  modules, your GTK headers are probably much different from these. In that
  case you should run <verbatim|make> <verbatim|generate> to regenerate the
  bindings; for this you also need to have pure-gen installed. (If you
  already have pure-gen then it's a good idea to do this anyway.)

  <subsection|Usage><label|module-atk><label|module-cairo><label|module-glib><label|module-gtk><label|module-pango><label|module-atk>

  See examples/hello.pure for a basic example. The files uiexample.pure and
  uiexample.glade show how to run a GUI created with the Glade-3 interface
  builder. This needs a recent version of the GtkBuilder API to work. (If
  you're still running Glade-2 and an older GTK+ version, you might want to
  use the older libglade interface instead. Support for that is in the
  Makefile, but it's not enabled by default.) NOTE: The examples start up
  much faster when they are compiled to native executables. To do this, just
  run <verbatim|make> <verbatim|examples> after <verbatim|make>. (Be patient,
  this takes a while.)

  pure-gtk can be discussed on the Pure mailing list at:
  <hlink|http://groups.google.com/group/pure-lang|http://groups.google.com/group/pure-lang>

  <subsubsection*|<hlink|Table Of Contents|index.tm>><label|pure-gtk-toc>

  <\itemize>
    <item><hlink|Pure GTK+ Bindings|#>

    <\itemize>
      <item><hlink|Copying|#copying>

      <item><hlink|Installation|#installation>

      <item><hlink|Usage|#module-atk>
    </itemize>
  </itemize>

  Previous topic

  <hlink|Pure OpenGL Bindings|pure-gl.tm>

  Next topic

  <hlink|pure-tk|pure-tk.tm>

  <hlink|toc|#pure-gtk-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-tk.tm> \|
  <hlink|previous|pure-gl.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2018, Albert Gräf et al. Last updated on Oct
  05, 2018. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
