<TeXmacs|1.99.5>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#install-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|windows.tm> \|
  <hlink|previous|pure-midi.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|Installing Pure (and LLVM)><label|installing-pure-and-llvm>

  Version 0.66, March 04, 2017

  Albert Graef \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  Eddie Rucker \<less\><hlink|erucker@bmc.edu|mailto:erucker@bmc.edu>\<gtr\>

  These instructions explain how to compile and install LLVM (which is the
  compiler backend required by Pure) and the Pure interpreter itself. The
  instructions are somewhat biased towards Linux and other Unix-like systems;
  the <hlink|System Notes|#system-notes> section at the end of this file
  details the tweaks necessary to make Pure compile and run on various other
  platforms. More information about installing LLVM and the required LLVM
  source packages can be found at <hlink|http://llvm.org|http://llvm.org>.

  Pure is known to work on Linux, FreeBSD, NetBSD, Mac OS X and MS Windows,
  and should compile (with the usual amount of tweaking) on all recent
  UNIX/POSIX- based platforms. Pure should compile out of the box with
  reasonably recent versions of either gcc or clang. You'll also need a
  Bourne-compatible shell and GNU make, which are also readily available on
  most platforms. For Windows compilation we support the Mingw version of gcc
  along with the MSYS environment.

  A binary package in msi format is provided for Windows users in the
  download area at <hlink|http://purelang.bitbucket.org|http://purelang.bitbucket.org>.
  Information about ports and packages for other (UNIX-like) systems is
  provided at the same location.

  <subsection|Quick Summary><label|quick-summary>

  Here is the executive summary for the impatient. This assumes that you're
  using LLVM 3.4 and Pure 0.66, please substitute your actual version numbers
  in the commands given below as needed.

  <with|font-series|bold|Note:> If you're reading this documentation online,
  then the Pure version described here most likely is still under
  development, in which case you can either grab the latest available
  release, or install from the development sources instead (see
  <hlink|Installing From Development Sources|#installing-from-development-sources>
  below).

  Prerequisites: gcc, GNU make, flex/bison (development sources only),
  libltdl, libgmp and libmpfr (including header files for development), wget
  (for downloading and installing the online documentation), GNU emacs (if
  you want to use Emacs Pure mode). These should all be available as binary
  packages on most systems.

  You'll also need LLVM and, of course, Pure. The LLVM 3.4 and Pure 0.66
  tarballs are available here:

  <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-0.66.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-0.66.tar.gz>

  <hlink|http://llvm.org/releases/3.4/llvm-3.4.src.tar.gz|http://llvm.org/releases/3.4/llvm-3.4.src.tar.gz>

  <hlink|http://llvm.org/releases/3.4/clang-3.4.src.tar.gz|http://llvm.org/releases/3.4/clang-3.4.src.tar.gz>

  <hlink|http://llvm.org/releases/3.4/dragonegg-3.4.src.tar.gz|http://llvm.org/releases/3.4/dragonegg-3.4.src.tar.gz>

  <with|font-series|bold|Note:> The present Pure version requires an LLVM
  version that still supports the \Pold\Q (pre-MCJIT) just-in-time compiler
  back-end (JIT). This means that the latest <em|supported> LLVM release is
  <with|font-series|bold|3.5.2>, which was released in April 2015. Earlier
  versions in the 3.x series should still work fine as well, if you can make
  them compile on your system. The following instructions assume that you use
  the very stable LLVM 3.4 release, otherwise you'll have to adjust the
  commands in the instructions accordingly.

  Installing LLVM and clang (the latter is optional but recommended):

  <\verbatim>
    \;

    $ tar xfvz llvm-3.4.src.tar.gz

    $ tar xfvz clang-3.4.src.tar.gz && mv clang-3.4 llvm-3.4/tools/clang

    $ cd llvm-3.4

    $ ./configure --enable-shared --enable-optimized
    --enable-targets=host-only

    $ make && sudo make install

    \;
  </verbatim>

  Be patient, this takes a while...

  You may want to leave out <verbatim|--enable-shared> to install LLVM as
  static libraries only, and <verbatim|--enable-targets=host-only> if you
  want to enable cross compilation for all supported targets in LLVM. (With
  some older LLVM versions you may also have to add
  <verbatim|--disable-assertions> <verbatim|--disable-expensive-checks> to
  disable stuff that makes LLVM very slow and/or breaks it on some systems.)
  Also, if you're still running gcc 4.5 or 4.6, you may want to install the
  LLVM \PDragonEgg\Q plugin for gcc, which provides LLVM bitcode compilation
  for languages other than C/C++. Please check the
  <hlink|dragonegg|#dragonegg> section below for details.

  Installing Pure:

  <\verbatim>
    \;

    $ tar xfvz pure-0.66.tar.gz

    $ cd pure-0.66

    $ ./configure --enable-release

    $ make && sudo make install

    \;
  </verbatim>

  Depending on your system you may have to run a utility to announce the
  shared LLVM and Pure libraries to the dynamic loader. E.g., on Linux:

  <\verbatim>
    \;

    $ sudo /sbin/ldconfig

    \;
  </verbatim>

  It is also recommended that you run the following to make sure that the
  Pure interpreter works correctly on your platform (see step 5 below for
  details):

  <\verbatim>
    \;

    $ make check

    \;
  </verbatim>

  The following is optional, but if you want to read the online documentation
  in the interpreter or in <hlink|Emacs Pure mode|#emacs-pure-mode>, you'll
  have to download and install the documentation files:

  <\verbatim>
    \;

    $ sudo make install-docs

    \;
  </verbatim>

  This needs the <verbatim|wget> program. You can also download and install
  the pure-docs tarball manually in the usual way, e.g.:

  <\verbatim>
    \;

    $ tar xfvz pure-docs-0.66.tar.gz

    $ cd pure-docs-0.66

    $ sudo make install

    \;
  </verbatim>

  That's it, Pure should be ready to go now:

  <\verbatim>
    \;

    $ pure

    \;
  </verbatim>

  Uninstalling:

  <\verbatim>
    \;

    $ cd pure-0.66

    $ sudo make uninstall

    $ cd ../llvm-3.4

    $ sudo make uninstall

    \;
  </verbatim>

  Please see below for much more detailed installation instructions.

  <subsection|Basic Installation><label|basic-installation>

  The basic installation process is as follows. Note that steps 1-3 are only
  required once. Steps 2-3 can be avoided if binary LLVM packages are
  available for your system (but see the caveats about broken LLVM packages
  on some systems below). Additional instructions for compiling Pure from the
  latest repository sources can be found in the <hlink|Installing From
  Development Sources|#installing-from-development-sources> section below.
  Moreover, you can refer to the <hlink|Other Build And Installation
  Options|#other-build-and-installation-options> section below for details
  about various options available when building and installing Pure.

  <with|font-series|bold|Step 1.> Make sure you have all the necessary
  dependencies installed (<verbatim|-dev> denotes corresponding development
  packages):

  <\itemize>
    <item>GNU make, GNU C/C++ and the corresponding libraries;

    <item>the GNU multiprecision library (<verbatim|libgmp>, <verbatim|-dev>)
    or some compatible replacement (see comments below);

    <item>the GNU multiprecision floating point library (<verbatim|libmpfr>,
    <verbatim|-dev>);

    <item>the PCRE library (<verbatim|libpcre>, <verbatim|-dev>), if you want
    Perl-compatible regex support (see below);

    <item>GNU readline (<verbatim|libreadline>, <verbatim|-dev>) or some
    compatible replacement (only needed if you want command line editing
    support in the interpreter; see comments below).

    <item>GNU Emacs (if you want to use the Emacs Pure mode).

    <item>GNU TeXmacs (if you want to use the TeXmacs Pure plugin).
  </itemize>

  In addition, the following will be required to compile the development
  version (see the <hlink|Installing From Development
  Sources|#installing-from-development-sources> section below):

  <\itemize>
    <item>autoconf and automake;

    <item>flex and bison;

    <item>git (needed to fetch the development sources).
  </itemize>

  The following may be required to build some LLVM versions:

  <\itemize>
    <item>GNU ltdl library (<verbatim|libltdl>, <verbatim|-dev>).
  </itemize>

  All dependencies are available as free software. Here are some links if you
  need or want to install the dependencies from source:

  <\itemize>
    <item>Autoconf: <hlink|http://www.gnu.org/software/autoconf|http://www.gnu.org/software/autoconf>

    <item>Automake: <hlink|http://www.gnu.org/software/automake|http://www.gnu.org/software/automake>

    <item>GNU C/C++: <hlink|http://gcc.gnu.org|http://gcc.gnu.org>

    <item>GNU make: <hlink|http://www.gnu.org/software/make|http://www.gnu.org/software/make>

    <item>Flex: <hlink|http://flex.sourceforge.net|http://flex.sourceforge.net>

    <item>Bison: <hlink|http://www.gnu.org/software/bison|http://www.gnu.org/software/bison>

    <item>GNU Emacs: <hlink|http://www.gnu.org/software/emacs|http://www.gnu.org/software/emacs>

    <item>GNU TeXmacs: <hlink|http://savannah.gnu.org/projects/texmacs|http://savannah.gnu.org/projects/texmacs>

    <item>GNU ltdl (part of the libtool software):
    <hlink|http://www.gnu.org/software/libtool|http://www.gnu.org/software/libtool>
  </itemize>

  Git can be obtained from <hlink|https://git-scm.com/|https://git-scm.com/>.
  A number of graphical frontends can be found there as well. Windows users
  may also want to check TortoiseGit, see
  <hlink|https://tortoisegit.org/|https://tortoisegit.org/>.

  The GNU multiprecision library or some compatible replacement is required
  for Pure's bigint support. Instead of GMP it's also possible to use MPIR.
  You can find these here:

  <\itemize>
    <item>GMP: <hlink|http://www.gnu.org/software/gmp|http://www.gnu.org/software/gmp>

    <item>MPIR: <hlink|http://www.mpir.org|http://www.mpir.org>
  </itemize>

  If you have both GMP and MPIR installed, you can specify
  <verbatim|--with-mpir> when configuring Pure to indicate that Pure should
  be linked against MPIR. Note that using this option might cause issues with
  some Pure modules which explicitly link against GMP. If you run into any
  such problems then you should build MPIR with the
  <verbatim|--enable-gmpcompat> configure option so that it becomes a drop-in
  replacement for GMP (in this case the <verbatim|--with-mpir> option isn't
  needed when configuring Pure).

  In addition, Pure 0.48 and later also require the GNU multiprecision
  floating point library:

  <\itemize>
    <item>MPFR: <hlink|http://www.mpfr.org|http://www.mpfr.org>
  </itemize>

  (Pure doesn't really have built-in support for MPFR numbers, this is
  provided through a separate pure-mpfr addon module instead, please check
  the Pure website for details. However, there is now some support for
  printing both GMP and MPFR numbers in the <verbatim|printf> and
  <verbatim|scanf> functions of the <hlink|<with|font-family|tt|system>|purelib.tm#module-system>
  module, for which the MPFR library is needed.)

  To make interactive command line editing work in the interpreter, you'll
  also need GNU readline or some compatible replacement such as BSD
  editline/libedit:

  <\itemize>
    <item>GNU readline: <hlink|http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html|http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html>

    <item>BSD editline/libedit: <hlink|http://www.thrysoee.dk/editline|http://www.thrysoee.dk/editline>
  </itemize>

  We recommend GNU readline because it's easier to use and has full UTF-8
  support, but in some situations BSD editline/libedit may be preferable for
  license reasons or because it's what the operating system provides. Pure's
  configuration script automatically detects the presence of both packages
  and also lets you disable readline and/or editline support using the
  <verbatim|--without-readline> and <verbatim|--without-editline> options.

  Pure normally uses the system's POSIX regex functions for its regular
  expression support (<hlink|<with|font-family|tt|regex>|purelib.tm#module-regex>
  module). Instead, you can also build it with support for Perl-style regular
  expressions. This is done by linking in the POSIX compatibility layer of
  the PCRE library:

  <\itemize>
    <item>PCRE: <hlink|http://www.pcre.org/|http://www.pcre.org/>
  </itemize>

  Please note that the PCRE support is still experimental and currently
  disabled by default. Configuring with <verbatim|--with-pcre> enables it.
  Also note that at present this is only available as a compile-time switch;
  to change the regex library used by the Pure runtime you need to recompile
  the interpreter.

  <with|font-series|bold|Step 2.> Get and unpack the LLVM sources.

  You can find these at <hlink|http://llvm.org/releases/download.html|http://llvm.org/releases/download.html>.

  You only need the LLVM tarball which contains the LLVM library as well as
  most of the LLVM toolchain. LLVM 3.5.2 is the latest <em|supported> release
  at the time of this writing. LLVM versions 2.5 thru 3.5 have all been
  tested and are known to work with Pure. We really recommend using LLVM 3.0
  or later, however, because LLVM has improved considerably in recent
  releases. (Support for older versions may be dropped in the future.)

  At this point we also recommend getting an LLVM-capable C/C++ compiler.
  This is completely optional, but you'll need it to take advantage of the
  new bitcode loader in Pure 0.44 and later. The easiest way to go is to take
  the clang tarball which corresponds to your LLVM version, unpack its
  contents into the LLVM tools directory and rename the <verbatim|clang-x.y>
  directory to just <verbatim|clang>. The clang compiler will then be built
  and installed along with LLVM. On older systems, you can also use llvm-gcc
  or dragonegg instead, please see <hlink|Installing an LLVM-capable C/C++
  Compiler|#installing-an-llvm-capable-c-c-compiler> below for further
  details.

  <with|font-series|bold|Note:> Some (older) Linux and BSD distributions
  provide LLVM packages and ports which are compiled with wrong configure
  options and are thus broken. If the Pure interpreter segfaults on startup
  or fails its test suite (<verbatim|make> <verbatim|check>) then you should
  check whether there's a newer LLVM package available for your system, or
  compile LLVM yourself.

  <with|font-series|bold|Step 3.> Configure, build and install LLVM as
  follows (assuming LLVM 3.4):

  <\verbatim>
    \;

    $ cd llvm-3.4

    $ ./configure --enable-shared --enable-optimized
    --enable-targets=host-only

    $ make

    $ sudo make install

    \;
  </verbatim>

  LLVM 2.7 and earlier may also require the flags
  <verbatim|--disable-assertions> <verbatim|--disable-expensive-checks> to
  disable some features which make LLVM slow and/or buggy on some systems.
  With LLVM 2.8 and later these options aren't needed any more.

  Note that the <verbatim|--enable-shared> option builds and installs LLVM as
  a shared library, which is often preferable if you're running different
  LLVM-based tools and compilers on your system. This requires LLVM 2.7 or
  later and may be broken on some systems. You can always leave out that
  option, in which case LLVM will be linked statically into the Pure runtime
  library. (You can also force Pure to be linked statically against LLVM even
  if you have the shared LLVM library installed, by configuring Pure with the
  <verbatim|--with-static-llvm> flag. This may be useful if you plan to
  deploy the Pure runtime library on systems which don't have LLVM
  installed.)

  Also note that the configure flags are for an optimized (non-debug) build
  and disable all compilation targets but the one for your system. You might
  wish to play with the configure options, but note that some options
  (especially <verbatim|--enable-expensive-checks>) can make LLVM very slow
  and may even break the Pure interpreter on some systems.

  <with|font-series|bold|Step 4.> Get and unpack the Pure sources.

  These can be downloaded from <hlink|http://purelang.bitbucket.org|http://purelang.bitbucket.org>.
  The latest source tarballs can always be found in the \PDownloads\Q
  section.

  <with|font-series|bold|Step 5.> Configure, build and install Pure as
  follows:

  <\verbatim>
    \;

    $ cd pure-0.66

    $ ./configure --enable-release

    $ make

    $ sudo make install

    \;
  </verbatim>

  The <verbatim|--enable-release> option configures Pure for a release build.
  This is recommended for maximum performance. If you leave away this option
  then you'll get a default build which includes debugging information and
  extra runtime checks useful for the Pure maintainers, but also runs
  considerably slower.

  To find out about other build options, you can invoke configure as
  <verbatim|./configure> <verbatim|--help>.

  The <verbatim|sudo> <verbatim|make> <verbatim|install> command installs the
  pure program, the runtime.h header file, the runtime library libpure.so, a
  Pure pkg-config file (pure.pc) and the library scripts in the appropriate
  subdirectories of /usr/local; the installation prefix can be changed with
  the <verbatim|--prefix> configure option, see <hlink|Other Build And
  Installation Options|#other-build-and-installation-options> for details.
  (The runtime.h header file is not needed for normal operation, but can be
  used to write C/C++ extensions modules or embed Pure in your C/C++
  applications.)

  In addition, if the presence of GNU Emacs was detected at configure time,
  then by default pure-mode.el and pure-mode.elc will be installed in the
  Emacs site-lisp directory. make tries to guess the proper location of the
  site-lisp directory, but if it guesses wrong or if you want to install in
  some custom location then you can also set the <verbatim|elispdir> make
  variable accordingly. If you prefer, you can also disable the automatic
  installation of the elisp files by running configure with
  <verbatim|./configure> <verbatim|--without-elisp>. (In that case, it's
  still possible to install the elisp files manually with <verbatim|make>
  <verbatim|install-el> <verbatim|install-elc>.)

  Similarly, if you have <hlink|GNU TeXmacs|http://savannah.gnu.org/projects/texmacs/>
  on your system and configure can locate it, the corresponding Pure plugin
  will be installed into the TeXmacs plugins directory. make tries to guess
  the proper location of the TeXmacs plugins directory, but if it guesses
  wrong or if you want to install in some custom location then you can also
  set the <verbatim|tmdir> make variable accordingly. If you prefer, you can
  also disable the automatic installation of the TeXmacs plugin by running
  configure with <verbatim|./configure> <verbatim|--without-texmacs>. (In
  that case, it's still possible to install the plugin manually with
  <verbatim|make> <verbatim|install-tm>.)

  On some systems you have to tell the dynamic linker to update its cache so
  that it finds the Pure runtime library. E.g., on Linux this is done as
  follows:

  <\verbatim>
    \;

    $ sudo /sbin/ldconfig

    \;
  </verbatim>

  After the build is complete, you can (and should) also run a few tests to
  check that Pure is working correctly on your computer:

  <\verbatim>
    \;

    $ make check

    \;
  </verbatim>

  (This can be done before actually installing Pure, but make sure that you
  first run <verbatim|ldconfig> or similar if you installed LLVM as a shared
  library, otherwise <verbatim|make> <verbatim|check> may fail simply because
  the LLVM library isn't found.)

  If all is well, all tests should pass. If not, the test directory will
  contain some <verbatim|*.diff> files containing further information about
  the failed tests. In that case please zip up the entire test directory and
  mail it to the author, post it on the Pure mailing list, or enter a bug
  report at <hlink|https://bitbucket.org/purelang/pure-lang/issues|https://bitbucket.org/purelang/pure-lang/issues>.
  Also please include precise information about your platform (operating
  system and cpu architecture) and the Pure and LLVM versions and/or source
  revision numbers you're running.

  Note that <verbatim|make> <verbatim|check> executes the run-tests script
  which is generated at configure time. If necessary, you can also run
  individual tests by running run-tests directly (e.g.,
  <verbatim|./run-tests> <verbatim|test/test020.pure>
  <verbatim|test/test047.pure>) or rerun only the tests that failed on the
  previous invocation (<verbatim|./run-tests> <verbatim|-f> or, equivalently,
  <verbatim|make> <verbatim|recheck>).

  Also note that MSYS 1.0.11 or later (or at least the diffutils package from
  that version) is required to make <verbatim|make> <verbatim|check> work on
  Windows. Also, under MS Windows this step is expected to fail on some math
  tests in test020.pure; this is nothing to worry about, it just indicates
  that some math routines in Microsoft's C library aren't fully
  POSIX-compatible. The same applies to some BSD systems.

  If Pure appears to be broken on your system (<verbatim|make>
  <verbatim|check> reports a lot of failures), it's often because of a
  miscompiled LLVM. Please review the instructions under step 3, and check
  the <hlink|System Notes|#system-notes> section to see whether your platform
  is known to have issues and which workarounds may be needed. If all that
  doesn't help then you might be running into LLVM bugs and limitations on
  not-so-well supported platforms; in that case please also report the
  results of <verbatim|make> <verbatim|check> as described above, so that we
  can try to figure out what is going on and whether there's a fix or
  workaround for the problem.

  <with|font-series|bold|Note:> If you have one of the LLVM C/C++ compilers
  installed (see <hlink|Installing an LLVM-capable C/C++
  Compiler|#installing-an-llvm-capable-c-c-compiler>), you can use those to
  compile Pure by passing the appropriate compiler names on the configure
  line:

  <\verbatim>
    \;

    $ ./configure --enable-release CC=clang CXX=clang++

    \;
  </verbatim>

  Or, when using llvm-gcc:

  <\verbatim>
    \;

    $ ./configure --enable-release CC=llvm-gcc CXX=llvm-g++

    \;
  </verbatim>

  llvm-gcc 4.2 and clang 2.8 or later should build Pure cleanly and pass all
  checks.

  <with|font-series|bold|Step 6.> Download and install the online
  documentation as follows:

  <\verbatim>
    \;

    $ sudo make install-docs

    \;
  </verbatim>

  This isn't necessary to run the interpreter, but highly recommended, as it
  gives you a complete set of manuals in html format which covers the Pure
  language and interpreter, the standard library, and all addon modules
  available from the Pure website. You can read these manuals with the
  <verbatim|help> command in the interpreter. You also need to have a html
  browser installed to make this work. By default, the interpreter assumes
  w3m (a text-based browser), you can change this by setting the
  <verbatim|BROWSER> or the <verbatim|PURE_HELP> variable accordingly.

  The <verbatim|install-docs> target requires a working Internet connection
  and the wget command. Instead, you can also download the
  pure-docs-0.66.tar.gz tarball manually and then install the documentation
  from the downloaded tarball in the usual way:

  <\verbatim>
    \;

    $ tar xfvz pure-docs-0.66.tar.gz

    $ cd pure-docs-0.66

    $ sudo make install

    \;
  </verbatim>

  As a bonus, downloading the package manually also gives you the
  documentation in pdf format (900+ pages), so that you can print it if you
  like. In addition, as of version 0.56 the tarball also contains the
  documentation in TeXmacs format so that you can read it inside TeXmacs (see
  <hlink|TeXmacs Plugin|#texmacs-plugin> below). After unpacking the tarball
  and installing the html documentation, you can install the
  TeXmacs-formatted documentation as follows:

  <\verbatim>
    \;

    $ sudo make install-tm

    \;
  </verbatim>

  <with|font-series|bold|Step 7.> The Pure interpreter should be ready to go
  now.

  Run Pure interactively as:

  <\verbatim>
    \;

    $ pure

    \;

    \ __ \\ \ \| \ \ \| \ __\| _ \\ \ \ \ Pure 0.66
    (x86_64-unknown-linux-gnu)

    \ \| \ \ \| \| \ \ \| \| \ \ \ __/ \ \ \ Copyright (c) 2008-2017 by
    Albert Graef

    \ .__/ \\__,_\|_\| \ \\___\| \ \ \ (Type 'help' for help, 'help copying'

    _\| \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ for license information.)

    \;

    Loaded prelude from /usr/lib/pure/prelude.pure.

    \;
  </verbatim>

  Check that it works:

  <\verbatim>
    \;

    \<gtr\> 6*7;

    42

    \;
  </verbatim>

  Read the online documentation:

  <\verbatim>
    \;

    \<gtr\> help

    \;
  </verbatim>

  Exit the interpreter (you can also just type the end-of-file character at
  the beginning of a line, i.e., <verbatim|Ctrl-D> on Unix):

  <\verbatim>
    \;

    \<gtr\> quit

    \;
  </verbatim>

  You can also run the interpreter from GNU Emacs and GNU TeXmacs (see
  below), and for Windows there is a nice GUI application named \PPurePad\Q
  which makes it easy to edit and run your Pure scripts.

  <subsection|Emacs Pure Mode><label|emacs-pure-mode>

  This step is optional, but if you're friends with Emacs then you should
  definitely give Pure mode a try. This is an Emacs programming mode which
  turns Emacs into an advanced IDE to edit and run Pure programs. If Emacs
  was detected by configure then after running <verbatim|make> and
  <verbatim|sudo> <verbatim|make> <verbatim|install> the required elisp files
  should already be installed in the Emacs site-lisp directory (unless you
  specifically disabled this with the <verbatim|--without-elisp> configure
  option).

  Note: make tries to guess the Emacs installation prefix. If it gets this
  wrong, you can also set the make variable <verbatim|elispdir> to point to
  your site-lisp directory. (In fact, you can specify any directory on Emacs'
  loadpath for <verbatim|elispdir>.)

  Before you can use Pure mode, you still have to add some stuff to your
  .emacs file to load the mode at startup. A minimal setup looks like this:

  <\verbatim>
    \;

    (require 'pure-mode)

    (setq auto-mode-alist

    \ \ \ \ \ \ (cons '("\\\\.pure\\\\(rc\\\\)?$" . pure-mode)
    auto-mode-alist))

    (add-hook 'pure-mode-hook 'turn-on-font-lock)

    (add-hook 'pure-eval-mode-hook 'turn-on-font-lock)

    \;
  </verbatim>

  This loads Pure mode, associates the .pure and .purerc filename extensions
  with it, and enables syntax highlighting.

  Other useful options are described at the beginning of the pure-mode.el
  file. In particular, we recommend installing emacs-w3m and enabling it as
  follows in your .emacs file, so that you can read the online documentation
  in Emacs:

  <\verbatim>
    \;

    (require 'w3m-load)

    \;
  </verbatim>

  Also, you can enable code folding by adding this to your .emacs:

  <\verbatim>
    \;

    (require 'hideshow)

    (add-hook 'pure-mode-hook 'hs-minor-mode)

    \;
  </verbatim>

  These lines should come before the loading of Pure mode in your .emacs, so
  that Pure mode can adjust accordingly.

  Once Emacs has been configured to load Pure mode, you can just run it with
  a Pure file to check that it works, e.g.:

  <\verbatim>
    \;

    $ emacs examples/hello.pure

    \;
  </verbatim>

  The online help about Pure mode can be read with <verbatim|C-h>
  <verbatim|m>. The Pure documentation can be accessed in Pure mode with
  <verbatim|C-c> <verbatim|h>.

  <subsection|TeXmacs Plugin><label|texmacs-plugin>

  Pure 0.56 has full support for running Pure as a session in <hlink|GNU
  TeXmacs|http://savannah.gnu.org/projects/texmacs/>. This is triggered by
  the <hlink|<em|\Utexmacs>|pure.tm#cmdoption-pure--texmacs> option of the
  interpreter. If TeXmacs was detected by configure then after running
  <verbatim|make> and <verbatim|sudo> <verbatim|make> <verbatim|install> the
  required plugin files should already be installed in the system-wide
  TeXmacs plugins directory and you should be able to find Pure in TeXmacs'
  Insert / Session and Document / Scripts menus. TeXmacs help is also
  included; after installation this should be available with the Help /
  Plug-ins / Pure menu option. Or you can just go and read the TeXmacs
  documents (.tm files) in texmacs/plugins/pure/doc included in the
  distribution.

  Note: make tries to guess the TeXmacs installation prefix. If it gets this
  wrong, you can also set the make variable <verbatim|tmdir> to point to your
  TeXmacs plugins directory. By default, the plugin files will be installed
  in the plugins/pure subdirectory of your system-wide TeXmacs directory,
  usually /usr/local/share/TeXmacs or similar. Removing the plugins/pure
  directory is sufficient to uninstall the plugin; you can also do this with
  <verbatim|sudo> <verbatim|make> <verbatim|uninstall-tm>.

  It's also possible to disable the automatic installation by invoking
  configure with the <verbatim|--without-texmacs> option. To do a manual
  installation, it should be sufficient to drop the texmacs/plugins/pure
  directory in the distribution into your personal TeXmacs plugins folder,
  usually <math|\<sim\>>/.TeXmacs/plugins. You can also do this with
  <verbatim|make> <verbatim|install-tm> <verbatim|tmdir=~/.TeXmacs> (in this
  case, uninstall with <verbatim|make> <verbatim|uninstall-tm>
  <verbatim|tmdir=~/.TeXmacs>). This has the advantage that it doesn't
  require root access and you can easily edit the plugin files under
  <math|\<sim\>>/.TeXmacs/plugins/pure/progs afterwards to tailor them to
  your needs.

  The distributed plugin has support for reading the Pure online help in
  TeXmacs format. See Step 6 under <hlink|Basic
  Installation|#basic-installation> above for instructions on how you can
  obtain the necessary TeXmacs files and install them in the Pure library
  directory along with the html documentation. (The TeXmacs-formatted
  documentation needs a little style file named puredoc.ts which is included
  in the distribution and will be installed when doing <verbatim|make>
  <verbatim|install> or <verbatim|make> <verbatim|install-tm>. You can also
  just drop the file into your <math|\<sim\>>/.TeXmacs/packages folder to
  make TeXmacs find it.)

  If the distributed plugin doesn't work for you, as a fallback option you
  can try the following minimal setup instead. This lacks all the bells and
  whistles of the distributed plugin, but should be sufficient to run a basic
  Pure session in TeXmacs, and should hopefully work with any TeXmacs version
  which has plugin support at all.

  <\verbatim>
    \;

    (plugin-configure pure

    \ \ (:require (url-exists-in-path? "pure"))

    \ \ (:launch "pure -i --texmacs")

    \ \ (:session "Pure"))

    \;
  </verbatim>

  This Scheme file should go into <math|\<sim\>>/.TeXmacs/plugins/pure/progs/init-pure.scm.
  Note that <em|both> the <verbatim|-i> and <verbatim|--texmacs> options are
  required in the launch command to make this work (you might also want to
  add the <verbatim|-q> option to suppress the signon message of the
  interpreter).

  <subsection|Installing an LLVM-capable C/C++
  Compiler><label|installing-an-llvm-capable-c-c-compiler>

  As already mentioned above, we suggest that you also install a C/C++
  compiler with an LLVM backend. clang, llvm-gcc as well as the dragonegg gcc
  plugin are all fully supported by Pure. (Nowadays, the LLVM project's main
  focus is on clang, however; llvm-gcc and dragonegg are not supported on
  recent systems any more.) Pure can be used without this, but then you'll
  miss out on the LLVM bitcode loader and C/C++ inlining facilities in Pure
  0.44 and later. (Note that you can always install clang, llvm-gcc and/or
  dragonegg at a later time to enable these features.)

  <subsubsection|clang><label|clang>

  With LLVM 2.8 and later, we recommend installing clang, the new LLVM-based
  C/C++ compiler (<hlink|http://clang.llvm.org/|http://clang.llvm.org/>).
  It's much easier to build, runs faster and has better diagnostics than gcc.
  Also, as of Pure 0.55 it is the default for compiling inline C/C++ code, so
  it's the easiest way to go if you want to use that feature.

  If you haven't built clang along with LLVM yet, you can now just drop the
  contents of the clang tarball into the <verbatim|llvm/tools> directory,
  renaming the resulting <verbatim|clang-x.y> directory to just
  <verbatim|clang>. Then build and install clang as follows:

  <\verbatim>
    \;

    $ cd llvm-3.4/tools/clang

    $ make

    $ sudo make install

    \;
  </verbatim>

  <subsubsection|llvm-gcc><label|llvm-gcc>

  <with|font-series|bold|Note:> LEGACY ALERT: This section applies to LLVM
  versions up to 2.9. With LLVM 3.0 or later, llvm-gcc is not supported any
  more and you should use <hlink|clang|#clang> instead.

  If available, llvm-gcc can be installed either as an alternative or in
  addition to clang. The main advantage of llvm-gcc over clang is that it has
  additional language frontends (Ada and Fortran).

  Installing llvm-gcc from source actually isn't all that difficult, if a bit
  time-consuming. Assuming that you have unpacked both the LLVM and the
  llvm-gcc sources in the same directory, you can build and install llvm-gcc
  as follows:

  <\verbatim>
    \;

    $ cd llvm-gcc-4.2-2.9.source

    $ mkdir obj

    $ cd obj

    $ ../configure --program-prefix=llvm- --enable-llvm=$PWD/../../llvm-2.9
    --enable-languages=c,c++

    $ make

    $ sudo make install

    \;
  </verbatim>

  (You might wish to add <verbatim|fortran> to <verbatim|--enable-languages>
  if you also want to build the Fortran compiler, and, likewise,
  <verbatim|ada> for the Ada compiler.)

  Be patient, this takes a while.

  Having installed llvm-gcc, you can add something like the following lines
  to your shell startup files, so that Pure uses it for inlined C/C++/Fortran
  code:

  <\verbatim>
    \;

    export PURE_CC=llvm-gcc

    export PURE_CXX=llvm-g++

    export PURE_FC=llvm-gfortran

    \;
  </verbatim>

  <subsubsection|dragonegg><label|dragonegg>

  <with|font-series|bold|Note:> LEGACY ALERT: This section applies to LLVM
  versions up to 3.3 and gcc 4.5 or 4.6. If you're running a newer LLVM
  and/or gcc version, you should use <hlink|clang|#clang> instead.

  Instead of llvm-gcc it's also possible to use \PDragonEgg\Q
  (<hlink|http://dragonegg.llvm.org/|http://dragonegg.llvm.org/>). This is
  provided in the form of a gcc plugin which, if you have one of the
  supported gcc versions, readily plugs into your existing system compiler.

  To install DragonEgg, make sure that you have the mpc and gcc plugin
  development files installed (packages <verbatim|mpc-dev> and
  <verbatim|gcc-plugin-dev> on Ubuntu). Then, after unpacking the dragonegg
  source tarball or downloading the svn sources, install dragonegg as
  follows:

  <\verbatim>
    \;

    $ make

    $ sudo cp dragonegg.so `gcc -print-file-name=plugin`

    \;
  </verbatim>

  Finally, add something like the following lines to your shell startup
  files, so that Pure uses gcc+dragonegg for all inlined C/C++/Fortran code:

  <\verbatim>
    \;

    export PURE_CC="gcc -fplugin=dragonegg"

    export PURE_CXX="g++ -fplugin=dragonegg"

    export PURE_FC="gfortran -fplugin=dragonegg"

    \;
  </verbatim>

  (Please also check the README file included in the dragonegg package for
  further installation and usage instructions. Also,
  examples/bitcode/Makefile in the Pure distribution demonstrates how to use
  gcc+dragonegg as an external compiler to generate LLVM bitcode from the
  command line.)

  <subsection|Installing From Development
  Sources><label|installing-from-development-sources>

  The latest development version of Pure is available in its Git source code
  repository. You can browse the repository at:

  <hlink|https://bitbucket.org/purelang/pure-lang|https://bitbucket.org/purelang/pure-lang>

  (You'll notice that the repository also contains various addon modules. See
  the pure subdirectory for the latest sources of the Pure interpreter
  itself.)

  Note that if you're going with the development sources, you'll also need
  fairly recent versions of autoconf, flex and bison (autoconf 2.63, flex
  2.5.31 and bison 2.3 or later should be ok).

  To compile from the development sources, replace steps 4 and 5 above with:

  <with|font-series|bold|Step 4'.> Fetch the latest sources from the
  repository:

  <\verbatim>
    \;

    $ git clone https://bitbucket.org/purelang/pure-lang

    \;
  </verbatim>

  This clones the repository and puts it into the pure-lang subdirectory in
  the current directory. This step needs to be done only once; once you've
  cloned the repository, you can update it to the latest revision at any time
  by running <verbatim|git> <verbatim|pull>.

  <with|font-series|bold|Step 5'.> Configure, build and install Pure.

  This is pretty much the same as with the distribution tarball, except that
  you need to run <verbatim|autoreconf> once to generate the configure script
  which isn't included in the source repository.

  <\verbatim>
    \;

    $ cd pure-lang/pure

    $ autoreconf

    $ ./configure --enable-release

    $ make

    $ sudo make install

    \;
  </verbatim>

  (Don't forget to also run <verbatim|make> <verbatim|check> to make sure
  that the interpreter is in good working condition.)

  <with|font-series|bold|Step 6'.> In addition, you can also build and
  install a recent snapshot of the documentation from the repository.

  This can be a bit tricky to set up, please check the FAQ wiki page on the
  Pure website for details.

  Alternatively, a ready-made recent snapshot of the documentation in html
  and pdf formats is also available in its own repository, which can be
  cloned as follows:

  <\verbatim>
    \;

    $ git clone https://bitbucket.org/puredocs/puredocs.bitbucket.org.git

    \;
  </verbatim>

  <subsection|Other Build and Installation
  Options><label|other-build-and-installation-options>

  The Pure configure script takes a few options which enable you to change
  the installation path and control a number of other build options.
  Moreover, there are some environment variables which also affect
  compilation and installation.

  Use <verbatim|./configure> <verbatim|--help> to print a summary of the
  provided options.

  <subsubsection|Installation Path><label|installation-path>

  By default, the pure program, the runtime.h header file, the runtime
  library, the pure.pc file and the library scripts are installed in
  /usr/local/bin, /usr/local/include/pure, /usr/local/lib,
  /usr/local/lib/pkg-config and /usr/local/lib/pure, respectively. This can
  be changed by specifying the desired installation prefix with the
  <verbatim|--prefix> option, e.g.:

  <\verbatim>
    \;

    $ ./configure --enable-release --prefix=/usr

    \;
  </verbatim>

  In addition, the <verbatim|DESTDIR> variable enables package maintainers to
  install Pure into a special \Pstaging\Q directory, so that installed files
  can be packaged more easily. If set at installation time,
  <verbatim|DESTDIR> will be used as an additional prefix to all installation
  paths. For instance, the following command will put all installed files
  into the tmp-root subdirectory of the current directory:

  <\verbatim>
    \;

    $ make install DESTDIR=tmp-root

    \;
  </verbatim>

  Note that if you install Pure into a non-standard location, you may have to
  set <verbatim|LD_LIBRARY_PATH> or a similar variable so that the dynamic
  linker finds the Pure runtime library, libpure.so. Also, when compiling and
  linking addon modules you might have to set <verbatim|C_INCLUDE_PATH> and
  <verbatim|LIBRARY_PATH> (or similar) so that the header and library of the
  runtime library is found. (This will become unnecessary once all addon
  modules have been converted to use pkg-config, see below, but this isn't
  the case right now.) On some systems this is even necessary with the
  default prefix, because /usr/local is not always in the default search
  paths.

  As of Pure 0.47, Pure also installs a pkg-config file which may be queried
  by module Makefiles to determine how to build a module and link it against
  the Pure runtime library; see <hlink|Pkg-config
  Support|#pkg-config-support> below. This file will usually be installed
  into <verbatim|$(prefix)/lib/pkg-config>. Again, if you use a non-standard
  installation prefix, you will have to tell pkg-config about the location of
  the file by adjusting the <verbatim|PKG_CONFIG_PATH> environment variable
  accordingly, see pkg-config(1) for details.

  <subsubsection|Tool Prefix and LLVM Version><label|tool-prefix-and-llvm-version>

  On some systems the LLVM toolchain may be located in special directories
  not on the <verbatim|PATH>, so that different LLVM installations can
  coexist on the same system. This is often the case, e.g., if LLVM was
  installed from a binary package.

  To deal with this situation, the configure script distributed with Pure
  0.55 and later allows you to specify the directory with the LLVM toolchain
  using the <verbatim|--with-tool-prefix> configure option. E.g.:

  <\verbatim>
    \;

    $ ./configure --with-tool-prefix=/usr/lib/llvm-3.4/bin

    \;
  </verbatim>

  This is also the directory where configure will first look for the
  <verbatim|llvm-config> script, so that the proper LLVM version is selected
  for compilation.

  You can also specify the desired LLVM version with the
  <verbatim|--with-llvm-version> option. This causes configure to look for
  the <verbatim|llvm-config-x.y> script on the <verbatim|PATH>, where
  <verbatim|x.y> is the specified version number. If this option isn't
  specified, the default is to look for the <verbatim|llvm-config> script on
  the <verbatim|PATH> (this should always work if you installed LLVM from
  source).

  If none of these yield a usable <verbatim|llvm-config> script, configure
  will try to locate an <verbatim|llvm-config-x.y> script by iterating
  through some recent LLVM releases, preferring the latest version if found.
  If this fails, too, configure gives up and prints an error message
  indicating that it couldn't locate a suitable LLVM installation. This is a
  fatal error, so if you see this then you'll either have to install LLVM
  yourself, or try to locate a suitable LLVM installation and tell configure
  about it, using the options explained above.

  <subsubsection|Versioned Installations><label|versioned-installations>

  Pure fully supports parallel installations of different versions of the
  interpreter. To enable this you have to specify
  <verbatim|--enable-versioned> when running configure:

  <\verbatim>
    \;

    $ ./configure --enable-release --enable-versioned

    \;
  </verbatim>

  When this option is enabled, bin/pure, include/pure, lib/pure,
  lib/pkg-config/pure.pc and man/man1/pure.1 are actually symbolic links to
  the current version (bin/pure-x.y, include/pure-x.y etc., where x.y is the
  version number). If you install a new version of the interpreter, the old
  version remains available as pure-x.y.

  Note that versioned and unversioned installations don't mix very well, it's
  either one or the other. If you already have an unversioned install of
  Pure, you must first remove it before switching to the versioned scheme.

  It <em|is> possible, however, to have versioned and unversioned
  installations under different installation prefixes. For instance, having
  an unversioned install under /usr and several versioned installations under
  /usr/local is ok.

  <subsubsection|Separate Build Directory><label|separate-build-directory>

  It is possible to build Pure in a separate directory, in order to keep your
  source tree tidy and clean, or to build multiple versions of the
  interpreter with different compilation flags from the same source tree.

  To these ends, just cd to the build directory and run configure and make
  there, e.g. (this assumes that you start from the source directory):

  <\verbatim>
    \;

    $ mkdir BUILD

    $ cd BUILD

    $ ../configure --enable-release

    $ make

    \;
  </verbatim>

  <subsubsection|Compiler and Linker Options><label|compiler-and-linker-options>

  There are a number of environment variables you can set on the configure
  command line if you need special compiler or linker options:

  <\itemize>
    <item><verbatim|CPPFLAGS>: preprocessor options (<verbatim|-I>,
    <verbatim|-D>, etc.)

    <item><verbatim|CXXFLAGS>: C++ compilation options (<verbatim|-g>,
    <verbatim|-O>, etc.)

    <item><verbatim|CFLAGS>: C compilation options (<verbatim|-g>,
    <verbatim|-O>, etc.)

    <item><verbatim|LDFLAGS>: linker flags (<verbatim|-s>, <verbatim|-L>,
    etc.)

    <item><verbatim|LIBS>: additional objects and libraries
    (<verbatim|-lfoo>, <verbatim|bar.o>, etc.)
  </itemize>

  (The <verbatim|CFLAGS> variable is only used to build the pure_main.o
  module which is linked into batch-compiled executables, see \PBatch
  Compilation\Q in the manual for details.)

  For instance, the following configure command changes the default
  compilation options to <verbatim|-g> and adds /opt/include and /opt/lib to
  the include and library search paths, respectively:

  <\verbatim>
    \;

    $ ./configure CPPFLAGS=-I/opt/include CXXFLAGS=-g LDFLAGS=-L/opt/lib

    \;
  </verbatim>

  More details on the build and installation process and other available
  targets and options can be found in the Makefile.

  <subsubsection|Predefined Build Types><label|predefined-build-types>

  For convenience, configure provides some options to set up
  <verbatim|CPPFLAGS> and <verbatim|CXXFLAGS> for various build types. Please
  note that most of these options assume gcc right now, so if you use another
  compiler you'll probably have to set up compilation flags manually by using
  the variables described in the previous section instead.

  The default build includes debugging information and additional runtime
  checks which provide diagnostics useful for maintainers if anything is
  wrong with the interpreter. It is also noticeably slower than the
  \Prelease\Q build. If you want to enjoy maximum performance, you should
  configure Pure for a release build as follows:

  <\verbatim>
    \;

    $ ./configure --enable-release

    \;
  </verbatim>

  This disables all runtime checks and debugging information in the
  interpreter, and uses a higher optimization level (<verbatim|-O3>), making
  the interpreter go substantially faster on most systems.

  To get smaller executables with either the default or the release build,
  add <verbatim|LDFLAGS=-s> to the configure command (gcc only, other
  compilers may provide a similar flag or a separate command to strip
  compiled executables and libraries).

  You can also do a \Pdebug\Q build as follows:

  <\verbatim>
    \;

    $ ./configure --enable-debug

    \;
  </verbatim>

  This is like the default build, but disables all optimizations, so
  compilation is faster but the compiled interpreter is <em|much> slower than
  even the default build. Hence this build is only recommended for debugging
  purposes.

  You can combine all build types with the <verbatim|--enable-warnings>
  option to enable compiler warnings (<verbatim|-Wall>):

  <\verbatim>
    \;

    $ ./configure --enable-release --enable-warnings

    \;
  </verbatim>

  This option is useful to check the interpreter sources for questionable
  constructs which might actually be bugs. However, for some older gcc
  versions it spits out lots of bogus warnings, so it is not enabled by
  default.

  In addition, there is an option to build a \Pmonolithic\Q interpreter which
  is linked statically instead of producing a separate runtime library:

  <\verbatim>
    \;

    $ ./configure --enable-release --disable-shared

    \;
  </verbatim>

  We strongly discourage from using this option, since it drastically
  increases the size of the executable and thereby the memory footprint of
  the interpreter if several interpreter processes are running
  simultaneously. It also makes it impossible to use batch compilation and
  addon modules which require the runtime library. We only provide this as a
  workaround for older LLVM versions which cannot be linked into shared
  libraries on some systems.

  In general, the build options can be combined freely with the variables
  described in the previous section, except that <verbatim|--enable-release>
  and <verbatim|--enable-debug> will always override the debugging
  (<verbatim|-g>) and optimization (<verbatim|-O>) options in
  <verbatim|CFLAGS> and <verbatim|CXXFLAGS>. Other options will be preserved.
  For instance, the following configures for a release build, but sets the
  warning flags manually and enables C++0x support in gcc:

  <\verbatim>
    \;

    $ ./configure --enable-release CFLAGS="-Wall" CXXFLAGS="-std=c++0x -Wall"

    \;
  </verbatim>

  If you mix build types and manual compilation flags in this way then it's
  always a good idea to check the resulting compilation options printed out
  at the end of the <verbatim|configure> run. If <verbatim|configure> seems
  to get things wrong then you'll have to set up all required flags manually
  instead.

  <subsubsection|Running Pure From The Source
  Directory><label|running-pure-from-the-source-directory>

  After your build is done, you should also run <verbatim|make>
  <verbatim|check> to verify that your Pure interpreter works correctly. This
  can be done without installing the software. In fact, there's no need to
  install the interpreter at all if you just want to take it for a test
  drive, you can simply run it from the source directory, if you set up the
  following environment variables (this assumes that you built Pure in the
  source directory; when using a separate build directory, you'll have to
  change the paths accordingly):

  <\description>
    <item*|<with|font-family|tt|LD_LIBRARY_PATH=.>>This is required on Linux
    systems so that libpure.so is found. Other systems may require an
    analogous setting, or none at all.

    <item*|<with|font-family|tt|PURELIB=./lib>>This is required on all
    systems so that the interpreter finds the prelude and other library
    scripts.
  </description>

  After that you should be able to run the Pure interpreter from the source
  directory, by typing <verbatim|./pure>.

  <subsubsection|Other Targets><label|other-targets>

  The Makefile supports the usual <verbatim|clean> and <verbatim|distclean>
  targets, and <verbatim|realclean> will remove all files created by the
  maintainer, including test logs and C++ source files generated from Flex
  and Bison grammars. (Only use the latter if you know what you are doing,
  since it will remove files which require special tools to be regenerated.)

  Maintainers can roll distribution tarballs with <verbatim|make>
  <verbatim|dist> and <verbatim|make> <verbatim|distcheck> (the latter is
  like <verbatim|make> <verbatim|dist>, but also does a test build and
  installation to verify that your tarball contains all needed bits and
  pieces).

  Last but not least, if you modify configure.ac for some reason then you can
  regenerate the configure script and config.h.in with <verbatim|make>
  <verbatim|config>. This needs autoconf, of course. (The distribution was
  prepared using autoconf 2.69.)

  <subsubsection|Pkg-config Support><label|pkg-config-support>

  Pure 0.47 and later install a pkg-config file (pure.pc) which lets addon
  modules query the installed Pure for the information needed to build and
  install a module. Besides the usual information provided by pkg-config,
  such as <verbatim|--cflags> and <verbatim|--libs> (which are set up so that
  the Pure runtime header and library will be found), pure.pc also defines a
  few additional variables which can be queried with pkg-config's
  <verbatim|--variable> option:

  <\itemize>
    <item><verbatim|DLL>: shared library extension for the host platform

    <item><verbatim|PIC>: position-independent code flag if required on the
    host platform

    <item><verbatim|shared>: flag used to create shared libraries on the host
    platform

    <item><verbatim|extraflags>: same as <verbatim|$shared> <verbatim|$PIC>
  </itemize>

  Together with the <verbatim|libdir> variable, this provides you with the
  information needed to build and install most Pure modules without much ado.
  As of Pure 0.55, pure.pc also defines the <verbatim|tool_prefix> variable
  which gives the LLVM toolchain prefix specified at configure time, cf.
  <hlink|Tool Prefix and LLVM Version|#tool-prefix-and-llvm-version>.

  If you want to use this information, you need to have pkg-config installed,
  see <hlink|http://pkg-config.freedesktop.org|http://pkg-config.freedesktop.org>.
  This program should be readily available on most Unix-like platforms, and a
  Windows version is available as well. An example illustrating the use of
  pkg-config can be found in the examples/hellomod directory in the sources.

  <subsection|System Notes><label|system-notes>

  Pure is known to work on recent Linux, Mac OS X and BSD versions under x86,
  x86-64 (AMD/Intel x86, 32 and 64 bit) and ppc (PowerPC), as well as on MS
  Windows (AMD/Intel x86, 32 bit). There are a few known quirks for specific
  platforms and/or LLVM versions which are discussed below, along with
  corresponding workarounds. As a fairly demanding LLVM application, Pure is
  also known to shake the bugs out of LLVM, so if you run into any
  LLVM-related issues, Pure isn't necessarily the culprit! However, most of
  the bugs have been ironed out over the years, so Pure should work fine with
  any recent LLVM version (3.4 or later).

  <subsubsection|All Platforms><label|all-platforms>

  Compiling the default and release versions using gcc with all warnings
  turned on (<verbatim|-Wall>) might give you the warning \Pdereferencing
  type-punned pointer will break strict-aliasing rules\Q at some point in
  util.cc with some older gcc versions. This is harmless and can be ignored.

  If your Pure program runs out of stack space, the interpreter may segfault.
  While the Pure interpreter does advisory stack checks to avoid that kind of
  mishap and generate an orderly exception instead, it has no way of knowing
  the actual stack size available to programs on your system. So if you're
  getting segfaults due to stack overflows then you'll have to set an
  appropriate stack size limit manually with
  the<label|index-0><hlink|<with|font-family|tt|PURE_STACK>|pure.tm#envvar-PURE-STACK>
  environment variable; see the Pure manual for details.

  <subsubsection|LLVM 2.5><label|llvm-2-5>

  The LLVM 2.5 JIT is broken on x86-32 if it is built with
  <verbatim|--enable-pic>, so make sure you do <em|not> use this option when
  compiling LLVM \<less\>=2.5 on 32 bit systems. On the other hand, building
  the Pure runtime library (libpure) on x86-64 systems <em|requires> that you
  configure LLVM 2.5 with <verbatim|--enable-pic> so that the static LLVM
  libraries can be linked into the runtime library. With LLVM 2.6 and later,
  this option isn't needed anymore.

  This LLVM version also has issues on PowerPC. Use LLVM 2.6 or later instead
  and check the notes on <hlink|PowerPC|#powerpc> below.

  Please also note that LLVM 2.5 is the oldest LLVM version that we still
  support right now. If you're still running this version (or any of the 2.x
  versions) then you should really upgrade. Newer LLVM versions offer
  substantial improvements in both compilation time and code quality. Support
  for LLVM versions older than 3.0 is likely to be dropped in future Pure
  releases.

  <subsubsection|LLVM 3.3><label|llvm-3-3>

  Reportedly the Pure batch compiler is broken when using LLVM 3.3 on Mac OS
  X. If you need the batch compiler then use either LLVM 3.2 or 3.4+ on OS X
  instead, these are known to work on that platform.

  <subsubsection|LLVM 3.4+><label|llvm-3-4>

  On Linux, the <verbatim|llc> program from LLVM 3.4 and 3.5 is known to
  create native assembler (.s) code which doesn't mangle assembler symbols as
  it used to be in earlier releases. When compiling Pure modules with the
  batch compiler, this results in native assembler code which can't be
  compiled using the system assemblers. As a remedy, the batch compiler in
  Pure 0.61 and later now creates native object (.o) files directly using
  llc, without going through the native assembler stage.

  <subsubsection|LLVM 3.6+><label|llvm-3-6>

  Pure doesn't work with LLVM versions 3.6 and beyond yet because these don't
  include the \Pold\Q LLVM JIT any more. So until Pure gets ported to the new
  MCJIT, you will have to stick with LLVM 3.5. Fortunately, this version is
  still readily available on most platforms.

  <subsubsection|PowerPC><label|powerpc>

  (This hasn't been checked in a <em|long> time, so this information may well
  be outdated.) You'll need Pure \<gtr\>= 0.35 and LLVM \<gtr\>= 2.6. Also
  make sure that you always configure LLVM with
  <verbatim|--disable-expensive-checks> and Pure with
  <verbatim|--disable-fastcc>. With these settings Pure should work fine on
  ppc (tested on ppc32 running Fedora Core 11 and 12), but note that tail
  call optimization doesn't work on this platform because of LLVM
  limitations.

  <subsubsection|Linux><label|linux>

  Linux is the primary development platform for this software, and the
  sources should build out of the box on all recent Linux distributions.
  Packages for various Linux distributions are also available, please check
  the Pure website for details.

  <subsubsection|Mac OS X><label|mac-os-x>

  Pure should build fine on recent OS X versions, and a port by Ryan Schmidt
  exists in the MacPorts collection, see <hlink|http://www.macports.org/|http://www.macports.org/>.
  If you install straight from the source, make sure that you use a recent
  LLVM version (LLVM 2.7 or later should work fine on all flavors of Intel
  Macs).

  Even if you compile Pure from source, we recommend installing LLVM and the
  other dependencies from MacPorts. In that case you'll have to add a few
  options to the configure command so that the required header files,
  libraries and LLVM tools are found:

  <\verbatim>
    \;

    ./configure --enable-release --prefix=/opt/local \\

    CPPFLAGS=-I/opt/local/include LDFLAGS=-L/opt/local/lib \\

    --with-tool-prefix=/opt/local/libexec/llvm-3.4/bin

    \;
  </verbatim>

  This assumes that your MacPorts installation lives under /opt/local and
  that you're using LLVM 3.4; otherwise you'll have to adjust the configure
  options accordingly.

  On really old Macs from the bygone PPC era you'll have to be prepared to
  deal with all kinds of issues with compilers, LLVM toolchain etc. If you're
  still using one of these, your best bet is to find an older port on
  MacPorts which works for your OS X version.

  <subsubsection|BSD><label|bsd>

  FreeBSD now offers a fairly extensive selection of Pure packages in their
  distribution.

  Compilation from source should also work fine on recent NetBSD and FreeBSD
  versions if you use Pure 0.33 or later. Also make sure that you install a
  recent port of LLVM which has the <verbatim|--enable-optimized> flag
  enabled.

  Building Pure requires GNU make, thus you will have to use gmake instead of
  make. In addition to gmake, you'll need recent versions of the following
  packages: perl5, flex, bison, gmp, mpfr and readline (or editline).
  Depending on your system, you might also have to set up some compiler and
  linker paths. E.g., the following reportedly does the trick on NetBSD:

  <\verbatim>
    \;

    export C_INCLUDE_PATH=/usr/local/include:/usr/pkg/include

    export LIBRARY_PATH=/usr/local/lib:/usr/pkg/lib

    export LD_LIBRARY_PATH=/usr/pkg/lib:/usr/local/lib

    \;
  </verbatim>

  <subsubsection|MS Windows><label|ms-windows>

  Thanks to Jiri Spitz' perseverance, tireless testing and bug reports, the
  sources compile and run fine on Windows, using the Mingw port of the GNU
  C++ compiler and the MSYS environment from
  <hlink|http://www.mingw.org/|http://www.mingw.org/>. Just do the usual
  <verbatim|./configure> <verbatim|&&> <verbatim|make> <verbatim|&&>
  <verbatim|make> <verbatim|install>. You'll need LLVM, of course (which
  builds with Mingw just fine), and a few additional libraries for which
  headers and precompiled binaries are available from the Pure website
  (<hlink|http://purelang.bitbucket.org|http://purelang.bitbucket.org>).

  However, the easiest way is to just go with the Pure MSI package available
  on the Pure website. This includes all required libraries and some
  shortcuts to run the Pure interpreter and read online documentation in html
  help format, as well as \PPurePad\Q, an alternative GUI frontend for
  editing and running Pure scripts on Windows. The only limitation is that
  the binaries in this package still are for x86 (32 bit) only right now, but
  these do work fine on all recent 64 bit flavors of Windows (tested on
  Windows 7, 8 and 10).

  <subsubsection*|<hlink|Table Of Contents|index.tm>><label|install-toc>

  <\itemize>
    <item><hlink|Installing Pure (and LLVM)|#>

    <\itemize>
      <item><hlink|Quick Summary|#quick-summary>

      <item><hlink|Basic Installation|#basic-installation>

      <item><hlink|Emacs Pure Mode|#emacs-pure-mode>

      <item><hlink|TeXmacs Plugin|#texmacs-plugin>

      <item><hlink|Installing an LLVM-capable C/C++
      Compiler|#installing-an-llvm-capable-c-c-compiler>

      <\itemize>
        <item><hlink|clang|#clang>

        <item><hlink|llvm-gcc|#llvm-gcc>

        <item><hlink|dragonegg|#dragonegg>
      </itemize>

      <item><hlink|Installing From Development
      Sources|#installing-from-development-sources>

      <item><hlink|Other Build and Installation
      Options|#other-build-and-installation-options>

      <\itemize>
        <item><hlink|Installation Path|#installation-path>

        <item><hlink|Tool Prefix and LLVM
        Version|#tool-prefix-and-llvm-version>

        <item><hlink|Versioned Installations|#versioned-installations>

        <item><hlink|Separate Build Directory|#separate-build-directory>

        <item><hlink|Compiler and Linker Options|#compiler-and-linker-options>

        <item><hlink|Predefined Build Types|#predefined-build-types>

        <item><hlink|Running Pure From The Source
        Directory|#running-pure-from-the-source-directory>

        <item><hlink|Other Targets|#other-targets>

        <item><hlink|Pkg-config Support|#pkg-config-support>
      </itemize>

      <item><hlink|System Notes|#system-notes>

      <\itemize>
        <item><hlink|All Platforms|#all-platforms>

        <item><hlink|LLVM 2.5|#llvm-2-5>

        <item><hlink|LLVM 3.3|#llvm-3-3>

        <item><hlink|LLVM 3.4+|#llvm-3-4>

        <item><hlink|LLVM 3.6+|#llvm-3-6>

        <item><hlink|PowerPC|#powerpc>

        <item><hlink|Linux|#linux>

        <item><hlink|Mac OS X|#mac-os-x>

        <item><hlink|BSD|#bsd>

        <item><hlink|MS Windows|#ms-windows>
      </itemize>
    </itemize>
  </itemize>

  Previous topic

  <hlink|pure-midi|pure-midi.tm>

  Next topic

  <hlink|Running Pure on Windows|windows.tm>

  <hlink|toc|#install-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|windows.tm> \|
  <hlink|previous|pure-midi.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2017, Albert Gräf et al. Last updated on Mar
  04, 2017. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
