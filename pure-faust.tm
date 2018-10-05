<TeXmacs|1.99.7>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-faust-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-liblo.tm> \|
  <hlink|previous|pure-audio.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|pure-faust><label|module-faust>

  Version 0.13, April 11, 2018

  Albert Graef \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  This module lets you load and run Faust-generated signal processing modules
  in <hlink|Pure|http://purelang.bitbucket.org/>.
  <hlink|Faust|http://faust.grame.fr/> (an acronym for Functional AUdio
  STreams) is a functional programming language for real-time sound
  processing and synthesis developed at <hlink|Grame|http://www.grame.fr/>
  and distributed as GPL'ed software.

  <with|font-series|bold|Note:> As of Pure 0.45, there's also built-in
  support for Faust interoperability in the Pure core, including the ability
  to inline Faust code in Pure programs; see <hlink|<em|Interfacing to
  Faust>|pure.tm#interfacing-to-faust> in the Pure manual. The built-in Faust
  interface requires a recent Faust version (2.0 or later, denoted using the
  \PFaust2\Q moniker in the following). Both interfaces provide pretty much
  the same basic capabilities and should work equally well for most
  applications. In fact, as of version 0.5 pure-faust comes with a
  compatibility module which provides the pure-faust API on top of the
  built-in Faust interface, see the description of the
  <hlink|<with|font-family|tt|faust2>|#module-faust2> module below for
  details.

  <subsection|Copying><label|copying>

  Unless explicitly stated otherwise, this software is Copyright (c)
  2009-2012 by Albert Graef. Please also see the source for the copyright and
  license notes pertaining to individual source files.

  pure-faust is free software: you can redistribute it and/or modify it under
  the terms of the GNU Lesser General Public License as published by the Free
  Software Foundation, either version 3 of the License, or (at your option)
  any later version.

  pure-faust is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License
  for more details.

  You should have received a copy of the GNU Lesser General Public License
  along with this program. If not, see \<less\><hlink|http://www.gnu.org/licenses/|http://www.gnu.org/licenses/>\<gtr\>.

  <subsection|Installation><label|installation>

  Get the latest source from <hlink|https://github.com/agraef/pure-lang/releases/download/pure-faust-0.13/pure-faust-0.13.tar.gz|https://github.com/agraef/pure-lang/releases/download/pure-faust-0.13/pure-faust-0.13.tar.gz>

  Binary packages can be found at <hlink|https://agraef.github.io/pure-lang/|https://agraef.github.io/pure-lang/>.
  To install from source, run the usual <verbatim|make> <verbatim|&&>
  <verbatim|sudo> <verbatim|make> <verbatim|install>. This requires Pure, of
  course (the present version will work with Pure 0.52 and later). The
  Makefile tries to guess the installation prefix under which Pure is
  installed. If it guesses wrong, you can tell it the right prefix with
  <verbatim|make> <verbatim|prefix=/some/path>. Or you can specify the exact
  path of the <verbatim|lib/pure> directory with <verbatim|make>
  <verbatim|libdir=/some/path>; by default the Makefile assumes
  <verbatim|$(prefix)/lib/pure>. The Makefile also tries to guess the host
  system type and set up some platform-specific things accordingly. If this
  doesn't work for your system then you'll have to edit the Makefile
  accordingly.

  The Faust compiler is not required to compile this module, but of course
  you'll need it to build the examples in the <verbatim|examples>
  subdirectory and to compile your own Faust sources. You'll need Faust
  0.9.46 or later.

  To compile Faust programs for use with this module, you'll also need the
  <verbatim|pure.cpp> architecture file. This should be included in recent
  Faust releases. If your Faust version doesn't have it yet, you can find a
  suitable version of this file in the <verbatim|examples> folder. Simply
  copy the file to your Faust library directory (usually something like
  <verbatim|/usr/local/lib/faust>, <verbatim|/usr/local/share/faust> with the
  latest Faust versions) or the directory holding the Faust sources to be
  compiled, and you should be set.

  <subsection|Usage><label|usage>

  Once Faust and this module have been installed as described above, you
  should be able to compile a Faust dsp to a shared module loadable by
  pure-faust as follows:

  <\verbatim>
    \;

    $ faust -a pure.cpp -o mydsp.cpp mydsp.dsp

    $ g++ -shared -o mydsp.so mydsp.cpp

    \;
  </verbatim>

  Note that, by default, Faust generates code which does all internal
  computations with single precision. You can add the <verbatim|-double> flag
  to the Faust command in order to use double precision instead. (In either
  case, all data will be represented as doubles on the Pure side.)

  Also note that the above compile command is for a Linux or BSD system using
  <verbatim|gcc>. Add <verbatim|-fPIC> for 64 bit compilation. For Windows
  compilation, the output filename should be <verbatim|mydsp.dll> instead of
  <verbatim|mydsp.so>; on Mac OSX, it should be <verbatim|mydsp.dylib>.
  There's a Makefile and a shell script in the <verbatim|examples> folder
  which both automate this process; the latter will also be included in
  recent Faust releases. Using the shell script, you can compile a Faust dsp
  simply as follows:

  <\verbatim>
    \;

    $ faust2pure mydsp.dsp

    \;
  </verbatim>

  This will also print the name of the compiled module on stdout.

  Once the module has been compiled, you can fire up the Pure interpreter and
  load the dsp as follows:

  <\verbatim>
    \;

    \<gtr\> using faust;

    \<gtr\> let dsp = faust_init "mydsp" 48000;

    \<gtr\> dsp;

    #\<less\>pointer 0xf09220\<gtr\>

    \;
  </verbatim>

  The <verbatim|faust_init> function loads the <verbatim|"mydsp.so"> module
  (the <verbatim|.so> suffix is supplied automatically) and returns a pointer
  to the Faust dsp object which can then be used in subsequent operations.

  <with|font-series|bold|Note:> <verbatim|faust_init> only loads the dsp
  module if it hasn't been loaded before. However, as of pure-faust 0.8,
  <verbatim|faust_init> also checks the modification time of the module and
  reloads it if the module was recompiled since it was last loaded. (This is
  for compatibility with Pure's built-in Faust interface which behaves in the
  same way.) If this happens, <em|all> existing dsp instances created with
  the old version of the module become invalid immediately (i.e., all
  subsequent operations on them will fail, except <verbatim|faust_exit>) and
  must be recreated.

  The second parameter of <verbatim|faust_init>, 48000 in this example,
  denotes the sample rate in Hz. This can be an arbitrary integer value which
  is available to the hosted dsp (it's up to the dsp whether it actually uses
  this value in some way). The sample rate can also be changed on the fly
  with the <verbatim|faust_reinit> function:

  <\verbatim>
    \;

    \<gtr\> faust_reinit dsp 44100;

    \;
  </verbatim>

  It is also possible to create copies of an existing dsp with the
  <verbatim|faust_clone> function, which is quite handy if multiple copies of
  the same dsp are needed (a case which commonly arises when implementing
  polyphonic synthesizers):

  <\verbatim>
    \;

    \<gtr\> let dsp2 = faust_clone dsp;

    \;
  </verbatim>

  When you're done with a dsp, you can invoke the <verbatim|faust_exit>
  function to unload it (this also happens automatically when a dsp object is
  garbage-collected):

  <\verbatim>
    \;

    \<gtr\> faust_exit dsp2;

    \;
  </verbatim>

  Note that after invoking this operation the dsp pointer becomes invalid and
  must not be used any more.

  In the following, we use the following little Faust program as a running
  example:

  <\verbatim>
    \;

    declare descr "amplifier";

    declare author "Albert Graef";

    declare version "1.0";

    \;

    gain = nentry("gain", 1.0, 0, 10, 0.01);

    process = *(gain);

    \;
  </verbatim>

  The <verbatim|faust_info> function can be used to determine the number of
  input/output channels as well as the \PUI\Q (a data structure describing
  the available control variables) of the loaded dsp:

  <\verbatim>
    \;

    \<gtr\> let n,m,ui = faust_info dsp;

    \;
  </verbatim>

  Global metadata of the dsp is available as a list of <verbatim|key=\>val>
  string pairs with the <verbatim|faust_meta> function. For instance:

  <\verbatim>
    \;

    \<gtr\> faust_meta dsp;

    ["descr"=\<gtr\>"amplifier","author"=\<gtr\>"Albert
    Graef","version"=\<gtr\>"1.0"]

    \;
  </verbatim>

  To actually run the dsp, you'll need two buffers capable of holding the
  required number of audio samples for input and output. For convenience, the
  <verbatim|faust_compute> routine lets you specify these as Pure double
  matrices. <verbatim|faust_compute> is invoked as follows:

  <\verbatim>
    \;

    \<gtr\> faust_compute dsp in out;

    \;
  </verbatim>

  Here, <verbatim|in> and <verbatim|out> must be double matrices which have
  at least <verbatim|n> or <verbatim|m> rows, respectively (corresponding to
  the number of input and output channels of the Faust dsp). The row size of
  these matrices determines the number of samples which will be processed (if
  one of the matrices has a larger row size than the other, the extra
  elements are ignored). The <verbatim|out> matrix will be modified in-place
  and also returned as the result of the call.

  Some DSPs (e.g., synthesizers) only take control input without processing
  any audio input; others (e.g., pitch detectors) might produce just control
  output without any audio output. In such cases you can just specify an
  empty <verbatim|in> or <verbatim|out> matrix, respectively. For instance:

  <\verbatim>
    \;

    \<gtr\> faust_compute dsp {} out;

    \;
  </verbatim>

  Most DSPs take additional control input. The control variables are listed
  in the \PUI\Q component of the <verbatim|faust_info> return value. For
  instance, suppose that there's a <verbatim|gain> parameter listed there, it
  might look as follows:

  <\verbatim>
    \;

    \<gtr\> controls ui!0;

    hslider #\<less\>pointer 0x12780a4\<gtr\> [] ("gain",1.0,0.0,10.0,0.1)

    \;
  </verbatim>

  The constructor itself denotes the type of control, which matches the name
  of the Faust builtin used to create the control (see the Faust
  documentation for more details on this). The <em|third> parameter is a
  tuple which indicates the arguments the control was created with in the
  Faust program. The <em|first> parameter is a C <verbatim|double*> which
  points to the current value of the control variable. You can inspect and
  change this value with the <verbatim|get_double> and <verbatim|put_double>
  routines available in the Pure prelude. (Note that, for compatibility with
  the internal Faust interface which supports both single and double
  precision controls, you can also use the <verbatim|get_control> and
  <verbatim|put_control> functions instead.) Changes of control variables
  only take effect between different invocations of <verbatim|faust_compute>.
  Example:

  <\verbatim>
    \;

    \<gtr\> let gain = control_ref (controls ui!0);

    \<gtr\> get_double gain;

    1.0

    \<gtr\> put_double gain 2.0;

    ()

    \<gtr\> faust_compute dsp in out;

    \;
  </verbatim>

  Output controls such as <verbatim|hbargraph> and <verbatim|vbargraph> are
  handled in a similar fashion, only that the Faust dsp updates these values
  for each call to <verbatim|faust_compute> and Pure scripts can then read
  the values with <verbatim|get_double> or <verbatim|get_control>.

  The <em|second> parameter of a control description is a list holding the
  Faust metadata of the control. This list will be empty if the control does
  not have any metadata. Otherwise you will find some of <verbatim|key=\>val>
  string pairs in this list. It is completely up to the application how to
  interpret the metadata, which may consist, e.g., of GUI layout hints or
  various kinds of controller definitions. For instance, a MIDI controller
  assignment might look as follows in the Faust source:

  <\verbatim>
    \;

    gain = nentry("gain[midi:ctrl 7]", 1.0, 0, 10, 0.01);

    \;
  </verbatim>

  In Pure this information will then be available as:

  <\verbatim>
    \;

    \<gtr\> control_meta (controls ui!0);

    ["midi"=\<gtr\>"ctrl 7"]

    \;
  </verbatim>

  Let's finally have a closer look at the contents of the UI data structure.
  You will find that it is actually a tree, similar to the directory tree of
  a hierarchical file system, which reflects the layout of the controls in
  the Faust program. For instance:

  <\verbatim>
    \;

    \<gtr\> ui;

    vgroup [] ("mydsp",[nentry #\<less\>pointer 0x12780a4\<gtr\> []
    ("gain",1.0,0.0,10.0,0.01)])

    \;
  </verbatim>

  The leaves of the tree are the actual controls, while its interior nodes
  are so-called \Pcontrol groups\Q, starting from a root node which
  represents the entire dsp. There are different kinds of control groups such
  as <verbatim|vgroup> and <verbatim|hgroup>; please check the Faust
  documentation for details. Control groups have a name and metadata just
  like individual controls, but there is no <verbatim|control_ref> component
  and the data stored at the node is the list of controls and subgroups
  contained in the control group. The <verbatim|controls> function returns a
  flat representation of the controls in the UI tree as a list, omitting the
  group nodes of the tree:

  <\verbatim>
    \;

    \<gtr\> controls ui;

    [hslider #\<less\>pointer 0x12780a4\<gtr\> [] ("gain",1.0,0.0,10.0,0.1)]

    \;
  </verbatim>

  We've already employed this function above to extract the <verbatim|gain>
  control of our example dsp. There's a variation of this function which
  yields the full \Ppathnames\Q of controls in the UI tree:

  <\verbatim>
    \;

    \<gtr\> pcontrols ui;

    [hslider #\<less\>pointer 0x12780a4\<gtr\> []
    ("mydsp/gain",1.0,0.0,10.0,0.1)]

    \;
  </verbatim>

  This is sometimes necessary to distinguish controls with identical names in
  different control groups. There are two additional convenience functions
  which work with this flat representation of the UI data structure:

  <\verbatim>
    \;

    \<gtr\> let ctrls = ans;

    \<gtr\> control_map ctrls;

    {"mydsp/gain"=\<gtr\>#\<less\>pointer 0x12780a4\<gtr\>}

    \<gtr\> control_metamap ctrls;

    {"mydsp/gain"=\<gtr\>[]}

    \;
  </verbatim>

  The results are Pure records which provide convenient access to the
  pointers and metadata of the controls by their name.

  Please note that, as of Pure 0.45, the UI access functions described above
  are actually provided by the <verbatim|faustui> standard library module
  which gets included by the <hlink|<with|font-family|tt|faust>|#module-faust>
  module.

  Further examples can be found in the examples subdirectory.

  <subsection|Faust2 Compatibility><label|module-faust2>

  As of version 0.5, pure-faust includes a Faust2 compatibility module which
  lets you use the pure-faust API on top of Pure's new Faust bitcode
  interface, using the same operations as described under
  <hlink|Usage|#usage> above. This module is invoked with the following
  import clause:

  <\verbatim>
    \;

    using faust2;

    \;
  </verbatim>

  To instantiate a Faust dsp using the <hlink|<with|font-family|tt|faust2>|#module-faust2>
  interface, you'll have to compile the Faust program to LLVM bitcode format.
  The easiest way to do this is to use the <verbatim|faust2pure> script with
  the <verbatim|-bitcode> option. Please see the <hlink|<em|Interfacing to
  Faust>|pure.tm#interfacing-to-faust> section in the Pure manual for
  details.

  Note that only one of the <hlink|<with|font-family|tt|faust>|#module-faust>
  and <hlink|<with|font-family|tt|faust2>|#module-faust2> modules may be
  imported into a program; trying to use both modules in the same program
  will <em|not> work. Also note that the <hlink|<with|font-family|tt|faust2>|#module-faust2>
  module requires Faust2 and a fairly recent Pure version to work, whereas
  the <hlink|<with|font-family|tt|faust>|#module-faust> module works with
  both current Faust (Faust2) and older Faust versions and doesn't rely on
  the Faust bitcode loader (only the <verbatim|pure.cpp> architecture is
  needed).

  <subsection|Acknowledgements><label|acknowledgements>

  Many thanks to Yann Orlarey at Grame, the principal author of Faust!

  <subsubsection*|<hlink|Table Of Contents|index.tm>><label|pure-faust-toc>

  <\itemize>
    <item><hlink|pure-faust|#>

    <\itemize>
      <item><hlink|Copying|#copying>

      <item><hlink|Installation|#installation>

      <item><hlink|Usage|#usage>

      <item><hlink|Faust2 Compatibility|#module-faust2>

      <item><hlink|Acknowledgements|#acknowledgements>
    </itemize>
  </itemize>

  Previous topic

  <hlink|pure-audio|pure-audio.tm>

  Next topic

  <hlink|pure-liblo|pure-liblo.tm>

  <hlink|toc|#pure-faust-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-liblo.tm> \|
  <hlink|previous|pure-audio.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2018, Albert Gräf et al. Last updated on Oct
  05, 2018. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
