<TeXmacs|1.99.5>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-lilv-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-lv2.tm> \|
  <hlink|previous|pure-liblo.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|pure-lilv: Pure Lilv Interface><label|module-lilv>

  Version 0.4, March 18, 2018

  Albert Gräf \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  <subsection|Copying><label|copying>

  pure-lilv is Copyright (c) 2014 by Albert Gräf. It is distributed under a
  3-clause BSD license, please check the COPYING file included in the
  distribution for details.

  <subsection|Installation><label|installation>

  Get the latest source from <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-lilv-0.4.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-lilv-0.4.tar.gz>.

  Run <verbatim|make> to compile the module and <verbatim|sudo>
  <verbatim|make> <verbatim|install> to install it in the Pure library
  directory. To uninstall the module, use <verbatim|sudo> <verbatim|make>
  <verbatim|uninstall>. There are a number of other targets (mostly for
  maintainers), please see the Makefile for details.

  <verbatim|make> tries to guess your Pure installation directory and
  platform-specific setup. If it gets this wrong, you can set some variables
  manually. In particular, <verbatim|make> <verbatim|install>
  <verbatim|prefix=/usr> sets the installation prefix.

  <subsection|Description><label|description>

  This package provides a Pure module for David Robillard's
  <hlink|Lilv|http://drobilla.net/software/lilv/>, a library for LV2 plugin
  host writers. <hlink|LV2|http://lv2plug.in/> is the new Linux audio plugin
  standard (LADSPA successor) which aims to be portable and extensible. Lilv
  makes it possible to load LV2 plugins in audio and other multimedia
  software. It is provided as a comprehensive and well-tested reference
  implementation for LV2 plugin hosts, so that authors of multimedia software
  don't have to craft their own (and often incomplete or bug-ridden)
  implementations of the LV2 plugin API.

  This module is still under development, but we already offer operations to
  retrieve information about the LV2 plugins installed on a system, and to
  instantiate and run most basic plugins. Support for MIDI input and output
  and handling LV2 presets and plugin state is also available. More work is
  still needed in order to support more exotic event types such as transport
  state and tempo changes, and any other extensions which may be required to
  run more advanced plugins. We're still trying to figure these out, so if
  you notice anything that's missing in the current implementation then
  please submit a feature request.

  Documentation still needs to be written. For the time being, please refer
  to the lilv.pure script for a description of the programming interface, and
  to the scripts in the examples folder for examples showing how to use the
  operations provided by this module. Specifically, have a look at the
  lilv_examp.pure script which illustrates most the API functions and how
  they are used in a Pure script. There's also a fairly complete software
  synthesizer example, synth.pure, which shows how to run instrument and
  effect plugins in a synth/effects chain in order to synthesize audio from
  MIDI input. Another complete example is the lv2plugin<math|\<sim\>> host
  for Pd which is written entirely in Pure; you can find this at
  <hlink|https://bitbucket.org/agraef/pd-lv2plugin|https://bitbucket.org/agraef/pd-lv2plugin>.

  Here's a brief excerpt from lilv_examp.pure which shows the necessary steps
  involved in running an LV2 audio plugin with Pure:

  <\verbatim>
    \;

    // Import the module.

    using lilv;

    // Load the LV2 world state.

    let world = lilv::world;

    \;

    // Instantiate a plugin.

    let p = lilv::plugin world "http://faust-lv2.googlecode.com/amp" 44100
    64;

    \;

    // Get some information about the plugin (number of audio inputs and

    // outputs, port descriptions).

    let n,m = lilv::num_audio_inputs p, lilv::num_audio_outputs p;

    let ports = [i, lilv::port_info p i \| i = 0..lilv::num_ports p-1];

    \;

    // Create some audio buffers for input and output.

    let in = dmatrix {0,1,0,-1,0,1,-1,0;0,1,0,-1,0,1,-1,0};

    let out = dmatrix (2,8);

    \;

    // Activate the plugin.

    lilv::activate p;

    \;

    // Run some samples through the plugin.

    lilv::run p in out;

    \;

    // Set a control value.

    lilv::set_control p 2 10;

    // Compute some more samples.

    lilv::run p in out;

    // Get the values of some output controls.

    map (lilv::get_control p) [4,5];

    \;

    // Send a MIDI message.

    lilv::set_midi p 10 [{0xb0, 7, 127}];

    // Compute some more samples.

    lilv::run p in out;

    \;
  </verbatim>

  <subsubsection*|<hlink|Table Of Contents|index.tm>><label|pure-lilv-toc>

  <\itemize>
    <item><hlink|pure-lilv: Pure Lilv Interface|#>

    <\itemize>
      <item><hlink|Copying|#copying>

      <item><hlink|Installation|#installation>

      <item><hlink|Description|#description>
    </itemize>
  </itemize>

  Previous topic

  <hlink|pure-liblo|pure-liblo.tm>

  Next topic

  <hlink|pure-lv2|pure-lv2.tm>

  <hlink|toc|#pure-lilv-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-lv2.tm> \|
  <hlink|previous|pure-liblo.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2018, Albert Gräf et al. Last updated on Apr
  10, 2018. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
