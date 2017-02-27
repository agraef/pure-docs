<TeXmacs|1.99.5>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#index-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure.tm> \| <hlink|Pure
  Language and Library Documentation|#>

  <section*|Pure Language and Library Documentation><label|pure-language-and-library-documentation>

  Last updated: February 24, 2017 (v0.65)

  This manual collects all of Pure's online documentation: <hlink|<em|The
  Pure Manual>|pure.tm> which covers the Pure language and the operation of
  the Pure interpreter; the <hlink|<em|Pure Library Manual>|purelib.tm> which
  describes the standard library modules included in the distribution of the
  Pure interpreter; all available documentation for the various <hlink|addon
  modules|#addon-modules> which can be downloaded as separate packages from
  the Pure website; and an appendix with <hlink|<em|installation
  instructions>|install.tm> and additional information for <hlink|<em|Windows
  users>|windows.tm>.

  Most of the Pure documentation is distributed under the <hlink|GNU Free
  Documentation License|http://www.gnu.org/copyleft/fdl.html>. The authors of
  the current edition are listed below. (This just lists the primary section
  authors in alphabetical order; please check the different parts of this
  manual for additional authorship and licensing information.)

  <\itemize>
    <item>Albert Gräf (<hlink|<em|The Pure Manual>|pure.tm>; <hlink|<em|Pure
    Library Manual>|purelib.tm>; various addon manuals)

    <item>Rob Hubbard (<hlink|<em|Pure-Rational - Rational number library for
    the Pure programming language>|pure-rational.tm>)

    <item>Kay-Uwe Kirstein (<hlink|<em|Gnuplot bindings>|pure-gplot.tm>)

    <item>Eddie Rucker (<hlink|<em|Pure-CSV - Comma Separated Value Interface
    for the Pure Programming Language>|pure-csv.tm>; <hlink|<em|pure-gsl -
    GNU Scientific Library Interface for Pure>|pure-gsl.tm>)

    <item>Jiri Spitz (<hlink|<em|Pure-GLPK - GLPK interface for the Pure
    programming language>|pure-glpk.tm>)

    <item>Peter Summerland (<hlink|<em|Pure-Sql3>|pure-sql3.tm>,
    <hlink|<em|pure-stlmap>|pure-stlmap.tm>,
    <hlink|<em|pure-stlvec>|pure-stlvec.tm>)
  </itemize>

  The Pure programming system is free and open source software. The
  interpreter runtime, the standard library and most of the addon modules are
  distributed under the <hlink|GNU Lesser General Public
  License|http://www.gnu.org/copyleft/lgpl.html> or the 3-clause <hlink|BSD
  License|http://www.opensource.org/licenses/bsd-license.php> which allow for
  commercial applications. Some parts of the system also use the <hlink|GNU
  General Public License|http://www.gnu.org/copyleft/gpl.html> (typically
  because they interface to other GPL'ed software such as Gnumeric, GSL and
  Octave). Details about authorship and license conditions can be found in
  the sources or in the various manual sections.

  For more information, discussions, feedback, questions, suggestions etc.
  please see:

  <\itemize>
    <item>Pure website: <hlink|http://purelang.bitbucket.org|http://purelang.bitbucket.org>

    <item>Pure mailing list: <hlink|http://groups.google.com/group/pure-lang|http://groups.google.com/group/pure-lang>
  </itemize>

  From the Pure website you can also download a recent version of this manual
  in <hlink|pdf format|http://puredocs.bitbucket.org/puredoc.pdf>.

  <subsection|Language and Standard Library><label|language-and-standard-library>

  This part of the manual documents the Pure language and interpreter, as
  well as the standard library distributed with the interpreter.

  <\itemize>
    <item><hlink|The Pure Manual|pure.tm>

    <item><hlink|Pure Library Manual|purelib.tm>
  </itemize>

  <subsection|Basic Support Utilities and
  Libraries><label|basic-support-utilities-and-libraries>

  This part covers general programming tools and libraries which are useful
  in many Pure programs but don't come bundled with the interpreter.

  <\itemize>
    <item><hlink|pure-avahi: Pure Avahi Interface|pure-avahi.tm>

    <item><hlink|pure-bonjour: Pure Bonjour Interface|pure-bonjour.tm>

    <item><hlink|pure-doc|pure-doc.tm>

    <item><hlink|pure-ffi|pure-ffi.tm>

    <item><hlink|pure-gen: Pure interface generator|pure-gen.tm>

    <item><hlink|pure-readline|pure-readline.tm>

    <item><hlink|pure-sockets: Pure Sockets Interface|pure-sockets.tm>

    <item><hlink|pure-stldict|pure-stldict.tm>

    <item><hlink|pure-stllib|pure-stllib.tm>

    <item><hlink|pure-stlmap|pure-stlmap.tm>

    <item><hlink|pure-stlvec|pure-stlvec.tm>
  </itemize>

  <subsection|Scientific Computing><label|scientific-computing>

  Interfaces to various 3rd party mathematical software.

  <\itemize>
    <item><hlink|Gnumeric/Pure: A Pure Plugin for Gnumeric|gnumeric-pure.tm>

    <item><hlink|Pure-GLPK - GLPK interface for the Pure programming
    language|pure-glpk.tm>

    <item><hlink|Gnuplot bindings|pure-gplot.tm>

    <item><hlink|pure-gsl - GNU Scientific Library Interface for
    Pure|pure-gsl.tm>

    <item><hlink|pure-mpfr|pure-mpfr.tm>

    <item><hlink|pure-octave|pure-octave.tm>

    <item><hlink|Pure-Rational - Rational number library for the Pure
    programming language|pure-rational.tm>

    <item><hlink|Computer Algebra with Pure: A Reduce
    Interface|pure-reduce.tm>
  </itemize>

  <subsection|Database and Web Programming><label|database-and-web-programming>

  Modules for dealing with data in CSV and XML format, interfacing to SQL
  databases, and running Pure scripts in a web server using the FastCGI
  protocol.

  <\itemize>
    <item><hlink|Pure-CSV - Comma Separated Value Interface for the Pure
    Programming Language|pure-csv.tm>

    <item><hlink|pure-fastcgi: FastCGI module for Pure|pure-fastcgi.tm>

    <item><hlink|Pure-ODBC - ODBC interface for the Pure programming
    language|pure-odbc.tm>

    <item><hlink|Pure-Sql3|pure-sql3.tm>

    <item><hlink|Pure-XML - XML/XSLT interface|pure-xml.tm>
  </itemize>

  <subsection|GUI and Graphics><label|gui-and-graphics>

  Various interfaces to 3rd party GUI and graphics libraries.

  <\itemize>
    <item><hlink|pure-g2|pure-g2.tm>

    <item><hlink|Pure OpenGL Bindings|pure-gl.tm>

    <item><hlink|Pure GTK+ Bindings|pure-gtk.tm>

    <item><hlink|pure-tk|pure-tk.tm>
  </itemize>

  <subsection|Multimedia><label|multimedia>

  A collection of scripts and modules useful for programming media
  applications. Currently, this covers digital audio, MIDI and OSC.
  Interfaces to Yann Orlarey's functional DSP programming language Faust and
  Miller Puckette's graphical computer music software PureData are also
  available.

  <\itemize>
    <item><hlink|faust2pd: Pd Patch Generator for Faust|faust2pd.tm>

    <item><hlink|pd-faust|pd-faust.tm>

    <item><hlink|pd-pure: Pd loader for Pure scripts|pd-pure.tm>

    <item><hlink|pure-audio|pure-audio.tm>

    <item><hlink|pure-faust|pure-faust.tm>

    <item><hlink|pure-liblo|pure-liblo.tm>

    <item><hlink|pure-lilv: Pure Lilv Interface|pure-lilv.tm>

    <item><hlink|pure-lv2|pure-lv2.tm>

    <item><hlink|pure-midi|pure-midi.tm>
  </itemize>

  <subsection|Appendix: Installation and Usage><label|appendix-installation-and-usage>

  General information about installing and using Pure.

  <\itemize>
    <item><hlink|Installing Pure (and LLVM)|install.tm>

    <item><hlink|Running Pure on Windows|windows.tm>

    <item><hlink|Using PurePad|purepad.tm>

    <item><hlink|Reporting Bugs|bugs.tm>
  </itemize>

  <subsection|Index><label|index>

  <\itemize>
    <item><hlink|<em|Module Index>|pure-modindex.tm>

    <item><hlink|<em|Index>|genindex.tm>
  </itemize>

  <subsubsection*|<hlink|Table Of Contents|#>><label|index-toc>

  <\itemize>
    <item><hlink|Pure Language and Library Documentation|#>

    <\itemize>
      <item><hlink|Language and Standard Library|#language-and-standard-library>

      <item><hlink|Basic Support Utilities and
      Libraries|#basic-support-utilities-and-libraries>

      <item><hlink|Scientific Computing|#scientific-computing>

      <item><hlink|Database and Web Programming|#database-and-web-programming>

      <item><hlink|GUI and Graphics|#gui-and-graphics>

      <item><hlink|Multimedia|#multimedia>

      <item><hlink|Appendix: Installation and
      Usage|#appendix-installation-and-usage>

      <item><hlink|Index|#index>
    </itemize>
  </itemize>

  Next topic

  <hlink|The Pure Manual|pure.tm>

  <hlink|toc|#index-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure.tm> \| <hlink|Pure
  Language and Library Documentation|#>

  <copyright> Copyright 2009-2017, Albert Gräf et al. Last updated on Feb
  27, 2017. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
