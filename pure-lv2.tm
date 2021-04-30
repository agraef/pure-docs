<TeXmacs|1.99.19>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-lv2-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-midi.tm> \|
  <hlink|previous|pure-lilv.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|pure-lv2><label|module-lv2>

  Version 0.2, April 11, 2018

  Albert Gräf \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  <subsection|Copying><label|copying>

  pure-lv2 is Copyright (c) 2014 by Albert Gräf. It is distributed under a
  3-clause BSD license, please check the COPYING file included in the
  distribution for details.

  <subsection|Installation><label|installation>

  Get the latest source from <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-lv2-0.2.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-lv2-0.2.tar.gz>.

  Make sure that you have the latest Pure version installed. Pure 0.60 or
  later is needed.

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

  <subsection|Description><label|description>

  <hlink|LV2|http://lv2plug.in/> is the new Linux audio plugin standard
  (successor of the venerable <hlink|LADSPA|http://www.ladspa.org/> standard)
  which aims to be portable and extensible. LV2 plugins can process any
  combination of audio, MIDI and control data in order to implement various
  kinds of real-time signal processing modules for use in digital audio and
  MIDI software such as <hlink|Ardour|http://ardour.org/> and
  <hlink|Qtractor|http://qtractor.sourceforge.net/>. A companion module is
  available which lets you implement LV2 plugin hosts in Pure, see
  <hlink|<em|pure-lilv: Pure Lilv Interface>|pure-lilv.tm>. Support for
  Miller Puckette's graphical computer music and multimedia software
  <hlink|Pd|http://puredata.info/> is available through the author's
  <hlink|lv2plugin<math|\<sim\>>|https://bitbucket.org/agraef/pd-lv2plugin>
  external. Moreover, stand-alone LV2 hosts such as
  <hlink|jalv|http://drobilla.net/software/jalv/> can be used to interface
  with other software which doesn't support LV2 directly, via the <hlink|Jack
  audio connection kit|http://jackaudio.org/>.

  This package provides a generic LV2 plugin wrapper for Pure which can be
  linked with batch-compiled Pure scripts to obtain LV2 plugin modules. For
  convenience, a shell script named pure2lv2 is included, which lets you
  compile the plugin and turn it into a complete LV2 bundle (consisting of an
  LV2 plugin manifest and the plugin binary), ready to be loaded by any LV2
  host. The package also includes an lv2.pure module which provides the
  operations needed to implement the functionality of a plugin, such as
  functions to read and write LV2 port data in Pure.

  Our implementation supports all standard LV2 port types (including MIDI via
  LV2 atom ports) and should thus be able to work with most LV2 hosts right
  out of the box. Experimental support for the LV2 time extension is also
  available, so that MIDI plugins written in Pure can obtain musical time and
  position data if the host supports this; please check lv2.pure for details.
  The package includes several examples which demonstrate how to write LV2
  plugins of various kinds in Pure, specifically:

  <\itemize>
    <item>pure_amp.pure shows how to do basic audio and control processing in
    order to amplify an incoming audio signal.

    <item>pure_transp.pure demonstrates how to implement a simple MIDI
    processing module which transposes incoming MIDI notes.

    <item>pure_metro.pure shows how to implement a MIDI metronome by making
    use of the musical time and tempo data provided by the LV2 time extension
    (this currently requires Ardour to work).
  </itemize>

  Please also check the <hlink|Usage|#usage> section below for information on
  how to run the pure2lv2 script.

  <subsection|Requirements and Limitations><label|requirements-and-limitations>

  Our implementation uses LV2's <hlink|dynamic
  manifests|http://lv2plug.in/ns/ext/dynmanifest/>, so that the plugin
  manifest, which describes the ports and other properties of the plugin, can
  be included in the plugin module. This makes things easier, but requires an
  LV2 host which supports the dynamic manifest extension (most LV2 hosts
  nowadays do; this includes all the hosts we mentioned above).

  As the Pure runtime isn't thread-safe yet, our implementation effectively
  serializes the plugin callbacks (invocations of the <verbatim|plugin>
  function) across <em|all> Pure plugins running inside a host. While this
  won't make a difference for single-threaded LV2 hosts such as jalv and Pd,
  it also makes the Pure plugins work reliably in heavily multi-threaded
  hosts such as Ardour. However, the serialization of callbacks may become a
  major bottleneck if a multi-threaded host runs many Pure plugins
  concurrently on a multi-processor machine. At present there is no way
  around this, but hopefully this limitation will go away in the
  not-too-distant future when the Pure runtime becomes thread-safe.

  <subsection|Usage><label|usage>

  A summary of the command syntax and options of the pure2lv2 script can be
  printed with <verbatim|purelv2> <verbatim|-h>. Usually the script is
  invoked simply as <verbatim|pure2lv2> <verbatim|myplugin.pure>, where
  <verbatim|myplugin.pure> is the Pure script implementing the plugin. The
  plugin script must provide two functions in order to implement the
  functionality of the plugin:

  <\itemize>
    <item>The <verbatim|manifest> function returns the port descriptions from
    which the plugin manifest is created when the LV2 host performs plugin
    discovery. This may be implemented either as a parameter-less function or
    a global variable in the Pure script. In either case it should return the
    list of port descriptions in a format described in the lv2.pure module.

    <item>The <verbatim|plugin> function implements the plugin itself. It
    gets invoked with a pointer object representing the plugin data which can
    be passed to the operations in the lv2.pure module. Often the plugin will
    actually be implemented as a closure which also encapsulates the local
    state maintained by the plugin; please check the included examples for
    details. At runtime, the <verbatim|plugin> function gets invoked
    repeatedly with an additional parameter, either a truth value denoting a
    change in the activation status, or the value <verbatim|()> to indicate
    that a block of samples (and/or MIDI messages and control data) is to be
    processed.
  </itemize>

  Please check the included examples to get an idea how the plugin scripts
  look like. Here is a simple example (an abridged version of pure_amp.pure)
  which multiplies an incoming audio signal with a volume control:

  <\verbatim>
    \;

    using lv2;

    \;

    manifest = [("vol", "Volume", lv2::controlin, 0.5, 0.0, 1.0),

    \ \ \ \ \ \ \ \ \ \ \ \ ("audioin", lv2::audioin), ("audioout",
    lv2::audioout)];

    \;

    plugin self () = () when

    \ \ // Process a block of samples.

    \ \ vol = lv2::get_port self 0; // control value from port #0 (control
    input)

    \ \ wav = lv2::get_port self 1; // sample data from port #1 (audio input)

    \ \ // Multiply the sample data with the vol control value and output the

    \ \ // resulting wave on port #2 (audio output).

    \ \ lv2::set_port self 2 (map (*vol) wav);

    end;

    \;
  </verbatim>

  Running <verbatim|pure2lv2> <verbatim|myplugin.pure> turns the plugin
  script into an LV2 bundle, which will be written to <verbatim|myplugin.lv2>
  by default (i.e., using the same basename as the plugin script). You can
  also specify a different name and path for the bundle directory with the
  <verbatim|-o> (or <verbatim|--output>) option, and a custom URI prefix for
  the bundle with the <verbatim|-u> (or <verbatim|--uriprefix>) option.
  Before you can use the plugin with your LV2 hosts, you still have to move
  the bundle directory to a directory on your <verbatim|LV2_PATH> (unless you
  already specified a suitable target path with <verbatim|-o>). The examples
  folder in the source package contains a GNU Makefile which shows how to
  automate this process.

  Normally the Pure code of the plugin will be compiled to a native object
  file which gets linked directly into the plugin binary. However, there's
  also a <verbatim|-s> (or <verbatim|--script>) option which copies the
  source script (along with any additional source files specified after the
  plugin script on the command line) to the bundle directory instead, from
  where it will be loaded dynamically when the plugin is used. This increases
  load times, sometimes substantially, since the Pure interpreter will have
  to JIT-compile the Pure script every time the host starts up and loads the
  plugins. But it also reduces turnaround times since you can easily change
  the plugin script right inside the bundle, without having to run pure2lv2
  in between; this may be convenient when developing and testing a plugin.

  <subsubsection*|<hlink|Table Of Contents|index.tm>><label|pure-lv2-toc>

  <\itemize>
    <item><hlink|pure-lv2|#>

    <\itemize>
      <item><hlink|Copying|#copying>

      <item><hlink|Installation|#installation>

      <item><hlink|Description|#description>

      <item><hlink|Requirements and Limitations|#requirements-and-limitations>

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

  <copyright> Copyright 2009-2021, Albert Gräf et al. Last updated on Apr
  30, 2021. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
