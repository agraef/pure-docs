<TeXmacs|1.0.7.20>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-lv2-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-midi.tm> \|
  <hlink|previous|pure-lilv.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|pure-lv2<label|module-lv2>>

  Version 0.1, March 11, 2014

  Albert Gräf \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  <subsection|Copying<label|copying>>

  pure-lv2 is Copyright (c) 2014 by Albert Gräf. It is distributed under a
  3-clause BSD license, please check the COPYING file included in the
  distribution for details.

  <subsection|Installation<label|installation>>

  Get the latest source from <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-lv2-0.1.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-lv2-0.1.tar.gz>.

  Make sure that you have the latest Pure version installed. (At the time of
  this writing, the latest Pure source from hg is needed.)

  Run <verbatim|make> to compile and <verbatim|sudo> <verbatim|make>
  <verbatim|install> to install the module. This installs the lv2.pure module
  and the source of the LV2 plugin wrapper (lv2pure.c, lv2pure.h) in the Pure
  library directory, and the pure2lv2 script in the bin directory, under the
  same installation prefix as the Pure interpreter. To uninstall the module,
  use <verbatim|sudo> <verbatim|make> <verbatim|uninstall>. There are a
  number of other targets (mostly for maintainers), please see the Makefile
  for details.

  <verbatim|make> tries to guess your Pure installation directory and
  platform-specific setup. If it gets this wrong, you can set some variables
  manually, please see the Makefile for details.

  <subsection|Description<label|description>>

  This package provides a generic LV2 plugin wrapper for Pure.
  <hlink|LV2|http://lv2plug.in/> is the new Linux audio plugin standard
  (LADSPA successor) which aims to be portable and extensible. The package
  contains some C wrapper code which can be linked with a batch-compiled Pure
  script to obtain an LV2 plugin module. A shell script named pure2lv2 is
  included, which lets you compile the plugin and turn it into an LV2 bundle,
  ready to be loaded by any LV2 host. There's also an lv2.pure module which
  provides some operations needed to implement the functionality of a plugin,
  such as functions to read and write LV2 ports in Pure.

  Documentation still needs to be written. For the time being, please refer
  to the lv2.pure script for a description of the programming interface, and
  to the scripts in the examples folder for LV2 plugin examples written in
  Pure.

  <subsection|Usage<label|usage>>

  The pure2lv2 script is invoked simply as <verbatim|pure2lv2>
  <verbatim|myplugin.pure> where <verbatim|myplugin.pure> is the Pure script
  implementing the plugin. The plugin script must provide two functions
  <verbatim|manifest>, which returns the port descriptions from which the
  plugin manifest is created, and <verbatim|plugin> which implements the
  plugin itself. Please check the included examples to get an idea how the
  plugin scripts look like.

  Running <verbatim|pure2lv2> <verbatim|myplugin.pure> turns the plugin
  script into an LV2 bundle, which will be written to <verbatim|myplugin.lv2>
  by default. You can also specify a different name for the bundle directory
  with the <verbatim|-o> (or <verbatim|--output>) option, and a custom URI
  prefix for the bundle with the <verbatim|-u> (or <verbatim|--uriprefix>)
  option. In either case, you still have to move the bundle directory to a
  directory on your <verbatim|LV2_PATH> before you can use it with your LV2
  hosts.

  Normally the code of the plugin will be compiled to a native object file
  which gets linked into the plugin binary. However, there's also a
  <verbatim|-s> (or <verbatim|--script>) option which copies the source
  script (along with any additional source files specified after the plugin
  script on the command line) to the bundle directory instead, from where it
  will be loaded dynamically when the plugin is used. This increases load
  times (sometimes substantially), but lets you modify the plugin more
  easily, by just changing the plugin script inside the bundle, which may be
  more convenient during plugin development.

  A summary of the command syntax and options of the pure2lv2 script can be
  printed with <verbatim|purelv2> <verbatim|-h>.

  <subsubsection*|<hlink|Table Of Contents|index.tm><label|pure-lv2-toc>>

  <\itemize>
    <item><hlink|pure-lv2|#>

    <\itemize>
      <item><hlink|Copying|#copying>

      <item><hlink|Installation|#installation>

      <item><hlink|Description|#description>

      <item><hlink|Usage|#usage>
    </itemize>
  </itemize>

  Previous topic

  <hlink|pure-lilv: Pure Lilv Interface|pure-lilv.tm>

  Next topic

  <hlink|pure-midi|pure-midi.tm>

  <hlink|toc|#pure-lv2-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-midi.tm> \|
  <hlink|previous|pure-lilv.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2014, Albert Gräf et al. Last updated on Mar
  11, 2014. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
